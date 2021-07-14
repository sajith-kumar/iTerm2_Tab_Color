#!/usr/bin/env python3

import iterm2
import random


def random_color():
    return random.randint(0, 255)


async def main(connection):
    app = await iterm2.async_get_app(connection)
    async with iterm2.NewSessionMonitor(connection) as mon:
        while True:
            session_id = await mon.async_get()
            session = app.get_session_by_id(session_id)
            if session:
                change = iterm2.LocalWriteOnlyProfile()
                color = iterm2.Color(random_color(), random_color(), random_color())
                change.set_tab_color(color)
                change.set_use_tab_color(True)
                await session.async_set_profile_properties(change)


iterm2.run_forever(main)