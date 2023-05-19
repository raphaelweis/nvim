-- alpha-nvim
local alpha_setup, alpha = pcall(require, "alpha")
if not alpha_setup then
	return
end

local dashboard_setup, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_setup then
	return
end

alpha.setup(dashboard.config)
