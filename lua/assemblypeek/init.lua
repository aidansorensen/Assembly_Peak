require('assemblypeek.ui')
require('assemblypeek.utils')
    -- local global_config = harpoon.get_global_settings()

    -- if global_config.save_on_toggle or force_save then
    --     require("assemblypeek.ui").on_menu_save()
    -- end

-- local function show_assembly()
--     vim.cmd("vsplit | terminal")
--     local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel fizzbuzz::fizz \\n")'
--     vim.cmd(command)
-- end

-- return {
--     show_assembly = show_assembly
-- }
--

--local function show_assembly(func_name)
--    vim.cmd("vsplit | terminal")
--    --local func_name = "fizzbuzz::fizz"
--    local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel ' .. func_name ..' \\n")'
--    vim.cmd(command)
--end

--return {
--    show_assembly = show_assembly
--}


