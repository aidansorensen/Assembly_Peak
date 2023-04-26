
local function show_assembly()
    input = vim.ui.input({prompt = "enter function you want to inspect as assembly: "})
    vim.cmd("vsplit | terminal")
    local command = ':call jobsend(b:terminal_job_id, "cargo asm --asm-style=intel fizzbuzz::.." input .. "\\n")'
    vim.cmd(command)
end

return {
    show_assembly = show_assembly
}
