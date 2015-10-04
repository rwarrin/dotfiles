
# variables
dir = ~/.environment
oldfiles_dir = ~/dotfiles_old
files = "bashrc vimrc"

echo -n "Creating $oldfiles_dir for backup of existing dotfiles in ~ ..."
mkdir -p $oldfiles_dir
echo "done"

echo -n "Moving any existing dot files from ~ to $oldfiles_dir ..."
for file in $files; do
	mv ~/.$file ~/dotfiles_old/
done
echo "done"

for file in $files; do
	echo -n "Creating symlink to $file in home directory..."
	ln -s $dir/$file ~/.$file
	echo "done"
done

echo "Installing Vim Plugins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter
echo "done"

echo "Installing Base16-Shell..."
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
echo "done"

echo "Installation complete!"
echo "Bash must be restarted in order for changes to take affect."

read -p "Press [ENTER] to reload bash..."
exec bash -l
