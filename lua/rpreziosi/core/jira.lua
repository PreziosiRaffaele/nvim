local Job = require('plenary.job')
local M = {}

function M.updateJiraField(issueKey, fieldId, fieldValue)
    if not issueKey or issueKey == '' then
        vim.notify('JIRA issue key is required.', vim.log.levels.ERROR)
        return
    end
    if not fieldId or fieldId == '' then
        vim.notify('JIRA custom field id is required.', vim.log.levels.ERROR)
        return
    end
    if fieldValue == nil then
        vim.notify('Field value is required.', vim.log.levels.ERROR)
        return
    end

    local jiraDomain = os.getenv('JIRA_DOMAIN')
    local jiraApiToken = os.getenv('JIRA_API_TOKEN')

    if not jiraDomain or jiraDomain == '' then
        vim.notify('JIRA_DOMAIN environment variable not set or empty.', vim.log.levels.ERROR)
        return
    end
    if not jiraApiToken or jiraApiToken == '' then
        vim.notify('JIRA_API_TOKEN environment variable not set or empty.', vim.log.levels.ERROR)
        return
    end

    -- Prepare request data
    local payload = vim.fn.json_encode({
        fields = {
            [fieldId] = fieldValue,
        },
    })
    local url = string.format('https://%s/rest/api/2/issue/%s', jiraDomain, issueKey)
    local authHeader = string.format('Authorization: Bearer %s', jiraApiToken)

    vim.notify('Updating JIRA issue ' .. issueKey .. '...', vim.log.levels.INFO)

    Job:new({
        command = 'curl',
        args = {
            '--request',
            'PUT',
            '--url',
            url,
            '--header',
            authHeader,
            '--header',
            'Content-Type: application/json',
            '--header',
            'Accept: application/json',
            '--data',
            payload,
            '-s',             -- Silent mode
            '-w',
            '\n%{http_code}', -- Append HTTP status code
        },
        on_exit = function(curl_job, curl_exit_code)
            vim.schedule(function()
                if curl_exit_code ~= 0 then
                    local stderr = table.concat(curl_job:stderr_result() or {}, '\n')
                    vim.notify(
                        'curl command failed. Exit code: ' .. curl_exit_code .. '\nError: ' .. stderr,
                        vim.log.levels.ERROR
                    )
                    return
                end

                local result = curl_job:result()
                if not result or #result == 0 then
                    vim.notify('JIRA update: No data received from curl.', vim.log.levels.WARN)
                    return
                end

                local httpCodeLine = result[#result] -- Last line is HTTP code
                table.remove(result, #result)        -- Remove status code line
                local responseBody = table.concat(result, '\n')
                local httpCode = tonumber(httpCodeLine)

                if httpCode and httpCode >= 200 and httpCode < 300 then
                    vim.notify(
                        'JIRA issue ' .. issueKey .. ' updated successfully. Status: ' .. httpCode,
                        vim.log.levels.INFO
                    )
                    if responseBody and responseBody ~= '' then
                        vim.notify('JIRA Response: ' .. responseBody, vim.log.levels.DEBUG)
                    end
                else
                    vim.notify(
                        'Failed to update JIRA issue '
                        .. issueKey
                        .. '. HTTP Status: '
                        .. (httpCodeLine or 'Unknown')
                        .. '\nResponse: '
                        .. responseBody,
                        vim.log.levels.ERROR
                    )
                end
            end)
        end,
    }):start()
end

function M.getJiraField(issueKey, fieldId, opts)
    opts = opts or {}
    local on_result = opts.on_result -- optional callback to receive the value

    if not issueKey or issueKey == '' then
        vim.notify('JIRA issue key is required.', vim.log.levels.ERROR)
        return
    end
    if not fieldId or fieldId == '' then
        vim.notify('JIRA custom field id is required.', vim.log.levels.ERROR)
        return
    end

    local jiraDomain = os.getenv('JIRA_DOMAIN')
    local jiraApiToken = os.getenv('JIRA_API_TOKEN')

    if not jiraDomain or jiraDomain == '' then
        vim.notify('JIRA_DOMAIN environment variable not set or empty.', vim.log.levels.ERROR)
        return
    end
    if not jiraApiToken or jiraApiToken == '' then
        vim.notify('JIRA_API_TOKEN environment variable not set or empty.', vim.log.levels.ERROR)
        return
    end

    local url = string.format('https://%s/rest/api/2/issue/%s?fields=%s', jiraDomain, issueKey, fieldId)
    local authHeader = string.format('Authorization: Bearer %s', jiraApiToken)

    vim.notify('Fetching field ' .. fieldId .. ' from JIRA issue ' .. issueKey .. '...', vim.log.levels.INFO)

    Job:new({
        command = 'curl',
        args = {
            '--request',
            'GET',
            '--url',
            url,
            '--header',
            authHeader,
            '--header',
            'Accept: application/json',
            '-s',             -- Silent mode
            '-w',
            '\n%{http_code}', -- Append HTTP status code
        },
        on_exit = function(curl_job, curl_exit_code)
            vim.schedule(function()
                if curl_exit_code ~= 0 then
                    local stderr = table.concat(curl_job:stderr_result() or {}, '\n')
                    vim.notify(
                        'curl command failed. Exit code: ' .. curl_exit_code .. '\nError: ' .. stderr,
                        vim.log.levels.ERROR
                    )
                    return
                end

                local result = curl_job:result()
                if not result or #result == 0 then
                    vim.notify('JIRA fetch: No data received from curl.', vim.log.levels.WARN)
                    return
                end

                local httpCodeLine = result[#result] -- Last line is HTTP code
                table.remove(result, #result)        -- Remove status code line
                local responseBody = table.concat(result, '\n')
                local httpCode = tonumber(httpCodeLine)

                if httpCode and httpCode >= 200 and httpCode < 300 then
                    local ok, decoded = pcall(vim.fn.json_decode, responseBody)
                    if not ok then
                        vim.notify('Failed to decode JIRA response JSON.', vim.log.levels.ERROR)
                        return
                    end
                    local fieldValue = decoded and decoded.fields and decoded.fields[fieldId]
                    if fieldValue == nil then
                        vim.notify('Field ' .. fieldId .. ' not present in JIRA response.', vim.log.levels.WARN)
                    else
                        vim.notify('Fetched JIRA field ' .. fieldId .. ' successfully.', vim.log.levels.INFO)
                    end
                    if on_result then
                        pcall(on_result, fieldValue)
                    end
                else
                    vim.notify(
                        'Failed to fetch JIRA issue '
                        .. issueKey
                        .. '. HTTP Status: '
                        .. (httpCodeLine or 'Unknown')
                        .. '\nResponse: '
                        .. responseBody,
                        vim.log.levels.ERROR
                    )
                end
            end)
        end,
    }):start()
end

function M.setup()
    vim.api.nvim_create_user_command('JiraUpdateSolutionDesign', function()
        local issueKey = vim.fn.expand('%:t:r')
        local fieldId = 'customfield_10816'
        local fieldValue = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')

        if not issueKey or issueKey == '' then
            vim.notify('JIRA issue key not provided and could not be inferred from filename.', vim.log.levels.ERROR)
            return
        end
        M.updateJiraField(issueKey, fieldId, fieldValue)
    end, {
        nargs = 0,
        desc = "Update JIRA custom field 'Solution Design' with current buffer content",
    })

-- Get Jira Description: use as argument the issue key
    vim.api.nvim_create_user_command('JiraGetAcceptanceCriteria', function(opts)
        local issueKey = opts.args
        if not issueKey or issueKey == '' then
            vim.notify('JIRA issue key is required.', vim.log.levels.ERROR)
            return
        end
        M.getJiraField(issueKey, 'customfield_10209', {
            on_result = function(desc)
                if desc == nil then
                    vim.notify('No description found for JIRA issue ' .. issueKey, vim.log.levels.WARN)
                    return
                end
                local text
                if type(desc) == 'table' then
                    text = vim.fn.json_encode(desc)
                else
                    text = tostring(desc)
                end
                local lines = vim.split(text, '\n', { plain = true })
                vim.api.nvim_put(lines, 'l', false, true)
            end,
        })
    end, {
        nargs = 1,
        desc = 'Get JIRA issue description and paste at cursor',
    })

    -- Get Jira Description: use as argument the issue key
    vim.api.nvim_create_user_command('JiraGetDescription', function(opts)
        local issueKey = opts.args
        if not issueKey or issueKey == '' then
            vim.notify('JIRA issue key is required.', vim.log.levels.ERROR)
            return
        end
        M.getJiraField(issueKey, 'description', {
            on_result = function(desc)
                if desc == nil then
                    vim.notify('No description found for JIRA issue ' .. issueKey, vim.log.levels.WARN)
                    return
                end
                local text
                if type(desc) == 'table' then
                    text = vim.fn.json_encode(desc)
                else
                    text = tostring(desc)
                end
                local lines = vim.split(text, '\n', { plain = true })
                vim.api.nvim_put(lines, 'l', false, true)
            end,
        })
    end, {
        nargs = 1,
        desc = 'Get JIRA issue description and paste at cursor',
    })
end

return M
