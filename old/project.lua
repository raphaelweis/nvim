local project_setup, project = pcall(require, "project")
if not project_setup then
	return
end

project.setup({
	silent_chdir = false,
})
