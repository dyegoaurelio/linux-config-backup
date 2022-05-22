/usr/bin/git --git-dir=$HOME/coding/linux-config-backup/dotfiles --work-tree=$HOME add -u

/usr/bin/git --git-dir=$HOME/coding/linux-config-backup/dotfiles --work-tree=$HOME commit -m "atualizando dotfiles"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CURR_DIR=$PWD

cd $SCRIPT_DIR

git add .
git commit -m "atualizando dotfiles"
git push origin

cd $CURR_DIR