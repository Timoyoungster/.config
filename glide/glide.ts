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
glide.keymaps.set("normal", "rr", "reload");
glide.keymaps.set("normal", "RR", "reload_hard");

// tab movement
glide.keymaps.set("normal", "<leader>ff", "commandline_show search ");
glide.keymaps.set("normal", "<leader>fn", "commandline_show search -n ");
glide.keymaps.set("normal", "<leader>ft", "commandline_show tab ");
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
glide.keymaps.set("command", "<c-d>", "commandline_focus_next");
glide.keymaps.set("command", "<c-n>", "commandline_focus_next");
glide.keymaps.set("command", "<c-u>", "commandline_focus_back");
glide.keymaps.set("command", "<c-p>", "commandline_focus_back");
glide.keymaps.set("command", "<c-c>", "commandline_toggle");
glide.keymaps.set("command", "<c-x>", "commandline_delete");

// ----------------
// ---- EXCMDS ----
// ----------------

const search_cmd = glide.excmds.create({
  name: "search",
  description: "Run a search query",
}, async ({ args_arr, tab_id }) => {
  let disp = "CURRENT_TAB";
  if (args_arr[0] === "-n" || args_arr[0] === "--new-tab") {
    args_arr.shift();
    disp = "NEW_TAB";
  }

  let search_string = args_arr.join(" ").trim();

  if (!search_string.includes(" ") && search_string.includes(".")) {
    if (!search_string.startsWith("http://") 
        && !search_string.startsWith("https://")) {
      search_string = "https://" + search_string;
    }
    if (disp === "CURRENT_TAB") {
      await browser.tabs.update(tab_id, {
        active: true,
        url: search_string,
      });
    } else {
      await browser.tabs.create({
        active: true,
        url: search_string,
      });
    }
  } else {
    await browser.search.search({
      disposition: disp,
      query: search_string
    });
  }

});

declare global {
  interface ExcmdRegistry {
    search: typeof search_cmd;
  }
}

// vim: ts=2 sw=2 et:
