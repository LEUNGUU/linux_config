return {
	"folke/noice.nvim",
	event = "VeryLazy",
	enabled = not vim.g.started_by_firenvim,
		-- stylua: ignore
		keys = {
			{ '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
			{ '<leader>snl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
			{ '<leader>snh', function() require('noice').cmd('history') end, desc = 'Noice History' },
			{ '<leader>sna', function() require('noice').cmd('all') end, desc = 'Noice All' },
			{ '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end, silent = true, expr = true, desc = 'Scroll forward', mode = {'i', 'n', 's'} },
			{ '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end, silent = true, expr = true, desc = 'Scroll backward', mode = {'i', 'n', 's'}},
		},
	---@type NoiceConfig
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		messages = {
			view_search = false,
		},
		routes = {
			-- See :h ui-messages
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "^%d+ changes?; after #%d+" },
						{ find = "^%d+ changes?; before #%d+" },
						{ find = "^Hunk %d+ of %d+$" },
						{ find = "^%d+ fewer lines;?" },
						{ find = "^%d+ more lines?;?" },
						{ find = "^%d+ line less;?" },
						{ find = "^Already at newest change" },
						{ kind = "wmsg" },
						{ kind = "emsg", find = "E486" },
						{ kind = "quickfix" },
					},
				},
				view = "mini",
			},
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "^%d+ lines .ed %d+ times?$" },
						{ find = "^%d+ lines yanked$" },
						{ kind = "emsg", find = "E490" },
						{ kind = "search_count" },
					},
				},
				opts = { skip = true },
			},
			{
				filter = {
					event = "notify",
					any = {
						{ find = "^No code actions available$" },
						{ find = "^No information available$" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
			-- inc_rename = true,
		},
		commands = {
			all = {
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			},
		},
	},
}
