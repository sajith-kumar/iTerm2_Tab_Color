#!/usr/bin/env python3.7

import iterm2
import random


async def main(connection):
    app = await iterm2.async_get_app(connection)
    session = app.current_terminal_window.current_tab.current_session
    change = iterm2.LocalWriteOnlyProfile()
    # color = iterm2.Color(255, 48, 48)
    random_color = list(range(10, 255, 10))
    color_temp = random.choices(random_color, k=3)
    color = iterm2.Color(color_temp[0], color_temp[1], color_temp[2])
    change.set_tab_color(color)
    change.set_use_tab_color(True)
    await session.async_set_profile_properties(change)


iterm2.run_until_complete(main)
