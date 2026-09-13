#!/usr/bin/env python3
import configparser
import datetime
import calendar
import os

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

CONF = os.path.expanduser("~/.config/polybar/config.ini")
POSY = 36
POSX = None
WIDTH = 300


def bar_geometry():
    cp = configparser.ConfigParser(strict=False)
    cp.read(CONF)
    try:
        h = int(cp.get("bar/main", "height"))
        oy = int(cp.get("bar/main", "offset-y"))
        ox = int(cp.get("bar/main", "offset-x").strip().rstrip("%"))
        w = int(cp.get("bar/main", "width").strip().rstrip("%"))
        return h, oy, ox, w
    except Exception:
        return 30, 6, 1, 98


BG = "#1d1d1d"
FG = "#ebdbb2"
DIM = "#a89984"
ACCENT = "#d79921"
WEEKEND = "#665c54"
BORDER = "#59443a"
SELECT = "#3c3836"

CSS = """
window.calpanel {
  background-color: %(bg)s;
  border: 1px solid %(border)s;
  border-top-width: 0;
  border-radius: 0;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
}
#root { padding: 12px 18px 14px 18px; }
#month {
  font-family: "Hack Nerd Font Mono";
  font-size: 13px;
  font-weight: bold;
  color: %(accent)s;
}
.wd {
  font-family: "Hack Nerd Font Mono";
  font-size: 10px;
  font-weight: bold;
  color: %(dim)s;
  padding: 1px 5px;
}
.wd.we { color: %(weekend)s; }
.day {
  font-family: "Hack Nerd Font Mono";
  font-size: 10px;
  color: %(fg)s;
  border-radius: 6px;
  padding: 2px 5px;
}
.day.today {
  background-color: %(select)s;
  color: %(accent)s;
}
""" % {
    "bg": BG, "border": BORDER, "accent": ACCENT, "dim": DIM,
    "weekend": WEEKEND, "fg": FG, "select": SELECT,
}


class CalPanel(Gtk.Window):
    def __init__(self):
        super().__init__(type=Gtk.WindowType.POPUP)
        self.set_name("calpanel")
        self.set_decorated(False)
        self.set_skip_taskbar_hint(True)
        self.set_skip_pager_hint(True)
        self.set_keep_above(True)
        self.set_accept_focus(False)
        self.set_position(Gtk.WindowPosition.NONE)
        self.set_gravity(Gdk.Gravity.NORTH_WEST)
        self.set_type_hint(Gdk.WindowTypeHint.DOCK)
        self.connect("destroy", Gtk.main_quit)
        self.connect("map-event", self._grab)
        self.connect("key-press-event", lambda w, e: self.destroy() or True)
        self.connect("button-press-event", lambda w, e: self.destroy() or True)

        screen = self.get_screen()
        if screen.get_rgba_visual():
            self.set_visual(screen.get_rgba_visual())

        provider = Gtk.CssProvider()
        provider.load_from_data(CSS.encode())
        Gtk.StyleContext.add_provider_for_screen(
            screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )

        root = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=9)
        root.set_name("root")
        self.add(root)
        self.get_style_context().add_class("calpanel")

        today = datetime.date.today()
        grid = calendar.monthcalendar(today.year, today.month)

        month = Gtk.Label(label="%s %d" % (calendar.month_name[today.month], today.year))
        month.set_name("month")
        root.pack_start(month, False, False, 0)

        table = Gtk.Grid(column_spacing=6, row_spacing=3, halign=Gtk.Align.CENTER)
        root.pack_start(table, True, True, 0)

        names = ["Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"]
        for c, name in enumerate(names):
            lbl = Gtk.Label(label=name)
            cls = lbl.get_style_context()
            cls.add_class("wd")
            if c >= 5:
                cls.add_class("we")
            table.attach(lbl, c, 0, 1, 1)

        for r, week in enumerate(grid):
            for c, day in enumerate(week):
                if day == 0:
                    lbl = Gtk.Label(label="")
                else:
                    lbl = Gtk.Label(label=str(day))
                    cls = lbl.get_style_context()
                    cls.add_class("day")
                    if day == today.day:
                        cls.add_class("today")
                table.attach(lbl, c, r + 1, 1, 1)

        self.show_all()

        wa = screen.get_width()
        global POSX
        POSX = (wa - WIDTH) // 2
        self.resize(WIDTH, 1)
        self.connect("map-event", self._place)

    def _grab(self, *a):
        win = self.get_window()
        try:
            with open(os.path.expanduser("/tmp/calpanel.wid"), "w") as f:
                f.write(str(win.get_xid()))
        except Exception:
            pass
        Gdk.pointer_grab(
            win, True,
            Gdk.EventMask.BUTTON_PRESS_MASK | Gdk.EventMask.BUTTON_RELEASE_MASK,
            None, None, Gdk.CURRENT_TIME,
        )
        Gdk.keyboard_grab(win, True, Gdk.CURRENT_TIME)
        h, oy, ox, w = bar_geometry()
        self.move(POSX, oy + h)
        return False

    def _place(self, *a):
        h, oy, ox, w = bar_geometry()
        self.move(POSX, oy + h)


if __name__ == "__main__":
    CalPanel()
    Gtk.main()