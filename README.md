# iTerm2_Tab_Color
Adopted from "iTerm2 Random Color Preset" script https://iterm2.com/python-api/examples/random_color.html

An iTerm2 daemon would ordinarily be an AutoLaunch script that provides some ongoing service. 

## #!/usr/bin/env python3

This is standard boilerplate for a Python script.
standardized pieces of text. Shebang line.
If you have several versions of Python installed, /usr/bin/env will ensure the interpreter used is the first one on your environment's $PATH. The alternative would be to hardcode something like #!/usr/bin/python

## Import iterm2

iterm2 is a Python module (available on PyPI) that provides a nice interface to communicate with iTerm2.

## async def main(connection):

The first argument is a connection that holds the link to a running iTerm2 process. 
main gets called only after a connection is established.

## async

A function that you introduce with async def is a coroutine. It may use await, return, or yield, but all of these are optional.

## 
## Nice walkthrough  by Brad Solomon in Real Python website
https://realpython.com/async-io-python/

async IO are coroutines. A coroutine is a specialized version of a Python generator function.
a coroutine is a function that can suspend its execution before reaching return, and it can indirectly pass control to another coroutine for some time.
Coroutines are a special type of function that deliberately yield control over to the caller, but does not end its context in the process, instead maintaining it in an idle state.

async IO is a style of concurrent programming

It signifies that this function can be interrupted, for example to perform a remote procedure call over a network. 
Because iTerm2 communicates with the script over a websocket connection, any time the script wishes to send or receive information from iterm2, it will have to wait for a few milliseconds.

The benefit of asyncio is that while the script is stopped waiting for a response from iTerm2, other work can happen. For example, handling of notifications from iTerm2.
## 

## app = await iterm2.async_get_app(connection)

The purpose of this line is to get a reference to the iterm2.App object, which is useful for many things you’ll want to do in a simple script. 
It is a singleton that provides access to iTerm2’s windows, and in turn their tabs and sessions.

The keyword await passes function control back to the event loop.
The core element of all asyncio applications is the ‘event loop’. The event loop is what schedules and runs asynchronous tasks.

In this case, it makes an RPC call to iTerm2 to get its state (such as the list of windows). The returned value is an iterm2.App.


## async with iterm2.NewSessionMonitor(connection) as mon:

Async with context manager 
class NewSessionMonitor(connection: iterm2.connection.Connection)
Watches for the creation of new sessions.

## while True:

When you use a context manager this way the flow of control enters the body of the context manager (beginning with while True).

## session_id = await mon.async_get()

async async_get() → str
Returns the new session ID.

## session = app.get_session_by_id(session_id)

get_session_by_id(session_id: str)
Finds a session exactly matching the passed-in id.
Parameters
session_id (str) – The session ID to search for.
Returns
A Session or None.

## change = iterm2.LocalWriteOnlyProfile()

It does not modify the underlying profile, so only the current session is affected.
A profile that can be modified but not read and does not send changes on each write.

## color = iterm2.Color(random_color(), random_color(), random_color())

Representing color. Describes a color.

## change.set_tab_color(color)
Sets the tab color.

## await session.async_set_profile_properties(change)
Sets the value of properties in this session.
You can safely create this with LocalWriteOnlyProfile(). Use async_set_profile_properties() to update a session without modifying the underlying profile.

## change.set_use_tab_color(True)
Sets whether the tab color should be used.
Parameter - A boolean

## iterm2.run_forever(main)
This starts the script and keeps it running even after main returns so it can continue to process New session & Tab creation until iTerm2 terminates. This is what makes it a long-running daemon.
