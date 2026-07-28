return {
  "elentok/open-link.nvim",
  init = function()
    local expanders = require("open-link.expanders")
    require("open-link").setup({
      expanders = {
        -- Extract only the actual URL from mixed text (e.g. "label,https://example.com")
        function(link)
          local url = link:match("(https?://[^%s,)>\"']+)")
          if url ~= nil then
            return url
          end

          -- Some contexts can drop one slash ("https:/..."), normalize it.
          local broken = link:match("(https:/[^%s,)>\"']+)")
          if broken ~= nil then
            local normalized = broken:gsub("^https:/", "https://")
            return normalized
          end
        end,

        -- expands "{user}/{repo}" to the github repo URL
        expanders.github,

        -- expands "format-on-save#15" the issue/pr #15 in the specified github project
        -- ("format-on-save" is the shortcut/keyword)
        expanders.github_issue_or_pr("format-on-save", "elentok/format-on-save.nvim"),

        -- expands "MYJIRA-1234" and "myotherjira-1234" to the specified Jira URL
        expanders.jira("https://myjira.atlassian.net/browse/", { "myjira", "myotherjira"})
      },
    })
  end,
  cmd = { "OpenLink", "PasteImage" },
  keys = {
    {
      "gl",
      function()
        local open_link = require("open-link").open
        local link = vim.fn.expand("<cfile>")
        local line = vim.api.nvim_get_current_line()

        if not link:match("^https?://") then
          link = line:match("(https?://[^%s,)>\"']+)") or link
        end

        open_link(link)
      end,
      desc = "Open the link under the cursor"
    },
    {
      "gL",
      function()
        local open_link = require("open-link").open
        local link = vim.fn.expand("<cfile>")
        local line = vim.api.nvim_get_current_line()

        if not link:match("^https?://") then
          link = line:match("(https?://[^%s,)>\"']+)") or link
        end

        open_link(link, {
          failure_callback = function(args)
            vim.notify(vim.inspect({
              message = args and args.message or "open-link failed",
              cfile = vim.fn.expand("<cfile>"),
              resolved_link = link,
              line = line,
            }), vim.log.levels.ERROR)
          end,
        })
      end,
      desc = "Open link (debug)",
    },
    {
      "<Leader>ip",
      "<cmd>PasteImage<cr>",
      desc = "Paste image from clipboard",
    },
  }
}
