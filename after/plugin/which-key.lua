-- which-key
local which_key_setup, which_key = pcall(require, "which-key")
if not which_key_setup then
	return
end
which_key.setup()
