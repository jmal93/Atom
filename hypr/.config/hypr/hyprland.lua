require("config_files.animations")
require("config_files.decoration")
require("config_files.general")
require("config_files.input")
require("config_files.keybindings")
require("config_files.windowrules")
require("config_files.colors-hyprland")

hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("systemctl --user start hyprpolkitagent ")
end)

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = "auto",
})
