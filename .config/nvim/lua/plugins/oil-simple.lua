-- Simple oil.nvim config (no 3-pane / parent / preview split logic).
--
-- This is a SEPARATE alternative to lua/plugins/oil.lua. Only one spec for
-- `stevearc/oil.nvim` may be active at a time in lazy.nvim.
--
-- To switch between them:
--   * Use this simple config:  rename oil.lua -> oil.lua.disabled
--   * Use the 3-pane config:   rename oil-simple.lua -> oil-simple.lua.disabled
--
-- Opening via `:Oil`, `:e <dir>`, or `nvim .` will then use plain oil.

return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,

			columns = {
				"icon",
				"size",
			},

			buf_options = {
				buflisted = true,
				bufhidden = "",
			},

			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},

			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			cleanup_delay_ms = 2000,

			lsp_file_methods = {
				enabled = false,
				timeout_ms = 1000,
				autosave_changes = false,
			},

			constrain_cursor = "editable",
			watch_for_changes = true,

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = false,
				["<C-a>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-l>"] = false,
				["<C-r>"] = "actions.refresh",
				["q"] = { "actions.close", mode = "n" },
				["-"] = "actions.parent",
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
			use_default_keymaps = true,

			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					local m = name:match("^%.")
					return m ~= nil
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
				natural_order = "true",
				case_insensitive = false,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
				highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
					return nil
				end,
			},

			extra_scp_args = {},

			git = {
				add = function(path)
					return false
				end,
				mv = function(src_path, dest_path)
					return false
				end,
				rm = function(path)
					return false
				end,
			},

			float = {
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				get_win_title = nil,
				preview_split = "auto",
				override = function(conf)
					return conf
				end,
			},

			preview_win = {
				update_on_cursor_moved = true,
				preview_method = "fast_scratch",
				disable_preview = function(filename)
					return false
				end,
				win_options = {},
			},

			confirmation = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},

			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},

			ssh = {
				border = "rounded",
			},

			keymaps_help = {
				border = "rounded",
			},
		})
	end,
	keys = {
		{
			'<A-->',
			function()
				require('oil').open(vim.fn.expand('%:p:h'))
			end,
			desc = 'Open file manager in cfd (current file directory)'
		},
		{
			'<A-=>',
			function()
				require('oil').open(vim.fn.getcwd())
			end,
			desc = 'Open file manager in cwd'
		}
	}
}
