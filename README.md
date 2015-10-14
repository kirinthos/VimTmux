My Vim and Tmux configuration

lots of integration between tmux and vim, i would suggest reading through the vimrc and tmux.conf before using just to see what's going on in there

to use:

	* copy vimrc 		=> ~/.vimrc
	* copy tmux.conf 	=> ~/.tmux.conf
	* copy vim 			=> ~/.vim

run git submodule update --init --recursive (or clone recursively) to acquire all of my plugins. 

everything should work out of the box except that you will have to build YouCompleteMe

requires vim and tmux (perhaps obviously) you can use vim without tmux, it shouldn't cause a problem

	* sudo apt-get install vim tmux
	* sudo pacman -S vim tmux
	* brew install vim tmux
	* sudo <some manager> <sync operation> vim tmux
	* windows? (shrug) 
