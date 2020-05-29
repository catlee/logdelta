Why
===
In my work I end up staring at a log of logs with timestamps in them. One of
the things I'm usually trying to figure out is where time is being spent.

Installation
============
Use your favourite vim plugin manager, e.g.:

```
Plug 'catlee/logdelta'
```

Usage
=====
Open up a log file with timestamps in a supported format, then hit enter
`<leader>p` in normal mode.

The [quickfix](https://vimhelp.org/quickfix.txt.html) window will open,
populated by log lines, sorted by how long they
appear to have taken.

![Image](https://atlee.ca/pics/logdelta.png)

Formats
=======
Currently only supports lines matching `HH:MM:SS`.

License
=======
MPL 2.0
