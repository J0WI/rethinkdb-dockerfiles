#! /usr/bin/env bash

base=2.3.6
new=$1
suffix=$2

if [[ -z "$1" ]]; then
  echo "cut-new-release: tag not specified" >&2
  exit 1
fi

for distro in ubuntu/* debian/*; do
  mkdir "./$distro/$new"
  sed -e "s/$base/$new$suffix/" "./$distro/$base/Dockerfile" \
    >"./$distro/$new/Dockerfile"
done
git add ./*/"$new"
git commit -m "Add $new"
git tag "$new" -m "$new"
