return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	keys = {
		{ "<localleader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
		{
			"<localleader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<CR>",
			desc = "Open trouble workspace diagnostics",
		},
		{
			"<localleader>xd",
			"<cmd>TroubleToggle document_diagnostics<CR>",
			desc = "Open trouble document diagnostics",
		},
		{ "<localleader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
		{ "<localleader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
		{ "<localleader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
	},
}
