-- Comment
local comment_setup, comment = pcall(require, "Comment")
if not comment_setup then
	return
end

comment.setup()
