#!/usr/bin/env bash
set -e
my_dir="$(readlink -f "$(dirname "$0")")"

dotfiles_remote="git@github.com:dezgeg/dotfiles.git"
secrets_remote="tmtynkky@melkki.cs.helsinki.fi:cshome/secrets.git"
secrets_dir="$my_dir/secrets"

uninstall=0
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
        "-u")
            uninstall=1
            skip_secrets=1
            shift;;
        *)
            echo "Invalid arg: $arg"
            exit 1;;
    esac
done

for file in "$my_dir"/* "$my_dir"/.* ; do
    file="$(basename "$file")"
    case "$file" in
        .|..|.git|.gitignore|share|secrets|sync.sh|.sw*|.*.sw*) continue;;
    esac

    home_file="$HOME/$file"
    backup_file="$HOME/$file.bak"
    dotfiles_file="$my_dir/$file"

    if [ "$uninstall" = 1 ]; then
        if [ -L "$home_file" ]; then
            run_cmd rm "$home_file"
        fi
    else
        if [ -L "$home_file" ]; then
            echo "$home_file: already symlinked"
        else
            if [ -e "$home_file" ]; then
                if [ -e "$backup_file" ]; then
                    echo "$home_file: already exists and can't make backup $backup_file."
                    exit 1
                fi
                run_cmd mv "$home_file" "$backup_file"
            fi
            run_cmd ln -s "$dotfiles_file" "$home_file"
        fi
    fi
done

chmod 700 ~/.ssh      2>/dev/null
chmod -R 600 ~/.ssh/* 2>/dev/null

if [ $skip_secrets = 0 ]; then
    if [ ! -d "$secrets_dir" ]; then
        run_cmd git clone "$secrets_remote" "$secrets_dir"
    else
        pushd "$secrets_dir" >/dev/null
        run_cmd git pull
        popd >/dev/null
    fi
    run_cmd chmod -R a-rw,u=rwX "$secrets_dir" >/dev/null
    echo

    pushd "$my_dir" >/dev/null
    git remote rm origin
    git remote add origin "$dotfiles_remote"
    git fetch origin
    git push -u origin master
    popd >/dev/null
fi
