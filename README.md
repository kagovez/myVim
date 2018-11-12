- This repository contains vimrc (_vimrc), color theme (colors\) and mswin_v74.vim which is used for CTRL+F (next page) feature since this feature doesn't work properly with mswin.vim provided by Vin80/Vim81.

- This vimrc is tested over the following platforms:
	- ~~Win7-64/HP-8470p~~
	- ~~Win10-64/HP-Spectre~~
	- Win10-Enterprise-64/HP-EliteBook-840-G5
	- WSL/HP-EliteBook-840-G5
	- Win10-Home-64/Lenovo-Yoga-910
	- WSL/Lenovo-Yoga-910
	- (TBC) Linux-raspberrypi-4.1.13-v7+/RPi2. 

- The following features are enabled:

	- ctrlp
		![](ForREADME/ctrlp.png)
    - Press F8 to enable TrinityToggleAll
        ![](ForREADME/F8.png)
    - Press F9 to enable TagList (TrinigyToggleTagList)
        ![](ForREADME/F9.png) 
    - Press F10 to enable SourceExplorer (TrinigyToggleSourceExplorer)
        ![](ForREADME/F10.png)
    - Press F11 to enable NERDTree (TrinigyToggleNERDTree)
        ![](ForREADME/F11.png)
    - Press F12 to call Do_Cstag
        ![](ForREADME/F12-1.png)
        ![](ForREADME/F12-2.png)
    - Type :UpdateTypesFile in EX mode:
        ![](ForREADME/UpdateTypesFile-2.png)

- Vundle is installed in the following path:
	- $VIM/vimfiles/bundle/Vundle.vim

		> For Windows, $VIM = C:\Program Files (x86)\Vim\
		> 
		> \> cd $VIM/vimfiles
        > \> git clone https://github.com/VundleVim/Vundle.vim.git ./bundle/Vundle.vim

		> For Linux
		> $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	- Plugins managed by Vundle are placed in the following path:
		> For Windows, $VIM/vimfiles/bundle/
		> For Linux, ~/.vim/bundle