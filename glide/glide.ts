// Config docs:
//
//   https://glide-browser.app/config
//
// API reference:
//
//   https://glide-browser.app/api
//
// Default config files can be found here:
//
//   https://github.com/glide-browser/glide/tree/main/src/glide/browser/base/content/plugins
//
// Most default keymappings are defined here:
//
//   https://github.com/glide-browser/glide/blob/main/src/glide/browser/base/content/plugins/keymaps.mts
//
// Try typing `glide.` and see what you can do!

// Options
glide.o.hint_size = "12px";
glide.o.native_tabs = "hide";

// Custom actions
const openBookmarksPicker = async () => {
  const bookmarks = await browser.bookmarks.getRecent(10);

  glide.commandline.show({
    title: "bookmarks",
    options: bookmarks.map((bookmark) => ({
      label: bookmark.title,
      async execute() {
        const tab = await glide.tabs.get_first({
          url: bookmark.url,
        });
        if (tab) {
          await browser.tabs.update(tab.id, {
            active: true,
          });
        } else {
          await browser.tabs.create({
            active: true,
            url: bookmark.url,
          });
        }
      },
    })),
  });
};

// ----------------
// ---- NORMAL ----
// ----------------

glide.keymaps.set("normal", "<leader>r", "config_reload");

// tab movement
glide.keymaps.set("normal", "<leader>ff", "keys <leader><leader>");
glide.keymaps.set("normal", "<leader>fb", openBookmarksPicker, {
  description: "Open the bookmarks picker",
});

// findbar
glide.keymaps.set("normal", "/", glide.findbar.open);

//* not working currently for some reason *//
glide.keymaps.set("normal", "<C-n>", glide.findbar.next_match);
glide.keymaps.set("normal", "<C-p>", glide.findbar.previous_match);

// -----------------
// ---- COMMAND ----
// -----------------
glide.keymaps.set("command", "<c-n>", "commandline_focus_next");
glide.keymaps.set("command", "<c-p>", "commandline_focus_back");


// vim: ts=2 sw=2 et:
