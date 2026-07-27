require("config_files.colors-hyprland")

-- https://wiki.hyprland.org/Configuring/Variables/#general
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 1,

		col = {
			active_border = foreground,
			inactive_border = background,
		},

		resize_on_border = false,
		allow_tearing = false,

		layout = "dwindle",
	},
})
