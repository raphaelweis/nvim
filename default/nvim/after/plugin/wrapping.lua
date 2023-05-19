-- wrapping
local wrapping_setup, wrapping = pcall(require, "wrapping")
if not wrapping_setup then
	return
end

wrapping.setup()
