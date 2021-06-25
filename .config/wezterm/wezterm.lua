local wezterm = require 'wezterm';

function font_with_fallback(name, params)
    local names = {name, "JetBrains Mono", "Noto Color Emoji"}
    return wezterm.font_with_fallback(names, params)
end

return {
    front_end = "OpenGL",
    check_for_updates = false,
    window_close_confirmation = "NeverPrompt",
    font = font_with_fallback("JetBrains Mono Medium"),
    font_rules = {
        {italic = true, font = font_with_fallback("JetBrains Mono", {italic = true})},
        {
            italic = true,
            intensity = "Bold",
            font = font_with_fallback("JetBrains Mono", {bold = true, italic = true})
        },
        {
            intensity = "Bold",
            font = font_with_fallback("JetBrains Mono", {bold = true})
        }, {intensity = "Half", font = font_with_fallback("JetBrains Mono")}
    },
    font_size = 10.5,
    font_shaper = "Harfbuzz",
    line_height = 1.0,
    freetype_load_target = "HorizontalLcd",
    freetype_render_target = "Normal",
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {left = 4, right = 4, top = 4, bottom = 4},
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 800,
    bold_brightens_ansi_colors = false,
    color_scheme = "OneDark",
    color_schemes = {
        ["OneDark"] = {
            foreground = "#c8ccd4",
            background = "#1e2127",
            cursor_bg = "#abb2bf",
            cursor_fg = "#1e2127",
            cursor_border = "#abb2bf",
            selection_fg = "#1e2127",
            selection_bg = "#c8ccd4",
            split = "#545862",
            ansi = {
                "#1e2127", "#e06c75", "#98c379", "#ffcb6b", "#61afef",
                "#b58fae", "#56b6c2", "#d0d0d0"
            },
            brights = {
                "#545862", "#ff8b92", "#ddffa7", "#ffe585", "#9cc4ff",
                "#e1acff", "#a3f7ff", "#ffffff"
            }
        }
    }
}
