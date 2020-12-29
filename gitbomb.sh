#!/bin/sh

file="$1"
layers="${2:-16}"
entries="${3:-16}"

obj_hash="$(git hash-object -w "$file")"
obj_type=blob
obj_perms=100644
for l in $(seq "$layers")
do
	obj_hash=$(for e in $(seq "$entries")
	do
		echo "$obj_perms $obj_type $obj_hash	$e"
	done | git mktree)
	obj_type=tree
	obj_perms=040000
done

git commit-tree -m 'this is a big commit' "$obj_hash"
