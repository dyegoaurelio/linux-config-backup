# script to install my workflow on Pop!_Os 20.10

#gettig options
installFonts=TRUE
# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o hc: -l help,no-download-fonts,clong: -- "$@")
then
    # something went wrong, getopt will put out an error message for us
    exit 1
fi

set -- $options

while [ $# -gt 0 ]
do
    case $1 in

    
    -a|--along) echo a ;;
    -h|--help) 
    echo "Just run with no arguments to install all programs"
    echo "--no-download-fonts                to dont download all fonts to be compatible with windows"
    exit 0;
    ;;
    --no-download-fonts) installFonts=FALSE;;
    # for options with required arguments, an additional shift is required
    -c|--clong) cargument="$2" ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done

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
#TODO FIX WOEUSB INSTALL
rm woeusb.deb


# replace libreoffice to wps office
flatpak install flathub com.wps.Office -y
sudo apt-get -y remove --purge libreoffice* 
sudo apt -y clean
sudo apt-get -y autoremove
#install fonts
wget https://codeload.github.com/udoyen/wps-fonts/zip/master -O wpsfonts.zip
unzip wpsfonts.zip -d wpsfonts
rm wpsfonts.zip
sudo mkdir -p /usr/share/fonts/kingsoft
sudo cp -a wpsfonts/wps-fonts-master/wps/. /usr/share/fonts/kingsoft/
sudo rm -r wpsfonts

if [[ $installFonts == TRUE ]]
then
    wget https://codeload.github.com/dyegoaurelio/linuxfonts/zip/main -O allfonts.zip
    unzip allfonts.zip -d allfonts
    rm allfonts.zip
    sudo cp -a  allfonts/linuxfonts-main/. /usr/share/fonts/kingsoft/
    sudo rm -r allfonts
fi

sudo chown -R $USER:$USER /usr/share/fonts/kingsoft
sudo chmod -R o+rw,g+rw /usr/share/fonts/kingsoft
sudo fc-cache -vfs

# install vscodium 
wget -qO - [https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg](https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg) | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] [https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/](https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/) vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium
#codium extensions
codium --install-extension esbenp.prettier-vscode
codium --install-extension yzhang.markdown-all-in-one
codium --install-extension CoenraadS.bracket-pair-colorizer-2
codium --install-extension Equinusocio.vsc-material-theme-icons
codium --install-extension Equinusocio.vsc-material-theme

#install programming languages
sudo apt install python3 python3-pip
pip install jupyter notebook

sudo apt install nodejs npm

#TO DO
#config firefox
#config git
