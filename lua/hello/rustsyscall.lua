--put lua stuff in here to:
--call a bash script maybe? that calls rust asm func with correct params and outputs into a specific window
--things i need to learn to do:
--1. how to get function name we want to display, and pass that into command line args for rust asm
--2. how to display output in a window in neovim
--lfg i think i have a way to do this now, just need to learn how to do this stuff

local api = vim.api
local buf, win

local function open_window()
    buf = api.nvim_create_buf(false, true)

    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")


    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)

    local row = math.ceil((height - win_height) / 2 -1)
    local col = math.ceil((width - win_width) / 2)

    local opts = {
        style = "minimal", 
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }


    win = api.nvim_open_win(buf, true, opts)

end
