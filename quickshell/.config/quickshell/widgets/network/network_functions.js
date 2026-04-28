function barToWifi(bar) {
        switch (bar) {
        case "▂▄▆█":
            return "󰤨";
        case "▂▄▆_":
            return "󰤥";
        case "▂▄__":
            return "󰤢";
        case "▂___":
            return "󰤟";
        default:
            return "󰤫";
        }
    }

function barToWifiSecurity(bar) {
        switch (bar) {
        case "▂▄▆█":
            return "󰤪";
        case "▂▄▆_":
            return "󰤧";
        case "▂▄__":
            return "󰤤";
        case "▂___":
            return "󰤡";
        default:
            return "󱛏";
        }
    }

