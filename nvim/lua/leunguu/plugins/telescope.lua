local telescope = require("telescope")
local actions = require("telescope.actions")

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				prompt_prefix = "  ", -- ❯  
				selection_caret = "▍ ",
				multi_icon = " ",

				path_display = { "smart" },

				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					horizontal = {
						height = 0.85,
					},
				},
				mappings = {
					i = {
						["jj"] = { "<Esc>", type = "command" },
						["<Tab>"] = actions.move_selection_worse,
						["<S-Tab>"] = actions.move_selection_better,
						["<C-u>"] = actions.results_scrolling_up,

						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-b>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["q"] = actions.close,
						["<Esc>"] = actions.close,

						["<Tab>"] = actions.move_selection_worse,
						["<S-Tab>"] = actions.move_selection_better,

						["<C-b>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-k>"] = actions.preview_scrolling_up,

						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["*"] = actions.toggle_all,
						["u"] = actions.drop_all,
						["J"] = actions.toggle_selection + actions.move_selection_next,
						["K"] = actions.toggle_selection + actions.move_selection_previous,
						[" "] = {
							actions.toggle_selection + actions.move_selection_next,
							type = "action",
							opts = { nowait = true },
						},

						["sv"] = actions.select_horizontal,
						["sg"] = actions.select_vertical,
						["st"] = actions.select_tab,

						["!"] = actions.edit_command_line,

						["t"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,

						["p"] = function()
							local entry = require("telescope.actions.state").get_selected_entry()
							require("rafi.util.preview").open(entry.path)
						end,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<localleader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<localleader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<localleader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set(
			"n",
			"<localleader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd" }
		)
		keymap.set(
			"n",
			"<localleader>fb",
			"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
			{ desc = "Fuzzy find Buffers" }
		)
	end,
}
