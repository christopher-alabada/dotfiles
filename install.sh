#!/bin/bash
## Simple install script

symlinks=()
install_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ignore_files=('install.sh' 'README.md')

for commit_file in *
do
  # Don't do ignore_files
  if [[ " ${ignore_files[@]} " =~ " ${commit_file} " ]]
  then
    continue
  fi

  dotfile="${HOME}/.${commit_file}"

  if [[ ! -L ${dotfile} ]]
  then
    # Backup if real file
    if [ -e ${dotfile} ]
    then
      mv "${dotfile}" "${dotfile}.backup"
      echo "Backed up ${dotfile} to ${dotfile}.backup"
    fi

    # Symlink if it doesn't exist
    ln -s "${install_dir}/${commit_file}" "${dotfile}"

    echo "Created symlink ${dotfile} -> ${install_dir}/${commit_file}"
  fi
done

exit 0
