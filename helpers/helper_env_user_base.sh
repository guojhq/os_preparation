. ${HELPERS}/_check_variable_current_user.sh

#-----------------------------------------------------------------------------------------
#Self Customize ${user_home}/.all
#-----------------------------------------------------------------------------------------

local current_user_home="$(getent passwd "$current_user" | cut -d':' -f6)"
local files=($(ls -a $HELPER_VIEW_FOLDER/user_home | grep -E "^\.[A-Za-z0-9_]+$"))

sed -i '/bash_base\//d' $current_user_home/.bashrc
echo 'source $HOME/.bash_base/.base' >> $current_user_home/.bashrc

for file in ${files[@]}
do
  rm -rf ${current_user_home}/$file
  \cp -a $HELPER_VIEW_FOLDER/user_home/$file ${current_user_home}/$file
done
RENDER_CP $HELPER_VIEW_FOLDER/user_home/.gitconfig ${current_user_home}/.gitconfig
test -f /etc/screenrc && mv /etc/screenrc /etc/screenrc.bak

#-----------------------------------------------------------------------------------------
#Setup Vim Setting
#-----------------------------------------------------------------------------------------
mkdir -p ${current_user_home}/.vim/autoload ${current_user_home}/.vim/bundle && \
curl -LSso ${current_user_home}/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd ${current_user_home}/.vim/bundle
git clone git://github.com/godlygeek/tabular.git
git clone https://github.com/Raimondi/delimitMate.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/vim-airline/vim-airline.git
#git clone https://github.com/vim-airline/vim-airline-themes

#Show git branch name
git clone git://github.com/tpope/vim-fugitive.git
#git clone git://github.com/airblade/vim-gitgutter.git

#-----------------------------------------------------------------------------------------
#Make sure user_home priv is correct
#-----------------------------------------------------------------------------------------
chown -R ${current_user}.${current_user} ${current_user_home}