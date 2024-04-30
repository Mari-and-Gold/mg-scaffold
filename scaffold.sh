#!/bin/bash

scaffold_dir='mg-scaffold'
scaffold_theme_dir="$scaffold_dir/wp-content/themes/mari-and-gold"

echo ""
echo "Starting M+G code base settings sync..."

echo "Check for required 'Theme_Name' parameter..."
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please include the theme name."
    echo -e "Example... \n./scaffold.sh theme-name-here"
    exit 1
fi

theme_dir=$1
theme_dir_path="wp-content/themes/${theme_dir}"
new_scaffold_theme_dir="$scaffold_dir/$theme_dir_path"
echo "Theme name: '$1' found."


echo ""
echo "Check theme directory exists..."
if [ -d "$theme_dir_path" ]; then
    echo "Theme exists."
    echo ""
else
    echo "Theme does not exist: $theme_dir_path"
    exit 1
fi

# clone repo
if [ -d "$scaffold_dir" ]; then
    echo "Scaffold directory already exists: $scaffold_dir. Exiting."
    exit 1
else
    git clone https://github.com/Mari-and-Gold/mg-scaffold.git $scaffold_dir
    echo "Repo cloned. Created $scaffold_dir directory."
    echo ""
fi

echo "Verify scaffold theme directory exists..."
# check destination theme
if [ -d "$scaffold_theme_dir" ]; then
    echo "Scaffold theme found: $scaffold_theme_dir"
    echo ""
else
    echo "Scaffold theme does not exist: $scaffold_theme_dir"
    exit 1
fi

# clean scaffold dir before copying content
echo "Prepare scaffold directory before copying content..."
rm -rf mg-scaffold/.git # not using a variable here as a precaution
rm mg-scaffold/README.md

move_dir_command="mv $scaffold_theme_dir $new_scaffold_theme_dir"
echo "'$move_dir_command'"
eval $move_dir_command

echo "Ready."
echo ""

echo "Sync files..."
sync_command="rsync -av $scaffold_dir/ ./"
echo "'$sync_command'"
eval $sync_command
echo "Sync complete. Removing scaffold directory..."
cleanup_command="rm -rf mg-scaffold"
echo "'$cleanup_command'"
eval $cleanup_command
echo "Done."
echo ""
