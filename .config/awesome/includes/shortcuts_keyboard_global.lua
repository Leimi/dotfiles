-- global keyboard shortcuts - work all the time everywhere
globalkeys = awful.util.table.join(

  -- almost normal alt-tab behavior with rofi https://github.com/DaveDavenport/rofi
  awful.key({ altkey,           }, "Escape",     function()
    awful.util.spawn_with_shell(string.format(
      'rofi -show window -font "%s" -fg "%s" -bg "%s" -hlfg "%s" -hlbg "%s" -o 95 -width 600',
      beautiful.font, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),

  -- focus next or prev client - works accross all screens
  awful.key({ altkey, sft       }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ altkey,           }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(1)
    if client.focus then client.focus:raise() end
  end),

  -- focus next or prev client - works accross all screens
  awful.key({ modkey, sft       }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(1)
    if client.focus then client.focus:raise() end
  end),

  -- jklm to resize windows
  awful.key({ modkey,           }, "j",       function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey,           }, "k",       function() awful.client.incwfact(-0.1) end),
  awful.key({ modkey,           }, "l",       function() awful.client.incwfact( 0.1) end),
  awful.key({ modkey,           }, "m",       function() awful.tag.incmwfact( 0.05) end),

  -- shift + jklm to move windows
  awful.key({ modkey, sft       }, "j",       function() awful.client.swap.global_bydirection("left") end),
  awful.key({ modkey, sft       }, "k",       function() awful.client.swap.global_bydirection("down") end),
  awful.key({ modkey, sft       }, "l",       function() awful.client.swap.global_bydirection("up") end),
  awful.key({ modkey, sft       }, "m",       function() awful.client.swap.global_bydirection("right") end),

  -- add or remove focused client to the master side
  awful.key({ modkey,           }, "h",       function() awful.tag.incnmaster( 1) end),
  awful.key({ modkey, sft       }, "h",       function() awful.tag.incnmaster(-1) end),

  -- cycle through existing layouts
  awful.key({ modkey            }, "Return",  function()
    awful.layout.inc(layouts, 1)
  end),

  -- run or raise applications
  awful.key({ modkey            }, "t",       function() awful.util.spawn(terminal) end),
  awful.key({ modkey            }, "f",       function() helpers.launcher.ror("pcmanfm", "Pcmanfm") end),
  awful.key({ modkey            }, "s",       function() helpers.launcher.ror("subl", { "Sublime_text", "Subl" }) end),
  awful.key({ modkey            }, "w",       function()
    helpers.launcher.ror("google-chrome-unstable", { "google-chrome-unstable" })
  end),
  awful.key({ modkey            }, "g",       function() helpers.launcher.ror("git-cola", "Git-cola") end),

  -- dmenu with fuzzy matching through -z option https://aur.archlinux.org/packages/dmenu-xft-fuzzy/
  awful.key({ modkey            }, "space",   function()
    awful.util.spawn_with_shell(string.format(
      "dmenu_run_aliases -fn '%s' -nf '%s' -nb '%s' -sf '%s' -sb '%s' -l 30 -i -z",
      beautiful.font_dmenu, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),

  awful.key({ ctrl, altkey      }, "l",       function()
    awful.util.spawn_with_shell("xscreensaver-command -lock")
  end),

  awful.key({ }, "XF86AudioLowerVolume",      function() awful.util.spawn("amixer set Master 2-") end),
  awful.key({ }, "XF86AudioRaiseVolume",      function() awful.util.spawn("amixer set Master 2+") end),
  awful.key({ }, "XF86AudioMute",             function() awful.util.spawn("amixer set Master toggle") end),

  awful.key({ }, "XF86",                      function() awful.util.spawn("lxde-logout") end),

  awful.key({ modkey            }, "F7",  function() awful.util.spawn("monitor switch") end),
  awful.key({ modkey, ctrl      }, "m",  function() awful.util.spawn("monitor switch") end),
  awful.key({ modkey, ctrl      }, "r",       awesome.restart),
  awful.key({ modkey, ctrl, sft }, "q",       awesome.quit),

  awful.key({ altkey,           }, "space",   function()
    helpers.tags.toggletag(main_screen, 7);
  end)
)


-- bind all key numbers to tags
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    -- go to tag x on the current screen, focusing back the client that was last focused on the given tag
    awful.key({ modkey       }, "#" .. i + 9, function()
      helpers.tags.toggletag(mouse.screen, i)
    end),
    -- go to tag x on the current screen and move currently focused client on the given tag
    awful.key({ modkey, sft  }, "#" .. i + 9, function()
      local tag = awful.tag.gettags(mouse.screen)[i]
      awful.client.movetotag(tag)
      helpers.tags.toggletag(mouse.screen, i, 1)
    end)
  )
end

-- set all global keyboard shortcuts
root.keys(globalkeys)