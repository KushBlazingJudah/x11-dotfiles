# WSJ's X11 dotfiles

![desktop image](/.local/share/wsj/desktop.png)
<br>
![desktop -9 image](/.local/share/wsj/desktop9.png)

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

## Setup

See `wsj-set-desktop` in my [my Alpine repo](https://github.com/KushBlazingJudah/alpine-repo).
Install the packages from there, build my Suckless builds, run `settheme
gruvbox-dark`, and run everything in `~/.local/lib/setup`.

Extra files:

- `~/.local/private/location`: Latitude, longitude, and friendly name for a
  location. Tab separated, all on one line. Used for redshift and wttr.
