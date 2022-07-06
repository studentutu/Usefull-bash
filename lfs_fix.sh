#!/usr/bin/env sh


lfs_files=($(git lfs ls-files -n))
for file in "${lfs_files[@]}"; do
  git cat-file -e "HEAD:${file}" && git cat-file -p "HEAD:${file}" > "$file"
done
;
rm -rf .git/lfs/objects