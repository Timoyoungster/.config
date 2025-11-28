# load autoconfig first to override everything else later
config.load_autoconfig()


# ----------------
# --- Keybinds ---
# ----------------

# swap J <-> K
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')

# qute-pass
config.bind(',p', 'spawn --userscript custom-1pass')
