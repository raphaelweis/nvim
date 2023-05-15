local neodev_setup, neodev = pcall(require, "neodev")
if not neodev_setup then
	return
end

neodev.setup()
