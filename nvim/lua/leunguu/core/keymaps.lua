-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
--
-- Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy UI" })

-- clear search highlights
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save the file" })
keymap.set("n", "q", ":q<CR>", { desc = "Exit the file" })
keymap.set("n", "<Leader><Leader>", "V", { desc = "Visual Mode" })
keymap.set("x", "<Leader><Leader>", "<Esc>", { desc = "Exit Visual Mode" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Clear search with <Esc>
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear Search Highlight" })

-- C-r: Easier search and replace visual/select mode
keymap.set(
	"x",
	"<C-r>",
	":<C-u>%s/\\V<C-R>=v:lua.require'rafi.util.edit'.get_visual_selection()<CR>" .. "//gc<Left><Left><Left>",
	{ desc = "Replace Selection" }
)

-- Re-select blocks after indenting in visual/select mode
keymap.set("x", "<", "<gv", { desc = "Indent Right and Re-select" })
keymap.set("x", ">", ">gv|", { desc = "Indent Left and Re-select" })

-- Use tab for indenting in visual/select mode
keymap.set("x", "<Tab>", ">gv|", { desc = "Indent Left" })
keymap.set("x", "<S-Tab>", "<gv", { desc = "Indent Right" })

-- Use backspace key for matching pairs
keymap.set({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })
