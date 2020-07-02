#!/bin/bash
#
# ©2017 Copyright 2017 Robert D. Chin
#
# Usage: bash cliappmenu.sh
#        (not sh cliappmenu.sh)
#
# +----------------------------------------+
# |    Revision number and Revision Date   |
# +----------------------------------------+
#
THIS_FILE="cliappmenu.sh"
REVDATE="December-31-2017 08:01"
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
# Script cliappmenu.sh is a menu of CLI applications and commands
# to help CLI newbies to discover what a command line can do.
#
# Please see the file README for more information.
# The "#:" at the beginning of lines below are used
# to delineate the Help Instructions.
#:
#:   Brief Description
#:   FILE LOCATIONS of cliappmenu project
#:   HOW-TO Update this script
#:   Revision number and Revision Date
#:   Why did I write this script?
#:   Why is this menu so complex?
#:   Script features
#:   HOW-TO Add a new menu item
#:   Trouble-shooting a new menu item
#:   Known problems and limitations
#:   For more help
#:   List of variables
#:   List of Special Menu Item Markers
#
# +----------------------------------------+
# |       GNU General Public License       |
# +----------------------------------------+
#
#LIC This program, cliappmenu.sh is under copyright.
#LIC ©2015 Copyright 2015 Robert D. Chin (rdchin at yahoo.com).
#LIC
#LIC This program is free software: you can redistribute it and/or modify
#LIC it under the terms of the GNU General Public License as published by
#LIC the Free Software Foundation, either version 3 of the License, or
#LIC (at your option) any later version.
#LIC 
#LIC This program is distributed in the hope that it will be useful,
#LIC but WITHOUT ANY WARRANTY; without even the implied warranty of
#LIC MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#LIC GNU General Public License for more details.
#LIC 
#LIC You should have received a copy of the GNU General Public License
#LIC along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# The "#:" at the beginning of lines below are used
# to delineate the Help Instructions.
#:
#: +----------------------------------------+
#: |      Why did I write this script?      |
#: +----------------------------------------+
#:
#: I wrote this script for 3 reasons:
#: 1. I wanted a categorized list of command line applications.
#: 2. I wanted to learn bash scripting, i.e. functions, looping, tests.
#: 3. I couldn't find a cli menu to launch cli apps on the web so I thought I'd
#:    give back to the community and perhaps others could build on and improve
#:    on what I've started.
#:
#: Please enjoy . . . bob chin (2017).
#:                    rdchin at yahoo.com.
#:
#:
#@ +----------------------------------------+
#@ |            Menu Features               |
#@ +----------------------------------------+
#@
#@ ----------------------------------------------------
#@ At the menu prompt, you can enter OPTIONS and FILES.
#@ ----------------------------------------------------
#@
#@ <application name> [OPTIONS]
#@
#@ <application name> [OPTIONS] [FILES]
#@
#@ Examples:
#@
#@ For a web browser:
#@ elinks www.lxer.com
#@
#@ To compare two text files:
#@ colordiff --side-by-side --suppress-common-lines <file name 1> <file name 2>
#@
#@
#@ --------------------------------------------------------------------------
#@ How to add your favorite applications to the "Favorite Applications Menu".
#@ --------------------------------------------------------------------------
#@
#@ For example, suppose you are in the Arcade Games Menu:
#@ 
#@ --- Arcade Games Menu ---
#@
#@ 0 - Return to previous menu.
#@ 1 - ascii-invaders - Space Invader clone.
#@ 2 - asciijump      - Ski jump game.
#@ ...
#@ 8 - ninvaders      - Space invaders-like game ncurses-based.
#@
#@ Enter 0 to 15 or letters: 8f
#@
#@ The response, "8f" indicates that you want to add "ninvaders"
#@ to your favorites menu.
#@
#@ The file "cli-app-menu-favorites.txt"
#@ can also be edited to delete menu entries.
#@
#@ 
#@ +----------------------------------------+
#@ |      General help on an application    |
#@ +----------------------------------------+
#@
#@ 1.    <application name> --help
#@
#@              joe --help
#@       Example for help on the 'joe' text editor, 
#@
#@ 2.    man <application name>       Where 'man' is short for 'manual'
#@
#@       Example for more help on the 'joe' text editor,
#@              man joe
#@
#@ Just remember --help (after the name) or man (before the name).
#@
#
# +----------------------------------------+
# |          Function f_test_dash          |
# +----------------------------------------+
#
#  Inputs: $BASH_VERSION (System variable), GUI.
#    Uses: None.
# Outputs: exit 1.
#
f_test_dash () {
      if [ -z "$BASH_VERSION" ]; then 
         # DASH Environment detected, display error message to invoke the BASH environment.
         f_detect_ui # Automatically detect UI environment.
         case $GUI in
              dialog | whiptail)
              f_test_dash_gui $GUI
              ;;
              text)
              f_test_dash_txt
              ;;
         esac
         exit 1 # Exit with value $?=1 indicating an error condition
                # and stop running script.
      fi
} # End of function f_test_dash
#
# +----------------------------------------+
# |        Function f_test_dash_txt        |
# +----------------------------------------+
#
#  Inputs: FCOLOR, BCOLOR, UCOLOR, ECOLOR.
#    Uses: None.
# Outputs: None.
#
f_test_dash_txt () {
      # Set default colors in case configuration file is not readable
      # or does not exist.
      FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red"
      #
      clear # Clear screen.
      echo $(tput bold)
      echo "You are using the DASH environment."
      echo "Ubuntu and Linux Mint default to DASH but also have BASH available."
      #
      # Use different color font for error messages.
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      #
      echo "*** This script cannot be run in the DASH environment. ***"
      #
      echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      echo
      echo "You can invoke the BASH environment by typing:"
      echo "'bash cliappmenu.sh' at the command line."
      echo
      #
      # Use different color font for error messages.
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      #
      echo "______________________________"
      echo "    >>> Exiting script <<<"
      echo "______________________________"
      echo $(tput sgr0)
      echo
} # End of function f_test_dash_txt
#
# +----------------------------------------+
# |        Function f_test_dash_gui        |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail").
#    Uses: None.
# Outputs: None.
#
f_test_dash_gui () {
      clear # Clear screen.
      $1 --title ">>> Warning: Must use BASH <<<" --msgbox "\n                   You are using the DASH environment.\n\n        *** This script cannot be run in the DASH environment. ***\n\n    Ubuntu and Linux Mint default to DASH but also have BASH available." 12 78
      #
      $1 --title "HOW-TO" --msgbox "\n  You can invoke the BASH environment by typing:\n    \"bash cliappmenu.sh\" at the command line.\n\n          >>> Now exiting script <<<" 12 55
} # End of function f_test_dash_gui
#
# +----------------------------------------+
# |         Function f_script_path         |
# +----------------------------------------+
#
#  Inputs: $BASH_SOURCE (System variable).
#    Uses: None.
# Outputs: SCRIPT_PATH.
#
f_script_path () {
# BASH_SOURCE[0] gives the filename of the script.
# dirname "{$BASH_SOURCE[0]}" gives the directory of the script
# Execute commands: cd <script directory> and then pwd
# to get the directory of the script.
# NOTE: This code does not work with symlinks in directory path.
#
SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
} # End of function f_script_path
#
# +----------------------------------------+
# |          Function f_detect_ui          |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: ERROR.
# Outputs: GUI (dialog, whiptail, text).
#
f_detect_ui () {
      command -v dialog >/dev/null
      # "&>/dev/null" does not work in Debian distro.
      # 1=standard messages, 2=error messages, &=both.
      ERROR=$?
      # Is Dialog GUI installed?
      if [ $ERROR -eq 0 ] ; then
         # Yes, Dialog installed.
         GUI="dialog"
      else
         # Is Whiptail GUI installed?
         command -v whiptail >/dev/null
         # "&>/dev/null" does not work in Debian distro.
         # 1=standard messages, 2=error messages, &=both.
         ERROR=$?
         if [ $ERROR -eq 0 ] ; then
            # Yes, Whiptail installed.
            GUI="whiptail"
         else
            # No CLI GUIs installed
            GUI="text"
         fi
      fi
} # End of function f_detect_ui
#
# +----------------------------------------+
# |        Function f_main_init_once       |
# +----------------------------------------+
#
#  Inputs: THIS_FILE, GUI.
#    Uses: None.
# Outputs: MAIN_MENU_DIR, THIS_DIR, FCOLOR, BCOLOR, UCOLOR, ECOLOR, TERM.
#
f_main_init_once () {
      # Initialize variables.
      #
      # Each user may store default settings in a configuration file
      # in the user's home folder.
      #
      # Set default colors in case configuration file is not readable
      # or does not exist.
      FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red"
      #
      f_term_color $FCOLOR $BCOLOR # Set terminal color.
      echo -n $(tput bold) # set bold font.
      #
      # Enable 256 colors for terminal, if possible.
      # Set terminal colors from 8 to 256 colors.
      export TERM=xterm-256color       
      #
      # You have the option of either keeping all the program files in the same
      # folder or a separate folder for the Main Menu (file cliappmenu.sh).
      # 
      # MAINMENU_DIR contains the script file cliappmenu.sh.
      # This may be the same directory as $THIS_DIR or may be any other
      # directory you choose.
      #
      # If you are using a single-user PC/laptop, you may simply put the 
      # script in your personal home directory.
      #
      # If multiple users login to the PC/laptop, you may want to put
      # the script in a /usr or an /opt folder with permissions set so 
      # other users may run the script, (rwx-rx-rx) or (755) permissions.
      #
      # i.e. /home/<username_goes_here>/<script-goes-here>
      #      Just put script cliappmenu.sh in your personal home directory.
      #      Other users will have to do the same with their own separate copy.
      #
      #      /home/<username_goes_here>/<cliappmenu sub-directory>
      #      Library module and support files go in the sub-directory.
      #      Other users will have to do the same with their own separate copy.
      #
      # i.e. /usr/local/bin/<script-goes-here>
      #      A single copy of the script, accessible to all users goes here.
      #
      #      /usr/local/bin/<cliappmenu sub-directory>
      #      Create this directory to contain all the library module files
      #      and support files, accessible by all users. 
      #      
      #      The /usr directory contains user applications.
      #
      # i.e. /opt/<script-goes-here>
      #      A single copy of the script, accessible to all users goes here.
      #
      #      /opt/<cliappmenu sub-directory>
      #      Create this directory to contain all the library module files
      #      and support files, accessible by all users.
      #
      #      The /opt directory is another place containing user applications.
      #
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      # MAINMENU_DIR does not need a trailing forward slash "/".
      MAINMENU_DIR="/home/robert/Dropbox/geek/cli-app-menu_git-project"
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      # THIS_DIR contains files: lib_cli-*, mod_apps-*, EDIT_HISTORY,
      # README, and COPYING and (optionally) cliappmenu.sh.
      #
      # THIS_DIR may or may not be the same folder as MAINMENU_DIR.
      # However it should be writable by the user maintaining it so that
      # additional software library modules may be downloaded as they are
      # updated or needed and LIST_APPS can be updated accordingly.
      # 
      # Since this folder will contain multiple files for this project,
      # it may help to name it "cliappmenu" for use by only project files.
      # 
      # If multiple users login to the PC/laptop, the folder $THIS_DIR needs
      # permissions set so other users may read/execute the files,
      # with (rwx-rx-rx) or (755) permissions.
      #
      # Also the $PATH variable must include $MAIN_MENU and $THIS_DIR.
      # Please refer to README for more instructions on how to set the $PATH
      # environmental variable to do this.
      #
      #
      # Why have a separate folder from the one containing cliappmenu.sh?
      #
      # If you are using a single-user PC/laptop, you may simply put the 
      # script in your personal home directory, with all other files in a
      # separate sub-folder so as not to "clog" your home directory with
      # a bunch of new files.
      #
      # Tip: When logging into the console, the user's home directory is the
      # working directory by default. You can automatically run cliappmenu.sh
      # every time you log in by including the script command into your .profile,
      # .bash_profile, or .bashrc file depending on your Linux configuration.
      # See function f_valid_path_txt in this file for a more complete
      # explanation of which file you should use for the PATH statement.
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      # THIS_DIR does not need a trailing forward slash "/".
      THIS_DIR="/home/robert/Dropbox/geek/cli-app-menu_git-project/cli-app-menu"
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      f_detect_ui # Automatically detect UI environment.
      #echo "GUI=$GUI" ; read X  # Diagnostic line.
      case $GUI in
           dialog | whiptail)
           f_main_init_gui $GUI
           ;;
           text)
           f_main_init_txt
           ;;
      esac
      #
      # Invoke the common library to display menus.
      . $THIS_DIR/lib_cli-common.lib    # invoke module/library.
      . $THIS_DIR/lib_cli-menu-cat.lib  # invoke module/library.
      . $THIS_DIR/lib_cli-web-sites.lib # invoke module/library.
} # End of function f_main_init_once
#
# +----------------------------------------+
# |        Function f_main_init_txt        |
# +----------------------------------------+
#
#  Inputs: THIS_DIR, MAINMENU_DIR, SCRIPT_PATH.
#    Uses: None.
# Outputs: FCOLOR, BCOLOR, UCOLOR, ECOLOR. 
#
f_main_init_txt () {
      # Does configuration file exist and is readable?
      if [ ! -r ~/.cliappmenu.cfg ] ; then
         # No, configuration file does not exist. Create file.
         f_missing_config_txt
      fi
      #
      if [ -r ~/.cliappmenu.cfg ] ; then
         # Yes. read file contents.
         . ~/.cliappmenu.cfg
         f_main_config
      else      
         # No. Use default settings.
         FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red" ; GUI="text"
      fi
      #
      # Validate file names and directories.
      # Use the directory $SCRIPT_DIR that contains the script cliappmenu.sh.
      # Does $SCRIPT_DIR = $MAINMENU_DIR?
         # Yes, exit function.
      if [ "$SCRIPT_PATH" != "$MAINMENU_DIR" ] ; then
         # No, edit script cliappmenu.sh so that $MAINMENU_DIR is $SCRIPT_DIR.
         f_change_mainmenu_dir_txt
      fi
      f_valid_files_txt "$THIS_DIR" "lib_cli-common.lib"
      f_valid_files_txt "$THIS_DIR" "lib_cli-web-sites.lib"
      f_valid_files_txt "$THIS_DIR" "lib_cli-menu-cat.lib"
} # End of function f_main_init_txt
#
# +----------------------------------------+
# |        Function f_main_init_gui        |
# +----------------------------------------+
#
#  Inputs: $1=GUI (dialog, whiptail), THIS_DIR, MAIN_MENU_DIR, SCRIPT_PATH.
#    Uses: None.
# Outputs: FCOLOR, BCOLOR, UCOLOR, ECOLOR. 
#
f_main_init_gui () {
      # Does configuration file exist and is readable?
      if [ ! -r ~/.cliappmenu.cfg ] ; then
         # No, configuration file does not exist. Create file.
         f_missing_config_gui $1
      fi
      #
      if [ -r ~/.cliappmenu.cfg ] ; then
         # Yes. read file contents.
         . ~/.cliappmenu.cfg
         f_main_config
      else      
         # No. Use default settings.
         FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red" ; GUI="text"
      fi
      #
      # Validate file names and directories.
      # Use the directory $SCRIPT_DIR that contains the script cliappmenu.sh.
      # Does $SCRIPT_DIR = $MAINMENU_DIR?
         # Yes, exit function.
      if [ "$SCRIPT_PATH" != "$MAINMENU_DIR" ] ; then
         # No, edit script cliappmenu.sh so that $MAINMENU_DIR is $SCRIPT_DIR.
         f_change_mainmenu_dir_gui $1
      fi
      #
      f_valid_files_gui $1 "$THIS_DIR" "lib_cli-common.lib"
      f_valid_files_gui $1 "$THIS_DIR" "lib_cli-web-sites.lib"
      f_valid_files_gui $1 "$THIS_DIR" "lib_cli-menu-cat.lib"
} # End of function f_main_init_gui
#
# +----------------------------------------+
# |      Function f_missing_config_txt     |
# +----------------------------------------+
#
#  Inputs: FCOLOR, BCOLOR, ECOLOR. 
#    Uses: X.
# Outputs: Create the "~/.cliappmenu.cfg" file.
#
f_missing_config_txt () {
      clear # Clear screen.
      # If background color is black or blue, then use yellow font.
      #
      # Use different color font for error messages.
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      echo
      echo "Configuration file is missing from user's home directory."
      echo
      echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      echo
      echo "Creating configuration file: /home/<username_goes_here>/.cliappmenu.cfg"
      echo "If you want to use \"Dialog\" or \"Whiptail\" GUI, select \"Configure\" menu option to change."
      echo "f_main_config () {" > ~/.cliappmenu.cfg
      echo "      GUI=\"text\"" >> ~/.cliappmenu.cfg
      echo "      FCOLOR=\"Green\" ; BCOLOR=\"Black\" ; UCOLOR=\"\" ; ECOLOR=\"Red\"" >> ~/.cliappmenu.cfg
      echo "} # End of function f_main_config" >> ~/.cliappmenu.cfg
      echo
      echo -n "Press \"Enter\" key to continue."
      read X
      unset X  # Throw out this variable.
} # End of function f_missing_config_txt
#
# +----------------------------------------+
# |      Function f_missing_config_gui     |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail").
#    Uses: None.
# Outputs: Create the "~/.cliappmenu.cfg" file.
#
f_missing_config_gui () {
      clear # Clear screen.
      $1 --title ">>> Warning: Configuration file missing <<<" --msgbox "\n      Configuration file is missing from user's home directory.\n\nCreating configuration file: /home/<username_goes_here>/.cliappmenu.cfg\n\n If you want to use \"$1\" GUI, select \"Configure\" menu option to change.\n\n                     Press 'Enter' key to continue." 12 78
      echo "f_main_config () {" > ~/.cliappmenu.cfg
      echo "      GUI=\"text\"" >> ~/.cliappmenu.cfg
      echo "      FCOLOR=\"Green\" ; BCOLOR=\"Black\" ; UCOLOR=\"\" ; ECOLOR=\"Red\"" >> ~/.cliappmenu.cfg
      echo "} # End of function f_main_config" >> ~/.cliappmenu.cfg
      echo
} # End of function f_missing_config_gui
#
# +----------------------------------------+
# |   Function f_change_mainmenu_dir_txt   |
# +----------------------------------------+
#
#  Inputs: BCOLOR, ECOLOR, SCRIPT_PATH, THIS_FILE, MAIN_MENU_DIR.
#    Uses: ERROR.
# Outputs: exit 1.
#
f_change_mainmenu_dir_txt () {
      clear # Clear screen.
      # If background color is black or blue, then use yellow font.
      #
      # Use different color font for error messages.
      f_term_color $ECOLOR $BCOLOR
      echo "Detected different directory reference for script:"
      echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      echo
      echo "Changing from:"
      echo "   $MAINMENU_DIR"
      echo
      echo "Changing to:"
      echo "   $SCRIPT_PATH"
      echo
      echo "This directory should contain the script \"$THIS_FILE\"."
      echo "Automatically re-configuring \"$THIS_FILE\" to use new directory."
      echo
      # Is directory writable?
      if [ -w $SCRIPT_PATH ] ; then
         # Yes, directory is writable.
         sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/$THIS_FILE
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error re-configuring \"$THIS_FILE\" to use new directory."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi   
      else
         # No, directory is not writable so use sudo permissions.
         echo "Must now use sudo permissions to re-configure \"$THIS_FILE\"."
         sudo sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/$THIS_FILE
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo "Error re-configuring,\"$THIS_FILE\" to use new directory"
            echo "            even when using sudo permissions."
            echo $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi
      fi
      #
      # Message to restart script.
      # Use different color font for error messages.
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      echo "___________________________________________"
      echo " Re-run script to use new script directory."
      echo "           >>> Exiting script <<<"
      echo "___________________________________________"
      echo $(tput sgr0)
      # Exit function and exit script to system prompt.
      exit 1
} # End of function f_change_mainmenu_dir_txt.
#
# +----------------------------------------+
# |   Function f_change_mainmenu_dir_gui   |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), SCRIPT_PATH, THIS_FILE,
#          MAIN_MENU_DIR.
#    Uses: XSTR, ERROR.
# Outputs: exit 1.
#
f_change_mainmenu_dir_gui () {
      clear # Clear screen.
      $1 --title "Changing Directory" --msgbox "\n              Detected different directory reference for script:\n\nChanging from:\n    $MAINMENU_DIR\n\nChanging to:\n   $SCRIPT_PATH\n\nThis directory should contain the script \"$THIS_FILE\".\nAutomatically re-configuring \"$THIS_FILE\" to use new directory." 15 75
      # Is directory writable?
      if [ -w $SCRIPT_PATH ] ; then
         # Yes, directory is writable.
         sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/$THIS_FILE
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            $1 --title ">>> Error <<<" --msgbox "\nError re-configuring \"$THIS_FILE\" to use new directory." 8 60
         fi
      else
         # No, directory is not writable so use sudo permissions.
         # Redirect dialog/whiptail --passwordbox output to $XSTR.
         # Exit status: Yes/OK=0 No/Cancel=1 Error=-1 ESC=255.
         ERROR=-1
         while [ $ERROR -ne 0 ]
         do
            f_sudo_password_gui $1 # Outputs $XSTR=<sudo password>, ERROR=$?.
            case $ERROR in
                 0) # OK button pressed.
                 echo $XSTR | sudo -S sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/$THIS_FILE &>/dev/null
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    $1 --clear --title ">>> Error <<<" --msgbox "\n     Error re-configuring,\"$THIS_FILE\" to use new directory\n            even when using sudo permissions." 10 70
                 fi
                 ;;
                 1 | 255) # Cancel button pressed.
                 ERROR=0
                 $1 --clear --title ">>> Error <<<" --msgbox "\n     Error re-configuring,\"$THIS_FILE\" to use new directory\n            even when using sudo permissions." 10 70
                 ;;
                 -1) # Error occurred.
                 $1 --clear --title ">>> Error <<<" --msgbox "\n     Error re-configuring,\"$THIS_FILE\" to use new directory\n            even when using sudo permissions." 10 70
                 ;;
            esac
         done
         unset XSTR
      fi
      #
      # Message to restart script.
      $1 --title "Exiting Script" --msgbox "\n        Re-run script to use new script directory.\n               >>> Exiting script <<<" 10 60
      # Exit function and exit script to system prompt.
      exit 1
} # End of function f_change_mainmenu_gui.
#
# +----------------------------------------+
# |      Function f_initvars_menu_app      |
# +----------------------------------------+
#
#  Inputs: $1=For-Loop variable.
#    Uses: X, INITVAR.
# Outputs: MAINMENU_DIR, THIS_DIR, APP_NAME.
#          MENU_ITEM, ERROR.
#
f_initvars_menu_app () {
      echo $(tput bold) # Display bold font for all menus.
      ERROR=0        # Initialize to 0 to indicate success at running last
                     # command.
      #
      # Initialize variables to "" or null.
      for INIT_VAR in APP_NAME
      do
          eval $INIT_VAR="" # eval sets the variables to "" or null.
      done
      #
      # Initialize variables to -1 to force looping in until loop(s).
      for INIT_VAR in MENU_ITEM $1
      do
          eval $INIT_VAR=-1 # eval sets the variables to "-1".
      done
      unset X
} # End of function f_initvars_menu_app
#
# +----------------------------------------+
# |        Function f_valid_files_txt      |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File, FCOLOR, BCOLOR, ECOLOR, GUI, PATH.
#    Uses: X, NEW_DIR
# Outputs: None.
#
f_valid_files_txt () {
      # Check for required files and directories.
      # Is the required file in an existing directory?
      NEW_DIR=$1  # Initialize NEW_DIR changed if new directory is created.
      if [ ! -r "$1/$2" ] ; then
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         clear  # Blank the screen.
         if [ ! -e "$1" ] ; then
            echo "The directory:"
            echo "   $1"
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo "Does not exist and needs to be either created or changed to a valid directory."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            echo
            echo -n "Press \"Enter\" key to continue."
            read X
            f_change_dir $GUI $1 # Outputs $NEW_DIR.
         else
            f_term_color $ECOLOR $BCOLOR
            echo -n $(tput bold)
            echo "A required file, \"$2\" is missing."
            echo $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            echo
            echo "Choices to fix the problem will be shown in the next menu."
            echo
            echo -n "Press \"Enter\" key to continue."
            read X
         fi
         #
         if [ -n "$NEW_DIR" ] ; then
            f_valid_menu_txt $NEW_DIR $2
         else
            f_valid_menu_txt $1 $2
         fi
         f_valid_path_txt $NEW_DIR
            echo -n "Press \"Enter\" key to continue."
            read X
            clear
         f_valid_exit_txt $1 $NEW_DIR
      else
         f_valid_path_txt $NEW_DIR
         if [[ ! "$PATH" == *":$NEW_DIR"* ]] ; then
            echo
            echo -n "Press \"Enter\" key to continue. "
            read X
            clear
            f_valid_exit_txt $1 $NEW_DIR
         fi
      fi
      unset X
} # End of function f_valid_files_txt
#
# +----------------------------------------+
# |        Function f_valid_files_gui      |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Directory, $3=File, PATH.
#    Uses: NEW_DIR.
# Outputs: None.
#
f_valid_files_gui () {
      # Check for required files and directories.
      # Is the required file in an existing directory?
      NEW_DIR=$2  # Initialize NEW_DIR changed if new directory is created.
      if [ ! -r "$2/$3" ] ; then
         if [ ! -e "$2" ] ; then
            $1 --title ">>> Error <<<" --msgbox "\nThe directory:\n   $2\n\nDoes not exist and needs to be either created or changed\nto a valid directory." 15 75
            f_change_dir $1 $2 #Outputs $NEW_DIR.
         else
            $1 --title ">>> Error <<<" --msgbox "\nA required file, \"$3\" is missing.\n\nChoices to fix the problem will be shown in the next menu." 10 50
            echo
         fi
         #
         if [ -n "$NEW_DIR" ] ; then
            f_valid_menu_gui $1 $NEW_DIR $3
         else
            f_valid_menu_gui $1 $2 $3
         fi
         f_valid_path_gui $1 $NEW_DIR
         f_valid_exit_gui $1 $NEW_DIR
      else
         f_valid_path_gui $1 $NEW_DIR
         if [[ ! "$PATH" == *":$NEW_DIR"* ]] ; then
            f_valid_exit_gui $1 $NEW_DIR
         fi
      fi
} # End of function f_valid_files_gui
#
# +----------------------------------------+
# |        Function f_valid_menu_txt       |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File, NEW_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: AAD, MENU_TITLE.
# Outputs: NEW_DIR.
#
f_valid_menu_txt () {
      f_initvars_menu_app "AAD"
      # Please note: This menu is a primitive, hard-coded menu because
      #              the function "f_show_menu" in library module file,
      #              "lib-cli-common.lib" cannot be used at this time,
      #              since that file may not yet exist or
      #              may need to be downloaded from the GitHub web site.
      #
      MENU_TITLE="Validate Files and Directories Menu"
      #
      until [ "$AAD" = "0" ]
      do    # Start of Validate Menu until loop.
            clear  # Blank the screen.
            if [ ! -r "$NEW_DIR/$2" ] ; then
               f_term_color $ECOLOR $BCOLOR
               echo -n $(tput bold)
               echo "Required file:"
               echo "   \"$2\""
               echo
               echo "is missing from directory:"
               echo "   $1"
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo
            else
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo "Required file:"
               echo "   \"$2\""
               echo
               echo "is now in a valid directory:"
               echo "   $1"
               echo 
            fi
            echo "--- $MENU_TITLE ---"
            echo
            echo "0 - Quit to the command line prompt."
            echo "1 - Download file    - Download the missing file from the GitHub web site."
            echo "2 - Change directory - Change the directory to the correct one."
            echo "3 - List files       - List files in directory."
            echo
            echo "'0', (Q)uit, to quit this script."
            echo
            echo -n "Enter 0 to 3 or letters: " # echo -n supresses line-feed.
            #
            read AAD
            case $AAD in
                 0 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
                 AAD=0
                 ;;
                 1 | [Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)
                 f_file_download_txt $1 $2
                 ;;
                 2 | [Cc] | [Cc][Hh] | [Cc][Hh][Aa]*)
                 f_change_dir $GUI $1
                 ;;
                 3 | [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)
                 f_ls_this_dir $1
                 ;;
            esac
      done  # End of Validate Menu until loop.
            #
      unset AAD MENU_TITLE   # Throw out this variable.
} # End of function f_valid_menu_txt
#
# +----------------------------------------+
# |        Function f_valid_menu_gui       |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Directory, $3=File.
#    Uses: AAD
# Outputs: NEW_DIR.
#
f_valid_menu_gui () {
      f_initvars_menu_app "AAD"
      # Please note: The function "f_show_menu" in library module file,
      #              "lib-cli-common.lib" cannot be used at this time,
      #              since that file may not yet exist or
      #              may need to be downloaded from the GitHub web site.
      #
      NEW_DIR=$2 # Set $NEW_DIR to original (possibly invalid) directory.
      #
      # Get user-entered directory name with dialog/whiptail --inputbox.
      # Save user-input with redirection.
      # Redirect stderr (standard error) to stdout (standard output)
      # thus capturing the error code.
      # Redirect stdout to screen (/dev/tty).
      # Capture result of stdout to $NEW_DIR variable.
      until [ "$AAD" = "0" ]
      do    # Start of Validate Menu until loop.
            AAD=$($1 --clear --title "Validate Files and Directories Menu" --menu "\n\nUse (up/down arrow keys) or (0 to 3) or (letters):" 15 70 4 \Quit "Quit to the command line prompt." \Download "Download the missing file from the GitHub web site." \Change "Change the directory to the correct one." \List "List files in directory." 2>&1 >/dev/tty)
            #
            case $AAD in
                 0 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
                 AAD=0
                 ;;
                 1 |[Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)
                 if [ ! -r "$NEW_DIR/$3" ] ; then
                    $1 --msgbox "Required file:\n   \"$3\"\n\nis missing from directory:\n   $NEW_DIR" 11 75
                 else
                    $1 --msgbox "Required file:\n   \"$3\"\n\nis now in a valid directory:\n   $NEW_DIR" 11 75
                 fi
                 f_file_download_gui $1 $NEW_DIR $3
                 ;;
                 2 | [Cc] | [Cc][Hh] | [Cc][Hh][Aa]*)
                 f_change_dir $GUI $NEW_DIR
                 ;;
                 3 | [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)
                 f_ls_this_dir $2
                 ;;
            esac
      done
      unset AAD  # Throw out this variable.
} # End of function f_valid_menu_gui
#
# +----------------------------------------+
# |         Function f_valid_path_txt      |
# +----------------------------------------+
#
#  Inputs: $1=Directory, PATH.
#    Uses: None.
# Outputs: Error code 1 if path is bad.
#
# The session-wide (pertaining to a specific user only, not system-wide)
# setting of the PATH variable can be done in several ways.
#
# 
# 1. Within a GUI environment using a terminal in a window:
#    reads ~/.bashrc.
#
# 2. Within a pure CLI environment without a GUI (Gnome, KDE, XFCE, etc):
#    reads ~/.bash_profile, ~/.bash_login
#    Note: If you invoke a GUI environment using "startx" from the CLI,
#          then you must edit
#          both    ~/.bashrc and ~/.bash_profile files
#          or both ~/.bashrc and ~/.bash_login   files.
#
# 3. Within a pure CLI environment without a GUI (Gnome, KDE, XFCE, etc):
#    reads ~/.profile.
#    Note: If you invoke a GUI environment using "startx" from the CLI,
#          then you must edit
#          both    ~/.bashrc and ~/.profile files.
#
# 4. Non-interactive, non-login shell environment:
#    reads the file contained in the variable BASH_ENV, if exists.
#
#-----------------------------------------
# Detailed information about options 1-4.
#-----------------------------------------
#
# 1. Within a GUI environment using a terminal in a window:
#    Only for Bash shells in a graphical environment in a desktop session.
#    (i.e. Xterm window session already logged in through the GUI Gnome, KDE).
#    WILL NOT WORK in a pure CLI environment login shell.
#    (i.e. ~/.bashrc will not work in a pure CLI environment login shell).
#
#    /home/<username_goes_here>/.bashrc
#                             ~/.bashrc
#
#    Edit the ~/.bashrc file
#    and add the following line to the end of the file.
#                             PATH=$PATH:$HOME/cli-app-menu
#
#
# 2. Within a pure CLI environment without a GUI (Gnome, KDE, XFCE, etc):
#    Only one of these files needs the new PATH statement.
#
#    Will work in most shells in either
#    a graphical environment in a desktop session (i.e. Xterm window session).
#    or a pure CLI environment login shell.
#
#                             ~/.bash_login
#                             ~/.bash_profile
#
#    Edit either the ~/.bash_login or ~/.bash_profile file
#    and add the following line to the end of the file.
#                             PATH=$PATH:$HOME/cli-app-menu
#
#
# 3. Within a pure CLI environment without a GUI (Gnome, KDE, XFCE, etc):
#    The ~/.profile is read last after the ~/.bash_login and ~/.bash_profile.
#
#    WARNING: Ubuntu ignores ~/.profile
#    if ~/.bash_login or ~/.bash_profile exists.
#    So edit ~/.profile only if you do not have either of the above files.
# 
#    Will work in most shells in either
#    a graphical environment in a desktop session (i.e. Xterm window session).
#    or a pure CLI environment login shell.
#
#    /home/<username_goes_here>/.profile
#                             ~/.profile
#
#    Edit the ~/.profile file and add the line below to the end of the file.
#                             export PATH="$PATH:$HOME/cli-app-menu"
#
#
# 4. Non-interactive, non-login shell environment:
#    reads the file contained in the variable BASH_ENV, if exists.
#
#    (Not pertinent or relevant since this script is interactive).
#    Included here to document another way to set the PATH variable.
#
f_valid_path_txt () {
      #
      # Check the $PATH
      if [[ ! "$PATH" == *":$1"* ]] ; then
         clear  # Blank the screen.
         echo -n $(tput bold)
         echo "Append the directory name to your PATH:"
         echo $(tput sgr0)
         echo "For more information:"
         echo "See comments in script, cliappmenu.sh under function, f_valid_path_txt."
         echo
         echo "Edit your /home/<username_goes_here>/.profile, .bash_profile, or .bashrc file"
         echo "and append the directory name to the end of the PATH statement."
         echo "               (don't forget the colon)."
         echo
         echo ":$1"
         echo
         echo "Change to:"
         echo "PATH=$PATH:$1"
         echo
         echo "export PATH"
         echo
         echo -n "Press \"Enter\" key to continue."
         read X
         clear  # Blank the screen.
         echo "                     >>> IMPORTANT <<<"
         echo "After editing the file, ~/.profile,  ~/.bash_profile, or ~/.bashrc:"
         echo
         echo "Close Terminal for changes to take effect."
         echo "Either logout or exit from Terminal and re-launch Terminal."
         echo
      fi
} # End of function f_valid_path_txt
#
# +----------------------------------------+
# |         Function f_valid_path_gui      |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Directory, PATH.
#    Uses: None.
# Outputs: Error code 1 if path is bad.
#
f_valid_path_gui () {
      #
      # Check the $PATH
      if [[ ! "$PATH" == *":$2"* ]] ; then
         $1 --title "*** Important ***" --msgbox "\nAppend the directory name to your PATH.\n  (For more information: See comments in script, cliappmenu.sh\n  under function, f_valid_path_txt.)\n\nEdit the file(s)\n/home/<username_goes_here>/.profile, .bash_profile, or .bashrc\nand append the directory name to the end of the PATH statement.\n               (don't forget the colon).\n\n:$2\n\nChange to:\nPATH=$PATH:$2\n\nexport PATH" 23 70
         #
         $1 --title "*** Important ***" --msgbox "\nAfter editing the file, ~/.profile,  ~/.bash_profile, or ~/.bashrc:\n\n        Close Terminal for changes to take effect.\nEither logout or exit from Terminal and re-launch Terminal.\n\n(For more information: See comments in script, cliappmenu.sh\nunder function, f_valid_path_txt.)\n" 15 70
      fi
} # End of function f_valid_path_gui
#
# +----------------------------------------+
# |        Function f_valid_exit_txt       |
# +----------------------------------------+
#
#  Inputs: $1=Original Directory, $2=New Directory, ECOLOR, BCOLOR.
#    Uses: None.
# Outputs: exit 1.
#
f_valid_exit_txt () {
      # Was directory changed?
      if [ "$1" != "$2" ] ; then
         # Yes, directory was changed.
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo "____________________________________"
         echo " Re-run script to use new directory."
         echo "       >>> Exiting script <<<"
         echo "____________________________________"
         echo $(tput sgr0)
         exit 1
      else
         # No, directory not changed, but THIS_DIR variable may have been
         # changed so exit.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo
         echo "______________________________"
         echo " Re-run script to use changes."
         echo "    >>> Exiting script <<<"
         echo "______________________________"
         echo $(tput sgr0)
         exit 1
         fi
} # End of function f_valid_exit_txt
#
# +----------------------------------------+
# |        Function f_valid_exit_gui       |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Original Directory,
#          $3=New Directory.
#    Uses: None.
# Outputs: exit 1.
#
f_valid_exit_gui () {
      # Was directory changed?
      if [ "$2" != "$3" ] ; then
         $1 --title "*** Important ***" --msgbox "\nRe-run script to use new directory.\n      >>> Exiting script <<<" 10 40
         exit 1
      else
         # No, directory not changed, but THIS_DIR variable
         # may have been changed so exit.
         $1 --title "*** Important ***" --msgbox "\nRe-run script to use changes.\n   >>> Exiting script <<<" 10 40
         exit 1
         fi
} # End of function f_valid_exit_gui
#
#
# +----------------------------------------+
# |      Function f_sudo_password_gui      |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), THIS_FILE.
#    Uses: None.
# Outputs: ERROR, XSTR.
#
f_sudo_password_gui () {
            if [ "$1" == "dialog" ] ; then
               XSTR=$($1 --title ">>> Need sudo permissions <<<" --stdout --insecure --passwordbox "\n  Must now use sudo permissions to re-configure \"$THIS_FILE\".\n\n              Enter sudo password at prompt below:" 10 70)
               ERROR=$?
            else # whiptail
               XSTR=$($1 --title ">>> Need sudo permissions <<<" --passwordbox "\n  Must now use sudo permissions to re-configure \"$THIS_FILE\".\n\n              Enter sudo password at prompt below:" 10 70 2>&1 >/dev/tty)
               ERROR=$?
            fi
} # End of function f_sudo_password_gui
#
# +----------------------------------------+
# |       Function f_file_download_txt     |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File, FCOLOR, BCOLOR, ECOLOR.
#    Uses: MOD_FILE.
# Outputs: None.
#
# If any of the module library *lib files are missing, then download all of
# them into target directory.
#
# Note: You cannot use any functions within the file "lib_cli-common.lib"
#       since that file may not yet be downloaded and available at this point.
#       That is why function "f_file_dload" is used rather than "f_wget_file"
#       or "f_download_file".
#
f_file_download_txt () {
      # Does directory exist?
      if [ -d $1 ] ; then
         # Yes, so continue to download files.
         if [ "$2" = "lib_cli-common.lib" ] || [ "$2" = "lib_cli-menu-cat.lib" ] || [ "$2" = "lib_cli-web-sites.lib" ] ; then
            echo
            echo "If needed, these files will now be downloaded:"
            echo "lib_cli-common.lib, lib_cli-menu-cat.lib, and lib_cli-web-sites.lib."
            echo
            echo -n "Press \"Enter\" key to continue."
            read X
            for MOD_FILE in lib_cli-common.lib lib_cli-menu-cat.lib lib_cli-web-sites.lib
            do
                # Does $MOD_FILE exist in that directory?
                if [ ! -r $1/$MOD_FILE ] ; then
                   # No it does not exist so download it.
                   f_file_dload_txt $1 $MOD_FILE
                fi
            done
         else
            if [ ! -r $1/$2 ] ; then
            # No it does not exist so download it.
               f_file_dload_txt $1 $2
            fi
         fi
      else
         # No, directory does not exist,
         # so cannot download file into the directory.
         # Use different color font for error messages.
         clear  # Blank the screen.
         f_term_color $ECOLOR $BCOLOR
         echo -n $(tput bold)
         echo
         echo "Required file:"
         echo "   \"$2\""
         echo "cannot be downloaded"
         echo
         echo "because directory does not exist:"
         echo "   $1"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo -n "Press \"Enter\" key to continue."
         read X
         #
      fi
      unset MOD_FILE
} # End of function f_file_download_txt
#
# +----------------------------------------+
# |       Function f_file_download_gui     |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Directory, $3=File.
#    Uses: MOD_FILE.
# Outputs: None.
#
# If any of the module library *lib files are missing, then download all of
# them into target directory.
#
# Note: You cannot use any functions within the file "lib_cli-common.lib"
#       since that file may not yet be downloaded and available at this point.
#       That is why function "f_file_dload" is used rather than "f_wget_file"
#       or "f_download_file".
#
f_file_download_gui () {
      # Does directory exist?
      if [ -d $2 ] ; then
         # Yes, so continue to download files.
         if [ "$3" = "lib_cli-common.lib" -o "$3" = "lib_cli-menu-cat.lib" -o "$3" = "lib_cli-web-sites.lib" ] ; then
            $1 --msgbox "If needed, these files will now be downloaded:\n\n     lib_cli-common.lib\n     lib_cli-menu-cat.lib\n     lib_cli-web-sites.lib." 12 50
            for MOD_FILE in lib_cli-common.lib lib_cli-menu-cat.lib lib_cli-web-sites.lib
            do
                # Does $MOD_FILE exist in that directory?
                if [ ! -r $1/$MOD_FILE ] ; then
                   # No it does not exist so download it.
                   f_file_dload_gui $1 $2 $MOD_FILE
                fi
            done
         else
            if [ ! -r $2/$3 ] ; then
            # No it does not exist so download it.
               f_file_dload_gui $1 $2 $3
            fi
         fi
      else
         # No, directory does not exist,
         # so cannot download file into the directory.
         # Use different color font for error messages.
            $1 --title ">>> Error <<<" --msgbox "Required file:\n   \"$3\"\ncannot be downloaded\nbecause directory does not exist:\n   $2" 10 60 
      fi
      unset MOD_FILE
} # End of function f_file_download_gui
#
# +----------------------------------------+
# |         Function f_file_dload_txt      |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X.
# Outputs: ERROR, NEW_DIR, MOD_FILE, WEB_SITE.
#
f_file_dload_txt () {
      clear  # Blank the screen.
      #
      if [ -d "$1" ] ; then
         # Directory exists so download file into the directory.
         echo "Download the file from the project's repository at the GitHub web site."
         echo "Use the MASTER branch of the project repository."
         echo "Download file:"
         echo "   $2"
         echo
         echo "into the directory:"
         echo "   $1"
         echo
         echo -n "Download the file from the MASTER branch? (Y/n): "
         read X
         case $X in
              [Nn]*)
              # No, stop
              ;;
              * | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
              # Yes, download it.
              NEW_DIR=$1  # Needed for f_wget_file.
              MOD_FILE=$2
              # Download from GitHub web site, project's MASTER branch.
              WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/"
              #
              # Is directory writable?
              if [ -w $NEW_DIR ] ; then
                 # Yes, directory is writable.
                 wget --directory-prefix=$NEW_DIR $WEB_SITE$MOD_FILE
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    f_term_color $ECOLOR $BCOLOR
                    echo $(tput bold)
                    echo -n "Error downloading $MOD_FILE to $NEW_DIR."
                    echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
                 fi
              else
                 # No, directory is not writable so use sudo to download.
                 echo "Must use sudo permissions to download $MOD_FILE."
                 sudo wget --directory-prefix=$NEW_DIR $WEB_SITE$MOD_FILE
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    f_term_color $ECOLOR $BCOLOR
                    echo $(tput bold)
                    echo -n "Error downloading $MOD_FILE even when using sudo permissions."
                    echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
                 fi
              fi
              ;;
         esac
      else
         # Directory does not exist,
         # so cannot download file into the directory.
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo -n $(tput bold)
         echo
         echo "Required file:"
         echo "   \"$2\""
         echo "cannot be downloaded"
         echo
         echo "because directory does not exist:"
         echo "   $1"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      fi
      echo
      echo -n "Press \"Enter\" key to continue."
      read X
      #
      unset X
} # End of function f_file_dload_txt
#
# +----------------------------------------+
# |         Function f_file_dload_gui      |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Directory, $3=File.
#    Uses: None.
# Outputs: ERROR, NEW_DIR, MOD_FILE, WEB_SITE.
#
f_file_dload_gui () {
      clear  # Blank the screen.
      #
      if [ -d "$2" ] ; then
         # Directory exists, so download file into the directory.
         $1 --yesno "Download the file from the project's repository at the GitHub web site.\nUse the MASTER branch of the project repository.\nDownload file:\n   $3\n\ninto the directory:\n   $2\n\nDownload the file from the MASTER branch?" 20 75
         ERROR=$?
         case $ERROR in
              1)
              # No, stop
              ;;
              0)
              # Yes, download it.
              NEW_DIR=$2  # Needed for f_wget_file.
              MOD_FILE=$3
              # Download from GitHub web site, project's MASTER branch.
              WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/"
              #
              # Is directory writable?
              if [ -w $NEW_DIR ] ; then
                 # Yes, directory is writable.
                 wget --directory-prefix=$NEW_DIR $WEB_SITE$MOD_FILE
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    $1 --title ">>> Error <<<" --msgbox "\n     Error downloading \"$MOD_FILE\" to $NEW_DIR." 8 75
                 fi
              else
                 # No, directory is not writable so use sudo to download.
                 $1 --msgbox "Must use sudo permissions to download \"$MOD_FILE\"." 8 50
                 f_sudo_password_gui $1 # Outputs $XSTR=<sudo password>,
                                        # $ERROR code.
                 echo $XSTR | sudo -S wget --directory-prefix=$NEW_DIR $WEB_SITE$MOD_FILE
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    $1 --title ">>> Error <<<" --msgbox "\nError downloading \"$MOD_FILE\" even when using sudo permissions." 10 75
                 fi
              fi
              ;;
         esac
      else
         # Directory does not exist,
         # so cannot download file into the directory.
         # Use different color font for error messages.
            $1 --title ">>> Error <<<" --msgbox "Required file:\n   \"$3\"\ncannot be downloaded\n\nbecause directory does not exist:\n   $2" 15 60 
      fi
} # End of function f_file_dload_gui
#
# +----------------------------------------+
# |           Function f_change_dir        |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("text", "dialog", "whiptail"), $2=Directory.
#    Uses: XSTR.
# Outputs: NEW_DIR.
#
f_change_dir () {
      clear  # Blank the screen.
      NEW_DIR="" ; XSTR=$2
      while [ "$NEW_DIR" != "QUIT" ] && [ ! -d "$NEW_DIR" ]
      do
            # Creates or switches to new directory
            # and reconfigures cliappmenu.sh to use it.
            # Outputs $NEW_DIR.
            if [ $1 = "text" ] ; then
               f_ask_new_directory_txt $2
            else
               f_ask_new_directory_gui $1 $2
            fi
            #
            if [ -d "$NEW_DIR" ] && [ $NEW_DIR != "QUIT" ] ; then
               XSTR=$NEW_DIR
            fi
            # If $NEW_DIR=<New directory> then $XSTR=$NEW_DIR.
            # If $NEW_DIR="QUIT"
            # then $XSTR=$2 <old (possibly invalid) directory>.
      done
      # Set $NEW_DIR in order to update "Validate Files and Directories Menu"
      # message display.
      # NEW_DIR=<new directory only if it exists>
      # or <old (possibly invalid) directory>.
      NEW_DIR=$XSTR
      unset XSTR
} # End of function f_change_dir
#
# +----------------------------------------+
# |    Function f_ask_new_directory_txt    |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, MAINMENU_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X.
# Outputs: NEW_DIR.
#
f_ask_new_directory_txt () {
      clear  # Blank the screen.
      echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      echo "The main script file: \"cliappmenu.sh\" is in directory:"
      echo "      $MAINMENU_DIR"
      echo "_________________________________________________________________"
      echo
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      if [ "$1" != "$MAINMENU_DIR/cli-app-menu" ] ; then
         echo "The directory for the required support files needs to be changed."
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "Change from:"
         echo "     $1"
         echo
         echo "Change to:"
         echo "     $MAINMENU_DIR/cli-app-menu"
      else
         # This scenario happens when the directory was deleted
         # while $THIS_DIR is still set correctly to point to that directory.
         # a rare scenario which occurred while in development and testing.
         echo "The directory for the required support files needs to be created."
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo "Create directory:"
         echo "     $1"
      fi
      echo
      echo
      echo "(Q)uit, to quit this script."
      echo
      echo -n "Do you agree with this directory change? (Y/n): "
      read X
      case $X in
           [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           NEW_DIR="QUIT"
           f_valid_exit_txt $NEW_DIR $NEW_DIR
           ;;
           [Nn]*)
           echo
           echo "If you want to have the required files in a separate directory from"
           echo "the main script file, then enter a different directory."
           echo
           echo "(Q)uit, to quit this script."
           echo
           echo -n "Enter new directory name: "
           read NEW_DIR
           echo
           case $NEW_DIR in
                "" | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
                NEW_DIR="QUIT"
                f_valid_exit_txt $NEW_DIR $NEW_DIR
                ;;
                */)
                # Strip off the last "/" in the directory name.
                # i.e. Change from "/opt/" to "/opt".
                # Substitution using bash curly bracket syntax.
                # Syntax: {<Target string>/<old pattern>/<new pattern>}
                #               NEW_DIR         %"/"         null
                #                                |
                #                              (%"/" means find trailing "/")
                NEW_DIR=${NEW_DIR/%"/"/}
                ;;
           esac
           #
           # Create directory only if it does not exist already.
           if [ ! -d "$NEW_DIR" ] ; then
              if [ -n "$NEW_DIR" ] ; then
                 f_ask_create_directory_txt $1 $NEW_DIR
                 # Directory creation failed for some reason.
                 if [ ! -d "$NEW_DIR" ] ; then
                    NEW_DIR="QUIT"
                 fi
              fi
           else
              f_term_color $ECOLOR $BCOLOR
              echo $(tput bold)
              echo "Directory cannot be created, since it may already exist."
              echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
              f_setup_dir $1 $NEW_DIR
           fi
           ;;
           *)
           NEW_DIR="$MAINMENU_DIR/cli-app-menu"
           f_create_directory_txt $1 $NEW_DIR
           ;;
      esac
      unset X
} # End of function f_ask_new_directory_txt
#
# +----------------------------------------+
# |    Function f_ask_new_directory_gui    |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Old Directory, MAINMENU_DIR.
#    Uses: None.
# Outputs: NEW_DIR, ERROR.
#
f_ask_new_directory_gui () {
      if [ "$2" != "$MAINMENU_DIR/cli-app-menu" ] ; then
         $1 --yesno "The main script file: \"cliappmenu.sh\" is in directory:\n      $MAINMENU_DIR\n_________________________________________________________________\n\nThe directory for the required support files needs to be changed.\n\nChange from:\n     $2\n\nChange to:\n     $MAINMENU_DIR/cli-app-menu\n\nDo you agree with this directory change?" 20 75
         ERROR=$?
      else
         # This scenario happens when the directory was deleted
         # while $THIS_DIR is still set correctly to point to that directory.
         # a rare scenario which occurred while in development and testing.
      $1 --yesno "The main script file: \"cliappmenu.sh\" is in directory:\n      $MAINMENU_DIR\n_________________________________________________________________\n\nThe directory for the required support files needs to be created.\nCreate directory:\n     $2\n\nDo you agree with this directory change?" 20 75
      ERROR=$?
      fi
      case $ERROR in
           1)
           # Get user-entered directory name with dialog/whiptail --inputbox.
           # Save user-input with redirection.
           # Redirect stderr (standard error) to stdout (standard output)
           # thus capturing the error code.
           # Redirect stdout to screen (/dev/tty).
           # Capture result of stdout to $NEW_DIR variable.
           NEW_DIR=$($1 --inputbox "If you want to have the required files in a separate directory from\nthe main script file, then enter a different directory.\n\n(Q)uit, to quit this script.\n\nEnter new directory name:" 15 75 2>&1 >/dev/tty)
           #
           case $NEW_DIR in
                "" | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
                NEW_DIR="QUIT"
                f_valid_exit_gui $1 $NEW_DIR $NEW_DIR
                ;;
                */)
                # Strip off the last "/" in the directory name.
                # i.e. Change from "/opt/" to "/opt".
                # Substitution using bash curly bracket syntax.
                # Syntax: {<Target string>/<old pattern>/<new pattern>}
                #               NEW_DIR         %"/"         null
                #                                |
                #                              (%"/" means find trailing "/")
                NEW_DIR=${NEW_DIR/%"/"/}
                ;;
           esac
           #
           # Create directory only if it does not exist already.
           if [ ! -d "$NEW_DIR" ] ; then
              if [ -n "$NEW_DIR" ] ; then
                 f_ask_create_directory_gui $1 $2 $NEW_DIR
                 # Directory creation failed for some reason.
                 if [ ! -d "$NEW_DIR" ] ; then
                    NEW_DIR="QUIT"
                 fi
              fi
           else
              $1 --msgbox "Directory cannot be created, since it may already exist." 8 60
              f_setup_dir_gui $1 $2 $NEW_DIR
           fi
           ;;
           0)
           NEW_DIR="$MAINMENU_DIR/cli-app-menu"
           f_create_directory_gui $1 $2 $NEW_DIR
           ;;
      esac
} # End of function f_ask_new_directory_gui
#
# +----------------------------------------+
# |   Function f_ask_create_directory_txt  |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory $2=New Directory.
#    Uses: X.
# Outputs: None.
#
f_ask_create_directory_txt () {
      # clear  # Blank the screen.
      echo
      echo "Create new directory:"
      echo "   $2"
      echo -n "Create it now? (Y/n): "
      read X
      echo
      case $X in
           [Nn]*)
           # No, do not create new directory, stop.
           ;;
           * | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
           # Yes, create it.
           f_create_directory_txt $1 $2
           ;;
      esac
      unset X
} # End of function f_ask_create_directory_txt
#
# +----------------------------------------+
# |   Function f_ask_create_directory_gui  |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Old Directory $3=New Directory.
#    Uses: None.
# Outputs: ERROR.
#
f_ask_create_directory_gui () {
      $1 --yesno "Create new directory:\n   $3\n\nCreate it now?" 12 75
      ERROR=$?
      case $ERROR in
           1)
           # No, do not create new directory, stop.
           ;;
           0)
           # Yes, create it.
           f_create_directory_gui $1 $2 $3
           ;;
      esac
} # End of function f_ask_create_directory_gui
#
# +----------------------------------------+
# |    Function f_create_directory_txt     |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, $2=New Directory, FCOLOR, BCOLOR, ECOLOR.
#    Uses: None.
# Outputs: None.
#
f_create_directory_txt () {
      mkdir $2 &>/dev/null # 1=standard messages, 2=error messages, &=both.
      # Was it created OK?
      if [ -d "$2" ] ; then
         # Yes, created OK. Change $THIS_DIR to reference new directory.
         echo
         echo "Directory successfully created:"
         echo "   $2"
         echo
         f_setup_dir $1 $2
      else
         # No, use sudo.
         # Create it with sudo.
         sudo mkdir $2
         # Was it created OK?
         if [ -d "$2" ] ; then
            # Yes, created OK. Change $THIS_DIR to reference new directory.
            echo
            echo "Directory successfully created:"
            echo "   $2"
            echo
            f_setup_dir_txt $1 $2
         else
            echo
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error creating new directory, even when using sudo permissions."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi
      fi
} # End of function f_create_directory_txt
#
# +----------------------------------------+
# |    Function f_create_directory_gui     |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Old Directory $3=New Directory.
#    Uses: None.
# Outputs: None.
#
f_create_directory_gui () {
      mkdir $3 &>/dev/null # 1=standard messages, 2=error messages, &=both.
      # Was it created OK?
      if [ -d "$3" ] ; then
         # Yes, created OK. Change $THIS_DIR to reference new directory.
         $1 --msgbox "Directory successfully created:\n   $3" 10 75
         f_setup_dir_gui $1 $2 $3
      else
         # No, use sudo.
         f_sudo_password_gui $1 # Outputs $XSTR=<sudo password>, $ERROR code.
         # Create it with sudo.
         echo $XSTR | sudo -S mkdir $3
         # Was it created OK?
         if [ -d "$3" ] ; then
            # Yes, created OK. Change $THIS_DIR to reference new directory.
            echo
            $1 --msgbox "Directory successfully created:\n   $3" 10 75
            f_setup_dir_gui $1 $2 $3
         else
            echo
            $1 --msgbox "Error creating new directory, even when using sudo permissions." 8 70
         fi
      fi
} # End of function f_create_directory_gui
#
# +----------------------------------------+
# |       Function f_setup_dir_txt         |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, $2=New Directory, SCRIPT_PATH, FCOLOR, BCOLOR,
#          ECOLOR.
#    Uses: X, ERROR.
# Outputs: NEW_DIR.
#
f_setup_dir_txt () {
      echo "Automatically re-configuring \"cliappmenu.sh\" to use the directory."
      echo
      if [ -w $SCRIPT_PATH ] ; then
         # Yes, directory is writable.
         # sed has \" back-slashes before the quotation marks to include the
         # literal quotation marks in the search/replace strings.
         #         Find string: THIS_DIR="$1
         # Replace with string: THIS_DIR="$2
         sed -i "s|THIS_DIR=\"$1|THIS_DIR=\"$2|" $SCRIPT_PATH/cliappmenu.sh
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error re-configuring, \"cliappmenu.sh\" to use the directory."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            # Set NEW_DIR back to the old directory
            # since re-configuring failed.
            NEW_DIR=$1
         fi 
      else
         # No, directory is not writable so use sudo permissions.
         sudo sed -i "s|THIS_DIR=\"$1|THIS_DIR=\"$2|" $SCRIPT_PATH/cliappmenu.sh
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error re-configuring,\"cliappmenu.sh\" to use the directory"
            echo "even when using sudo permissions."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            # Set NEW_DIR back to the old directory
            # since re-configuring failed.
            NEW_DIR=$1
         fi
      fi
      echo -n "Press \"Enter\" key to continue."
      read X
      unset X
} # End of function f_setup_dir_txt
#
# +----------------------------------------+
# |       Function f_setup_dir_gui         |
# +----------------------------------------+
#
#  Inputs: $1=GUI ("dialog", "whiptail"), $2=Old Directory $3=New Directory,
#          SCRIPT_PATH.
#    Uses: None.
# Outputs: ERROR, NEW_DIR.
#
f_setup_dir_gui () {
      $1 --msgbox "Automatically re-configuring \"cliappmenu.sh\" to use the directory." 8 70
      if [ -w $SCRIPT_PATH ] ; then
         # Yes, directory is writable.
         # sed has \" back-slashes before the quotation marks to include the
         # literal quotation marks in the search/replace strings.
         #         Find string: THIS_DIR="$2
         # Replace with string: THIS_DIR="$3
         sed -i "s|THIS_DIR=\"$2|THIS_DIR=\"$3|" $SCRIPT_PATH/cliappmenu.sh
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            $1 --msgbox --title ">>> Error <<<" "Error re-configuring, \"cliappmenu.sh\" to use the directory." 8 70
            # Set NEW_DIR back to the old directory
            # since re-configuring failed.
            NEW_DIR=$2
         fi 
      else
         # No, directory is not writable so use sudo permissions.
         f_sudo_password_gui $1 # Outputs $XSTR=<sudo password>, $ERROR code.
         ERROR=$?
         if [ $ERROR -eq 0 ] ; then
            echo $XSTR | sudo -S sed -i "s|THIS_DIR=\"$2|THIS_DIR=\"$3|" $SCRIPT_PATH/cliappmenu.sh
            ERROR=$?
            if [ $ERROR -ne 0 ] ; then
               $1 --msgbox --title ">>> Error <<<" "Error re-configuring,\"cliappmenu.sh\" to use the directory\neven when using sudo permissions." 10 70
               # Set NEW_DIR back to the old directory
               # since re-configuring failed.
               NEW_DIR=$2
            fi
         else
            # Cancel button pressed.
            # Set NEW_DIR back to the old directory
            # since re-configuring failed.
            NEW_DIR=$2
         fi
      fi
} # End of function f_setup_dir_gui
#
#
# +----------------------------------------+
# |      Function f_main_applications      |
# +----------------------------------------+
#
#  Inputs: $1 - Directory. 
#    Uses: None.
# Outputs: None.
#
f_main_applications () {
      f_menu_cat_applications
} # End of function f_main_applications
#
# +----------------------------------------+
# |       Function f_main_favorites        |
# +----------------------------------------+
#
#  Inputs: $1 - Directory. 
#    Uses: None.
# Outputs: None.
#
f_main_favorites () {
      f_menu_app_favorites
} # End of function f_main_favorites
#
# +----------------------------------------+
# |           Function f_main_help         |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_help () {
case $GUI in
     dialog | whiptail)
     f_main_help_gui
     ;;
     text)
     f_main_help_txt
     ;;
esac
} # End of f_main_help
#
# +----------------------------------------+
# |        Function f_main_help_txt        |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_FILE. 
#    Uses: None.
# Outputs: None.
#
f_main_help_txt () {
      clear # Blank the screen.
      # Display Help (all lines beginning with "#@" but do not print "#@").
      # sed substitutes null for "#@" at the beginning of each line
      # so it is not printed.
      # less -P customizes prompt for
      # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
      THIS_FILE="cliappmenu.sh"
      sed -n 's/^#@//'p $MAINMENU_DIR/$THIS_FILE | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
} # End of function f_main_help_txt
#
# +----------------------------------------+
# |        Function f_main_help_gui        |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_FILE. 
#    Uses: None.
# Outputs: None.
#
f_main_help_gui () {
      clear # Blank the screen.
      # Display Help (all lines beginning with "#@" but do not print "#@").
      # sed substitutes null for "#@" at the beginning of each line
      # so it is not printed.
      # less -P customizes prompt for
      # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
      THIS_FILE="cliappmenu.sh"
      sed -n 's/^#@//'p $MAINMENU_DIR/$THIS_FILE >cliappmenu.tmp
      # Get the screen resolution or X-window size.
      # Get rows (height).
      Y=$(stty size | awk '{ print $1 }')
      let Y=$Y-3  # Make room at top of window for a backtitle.
      # Get columns (width).
      X=$(stty size | awk '{ print $2 }')
      #
      $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "General User Instructions" --textbox cliappmenu.tmp $Y $X
      #
      if [ -r cliappmenu.tmp ] ; then
         rm cliappmenu.tmp
      fi
} # End of function f_main_help_gui
#
# +----------------------------------------+
# |           Function f_main_about        |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X.
# Outputs: None.MOD_FILE, PROJECT_REVDATE, PROJECT_REVISION, PRESS_KEY.
#
f_main_about () {
      # Calculate project revision number
      # by counting all lines starting with "## 2014".
      # grep ^ (carot sign) means grep any lines beginning with "##2014".
      # grep -c means count the lines that match the pattern.
      #
      if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         while [  "$X" != "YES" -a "$X" != "NO" ]
         do
               clear # Blank the screen.
               #
               # Use different color font for error messages.
               f_term_color $ECOLOR $BCOLOR
               echo $(tput bold)
               #
               echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo
               echo -n "Download EDIT_HISTORY from GitHub.com? (Y/n): "
               read X
               case $X in # Start of git download case statement.
                    "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                    MOD_FILE="EDIT_HISTORY"
                    f_download_file
                    X="YES"
                    ;;
                    [Nn] | [Nn][Oo])
                    X="NO"
                    ;;
               esac # End of git download case statement.
         done
      fi
      #
      if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         PROJECT_REVISION="Unknown, edit history is unavailable."
	 PROJECT_REVDATE="Unknown, edit history is unavailable."
      else
         PROJECT_REVISION=$(grep ^PROJECT_REVISION $THIS_DIR"/EDIT_HISTORY" | awk -F "=" '{ print $2 }' | awk -F '"' '{print $2}')
         PROJECT_REVDATE=$(grep ^PROJECT_REVDATE= $THIS_DIR"/EDIT_HISTORY" | awk -F "=" '{ print $2 }' | awk -F '"' '{print $2}')
      fi
      #
      # grep finds line beginning with "PROJECT_REVDATE=" in file EDIT_HISTORY
      # The first awk results in the date in quotes as a string.
      # The second awk strips the quotation marks from the date string.
      #
      case $GUI in
           dialog | whiptail)
           f_main_about_gui
           ;;
           text)
           f_main_about_txt
           ;;
      esac
      #
      unset X
} # End of function f_main_about
#
# +----------------------------------------+
# |        Function f_main_about_txt       |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_about_txt () {
      clear # Blank the screen.
      echo "Project version: $PROJECT_REVISION"
      echo " Last edited on: $PROJECT_REVDATE"
      echo
      echo "Main Menu script cliappmenu.sh is located in:"
      echo "$MAINMENU_DIR"
      echo
      echo "Module library files and documentation is located in:"
      echo "$THIS_DIR"
      f_press_enter_key_to_continue
      PRESS_KEY=0
} # End of function f_main_about_txt
#
# +----------------------------------------+
# |        Function f_main_about_gui       |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_about_gui () {
      echo "Project version: $PROJECT_REVISION" >cliappmenu.tmp
      echo " Last edited on: $PROJECT_REVDATE" >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "Main Menu script cliappmenu.sh is located in:" >>cliappmenu.tmp
      echo "$MAINMENU_DIR" >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "Module library files and documentation is located in:" >>cliappmenu.tmp
      echo "$THIS_DIR" >>cliappmenu.tmp
      # Get the screen resolution or X-window size.
      # Get rows (height).
      Y=$(stty size | awk '{ print $1 }')
      let Y=$Y-3  # Make room at top of window for a backtitle.
      # Get columns (width).
      X=$(stty size | awk '{ print $2 }')
      #
      $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "About CLI-APP-MENU Project" --textbox cliappmenu.tmp $Y $X
      #
      if [ -r cliappmenu.tmp ] ; then
         rm cliappmenu.tmp
      fi
} # End of function f_main_about_gui
#
# +----------------------------------------+
# |        Function f_main_configure       |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_configure () {
case $GUI in
     dialog | whiptail)
     f_main_configure_gui
     ;;
     text)
     f_main_configure_txt
     ;;
esac
} # End of f_main_configure
#
# +----------------------------------------+
# |      Function f_main_configure_txt     |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: AAC , MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_main_configure_txt () {
      f_initvars_menu_app "AAC"
      # When $DELIMITER is set as above, then f_menu_item_process does not call
      # f_application_run and try to run the menu item's name.
      # i.e. "Colors", "Un-colors" or "Update", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAC" = "0" ]
      do    # Start of Configuration Menu until loop.
#f_update_software^0^0^0^0       #AAC Update Program     - Update menu scripts from the GitHub repository.
#f_update_all_modules^0^0^0^0    #AAC Update All Modules - Update all installed modules from GitHub repository.
#f_menu_module_manager^0^0^0^0   #AAC Manage Modules     - Add/Delete/Remove/Restore/Update selected modules.
#f_update_list_apps^0^0^0^0      #AAC Update App List    - Update list of applications in ACTIVATED modules.
#f_ls_this_dir $THIS_DIR^0^0^0^0 #AAC List Files         - List all support and library program files.
#f_menu_term_ui^0^0^0^0          #AAC User-interface     - Set default user-interface: text, Dialog, Whiptail.
#f_menu_term_color^0^0^0^0       #AAC Colors             - Set default font/background colors.
#f_menu_term_uncolor^0^0^0^0     #AAC Un-colors          - Set font color for unavailable library modules.
#f_reinstall_readme^0^0^0^1      #AAC Install to New Dir - HOW-TO re-install script into another directory.
            #
            THIS_FILE="cliappmenu.sh"
            MENU_TITLE="Configuration Menu"
            DELIMITER="#AAC" #AAC This 3rd field prevents awk from printing this line into menu options. 
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAC
            f_menu_item_process $AAC  # Outputs $MENU_ITEM.
      done  # End of Configuration Menu until loop.
      #
      unset AAC MENU_ITEM MENU_TITLE  # Throw out this variable.
      # Do not unset DELIMITER because it is needed when this function ends and
      # program flow returns to the Main Menu to prevent running of MENU_ITEM.
} # End of function f_main_configure_txt
#
# +----------------------------------------+
# |      Function f_main_configure_gui     |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: AAC, MENU_TITLE.
# Outputs: None.
#
f_main_configure_gui () {
      f_initvars_menu_app "AAC"
      MENU_TITLE="Configuration Menu"
      until [ "$AAC" = "0" ]
      do    # Start of Main Configure Menu until loop.
            AAC=$($GUI --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (1 to 9) or (letters):" 20 80 11 \
            "Return" "Return to the previous menu." \
            "Update Program" "Update menu scripts from the GitHub repository." \
            "Update All Modules" "Update all installed modules from GitHub repository." \
            "Manage Modules" "Add/Delete/Remove/Restore/Update selected modules." \
            "Update App List" "Update list of applications in ACTIVATED modules." \
            "List Files" "List all support and library program files." \
            "User-interface" "Set default user-interface: text, Dialog, Whiptail."\
            "Colors" "Set default font/background colors." \
            "Un-colors" "Set font color for unavailable library modules." \
            "Install to New Dir" "HOW-TO re-install script into another directory." \
            2>&1 >/dev/tty)
            #
            case $AAC in
                 "Return") AAC=0 ;;
                 "Update Program") f_update_software ;;
                 "Update All Modules") f_update_all_modules ;;
                 "Manage Modules") f_menu_module_manager ;;
                 "Update App List") f_update_list_apps ;;
                 "List Files") f_ls_this_dir $THIS_DIR ;;
                 "User-interface") f_menu_term_ui ;;
                 "Colors") f_menu_term_color ;;
                 "Un-colors") f_menu_term_uncolor ;;
                 "Install to New Dir") f_reinstall_readme ;;
            esac
      done  # End of Main Configure Menu until loop.
      #
      unset AAC MENU_TITLE
} # End of f_main_configure_gui
#
#
# +----------------------------------------+
# |      Function f_main_information       |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_information () {
case $GUI in
     dialog | whiptail)
     f_main_information_gui
     ;;
     text)
     f_main_information_txt
     ;;
esac
} # End of f_main_information
#
# +----------------------------------------+
# |      Function f_main_information_txt   |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: AAG, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_main_information_txt () {
      f_initvars_menu_app "AAG"
      # When $DELIMITER is set as above, then f_menu_item_process does not call
      # f_application_run and try to run the menu item's name.
      # i.e. "Colors", "Un-colors" or "Update", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAG" = "0" ]
      do    # Start of Configuration Menu until loop.
#f_main_about^0^0^0^0            #AAG About CLI Menu  - What version am I using.
#f_main_version_history^0^0^0^0  #AAG Version History - Version/Release history with general summaries.
#f_main_documentation^0^0^0^0    #AAG Documentation   - Script documentation, programmer notes, HOW-TOs.
#f_main_code_history^0^0^0^0     #AAG Code History    - All the craziness behind the scenes.
#f_main_license^0^0^0^0          #AAG License         - Licensing, GPL.
            #
            THIS_FILE="cliappmenu.sh"
            MENU_TITLE="Information Menu"
            DELIMITER="#AAG" #AAG This 3rd field prevents awk from printing this line into menu options. 
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAG
            f_menu_item_process $AAG  # Outputs $MENU_ITEM.
      done  # End of Configuration Menu until loop.
      #
      unset AAG MENU_ITEM MENU_TITLE # Throw out this variable.
      # Do not unset DELIMITER because it is needed when this function ends and
      # program flow returns to the Main Menu to prevent running of MENU_ITEM.
} # End of function f_main_information_txt
#
# +----------------------------------------+
# |      Function f_main_information_gui   |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: AAG, MENU_TITLE.
# Outputs: None.
#
f_main_information_gui () {
      f_initvars_menu_app "AAG"
      MENU_TITLE="Information Menu"
      until [ "$AAG" = "0" ]
      do    # Start of Main Information Menu until loop.
            AAG=$($GUI --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (1 to 6) or (letters):" 20 80 11 \
            "Return" "Return to the previous menu." \
            "About CLI Menu" "What version am I using." \
            "Version History" "Version/Release history with general summaries." \
            "Documentation" "Script documentation, programmer notes, HOW-TOs." \
            "Code History" "All the craziness behind the scenes." \
            "License" "Licensing, GPL." \
            2>&1 >/dev/tty)
            #
            case $AAG in
                 "Return") AAG=0 ;;
                 "About CLI Menu") f_main_about ;;
                 "Version History") f_main_version_history ;;
                 "Documentation") f_main_documentation ;;
                 "Code History") f_main_code_history ;;
                 "License") f_main_license ;;
           esac
      done  # End of Main Information Menu until loop.
      #
      unset AAC MENU_TITLE
} # End of function f_main_information_gui
#
# +----------------------------------------+
# |     Function f_main_documentation      |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_documentation () {
case $GUI in
     dialog | whiptail)
     f_main_documentation_gui
     ;;
     text)
     f_main_documentation_txt
     ;;
esac
} # End of f_main_documentation
#
# +----------------------------------------+
# |    Function f_main_documentation_txt   |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_documentation_txt () {
      f_ask_download_file $THIS_DIR "README"
      #
      if [ -r $THIS_DIR"/README" ] ; then
         # Display README Documentation
         # (all lines beginning with "#:" but do not print "#:").
         # sed substitutes null for "#:" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^#://'p $THIS_DIR"/README" | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
      fi
} # End of function f_main_documentation_txt
#
# +----------------------------------------+
# |    Function f_main_documentation_gui   |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_documentation_gui () {
      f_ask_download_file $THIS_DIR "README"
      #
      if [ -r $THIS_DIR"/README" ] ; then
         # Display README Documentation
         # (all lines beginning with "#:" but do not print "#:").
         # sed substitutes null for "#:" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^#://'p $THIS_DIR"/README"'' >cliappmenu.tmp
         # Get the screen resolution or X-window size.
         # Get rows (height).
         Y=$(stty size | awk '{ print $1 }')
         let Y=$Y-3  # Make room at top of window for a backtitle.
         # Get columns (width).
         X=$(stty size | awk '{ print $2 }')
         #
         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "README - Programming Documentation" --textbox cliappmenu.tmp $Y $X
         #
         if [ -r cliappmenu.tmp ] ; then
            rm cliappmenu.tmp
         fi
      fi
} # End of function f_main_documentation_gui
#
# +----------------------------------------+
# |    Function f_main_version_history     |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_version_history () {
case $GUI in
     dialog | whiptail)
     f_main_version_history_gui
     ;;
     text)
     f_main_version_history_txt
     ;;
esac
} # End of f_main_version_history
#
# +----------------------------------------+
# |  Function f_main_version_history_txt   |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_version_history_txt () {
      f_ask_download_file $THIS_DIR "EDIT_HISTORY"
      #
      if [ -r  $THIS_DIR"/EDIT_HISTORY" ] ; then
         # Display Edit History
         # (all lines beginning with "##" but do not print "##").
         # sed substitutes null for "##" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^##//'p $THIS_DIR"/EDIT_HISTORY" | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
         PRESS_KEY=0
      fi
} # End of function f_menu_edit_history_txt
#
# +----------------------------------------+
# |    Function f_main_edit_history_gui    |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_version_history_gui () {
      f_ask_download_file $THIS_DIR "EDIT_HISTORY"
      #
      if [ -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         # Display Edit History
         # (all lines beginning with "##" but do not print "##").
         # sed substitutes null for "##" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^##//'p $THIS_DIR"/EDIT_HISTORY"'' >cliappmenu.tmp
         # Get the screen resolution or X-window size.
         # Get rows (height).
         Y=$(stty size | awk '{ print $1 }')
         let Y=$Y-3  # Make room at top of window for a backtitle.
         # Get columns (width).
         X=$(stty size | awk '{ print $2 }')
         #
         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "Version History" --textbox cliappmenu.tmp $Y $X
         #
         if [ -r cliappmenu.tmp ] ; then
            rm cliappmenu.tmp
         fi
      fi
} # End of function f_menu_version_history_gui
#
# +----------------------------------------+
# |     Function f_main_code_history       |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_code_history () {
case $GUI in
     dialog | whiptail)
     f_main_code_history_gui
     ;;
     text)
     f_main_code_history_txt
     ;;
esac
} # End of f_main_code_history
#
# +----------------------------------------+
# |    Function f_main_code_history_txt    |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_code_history_txt () {
      f_ask_download_file $THIS_DIR "CODE_HISTORY"
      #
      if [ -r $THIS_DIR"/CODE_HISTORY" ] ; then
         # Display Edit History
         # (all lines beginning with "##" but do not print "##").
         # sed substitutes null for "##" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^##//'p $THIS_DIR"/CODE_HISTORY" | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
         PRESS_KEY=0
      fi
} # End of function f_menu_code_history_txt
#
# +----------------------------------------+
# |    Function f_main_code_history_gui    |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_code_history_gui () {
      f_ask_download_file $THIS_DIR "CODE_HISTORY"
      #
      if [ -r $THIS_DIR"/CODE_HISTORY" ] ; then
         # Display Edit History
         # (all lines beginning with "##" but do not print "##").
         # sed substitutes null for "##" at the beginning of each line
         # so it is not printed.
         # less -P customizes prompt for
         # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^##//'p $THIS_DIR"/CODE_HISTORY"  >cliappmenu.tmp
         # Get the screen resolution or X-window size.
         # Get rows (height).
         Y=$(stty size | awk '{ print $1 }')
         let Y=$Y-3  # Make room at top of window for a backtitle.
         # Get columns (width).
         X=$(stty size | awk '{ print $2 }')
         #
         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "Code History" --textbox cliappmenu.tmp $Y $X
         #
         if [ -r cliappmenu.tmp ] ; then
            rm cliappmenu.tmp
         fi
      fi
} # End of function f_menu_code_history_gui
#
# +----------------------------------------+
# |      Function f_ask_download_file      |
# +----------------------------------------+
#
#  Inputs: #  Inputs: $1=Directory, $2=File, FCOLOR, BCOLOR, ECOLOR, MOD_FILE.
#    Uses: X.
# Outputs: ERROR.
#
f_ask_download_file () {
      X="" # Initialize scratch variable.
      clear # Blank the screen.
      if [ ! -r $1"/$2" ] ; then
         while [  "$X" != "YES" -a "$X" != "NO" ]
         do
               clear # Blank the screen.
               #
               # Use different color font for error messages.
               f_term_color $ECOLOR $BCOLOR
               echo $(tput bold)
               #
               echo ">>>The file $2 is either missing or cannot be read.<<<"
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo
               echo -n "Download $2 from GitHub.com? (Y/n): "
               read X
               case $X in # Start of git download case statement.
                    "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                    MOD_FILE=$2
                    # Check if there is an Internet connection
                    # before doing a download.
                    f_test_internet_connection
                    #
                    # If Internet connection OK, then download.
                    if [ $ERROR -eq 0 ] ; then
                       f_download_file
                    fi
                    #
                    X="YES"
                    ;;
                    [Nn] | [Nn][Oo])
                    X="NO"
                    ;;
               esac # End of git download case statement.
         done
      fi
      #
      unset X
} # End of function f_ask_download_file
#
# +----------------------------------------+
# |         Function f_main_license        |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X, Y.
# Outputs: APP_NAME, WEB_SITE.
#
f_main_license () {
      clear # Blank the screen.
      # Display License
      # (all lines beginning with "#LIC" but do not print "#LIC").
      # sed substitutes null for "#LIC" at the beginning of each line
      # so it is not printed.
      # less -P customizes prompt for
      # %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
      case $GUI in
           dialog | whiptail)
           # Get the screen resolution or X-window size.
           # Get rows (height).
           Y=$(stty size | awk '{ print $1 }')
           let Y=$Y-3  # Make room at top of window for a backtitle.
           # Get columns (width).
           X=$(stty size | awk '{ print $2 }')
           #
           THIS_FILE="cliappmenu.sh"
           sed -n 's/^#LIC//'p $MAINMENU_DIR/$THIS_FILE >cliappmenu.tmp
           $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "License Agreement" --textbox cliappmenu.tmp $Y $X
           #
           if [ -r cliappmenu.tmp ] ; then
              rm cliappmenu.tmp
           fi
           ;;
           text)
           THIS_FILE="cliappmenu.sh"
           sed -n 's/^#LIC//'p $MAINMENU_DIR/$THIS_FILE | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
           ;;
      esac
      #
      X="" # Initialize scratch variable.
      while [  "$X" != "YES" -a "$X" != "NO" ]
      do
            clear # Blank the screen.
            echo -n "Read the full license text contained in file \"COPYING\"? (Y/n): "
            read X
            case $X in # Start of license case statment.
                 ""| [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                 X="YES"
                 echo
                 if [ ! -r $THIS_DIR"/COPYING" ] ; then
                    f_main_license_missing
                 fi
                 #
                 if [ -r $THIS_DIR"/COPYING" ] ; then
                    case $GUI in
                         dialog | whiptail)
                         # Get the screen resolution or X-window size.
                         # Get rows (height).
                         Y=$(stty size | awk '{ print $1 }')
                         let Y=$Y-3  # Make room at top of window for a backtitle.
                         # Get columns (width).
                         X=$(stty size | awk '{ print $2 }')
                         #
                         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "Full License Agreement" --textbox $THIS_DIR"/COPYING" $Y $X
                         ;;
                         text)
                         less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/COPYING"
                         ;;
                    esac
                 fi
                 X="YES"
                 ;;
                 [Nn] | [Nn][Oo])
                 X="NO"
                 ;;
            esac # End of license case statement.
      done
      #
      unset X Y
} # End of function f_main_license
#
# +----------------------------------------+
# |     Function f_main_license_missing    |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X.
# Outputs: APP_NAME, WEB_SITE.
#
f_main_license_missing () {
                    X="" # Initialize scratch variable.
                    while [  "$X" != "YES" -a "$X" != "NO" ]
                    do
                          clear # Blank the screen.
                          #
                          # Use different color font for error messages.
                          f_term_color $ECOLOR $BCOLOR
                          echo $(tput bold)
                          #
                          echo ">>>The file COPYING is either missing or cannot be read.<<<"
                          echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
                          echo
                          echo -n "Download \"COPYING\" from GitHub.com? (Y/n): "
                          read X
                          case $X in # Start of git download case statement.
                               "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                               MOD_FILE="COPYING"
                               f_download_file
                               X="YES"
                               ;;
                               [Nn] | [Nn][Oo])
                               X="" # Initialize scratch variable.
                               while [  "$X" != "YES" -a "$X" != "NO" ]
                               do
                                     clear # Blank the screen.
                                     echo -n "Read the full license text at \"http://www.gnu.org/licenses/\"? (Y/n): "
                                     read X
                                     case $X in # Start of gnu.org case statement.
                                          "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                                          clear # Blank the screen.
                                          APP_NAME="elinks"
                                          WEB_SITE="http://www.gnu.org/licenses/gpl.html"
                                          APP_NAME="$APP_NAME $WEB_SITE"
                                          f_application_run
                                          X="YES"
                                          ;;
                                          [Nn] | [Nn][Oo])
                                          X="NO"
                                          ;;
                                     esac # End of gnu.org case statement.
                               done
                               X="NO"
                               ;;
                          esac # End of git download case statement.
                    done
} # End of function f_main_license_missing.
#
# +----------------------------------------+
# |     Function f_main_list_find_menus    |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_main_list_find_menus () {
case $GUI in
     dialog | whiptail)
     f_main_list_find_menus_gui
     ;;
     text)
     f_main_list_find_menus_txt
     ;;
esac
} # End of function f_main_list_find_menus
#
# +----------------------------------------+
# |   Function f_main_list_find_menus_txt  |
# +----------------------------------------+
#
#  Inputs: THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: AAH, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_main_list_find_menus_txt () {
      if [ ! -r $THIS_DIR"/LIST_APPS" ] ; then
         clear # Blank the screen.
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "The file LIST_APPS will now be automatically created/updated:"
         echo
         f_press_enter_key_to_continue
         # Download/Update file LIST_APPS.
         f_update_list_apps
      fi
      # display LIST_APPS
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         f_initvars_menu_app "AAH"
         # When $DELIMITER is set as above, then f_menu_item_process
         # does not call f_application_run and try to run the menu item's name.
         # i.e. "Colors", "Un-colors" or "Update", etc.
         # since those are not the names of executable (run-able) applications.
         #
         until [ "$AAH" = "0" ]
         do    # Start of List/Find Menu until loop.
#f_main_list_menus_txt^0^0^0^0  #AAH List All Menus - List all menus and applications.
#f_main_find_menus_txt^0^0^0^0  #AAH Find All Menus - Find menus containing an application.
               #
               THIS_FILE="cliappmenu.sh"
               MENU_TITLE="List or Find Menus Menu"
               DELIMITER="#AAH" #AAH This 3rd field prevents awk from printing this line into menu options. 
               #
               f_show_menu "$MENU_TITLE" "$DELIMITER" 
               read AAH
               f_menu_item_process $AAH  # Outputs $MENU_ITEM.
         done  # End of List/Find Menu until loop.
         #
         unset AAH MENU_ITEM MENU_TITLE  # Throw out this variable.
         # Do not unset DELIMITER because it is needed when this function ends and
         # program flow returns to the Main Menu to prevent running of MENU_ITEM.
      fi
} # End of function f_main_list_find_menus_txt
#
# +----------------------------------------+
# |   Function f_main_list_find_menus_gui  |
# +----------------------------------------+
#
#  Inputs: THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: AAH, THIS_FILE, MENU_TITLE.
# Outputs: None.
#
f_main_list_find_menus_gui () {
      if [ ! -r $THIS_DIR"/LIST_APPS" ] ; then
         clear # Blank the screen.
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "The file LIST_APPS will now be automatically created/updated:"
         echo
         f_press_enter_key_to_continue
         # Download/Update file LIST_APPS.
         f_update_list_apps
      fi
      # display LIST_APPS
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         f_initvars_menu_app "AAH"
         # When $DELIMITER is set as above, then f_menu_item_process
         # does not call f_application_run and try to run the menu item's name.
         # i.e. "Colors", "Un-colors" or "Update", etc.
         # since those are not the names of executable (run-able) applications.
         #
         THIS_FILE="cliappmenu.sh"
         MENU_TITLE="List or Find Menus Menu"
         until [ "$AAH" = "0" ]
         do    # Start of List/Find Menu until loop.
            AAH=$($GUI --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (letters):" 20 80 11 \
            "Return" "Return to the previous menu." \
            "List All Menus" "List all menus and applications." \
            "Find All Menus" "Find menus containing an application." \
            2>&1 >/dev/tty)
            #
            case $AAH in
                 "Return") AAH=0 ;;
                 "List All Menus") f_main_list_menus_gui ;;
                 "Find All Menus") f_main_find_menus_gui ;;
            esac
               #
         done  # End of List/Find Menu until loop.
         #
         unset AAH MENU_TITLE  # Throw out this variable.
         # Do not unset DELIMITER because it is needed when this function ends and
         # program flow returns to the Main Menu to prevent running of MENU_ITEM.
      fi
} # End of function f_main_list_find_menus_gui
#
# +----------------------------------------+
# |     Function f_main_list_menus_txt     |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_list_menus_txt () {
      less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/LIST_APPS"
} # End of function f_main_list_menus_txt
#
# +----------------------------------------+
# |     Function f_main_list_menus_gui     |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X, Y.
# Outputs: None.
#
f_main_list_menus_gui () {
      f_ask_download_file $THIS_DIR "LIST_APPS"
      #
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         # Display LIST_APPS list of applications.
         # Get the screen resolution or X-window size.
         # Get rows (height).
         Y=$(stty size | awk '{ print $1 }')
         let Y=$Y-3  # Make room at top of window for a backtitle.
         # Get columns (width).
         X=$(stty size | awk '{ print $2 }')
         #
         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "List of Applications" --textbox $THIS_DIR/LIST_APPS $Y $X
      else
         $GUI --title "Read Error" --msgbox "Cannot read $THIS_DIR/LIST_APPS"
      fi
      unset X Y
} # End of function f_main_list_menus_gui
#
# +----------------------------------------+
# |      Function f_main_find_menus_txt    |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X.
# Outputs: None.
#
f_main_find_menus_txt () {
      echo
      echo
      echo "Enter the name of the application to show the menu where it is listed."
      echo
      echo -n "Enter application name: "
      read X
      grep --ignore-case -B 20 --color=always ^" "$X $THIS_DIR"/LIST_APPS" | less -r -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
unset X
} # End of function f_main_find_menus_txt
#
# +----------------------------------------+
# |      Function f_main_find_menus_gui    |
# +----------------------------------------+
#
#  Inputs: THIS_DIR, GUI.
#    Uses: X, XX, Y.
# Outputs: None.
#
f_main_find_menus_gui () {
      f_ask_download_file $THIS_DIR "LIST_APPS"
      #
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         # Display LIST_APPS list of applications.
         # Get the screen resolution or X-window size.
         # Get rows (height).
         Y=$(stty size | awk '{ print $1 }')
         let Y=$Y-3  # Make room at top of window for a backtitle.
         # Get columns (width).
         X=$(stty size | awk '{ print $2 }')
         #
         XX=$($GUI --inputbox "Enter the name of the application to show the menu where it is listed." 10 70 2>&1 >/dev/tty)
         grep --ignore-case -B 20 ^" "$XX $THIS_DIR"/LIST_APPS" >cliappmenu.tmp
         $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "Search Results" --textbox cliappmenu.tmp $Y $X
      else
         $GUI --title "Read Error" --msgbox "Cannot read $THIS_DIR/LIST_APPS"
      fi
      #
      if [ -r cliappmenu.tmp ] ; then
         rm cliappmenu.tmp
      fi
unset X XX Y
} # End of function f_main_find_menus_gui
#
# +----------------------------------------+
# |       Function f_main_search_apps      |
# +----------------------------------------+
#
#  Inputs: THIS_DIR, FCOLOR, BCOLOR, ECOLOR. 
#    Uses: XSTR.
# Outputs: None.
#
f_main_search_apps () {
      clear # Blank the screen.
      if [ ! -r $THIS_DIR"/LIST_APPS" ] ; then
         clear # Blank the screen.
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "The file LIST_APPS will now be automatically created/updated:"
         echo
         f_press_enter_key_to_continue
         # Download/Update file LIST_APPS.
         f_update_list_apps
      fi
      #
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         XSTR="-1"
         while [ -n "$XSTR" ]
         do
               clear # Blank the screen.
               echo "--- Find & Run an Application ---"
               echo
               echo "Find an application featured in this menu script."
               echo
               echo "To quit, press 'Enter' key."
               echo
               echo -n "Enter the name of the application or software package: "
               read XSTR
               if [ -n "$XSTR" ] ;then
                  echo
                  echo "Please note:"
                  echo "Even if \"$XSTR\" is found," 
                  echo "it may not be available for your Linux distribution."
                  echo
                  echo "Not all Linux distributions will have all packages featured in this menu."
                  echo "i.e. A software package available in Red Hat may not be available in Debian,"
                  echo "     and vice versa."
                  f_press_enter_key_to_continue
                  #
                  f_run_app $XSTR
               fi 
         done
         unset XSTR  # Throw out this variable.
      fi
} # End of function f_main_search_apps

# +----------------------------------------+
# |         Function f_menu_term_ui        |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: X, OLDGUI.
# Outputs: GUI. 
#
f_menu_term_ui () {  # Set terminal display properties.
      # Detect current user-interface in use.
      clear
      echo
      echo "     User-interface \"$GUI\" is currently in-use."
      echo
      OLDGUI="$GUI"
      # Detect other installed user-interfaces.
      if [ $GUI != "dialog" ] ; then
         f_test_gui dialog
      fi
      #
      if [ $GUI != "whiptail" ] ; then
         f_test_gui whiptail
      fi
      #
      if [ $GUI != "text" ] ; then
         echo "     User-interface \"text\" is available."
      fi
      #
      echo
      echo -n "Choose user-interface (d)ialog / (w)hiptail / (t)ext / (q)uit: "; read X
      case $X in
           d*)
           # Test if valid choice.
           f_test_gui dialog
           if [ $ERROR = 0 ] ; then
              # Write to cliapp.cfg configuration file to save preference.
              if [ $OLDGUI = "text" ] ; then  # If switching from "text" to "dialog" then require a restart.
                 echo
                 echo "*********************************************************"
                 echo " Please exit this application to re-start with \"Dialog\"."
                 echo "*********************************************************"
                 echo
                 sleep 3
                 #
                 GUI="dialog"
                 f_update_config_file
                 GUI="text"  # Set $GUI back to "text" to prevent GUI problems with menus until restart.
              else
                 GUI="dialog"
                 f_update_config_file
              fi
           else
              echo
              echo "     User interface is unchanged"
           fi
           ;;
           w*)
           # Test if valid choice.
           f_test_gui whiptail
           if [ $ERROR = 0 ] ; then
              # Write to cliapp.cfg configuration file to save preference.
              if [ $OLDGUI = "text" ] ; then  # If switching from "text" to "whiptail" then require a restart.
                 echo
                 echo "*********************************************************"
                 echo " Please exit this application to re-start with \"Whiptail\"."
                 echo "*********************************************************"
                 echo
                 sleep 3
                 #
                 GUI="whiptail"
                 f_update_config_file
                 GUI="text"  # Set $GUI back to "text" to prevent GUI problems with menus until restart.
              else
                 GUI="whiptail"
                 f_update_config_file
              fi
           else
              echo
              echo "     User interface is unchanged"
           fi
           ;;
           t*)
           # Write to cliapp.cfg configuration file to save preference.
           if [ $GUI != "text" ]  ; then  # If switching from "dialog" or "whiptail" to text then require a restart.
              echo
                 echo "*********************************************************"
              echo " Please exit this application to re-start with \"text or CLI\"."
                 echo "*********************************************************"
              echo
              sleep 3
           fi
           GUI="text"
           f_update_config_file
           GUI="$OLDGUI"  # Set $GUI back to "Whiptail" or "Dialog" to prevent GUI problems with menus until restart.
           ;;
           *)
           echo
           echo "     User interface is unchanged"
           ;;
      esac
      unset X OLDGUI
      #
} # End of function f_menu_term_ui
#
# +----------------------------------------+
# |           Function f_test_gui          |
# +----------------------------------------+
#
#  Inputs: $1=GUI.
#    Uses: None.
# Outputs: ERROR. 
#
f_test_gui () {  # Set terminal display properties.
      # If UI is different from the one in-use.  
      # Test if GUI is installed.
      command -v $1 >/dev/null
      # "&>/dev/null" does not work in Debian distro.
      # 1=standard messages, 2=error messages, &=both.
      ERROR=$?
      # Is GUI installed?
      if [ $ERROR -eq 0 ] ; then
         # Yes, GUI is installed.
         echo "     User-interface \"$1\" is available."
      else
         echo "     User-interface \"$1\" is not installed."
      fi
} # End of function f_test_gui
#
# +----------------------------------------+
# |          Function f_term_color         |
# +----------------------------------------+
#
#  Inputs: $1=$FCOLOR. $2=$BCOLOR
#    Uses: CNT, TPUTX, COLOR.
# Outputs: None. 
#
f_term_color () {  # Set terminal display properties.
      #
      # BASH commands to change the color of characters in a terminal.
      # bold    "$(tput bold)"
      # black   "$(tput setaf 0)"
      # red     "$(tput setaf 1)"
      # green   "$(tput setaf 2)"
      # yellow  "$(tput setaf 3)"
      # blue    "$(tput setaf 4)"
      # magenta "$(tput setaf 5)"
      # cyan    "$(tput setaf 6)"
      # white   "$(tput setaf 7)"
      # reset   "$(tput sgr0)"
      #
      # setterm does not work in X-window virtual terminals.
      # setterm -foreground white -background black -bold on -store
      #
      # Set background first because you must reset colors first to get
      # true black background in some virtual X-terminals.
      # Since "tput setab 0" appears light gray,
      # use "tput sgr0" to reset colors.
      # Set CNT=1 background color then set CNT=2 font color.
      for CNT in 1 2
      do
          if [ $CNT -eq 1 ] ; then
             
             TPUTX="setab"  # Background color.
             COLOR=$2
          else
             TPUTX="setaf"  #  Font color (Fore-ground color).
             COLOR=$1
          fi
          case $COLOR in
               [Bb] | [Bb][Ll] | [Bb][Ll][Aa]*)
               if [ $CNT -eq 1 ] ; then
                  echo -n $(tput sgr0)  # Black background selected.
                                        # Reset colors to get true black.
               else
                  echo -n $(tput $TPUTX 0)  # Black font selected.
               fi
               ;;
               [Bb] | [Bb][Ll] | [Bb][Ll][Uu]*)
               echo -n $(tput $TPUTX 4)  # Blue font/background selected.
               ;;
               [Cc] | [Cc][Yy]*)
               echo -n $(tput $TPUTX 6)  # Cyan font/background selected.
               ;;
               [Gg] | [Gg][Rr] | [Gg][Rr][Ee]*)
               echo -n $(tput $TPUTX 2)  # Green font/background selected.
               ;;
               [Gg] | [Gg][Rr] | [Gg][Rr][Aa]*)
               echo -n $(tput $TPUTX 237)  # Gray font/background selected.
               ;;
               [Mm] | [Mm][Aa]*)
               echo -n $(tput $TPUTX 5)  # Magenta font/background selected.
               ;;
               [Rr] | [Rr][Ee] | [Rr][Ee][Dd])
               echo -n $(tput $TPUTX 1)  # Red font/background selected.
               ;;
               [Rr] | [Rr][Ee] | [Rr][Ee][Ss]*)
               echo -n $(tput sgr0)  # Reset selected.
               ;;
               [Ww] | [Ww][Hh]*)
               echo -n $(tput $TPUTX 7)  # White font/background selected.
               ;;
               [Yy] | [Yy][Ee]*)
               echo -n $(tput $TPUTX 3)  # Yellow font/background selected.
               ;;
          esac
      done
      unset CNT TPUTX COLOR
} # End of function f_term_color
#
# +----------------------------------------+
# |        Function f_menu_term_color      |
# +----------------------------------------+
#
#  Inputs: GUI, FCOLOR, BCOLOR.
#    Uses: AAE, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_menu_term_color () {
case $GUI in
     dialog | whiptail)
     f_menu_term_color_gui $GUI
     ;;
     text)
     f_menu_term_color_txt
     ;;
esac
} # End of f_menu_term_color
#
# +----------------------------------------+
# |      Function f_menu_term_color_txt    |
# +----------------------------------------+
#
#  Inputs: FCOLOR, BCOLOR.
#    Uses: AAE, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_menu_term_color_txt () {
      f_initvars_menu_app "AAE"
      # When $DELIMITER is set as above, then f_menu_item_process does not call
      # f_application_run and try to run the menu item's name.
      # i.e. "Red", "Green" or "Yellow", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAE" = "0" ]
      do    # Start of Terminal Colors Menu until loop.
#f_color_red     #AAE Red     - Red     on black.
#f_color_green   #AAE Green   - Green   on black.
#f_color_yellow  #AAE Yellow  - Yellow  on black.
#f_color_blue    #AAE Blue    - Blue    on black.
#f_color_magenta #AAE Magenta - Magenta on black.
#f_color_cyan    #AAE Cyan    - Cyan    on black.
#f_color_white   #AAE White   - White   on black.
                 #AAE ------- - -----------------
#f_color_bw      #AAE BW      - Black   on white.
#f_color_rw      #AAE RW      - Red     on white.
#f_color_lw      #AAE LW      - Blue    on white.
#f_color_wb      #AAE WB      - White   on blue (Classic "Blueprint").
#f_color_yb      #AAE YB      - Yellow  on blue.
            #
            THIS_FILE="cliappmenu.sh"
            MENU_TITLE="Terminal Colors Menu"
            DELIMITER="#AAE" #AAE This 3rd field prevents awk from printing this line into menu options. 
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AEE
            f_menu_item_process $AEE  # Outputs $MENU_ITEM.
            #
            f_term_color $FCOLOR $BCOLOR # Set terminal color.
            echo $(tput bold) # set bold font.
            #
      done  # End of Terminal Colors Menu until loop.
      #
      unset AAE MENU_ITEM MENU_TITLE  # Throw out this variable.
      # Do not unset DELIMITER because it is needed when this function ends and
      # program flow returns to the Main Menu to prevent running of MENU_ITEM.
} # End of function f_menu_term_color_txt
#
# +----------------------------------------+
# |      Function f_menu_term_color_gui    |
# +----------------------------------------+
#
#  Inputs: $1=GUI
#    Uses: AAE, MENU_TITLE.
# Outputs: None.
#
f_menu_term_color_gui () {
      f_initvars_menu_app "AAE"
      MENU_TITLE="Terminal Colors Menu"
      until [ "$AAE" = "0" ]
      do    # Start of Main Information Menu until loop.
            AAE=$($1 --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (letters):" 20 80 11 \
            "Return"  "Return to the previous menu." \
            "BW"      "Black   on white." \
            "RW"      "Red     on white." \
            "LW"      "Blue    on white." \
            "WB"      "White   on blue (Classic 'Blueprint')." \
            "YB"      "Yellow  on blue." \
            "Red"     "Red     on black." \
            "Green"   "Green   on black." \
            "Yellow"  "Yellow  on black." \
            "Blue"    "Blue    on black." \
            "Magenta" "Magenta on black." \
            "Cyan"    "Cyan    on black." \
            "White"   "White   on black." \
             2>&1 >/dev/tty)
            #
            case $AAE in
                 "Return") AAE=0 ;;
                 "Red") f_color_red ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "Green") f_color_green ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "Yellow") f_color_yellow ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "Blue") f_color_blue ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "Magenta") f_color_magenta ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "Cyan") f_color_cyan ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "White") f_color_white ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "BW") f_color_bw ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "RW") f_color_rw ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "LW") f_color_lw ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "WB") f_color_wb ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
                 "YB") f_color_yb ; f_term_color $FCOLOR $BCOLOR ; echo -n "This is the color of the text.  Press <Enter> key to continue." ; read X ;;
            esac
      done
} # End of function f_menu_term_color_gui
#
# +----------------------------------------+
# |         Function f_color_<color>       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: None.
# Outputs: FCOLOR, BCOLOR, ECOLOR
#
# The series of functions below set the terminal's color.
#
f_color_red () {
      FCOLOR="Red" ; BCOLOR="Black"  ; ECOLOR="Yellow"
      f_update_config_file
}
#
f_color_green () {
      FCOLOR="Green" ; BCOLOR="Black" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_yellow () {
      FCOLOR="Yellow" ; BCOLOR="Black" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_blue () {
      FCOLOR="Blue" ; BCOLOR="Black" ;  ECOLOR="Red"
      f_update_config_file
}
#
f_color_magenta () {
      FCOLOR="Magenta" ; BCOLOR="Black" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_cyan () {
      FCOLOR="Cyan" ; BCOLOR="Black" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_white () {
      FCOLOR="White" ; BCOLOR="Black" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_bw () {
      FCOLOR="Black" ; BCOLOR="White" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_rw () {
      FCOLOR="Red" ; BCOLOR="White" ; ECOLOR="Blue"
      f_update_config_file
}
#
f_color_lw () {
      FCOLOR="Blue" ; BCOLOR="White" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_wb () {
      FCOLOR="White" ; BCOLOR="Blue" ; ECOLOR="Red"
      f_update_config_file
}
#
f_color_yb () {
      FCOLOR="Yellow" ; BCOLOR="Blue" ; ECOLOR="Red"
      f_update_config_file
}
#
# +----------------------------------------+
# |       Function f_menu_term_uncolor     |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_menu_term_uncolor () {
case $GUI in
     dialog | whiptail)
      clear # Clear screen.
      $GUI --title "Not applicable for \"Dialog\" or \"Whiptail\"" --msgbox "\n       You are using the \"Dialog\" or \"Whiptail\" User-Interface.\n\n   *** This option does not apply to the current user-interface. ***\n\n              It only applies to the \"Text\" user-interface." 12 78
      #
      $GUI --title "HOW-TO" --msgbox "\nYou may still set the terminal colors but it will only affect the \"Text\" user-interface.\n\nThis script needs to be restarted with the user-interface set to \"Text\" mode to see any color changes." 12 65
     f_menu_term_uncolor_gui $GUI		
     ;;
     text)
     f_menu_term_uncolor_txt
     ;;
esac
} # End of f_menu_term_uncolor
#
# +----------------------------------------+
# |     Function f_menu_term_uncolor_txt   |
# +----------------------------------------+
#
#  Inputs: FCOLOR, BCOLOR.
#    Uses: AAF, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: THIS_FILE.
#
f_menu_term_uncolor_txt () {
      f_initvars_menu_app "AAF"
      # When $DELIMITER is set as above, then f_menu_item_process does not call
      # f_application_run and try to run the menu item's name.
      # i.e. "Red", "Green" or "Yellow", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAF" = "0" ]
      do    # Start of Unavailable Colors until loop.
#f_ucolor_red     #AAF Red        - Red.
#f_ucolor_green   #AAF Green      - Green.
#f_ucolor_yellow  #AAF Yellow     - Yellow.
#f_ucolor_blue    #AAF Blue       - Blue.
#f_ucolor_magenta #AAF Magenta    - Magenta.
#f_ucolor_cyan    #AAF Cyan       - Cyan.
#f_ucolor_white   #AAF White      - White.
#f_ucolor_gray    #AAF Gray       - Gray (not available in 8-color terminals).
           #
            THIS_FILE="cliappmenu.sh"
            MENU_TITLE="Colors for Unavailable Menu Items"
            DELIMITER="#AAF" #AAF This 3rd field prevents awk from printing this line into menu options.
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAF
            f_menu_item_process $AAF  # Outputs $MENU_ITEM.
            #
            f_term_color $FCOLOR $BCOLOR # Set terminal color.
            echo $(tput bold) # set bold font.
            #
      done  # End of Unavailable Colors until loop.
      #
      unset AAF MENU_ITEM MENU_TITLE  # Throw out this variable.
      # Do not unset DELIMITER because it is needed when this function ends and
      # program flow returns to the Main Menu to prevent running of MENU_ITEM.
} # End of function f_menu_term_uncolor_txt
#
# +----------------------------------------+
# |     Function f_menu_term_uncolor_gui   |
# +----------------------------------------+
#
#  Inputs: $1=GUI, FCOLOR, BCOLOR.
#    Uses: AAF, MENU_TITLE.
# Outputs: None.
#
f_menu_term_uncolor_gui () {
      f_initvars_menu_app "AAF"
      THIS_FILE="cliappmenu.sh"
      MENU_TITLE="Colors for Unavailable Menu Items"
      until [ "$AAF" = "0" ]
      do    # Start of Unavailable Colors until loop.
            AAF=$($1 --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (letters):" 20 80 11 \
            "Return"  "Return to the previous menu." \
            "Red"     "Red." \
            "Green"   "Green." \
            "Yellow"  "Yellow."\
            "Blue"    "Blue." \
            "Magenta" "Magenta." \
            "Cyan"    "Cyan." \
            "White"   "White." \
            "Gray"    "Gray (not available in 8-color terminals)." \
            2>&1 >/dev/tty)
            #
            case $AAF in
                 "Return") AAF=0 ;;
                 "Red") f_ucolor_red ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Green") f_ucolor_green ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Yellow") f_ucolor_yellow ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Blue") f_ucolor_blue ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Magenta") f_ucolor_magenta ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Cyan") f_ucolor_cyan ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "White") f_ucolor_white ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
                 "Gray") f_ucolor_gray ; f_term_color $UCOLOR $BCOLOR ; echo -n "Unavailable menu items." ; f_term_color $FCOLOR $BCOLOR ; echo -n " Available menu items.   " ; echo -n "Press <Enter> key to continue." ; read X ;;
           esac
           #
           f_term_color $FCOLOR $BCOLOR # Set terminal color.
           echo $(tput bold) # set bold font.
           #
      done  # End of Unavailable Colors until loop.
      #
      unset AAF MENU_TITLE  # Throw out this variable.
      # Do not unset DELIMITER because it is needed when this function ends and
      # program flow returns to the Main Menu to prevent running of MENU_ITEM.
} # End of function f_menu_term_uncolor_gui
#
# +----------------------------------------+
# |         Function f_ucolor_<color>      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: None.
# Outputs: UCOLOR
#
# The series of functions below set the terminal's color.
#
f_ucolor_red () {
      UCOLOR="Red"
      f_update_config_file
}
#
f_ucolor_green () {
      UCOLOR="Green"
      f_update_config_file
}
#
f_ucolor_yellow () {
      UCOLOR="Yellow"
      f_update_config_file
}
#
f_ucolor_blue () {
      UCOLOR="Blue"
      f_update_config_file
}
#
f_ucolor_magenta () {
      UCOLOR="Magenta"
      f_update_config_file
}
#
f_ucolor_cyan () {
      UCOLOR="Cyan"
      f_update_config_file
}
#
f_ucolor_white () {
      UCOLOR="White"
      f_update_config_file
}
#
f_ucolor_gray () {
      UCOLOR="gray"
      f_update_config_file
}
#
# +----------------------------------------+
# |      Function f_update_config_file     |
# +----------------------------------------+
#
#  Inputs: GUI, FCOLOR, BCOLOR, UCOLOR, ECOLOR.
#    Uses: None.
# Outputs: File ~/.cliappmenu.cfg over-written.
#
f_update_config_file () {
      # Update Configuration File: ~/.cliappmenu.conf
      # to save user chosen colors.
      echo "f_main_config () {" > ~/.cliappmenu.cfg
      echo "      GUI=\"$GUI\"" >> ~/.cliappmenu.cfg
      echo "      FCOLOR=\"$FCOLOR\" ; BCOLOR=\"$BCOLOR\" ; UCOLOR=\"$UCOLOR\" ; ECOLOR=\"$ECOLOR\"" >> ~/.cliappmenu.cfg
      echo "} # End of function f_main_config" >> ~/.cliappmenu.cfg
} # End of function f_update_config_file
#
# +----------------------------------------+
# |       Function f_update_software       |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: X, ERROR, MOD_FILE.
# Outputs: PRESS_KEY.
#
f_update_software () {
      MOD_FILE=""  # Null so an older file name is not displayed by function,
                   # f_test_internet_connection if the test fails.
      #
      # Check if there is an Internet connection before doing a download.
      f_test_internet_connection
      #
      # If Internet connection OK, then download.
      if [ $ERROR -eq 0 ] ; then
         #
         # Are either of the directories read-only?
         if [ ! -w $MAINMENU_DIR -o ! -w $THIS_DIR ] ; then 
            # Yes, then need sudo permissions.
            # Ask for sudo permissions password using an innocuous command.
            echo
            echo "You need sudo permissions to update this software."
            sudo echo &>/dev/null
            # 1=standard messages, 2=error messages, &=both.
         fi
         echo
         echo "Choose the branch from where you want to update the software."
         for MOD_FILE in cliappmenu.sh lib_cli-common.lib lib_cli-menu-cat.lib lib_cli-web-sites.lib mod_apps-sample-template.lib README COPYING EDIT_HISTORY CODE_HISTORY LIST_APPS
         do
            echo "_____________________________________________________________________"
            echo
            echo "Update \"$MOD_FILE\" from the GitHub software repository?"
            # Ask download from which branch and wget.
            f_wget_file
            #
            if [ "$MOD_FILE" = "LIST_APPS" ] ; then
               echo
               echo "If upgrading from version 1 to version 2, please update all modules also."
               echo "You may do this by selecting \"Update All Modules\" in the \"Configuration Menu\"."
               f_press_enter_key_to_continue
            fi
            #
         done
         PRESS_KEY=0  # Do not use "Press Enter key" but use "Q" or "Quit"
                      # so message above is read.
                      # f_wget also sets it to 1
                      # but if module is not downloaded then still set to 0.
         clear # Blank the screen.
         echo
         echo "Files cliappmenu.sh and cliappmenu.tar.gz (backup) are in folder:"
         echo "\"$MAINMENU_DIR\"."
         echo
         echo "All other software program files are in folder:"
         echo "\"$THIS_DIR\"."
         echo
         #
         # Message to restart script.
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo "___________________________________________"
         echo " Re-run script to use new updated script."
         echo "           >>> Exiting script <<<"
         echo "___________________________________________"
         f_term_color $FCOLOR $BCOLOR
         echo $(tput bold)
         f_press_enter_key_to_continue
         #
         # Exit function and exit script to system prompt.
         exit 1
      else  # Internet connection failed so skip download of updates/upgrades.
         f_press_enter_key_to_continue
      fi
      unset X ERROR MOD_FILE
} # End of function f_update_software
#
# +----------------------------------------+
# |       Function f_update_list_apps      |  
# +----------------------------------------+
#
#  Inputs: THIS_DIR, FCOLOR, BCOLOR, ECOLOR.
#    Uses: Y.
# Outputs: None.
#
f_update_list_apps () {
      Y="" # Initialize scratch variable.
      while [  "$Y" != "YES" -a "$Y" != "NO" ]
      do
             clear # Blank the screen.
             echo "--- Update App List ---"
             echo
             echo "This will update the list of applications available only in the modules"
             echo "currently downloaded into the software module library directory."
             echo
             echo "If a software module has not been downloaded, then the applications described"
             echo "in that module will not appear in this list."
             echo 
             echo "For a COMPLETE listing of ALL applications available in ALL modules,"
             echo "ALL modules MUST be downloaded into the software module library directory."
             echo
             echo "The file below contains the list of applications."
             echo "\"$THIS_DIR/LIST_APPS\""
             echo
             echo -n "Are you ready to update the file, \"LIST_APPS\"? (y/N): "
             read Y
             case $Y in
                  [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                  # if README file is missing, download it from GitHub.
                  f_ask_download_file $THIS_DIR "README"
                  #
                  # Was download of README successful?
                  if [ -r $THIS_DIR/README ] ; then
                     . lib_cli-common.lib
                     f_create_LIST_APPS
                     echo ; echo "File \"LIST_APPS\" is updated."
                  else
                     # Use different color font for error messages.
                     f_term_color $ECOLOR $BCOLOR
                     echo $(tput bold)
                     #
                     echo "File \"LIST_APPS\" is not updated."
                     echo "because the $THIS_DIR/README file is missing."
                     #
                     f_term_color $FCOLOR $BCOLOR
                     echo $(tput bold)
                  fi
                  Y="YES"
                  f_press_enter_key_to_continue
                  ;;
                  "" | [Nn] | [Nn][Oo])
                  echo ; echo "File \"LIST_APPS\" is not updated."
                  f_press_enter_key_to_continue
                  Y="NO"
                  ;;
             esac
      done
      unset Y
} # End of function f_update_list_apps
#
# +----------------------------------------+
# |         Function f_ls_this_dir         |
# +----------------------------------------+
#
#  Inputs: $1 - Directory. 
#    Uses: None.
# Outputs: None.
#
f_ls_this_dir () {
      clear # Blank the screen.
      ls -gGh --group-directories-first $1 | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
} # End of function f_ls_this_dir
#
# +----------------------------------------+
# |     Function f_reinstall_readme        |
# +----------------------------------------+
#
#  Inputs: GUI.
#    Uses: None.
# Outputs: None.
#
f_reinstall_readme () {
case $GUI in
     dialog | whiptail)
     f_reinstall_readme_gui
     ;;
     text)
     f_reinstall_readme_txt
     ;;
esac
} # End of f_main_code_history
#
# +----------------------------------------+
# |    Function f_reinstall_readme_txt     |
# +----------------------------------------+
#
#  Inputs: $1 - Directory. 
#    Uses: None.
# Outputs: None.
#
f_reinstall_readme_txt () {
      clear # Blank the screen.
      echo "To re-install this software into another location/directory,"
      echo "simply copy the file, "cliappmenu.sh" to the other directory."
      echo
      echo "        cp <old directory>/cliappmenu.sh <new directory>"
      echo "             or"
      echo  "       sudo cp <old directory>/cliappmenu.sh <new directory>"
      echo
      echo
      echo "Then change to the new directory and run the script."
      echo
      echo "        cd <new directory>"
      echo
      echo "        bash cliappmenu.sh"
      echo "             or"
      echo "        sudo bash cliappmenu.sh"
      echo
      echo "Then the mini-installer will automatically run and give you more instructions."
      echo
} # End of function f_reinstall_readme_txt
#
# +----------------------------------------+
# |    Function f_reinstall_readme_gui     |
# +----------------------------------------+
#
#  Inputs: $1 - Directory. 
#    Uses: None.
# Outputs: None.
#
f_reinstall_readme_gui () {
      echo "To re-install this software into another location/directory," >cliappmenu.tmp
      echo "simply copy the file, "cliappmenu.sh" to the other directory." >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "        cp <old directory>/cliappmenu.sh <new directory>" >>cliappmenu.tmp
      echo "             or" >>cliappmenu.tmp
      echo  "       sudo cp <old directory>/cliappmenu.sh <new directory>" >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "Then change to the new directory and run the script." >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "        cd <new directory>" >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "        bash cliappmenu.sh" >>cliappmenu.tmp
      echo "             or" >>cliappmenu.tmp
      echo "        sudo bash cliappmenu.sh" >>cliappmenu.tmp
      echo >>cliappmenu.tmp
      echo "Then the mini-installer will automatically run" >>cliappmenu.tmp
      echo "and give you more instructions." >>cliappmenu.tmp
      # Get the screen resolution or X-window size.
      # Get rows (height).
      Y=$(stty size | awk '{ print $1 }')
      let Y=$Y-3  # Make room at top of window for a backtitle.
      # Get columns (width).
      X=$(stty size | awk '{ print $2 }')
      #
      $GUI --backtitle "(use arrow keys and spacebar to scroll up/down/side-ways)" --title "HOW-TO Reinstall" --textbox cliappmenu.tmp $Y $X
      #
      if [ -r cliappmenu.tmp ] ; then
         rm cliappmenu.tmp
      fi
} # End of function f_reinstall_readme_gui
#
# **************************************
# ***         Main Menu Text         ***
# **************************************
#
#  Inputs: None.
#    Uses: None.
# Outputs: None.
#
f_main_menu_txt () {
      f_initvars_menu_app "AAA"
      # When $DELIMITER is set as above,
      # then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
      # i.e. "Applications", "Help and Features" or "About CLI Menu",
      #      "Configure", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAA" = "0" ]
      do    # Start of Main Menu until loop.
            #f_menu_cat_applications #AAA Applications       - Run an application.
            #f_menu_app_favorites    #AAA Favorites          - Menu of favorite applications.
            #f_main_search_apps      #AAA Find and Run       - Find & run an application in active menus.
            #f_main_list_find_menus  #AAA List or Find Menus - List all menus or find a menu containing an app.
            #f_main_configure        #AAA Configure          - Update software, manage modules, change colors, etc.
            #f_main_help             #AAA Help and Features  - Basic usage and what can it do.
            #f_main_information      #AAA Information        - About, version, documentation, code history, license.
            #
            THIS_FILE="cliappmenu.sh"
            MENU_TITLE="Main Menu"
            DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu items.
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER"
            read AAA
            f_menu_item_process $AAA  # Outputs $MENU_ITEM.
                                      # Sets AAA=0 for item option Quit.
      done  # End of Main Menu until loop.
      #
      # Unset all variables because the following libraries and all modules are
      # "sourced" which means that any variables set by these sourced
      # module/library files will remain behind in the shell unless unset
      # explicitly.
      #
      # List of "Sourced" module/library files.
      # . $THIS_DIR/lib_cli-common.lib    # invoke module/library.
      # . $THIS_DIR/lib_cli-menu-cat.lib  # invoke module/library.
      # . $THIS_DIR/lib_cli-web-sites.lib # invoke module/library.
      # . $THIS_DIR/mod_apps_*.lib        # invoke module/library.

      unset AAA ANS APP_NAME APP_NAME_INSTALL APP_NAME_SUDO APP_NAME_TMP BCOLOR BRANCH  CHOICE CNT COLOR DELIM ERROR ECOLOR FCOLOR GUI INIT_VAR INSTALL_ANS MAINMENU_DIR MAX MENU_ITEM MENU_ITEM_MAX MENU_ITEM_OPT MENU_TITLE MOD_FILE MOD_FUNC NEW_DIR NO_CLEAR PRESSKEY PROJECT_REVDATE PROJECT_REVISION QUIT_FIELD REVDATE REVISION SAVE_DIR SCRIPT_PATH THIS_DIR THIS_FILE TPUTX UCOLOR WEB_SITE WEB_SITE_INSTALL X XNUM XSTR XXSTR YSTR
      #
      clear # Blank the screen. Nicer ending especially if you chose custom colors for this script.
      #
      exit 0 # Exit with exit code 0.
      # This cleanly closes the process generated by #!bin/bash. 
      # Otherwise every time this script is run, another instance of
      # process /bin/bash is created using up resources.
} # End of function f_main_menu_txt
#
# **************************************
# ***         Main Menu GUI          ***
# **************************************
#
#  Inputs: None.
#    Uses: None.
# Outputs: None.
#
f_main_menu_gui () {
      f_main_init_once
      f_initvars_menu_app "AAA"
      # When $DELIMITER is set as above,
      # then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
      # i.e. "Applications", "Help and Features" or "About CLI Menu",
      #      "Configure", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAA" = "0" ]
      do    # Start of Main Menu until loop.
            MENU_TITLE="Main Menu"
            AAA=$($GUI --title "$MENU_TITLE" --menu "\n\nUse (up/down arrow keys) or (1 to 8) or (letters):" 20 80 11 \
            "Quit" "Quit to the command line prompt." \
            "Applications" "Run an application." \
            "Favorites" "Menu of favorite applications." \
            "Find and Run" "Find & run an application in active menus." \
            "List or Find Menus" "List all menus or find a menu containing an app." \
            "Configure" "Update software, manage modules, change colors, etc." \
            "Help and Features" "Basic usage and what can it do." \
            "Information" "About, version, documentation, code history, license." \
            2>&1 >/dev/tty)
            #
            case $AAA in
                 "Quit") AAA=0 ;;
                 "Applications") f_main_applications ;;
                 "Favorites") f_main_favorites ;;
                 "Find and Run") f_main_search_apps ;;
                 "List or Find Menus") f_main_list_find_menus ;;
                 "Configure") f_main_configure ;;
                 "Help and Features") f_main_help ;;
                 "Information") f_main_information ;;
            esac
      done  # End of Main Menu until loop.
      #
      # Unset all variables because the following libraries and all modules are
      # "sourced" which means that any variables set by these sourced
      # module/library files will remain behind in the shell unless unset
      # explicitly.
      #
      unset AAA ANS APP_NAME APP_NAME_INSTALL APP_NAME_SUDO APP_NAME_TMP BCOLOR BRANCH CHOICE CNT COLOR DELIM ERROR ECOLOR FCOLOR GUI INIT_VAR INSTALL_ANS MAINMENU_DIR MAX MENU_ITEM MENU_ITEM_MAX MENU_ITEM_OPT MENU_TITLE MOD_FILE MOD_FUNC NEW_DIR NO_CLEAR PRESSKEY PROJECT_REVDATE PROJECT_REVISION QUIT_FIELD REVDATE REVISION SAVE_DIR SCRIPT_PATH THIS_DIR THIS_FILE TPUTX UCOLOR WEB_SITE WEB_SITE_INSTALL X XNUM XSTR XXSTR YSTR
      #
      clear # Blank the screen. Nicer ending especially if you chose custom colors for this script.
      #
      exit 0 # Exit with exit code 0.
      # This cleanly closes the process generated by #!bin/bash. 
      # Otherwise every time this script is run, another instance of
      # process /bin/bash is created using up resources.
} # End of function f_main_menu_gui
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
#  Inputs: 
#    Uses: AAA, MENU_ITEM, MENU_TITLE, DELIMITER.
# Outputs: exit 0
#
# Since the DASH environment does not recognize the ". <library> command,
# the function f_test_dash must be included in this cliappmenu.sh script file
# rather than in the library file lib_cli-common.lib, but once in BASH, then
# common library file may be invoked.
#
# Test the environment for DASH and if in BASH invoke the common library.
f_test_dash
#
# Set SCRIPT_PATH to directory path of script.
f_script_path
#
f_main_init_once
#
# If you want to force a particular environment, text, whiptail, or dialog,
# see the tail of function f_detect_ui and uncomment the GUI variable.
# Those lines are marked "# Diagnostic line." for easy reference.
#
# Force $GUI to a specific environment for testing.  # Diagnostic line.
# GUI="text"      # Diagnostic line.
# GUI="dialog"    # Diagnostic line.
# GUI="whiptail"  # Diagnostic line.
#
case $GUI in
     dialog | whiptail)
     f_main_menu_gui
     ;;
     text)
     f_main_menu_txt
     ;;
esac
fterm_color GREEN BLACK  # Reset terminal colors to Green on Black.
} # End of Main Program
# all dun dun noodles.
