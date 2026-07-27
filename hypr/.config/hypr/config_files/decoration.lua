require("config_files.colors-hyprland")

-- https://wiki.hyprland.org/Configuring/Variables/#decoration
hl.config({
	decoration = {
		rounding = 0,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = color1,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,

			vibrancy = 0.1696,
		},
	},
})
