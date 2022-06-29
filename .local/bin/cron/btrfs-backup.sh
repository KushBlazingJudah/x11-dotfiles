#!/bin/sh -e

# This script requires root permissions, and shouldn't be ran from here.
# Place it in /usr/local/bin or something where it is unlikely to be modified.

if [ "$(id -u)" -ne 0 ]; then
	printf 'This script must be run as root.\n' >&2
	exit 1
fi

SNAPSHOT_TO="/.snap"
BACKUP="/home /"
KEEP="5"

should_skip() {
	for i in $SNAPSHOT_TO $IGNORE; do
		if [ "$i" = "$1" ]; then
			return 0
		fi
	done

	return 1
}

list_for() {
	[ -z "$1" ] && return 1
	for i in "$SNAPSHOT_TO"/*-"$1"; do
		echo "$i"
	done
}

delete_old() {
	list_for "$1" | head -n-"$KEEP" | sort | while read -r line; do
		btrfs -q subvol delete "$line"
	done
}

snap() {
	if should_skip "$1"; then
		return
	fi

	name="${1#/}"
	case "$1" in
		/)	name="root" ;;
		*)	name="$(printf '%s' "$name" | tr -- / -)"
	esac

	btrfs -q subvol snapshot -r -- "$1" "$SNAPSHOT_TO/$(date +%s)-$name"
	delete_old "$name"
}

# /.snap is mounted and unmounted automatically to prevent any unfortunate rm -rf / from messing things up.
# Sure, it may get ignored because it starts with a ., but this makes things mildly safer.

if ! cut -d' ' -f 2 < /proc/mounts | grep -q /.snap; then
	mount /.snap
fi
trap "umount /.snap" EXIT INT # Unmount at exit.

for name in $BACKUP; do
	snap "$name"
done
