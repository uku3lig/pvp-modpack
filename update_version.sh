#!/usr/bin/env bash

PACK_FILE="pack.toml"
TO_EDIT=(
    "pack.toml"
    "config/isxander-main-menu-credits.json"
    "config/craftpresence.json"
)

# check if tomlq is installed, exit otherwise
if ! command -v tomlq &> /dev/null
then
    echo "tomlq could not be found"
    exit
fi

# get new version from arguments
if [ -z "$1" ]
then
    echo "No version argument supplied"
    exit
fi
NEW_VERSION=$1

# query pack file for version with tomlq
OLD_VERSION=$(tomlq ".version" $PACK_FILE | tr -d '"' | sed -n 's/\(.*\)+.*$/\1/p')
echo "$OLD_VERSION -> $NEW_VERSION"

# replace old version with new in all files
for file in "${TO_EDIT[@]}"
do
    sed -i "s/$OLD_VERSION/$NEW_VERSION/g" "$file"
done

# commit
git commit -am "chore: bump version to ${NEW_VERSION}"
