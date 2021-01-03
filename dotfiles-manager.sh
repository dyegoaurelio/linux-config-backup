rm -rf dotfiles/clone

git clone dotfiles dotfiles/clone

/usr/bin/git --git-dir=$HOME/coding/Pop_Os-Config-Backup/dotfiles --work-tree=$HOME reset --hard

alias dotfiles-manager='/usr/bin/git --git-dir=$HOME/coding/Pop_Os-Config-Backup/dotfiles --work-tree=$HOME'
bash