from __future__ import annotations

import json
import platform
import socket

from kivy.app import App
from kivy.clock import Clock
from kivy.uix.label import Label


class MonitorApp(App):
    def build(self):
        self.label = Label(
            text="Service Active\nMonitoring Status: Running",
            halign="center",
            valign="middle",
        )
        Clock.schedule_interval(self.report_status, 300)
        return self.label

    def report_status(self, dt):
        data = {
            "device": platform.node(),
            "system": platform.system(),
            "status": "active",
        }

        try:
            with socket.create_connection(("192.168.1.100", 5555), timeout=5) as sock:
                sock.sendall(json.dumps(data).encode("utf-8"))
        except (OSError, TypeError, ValueError):
            pass


if __name__ == "__main__":
    MonitorApp().run()
