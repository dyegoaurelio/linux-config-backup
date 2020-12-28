# script to install my workflow on Pop!_Os 20.10
sudo apt install wmctrl -y # required for some shortcuts
sudo apt install gnome-tweaks -y
dconf write /org/gnome/desktop/interface/gtk-enable-primary-paste true # para ativar o middle click to paste no terminal

# install gnome extensions 
bash download-gnome-extensions.sh "https://extensions.gnome.org/extension-data/clipboard-indicatortudmotu.com.v37.shell-extension.zip"
bash download-gnome-extensions.sh "https://extensions.gnome.org/extension-data/workspace_scroll%40squgeim.com.np.v5.shell-extension.zip"
bash download-gnome-extensions.sh "https://extensions.gnome.org/extension-data/audio-output-switcheranduchs.v12.shell-extension.zip"

rm gnome-extension.zip

# create cls alias to clear command
sudo ln -n /usr/bin/clear /usr/bin/cls

# install most used utilities
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.getpostman.Postman -y
sudo apt-get install kdeconnect -y

# install less used utilities
sudo apt install kazam -y 
flatpak install flathub org.gnome.clocks -y
#woeUsb para instalar isos de Windows
sudo apt install libwxgtk3.0-gtk3-dev -y
wget http://mirrors.edge.kernel.org/ubuntu/pool/universe/w/wxwidgets3.0/libwxgtk3.0-0v5_3.0.4+dfsg-3_amd64.deb -O woeusb.deb
sudo dpkg -i woeusb.deb
rm woeusb.deb


# replace libreoffice to wps office
flatpak install flathub com.wps.Office -y
sudo apt-get remove --purge libreoffice* && sudo apt clean && sudo apt-get autoremove
#install fonts
wget https://codeload.github.com/udoyen/wps-fonts/zip/master -O wpsfonts.zip
unzip wpsfonts.zip
rm wpsfonts.zip
sudo mkdir -p /usr/share/fonts/kingsoft
sudo cp -a wpsfonts/wps/. /usr/share/fonts/kingsoft/
sudo rm -r wpsfonts

wget https://codeload.github.com/dyegoaurelio/linuxfonts/zip/main -O allfonts.zip
unzip allfonts.zip
rm allfonts.zip
sudo cp -a  allfonts/. /usr/share/fonts/kingsoft/
sudo rm -r allfonts

sudo chown -R $USER:$USER /usr/share/fonts/kingsoft
sudo chmod -R o+rw,g+rw /usr/share/fonts/kingsoft
sudo fc-cache -vfs
