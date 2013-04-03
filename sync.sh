#!/bin/bash -e
my_dir="$(readlink -f "$(dirname "$0")")"

secrets_remote="tmtynkky@melkki.cs.helsinki.fi:secrets.git"
secrets_dir="$my_dir/secrets"
file_list="$my_dir/files.list"

dry_run=0
skip_secrets=0

run_cmd() {
    echo "Running:" "$@"
    if [ $dry_run = 0 ]; then
        "$@"
    fi
}

die() {
    echo "$@"
    exit 1
}

for arg; do
    case "$arg" in
        "-d")
            dry_run=1
            shift;;
        "-n")
            skip_secrets=1
            shift;;
        *)
            echo "Invalid arg: $arg"
            exit 1;;
    esac
done

if [ $skip_secrets = 0 ]; then
    if [ ! -d "$secrets_dir" ]; then
        run_cmd git clone "$secrets_remote" "$secrets_dir"
    else
        pushd "$secrets_dir" >/dev/null
        run_cmd git pull
        popd >/dev/null
    fi
    run_cmd chmod -R a-rw,u=rwX "$secrets_dir"
    echo
fi

[ ! -f "$file_list" ] && die "$file_list: not found"

for file in $(cat "$file_list"); do
    file="$(basename "$file")"
    home_file="$HOME/$file"
    backup_file="$HOME/$file.bak"
    dotfiles_file="$my_dir/$file"

    if [ -L "$home_file" ]; then
        echo "$home_file: already symlinked"
    elif [ -e "$home_file" -a -e "$backup_file" ]; then
        echo "$home_file: already exists and can't make backup $backup_file."
        exit 1
    elif [ ! -e "$home_file" -a ! -e "$dotfiles_file" ]; then
        echo "$home_file: missing from dotfiles and homedir"
        exit 1
    else
        if [ ! -e "$dotfiles_file" ]; then
            run_cmd mv "$home_file" "$dotfiles_file"
        elif [ -e "$home_file" ]; then
            run_cmd mv "$home_file" "$backup_file"
        fi
        run_cmd ln -s "$dotfiles_file" "$home_file"
    fi
done
