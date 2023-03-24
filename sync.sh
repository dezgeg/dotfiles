#!/usr/bin/env bash
set -e
my_dir="$(readlink -f "$(dirname "$0")")"

dotfiles_remote="git@github.com:dezgeg/dotfiles.git"
secrets_remote="dezgeg@kapsi.fi:secrets.git"
secrets_dir="$my_dir/secrets"

flag_uninstall=0
flag_dry_run=0
flag_skip_secrets=0

run_cmd() {
    echo "Running:" "$@"
    if [ $flag_dry_run = 0 ]; then
        "$@"
    fi
}

make_link() {
    dotfiles_file=$1
    home_file=$2
    backup_file="$home_file.bak"

    if [ "$flag_uninstall" = 1 ]; then
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

}

die() {
    echo "$@"
    exit 1
}

for arg; do
    case "$arg" in
        "-d")
            flag_dry_run=1
            shift;;
        "-n")
            flag_skip_secrets=1
            shift;;
        "-u")
            flag_uninstall=1
            flag_skip_secrets=1
            shift;;
        *)
            echo "Invalid arg: $arg"
            exit 1;;
    esac
done

for file in $(cd "$my_dir" && echo * .*) ; do
    case "$file" in
        .|..|.config|.git|.gitignore|share|secrets|sync.sh|vim|.sw*|.*.sw*|*.un~|.*.un~) continue;;
    esac

    make_link "$my_dir/$file" "$HOME/$file"
done

mkdir -p "$HOME/.config"
for file in $(cd "$my_dir/.config" && echo *) ; do
    make_link "$my_dir/.config/$file" "$HOME/.config/$file"
done

chmod 700 ~/.ssh      2>/dev/null
chmod -R 600 ~/.ssh/* 2>/dev/null

if [ $flag_skip_secrets = 0 ]; then
    if [ ! -d "$secrets_dir" ]; then
        run_cmd git clone "$secrets_remote" "$secrets_dir"
    else
        (
            cd "$secrets_dir"
            run_cmd git pull --rebase
        )
    fi
    run_cmd chmod -R a-rw,u=rwX "$secrets_dir" >/dev/null
    echo

    (
        cd "$my_dir"
        git remote rm origin
        git remote add origin "$dotfiles_remote"
        git fetch origin
    )
fi
