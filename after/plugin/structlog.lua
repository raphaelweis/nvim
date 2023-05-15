local structlog_setup, structlog = pcall(require, "structlog")
if not structlog_setup then
	return
end

structlog.configure({
	my_logger = {
		pipelines = {
			{
				level = structlog.level.INFO,
				processors = {
					structlog.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 0 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.FormatColorizer( --
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" },
					{ level = structlog.formatters.FormatColorizer.color_level() }
				),
				sink = structlog.sinks.Console(),
			},
			{
				level = structlog.level.WARN,
				processors = {},
				formatter = structlog.formatters.Format( --
					"%s",
					{ "msg" },
					{ blacklist = { "level", "logger_name" } }
				),
				sink = structlog.sinks.NvimNotify(),
			},
			{
				level = structlog.level.TRACE,
				processors = {
					structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3 }),
					structlog.processors.Timestamper("%H:%M:%S"),
				},
				formatter = structlog.formatters.Format( --
					"%s [%s] %s: %-30s",
					{ "timestamp", "level", "logger_name", "msg" }
				),
				sink = structlog.sinks.File("./test.log"),
			},
		},
	},
	-- other_logger = {...}
})
