# WSJ's X11 dotfiles

These dotfiles are simply a rewrite of a rewrite of my original dotfiles.
This time, I'm targeting (mostly) X11 even though I use Wayland, but I need
dotfiles that support things Wayland doesn't really support yet.

Such as:

- Proper IME support
- ...and probably others

These dotfiles are spread across several repositories.
Importantly, you'll want these custom builds of suckless tools:

- [dmenu](https://github.com/KushBlazingJudah/dmenu)
- [dwm](https://github.com/KushBlazingJudah/dwm)
- [slock](https://github.com/KushBlazingJudah/slock)
- [st](https://github.com/KushBlazingJudah/st)
- [sta](https://github.com/KushBlazingJudah/sta)

*All are packaged in
[my Alpine repo](https://github.com/KushBlazingJudah/alpine-repo)*

These four tools lay the foundation for my setup and countless others.
My builds are patched somewhat heavily, but nothing terrible.

Once everything is in place, run the files in `.local/lib/setup` where
appropriate to complete your configuration.

## TODO

Revisit this list every once in a while.

- Write a detailed description of the packages used here to make it easy to
  bootstrap a system.
  - Package a couple things because there are several things in here that are
    not packaged, namely suckless tools.
