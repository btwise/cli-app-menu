#!/bin/bash
# ©2013 Copyright 2013 Robert D. Chin
#
# +----------------------------------------+
# |    Revision number and Revision Date   |
# +----------------------------------------+
#
THIS_FILE="cli-app-menu.sh"
REVDATE="December-14 2013 14:41"
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
# Script cli-app-menu.sh is a menu of CLI applications and commands
# to help CLI newbies to discover what a command line can do.
#
# Please see the file README for more information.
# The "#:" at the beginning of lines below are used to delineate the Help Instructions.
#:
#:   Brief Description
#:   FILE LOCATIONS of cli-app-menu project
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
#LIC This program, cli-app-menu.sh is under copyright.
#LIC ©2013 Copyright 2013 Robert D. Chin (rdchin at yahoo.com).
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
# The "#:" at the beginning of lines below are used to delineate the Help Instructions.
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
#: Please enjoy . . . bob chin (2013).
#:                    rdchin at yahoo.com.
#:
#:
#@ +----------------------------------------+
#@ |            Menu Features               |
#@ +----------------------------------------+
#@
#@ At the menu prompt, you can enter OPTIONS and FILES.
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
# |         Function f_script_path         |
# +----------------------------------------+
#
#  Inputs: $BASH_SOURCE (System variable)
#    Uses: None
# Outputs: SCRIPT_PATH
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
# |          Function f_test_dash          |
# +----------------------------------------+
#
#  Inputs: $BASH_VERSION (System variable)
#    Uses: None
# Outputs: None
#
f_test_dash () {
      # Set default colors in case configuration file is not readable or does not exist.
      FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red"
      #
      if [ "$BASH_VERSION" = '' ]; then
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
         echo "'bash cli-app-menu.sh' at the command line."
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
         exit 1 # Exit with value $?=1 indicating an error condition
                # and stop running script.
      fi
} # End of function f_test_dash
#
# +----------------------------------------+
# |        Function f_main_init_once       |
# +----------------------------------------+
#
#  Inputs: $BASH_VERSION (System variable)
#    Uses: None
# Outputs: None
#
f_main_init_once () {
      # Initialize variables.
      #
      # Each user may store default settings in a configuration file
      # in the user's home folder.
      #
      # Set default colors in case configuration file is not readable or does not exist.
      FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red"
      #
      # Does configuration file exist and is readable?
      if [ ! -r ~/.cli-app-menu.cfg ] ; then
         # No, configuration file does not exist. Create file.
         # If background color is black or blue, then use yellow font.
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo
         echo "Configuration file is missing from user's home directory."
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo "Creating configuration file: /home/<username_goes_here>/.cli-app-menu.cfg"
         echo "f_main_config () {" > ~/.cli-app-menu.cfg
         echo "      FCOLOR=\"Green\" ; BCOLOR=\"Black\" ; UCOLOR=\"\" ; ECOLOR=\"Red\"" >> ~/.cli-app-menu.cfg
         echo "} # End of function f_main_config" >> ~/.cli-app-menu.cfg
         echo
         echo -n "Press '"Enter"' key to continue."
         read X
         unset X  # Throw out this variable.
      fi
      #
      if [ -r ~/.cli-app-menu.cfg ] ; then
         # Yes. read file contents.
         . ~/.cli-app-menu.cfg
         f_main_config
      else      
         # No. Use default settings.
         FCOLOR="Green" ; BCOLOR="Black" ; UCOLOR="" ; ECOLOR="Red"
      fi
      #
      f_term_color $FCOLOR $BCOLOR # Set terminal color.
      echo -n $(tput bold) # set bold font.
      #
      # Enable 256 colors for terminal, if possible.
      # Set terminal colors from 8 to 256 colors.
        export TERM=xterm-256color       
      #
      # You have the option of either keeping all the program files in the same
      # folder or a separate folder for the Main Menu (file cli-app-menu.sh).
      # 
      # MAINMENU_DIR contains the script file cli-app-menu.sh.
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
      #      Just put script cli-app-menu.sh in your personal home directory.
      #      Other users will have to do the same with their own separate copy.
      #
      #      /home/<username_goes_here>/<cli-app-menu sub-directory>
      #      Library module and support files go in the sub-directory.
      #      Other users will have to do the same with their own separate copy.
      #
      # i.e. /usr/local/bin/<script-goes-here>
      #      A single copy of the script, accessible to all users goes here.
      #
      #      /usr/local/bin/<cli-app-menu sub-directory>
      #      Create this directory to contain all the library module files
      #      and support files, accessible by all users. 
      #      
      #      The /usr directory contains user applications.
      #
      # i.e. /opt/<script-goes-here>
      #      A single copy of the script, accessible to all users goes here.
      #
      #      /opt/<cli-app-menu sub-directory>
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
      MAINMENU_DIR="/Directory_containing_the_script_cli-app-menu.sh"
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize MAINMENU_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      # Validate file names and directories.
      # Use the directory $SCRIPT_DIR that contains the script cli-app-menu.sh.
      # Does $SCRIPT_DIR = $MAINMENU_DIR?
         # Yes, exit function.
      if [ "$SCRIPT_PATH" != "$MAINMENU_DIR" ] ; then
         # No, edit script cli-app-menu.sh so that $MAINMENU_DIR is $SCRIPT_DIR.
         #
         clear # Blank the screen.
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo "Detected different directory reference for script:"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "Changing from:"
         echo "   $MAINMENU_DIR"
         echo
         echo "Changing to:"
         echo "   $SCRIPT_PATH"
         echo
         echo "This directory should contain the script \"cli-app-menu.sh\"."
         echo "Automatically re-configuring \"cli-app-menu.sh\" to use new directory."
         echo
         # Is directory writeable?
         if [ -w $SCRIPT_PATH ] ; then
            # Yes, directory is writeable.
            sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/cli-app-menu.sh
            ERROR=$?
            if [ $ERROR -ne 0 ] ; then
               f_term_color $ECOLOR $BCOLOR
               echo $(tput bold)
               echo -n "Error re-configuring \"cli-app-menu.sh\" to use new directory."
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            fi   
         else
            # No, directory is not writeable so use sudo permissions.
            echo "Must now use sudo permissions to re-configure \"cli-app-menu.sh\"."
            sudo sed -i "s|$MAINMENU_DIR|$SCRIPT_PATH|" $SCRIPT_PATH/cli-app-menu.sh
            ERROR=$?
            if [ $ERROR -ne 0 ] ; then
               f_term_color $ECOLOR $BCOLOR
               echo $(tput bold)
               echo "Error re-configuring,\"cli-app-menu.sh\" to use new directory"
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
         unset X XSTR
         exit 1
      fi
      #
      # THIS_DIR contains files: lib_cli-*, mod_apps-*, EDIT_HISTORY,
      # README, and COPYING and (optionally) cli-app-menu.sh.
      #
      # THIS_DIR may or may not be the same folder as MAINMENU_DIR.
      # However it should be writable by the user maintaining it so that
      # additional software library modules may be downloaded as they are
      # updated or needed and LIST_APPS can be updated accordingly.
      # 
      # Since this folder will contain multiple files for this project,
      # it may help to name it "cli-app-menu" for use by only project files.
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
      # Why have a separate folder from the one containing cli-app-menu.sh?
      #
      # If you are using a single-user PC/laptop, you may simply put the 
      # script in your personal home directory, with all other files in a
      # separate sub-folder so as not to "clog" your home directory with
      # a bunch of new files.
      #
      # Tip: When logging into the console, the user's home directory is the
      # working directory by default. You can automatically run cli-app-menu.sh
      # every time you log in by including the script command into your .bashrc
      # file.
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      # THIS_DIR does not need a trailing forward slash "/".
      THIS_DIR="/some_directory/cli-app-menu"
      #
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      # >>>>>>>>>>>>>>>>>>>>> Customize THIS_DIR <<<<<<<<<<<<<<<<<<<<<
      #
      f_valid_files "$THIS_DIR" "lib_cli-common.lib"
      f_valid_files "$THIS_DIR" "lib_cli-web-sites.lib"
      f_valid_files "$THIS_DIR" "lib_cli-menu-cat.lib"
      #
      # Invoke the common library to display menus.
      . $THIS_DIR/lib_cli-common.lib    # invoke module/library.
      . $THIS_DIR/lib_cli-menu-cat.lib  # invoke module/library.
      . $THIS_DIR/lib_cli-web-sites.lib # invoke module/library.
} # End of function f_main_init_once
#
# +----------------------------------------+
# |      Function f_initvars_menu_app      |
# +----------------------------------------+
#
#  Inputs: $1=Until-Loop variable.
#    Uses: X, INITVAR.
# Outputs: MAINMENU_DIR, THIS_DIR, APP_NAME, WEB_BROWSER, TEXT_EDITOR, MENU_ITEM, ERROR.
#
f_initvars_menu_app () {
      echo $(tput bold) # Display bold font for all menus.
      ERROR=0        # Initialize to 0 to indicate success at running last
                     # command.
      #
      # Initialize variables to "" or null.
      for INIT_VAR in APP_NAME WEB_BROWSER TEXT_EDITOR
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
# |          Function f_valid_files        |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File.
#    Uses: None.
# Outputs: None.
#
f_valid_files () {
      # Check for required files and directories.
      # Is the required file in an existing directory?
      NEW_DIR=""  # Initialize NEW_DIR changed if new directory is created.
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
            f_change_dir $1 $2
         else
            f_term_color $ECOLOR $BCOLOR
            echo -n $(tput bold)
            echo "A required file, \"$2\" is missing."
            echo $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
            echo
            echo "Choices to fix the problem will be shown in the next menu."
            echo
            echo -n "Press \"Enter\" key to continue. "
            read X
         fi
         #
         if [ "$NEW_DIR" != "" ] ; then
            f_valid_menu $NEW_DIR $2
         else
            f_valid_menu $1 $2
         fi
         f_valid_path $NEW_DIR
         f_valid_exit $1 $NEW_DIR
      fi
} # End of function f_valid_files
#
# +----------------------------------------+
# |          Function f_valid_menu         |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File.
#    Uses: None.
# Outputs: NEW_DIR.
#
f_valid_menu () {
      f_initvars_menu_app "AAD"
      # Please note: The function "f_show_menu" in library module file, "lib-cli-common.lib"
      #              cannot be used at this time, since that file may not yet exist or
      #              may need to be downloaded from the GitHub web site.
      #
      MENU_TITLE="Validate Files and Directories Menu"
      NEW_DIR=$1 # Set $NEW_DIR to original (possibly invalid) directory.
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
               echo "   $NEW_DIR"
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo
            else
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo "Required file:"
               echo "   \"$2\""
               echo
               echo "is now in a valid directory:"
               echo "   $NEW_DIR"
               echo 
            fi
            echo "--- $MENU_TITLE ---"
            echo
            echo "0 - Quit to command line prompt."
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
                 1 |[Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)
                 f_file_download $NEW_DIR $2
                 ;;
                 2 | [Cc] | [Cc][Hh] | [Cc][Hh][Aa]*)
                 f_change_dir $NEW_DIR $2
                 ;;
                 3 | [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)
                 THIS_DIR=$NEW_DIR
                 f_ls_this_dir
                 ;;

            esac
      done  # End of Validate Menu until loop.
            #
      unset AAD MENU_ITEM  # Throw out this variable.
} # End of function f_valid_menu
#
# +----------------------------------------+
# |           Function f_valid_path        |
# +----------------------------------------+
#
#  Inputs: $1=Directory
#    Uses: $PATH.
# Outputs: Error code 1 if path is bad.
#
f_valid_path () {
      #
      # Check the $PATH
      if [[ ! "$PATH" == *":$1"* ]] ; then
         echo
         echo $(tput bold)
         echo "Append the directory name to your PATH:"
         echo "$PATH"
         echo $(tput sgr0)
         echo "Edit your /home/<username_goes_here>/.bashrc file and add the directory"
         echo "by adding these lines to the end of the .bashrc file:"
         echo 
         echo $(tput bold)'PATH=$PATH'":$1"
         echo "export PATH"
         echo
         echo "       >>> IMPORTANT <<<"
         echo "After editing the file, .bashrc:"
         echo "Close Terminal for changes to take effect."
         echo "Either logout or exit from Terminal and re-launch Terminal."
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
         exit 1
      fi
} # End of function f_valid_path
#
# +----------------------------------------+
# |          Function f_valid_exit         |
# +----------------------------------------+
#
#  Inputs: $1=Original Directory, $2=New Directory.
#    Uses: None.
# Outputs: None.
#
f_valid_exit () {
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
         unset
         exit 1
      else
         # No, directory not changed, but THIS_DIR variable may have been changed so exit.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo
         echo "______________________________"
         echo " Re-run script to use changes."
         echo "    >>> Exiting script <<<"
         echo "______________________________"
         echo $(tput sgr0)
         unset NEW_DIR
         exit 1
         fi
} # End of function f_valid_exit
#
# +----------------------------------------+
# |         Function f_file_download       |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File.
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
f_file_download () {
      # Does directory exist?
      if [ -d $1 ] ; then
         # Yes, so continue to download files.
         if [ "$2" = "lib_cli-common.lib" -o "$2" = "lib_cli-menu-cat.lib" -o "$2" = "lib_cli-web-sites.lib" ] ; then
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
                   f_file_dload $1 $MOD_FILE
                fi
            done
         else
            if [ ! -r $1/$2 ] ; then
            # No it does not exist so download it.
               f_file_dload $1 $2
            fi
         fi
      else
         # No, directory does not exist so cannot download file into the directory.
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
} # End of function f_file_download
#
# +----------------------------------------+
# |           Function f_file_dload        |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File.
#    Uses: X.
# Outputs: None.
#
f_file_dload () {
      clear  # Blank the screen.
      #
      if [ -d "$1" ] ; then
         # Directory exists so download file into the directory.
         echo "Download the file from the GitHub web site."
         echo
         echo "Download file:"
         echo "   $2"
         echo
         echo "into the directory:"
         echo "   $1"
         echo
         # Ask download from which branch and wget.
         echo -n "Download the file now? (Y/n): "
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
              # Is directory writeable?
              if [ -w $NEW_DIR ] ; then
                 # Yes, directory is writeable.
                 wget --directory-prefix=$NEW_DIR $WEB_SITE$MOD_FILE
                 ERROR=$?
                 if [ $ERROR -ne 0 ] ; then
                    f_term_color $ECOLOR $BCOLOR
                    echo $(tput bold)
                    echo -n "Error downloading $MOD_FILE to $NEW_DIR."
                    echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
                 fi
              else
                 # No, directory is not writeable so use sudo to download.
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
         # Directory does not exist so cannot download file into the directory.
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
} # End of function f_file_dload
#
# +----------------------------------------+
# |           Function f_change_dir        |
# +----------------------------------------+
#
#  Inputs: $1=Directory, $2=File.
#    Uses: XSTR.
# Outputs: NEW_DIR.
#
f_change_dir () {
      clear  # Blank the screen.
      NEW_DIR="" ; XSTR=$1
      while [ "$NEW_DIR" != "QUIT" ] && [ ! -d "$NEW_DIR" ]
      do
            # Creates or switches to new directory
            # and reconfigures cli-app-menu.sh to use it.
            # Outputs $NEW_DIR.
            f_ask_new_directory $1
            #
            if [ -d "$NEW_DIR" ] && [ $NEW_DIR != "QUIT" ] ; then
               XSTR=$NEW_DIR
            fi
            # If $NEW_DIR=<New directory> then $XSTR=$NEW_DIR.
            # If $NEW_DIR="QUIT" then $XSTR=$1 <old (possibly invalid) directory>.
      done
      # Set $NEW_DIR in order to update "Validate Files and Directories Menu" message display.
      # NEW_DIR=<new directory only if it exists> or <old (possibly invalid) directory>.
      NEW_DIR=$XSTR 
      unset XSTR
} # End of function f_change_dir
#
# +----------------------------------------+
# |      Function f_ask_new_directory      |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, SCRIPT_PATH, THIS_FILE.
#    Uses: X.
# Outputs: NEW_DIR.
#
f_ask_new_directory () {
      clear  # Blank the screen.
      echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
      echo "The main script file: \"cli-app-menu.sh\" is in directory:"
      echo "      $MAINMENU_DIR"
      echo "_________________________________________________________________"
      # Although $1=Old directory, use grep to be certain that THIS_DIR=$1.
      # grep results in 'THIS_DIR="<old directory>"'
      # Strip off the leading 'THIS_DIR=' and then strip off quotation marks.
      # Substitution using bash curly bracket syntax.
      # Syntax: {<Target string>/<old pattern>/<new pattern>}
      #
      X="`grep -m 1 $1 $SCRIPT_PATH/$THIS_FILE`"  # Stop grep after 1st matching string and delete leading
                                                  # Use back-ticks to run grep and get results.
      X=${X/      THIS_DIR=/} ; X=${X/\"/}  # Remove strings '      THIS_DIR=' 
                                            # and double-quotation marks from result.
      #
      # SCRIPT_PATH is the directory where THIS_FILE actually is currently residing.
      echo
      f_term_color $ECOLOR $BCOLOR
      echo $(tput bold)
      if [ "$X" != "$MAINMENU_DIR/cli-app-menu" ] ; then
         echo "The directory for the required support files needs to be changed."
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         echo "Change from:"
         echo "     $X"
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
         echo "     $X"
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
           f_valid_exit $NEW_DIR $NEW_DIR
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
                f_valid_exit $NEW_DIR $NEW_DIR
                ;;
                */)
                # Strip off the last "/" in the directory name. i.e. Change from "/opt/" to "/opt".
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
                 f_ask_create_directory $1 $NEW_DIR
                 # Directory creation failed for some reason.
                 if [ ! -d "$NEW_DIR" ] ; then
                    NEW_DIR="QUIT"
                 fi
              fi
           else
              f_term_color $ECOLOR $BCOLOR
              echo $(tput bold)
              echo "Directory cannot be created, it may already exist."
              echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
              f_setup_dir $1 $NEW_DIR
           fi
           ;;
           *)
           NEW_DIR="$MAINMENU_DIR/cli-app-menu"
           f_create_directory $1 $NEW_DIR
           ;;
      esac
      unset X
} # End of function f_ask_new_directory
#
#
# +----------------------------------------+
# |     Function f_ask_create_directory    |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory $2=New Directory.
#    Uses: X.
# Outputs: None.
#
f_ask_create_directory () {
      # clear  # Blank the screen.
      echo
      echo "Create new directory:"
      echo "   $2"
      echo -n "Create it now (Y/n)? "
      read X
      echo
      case $X in
           [Nn]*)
           # No, do not create new directory, stop.
           ;;
           * | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
           # Yes, create it.
           f_create_directory $1 $2
           ;;
      esac
      unset X
} # End of function f_ask_create_directory
#
# +----------------------------------------+
# |      Function f_create_directory       |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, $2=New Directory.
#    Uses: None.
# Outputs: None.
#
f_create_directory () {
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
            f_setup_dir $1 $2
         else
            echo
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error creating new directory, even when using sudo permissions."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi
      fi
} # End of function f_create_directory
#
# +----------------------------------------+
# |         Function f_setup_dir           |
# +----------------------------------------+
#
#  Inputs: $1=Old Directory, $2=New Directory, SCRIPT_PATH.
#    Uses: X.
# Outputs: None.
#
f_setup_dir () {

      echo "Automatically re-configuring \"cli-app-menu.sh\" to use the directory."
      echo
      if [ -w $SCRIPT_PATH ] ; then
         # Yes, directory is writeable.
         # sed has \" back-slashes before the quotation marks to include the
         # literal quotation marks in the search/replace strings.
         #         Find string: THIS_DIR="$1
         # Replace with string: THIS_DIR="$2
         sed -i "s|THIS_DIR=\"$1|THIS_DIR=\"$2|" $SCRIPT_PATH/cli-app-menu.sh
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error re-configuring, \"cli-app-menu.sh\" to use the directory."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi 
      else
         # No, directory is not writeable so use sudo permissions.
         sudo sed -i "s|THIS_DIR=\"$1|THIS_DIR=\"$2|" $SCRIPT_PATH/cli-app-menu.sh
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            f_term_color $ECOLOR $BCOLOR
            echo $(tput bold)
            echo -n "Error re-configuring,\"cli-app-menu.sh\" to use the directory even when using sudo permissions."
            echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         fi
      fi
      echo -n "Press \"Enter\" key to continue."
      read X
      unset X
} # End of function f_setup_dir
#
# +----------------------------------------+
# |          Function f_main_help          |
# +----------------------------------------+
#
#  Inputs: MAINMENU_DIR, THIS_FILE. 
#    Uses: None.
# Outputs: None.
#
f_main_help () {
      clear # Blank the screen.
      # Display Help (all lines beginning with "#@" but do not print "#@").
      # sed substitutes null for "#@" at the beginning of each line so it is not printed.
      # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
      sed -n 's/^#@//'p $MAINMENU_DIR/$THIS_FILE | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
} # End of function f_main_help
#
# +----------------------------------------+
# |           Function f_main_about        |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X, REVDATE, PROJECT_REVDATE, PROJECT_REVISION.
# Outputs: None.
#
f_main_about () {
      # Calculate project revision number by counting all lines starting with "## 2013".
      # grep ^ (carot sign) means grep any lines beginning with "##2013".
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
               echo -n "Download EDIT_HISTORY from GitHub.com? (Y/n) "
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
               esac         # End of git download case statement.
         done
      fi
      #
      if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         PROJECT_REVISION="Unknown, edit history is unavailable."
	 PROJECT_REVDATE="Unknown, edit history is unavailable."
      else
         PROJECT_REVISION=$(grep ^"## 2013" -c $THIS_DIR"/EDIT_HISTORY") ; PROJECT_REVISION="2013.$PROJECT_REVISION"
         PROJECT_REVDATE=$(grep ^PROJECT_REVDATE= $THIS_DIR"/EDIT_HISTORY" | awk -F "=" '{ print $2 }' | awk -F '"' '{print $2}')
      fi
      #
      # grep finds line beginning with "PROJECT_REVDATE=" in file EDIT_HISTORY
      # The first awk results in the date in quotes as a string.
      # The second awk strips the quotation marks from the date string.
      #
      clear # Blank the screen.
      echo "Project version: $PROJECT_REVISION"
      echo " Last edited on: $PROJECT_REVDATE"
      echo
      echo "   Project file: cli-app-menu.sh"
      echo " Last edited on: $REVDATE"
      echo
      echo "Main Menu script cli-app-menu.sh is located in:"
      echo "$MAINMENU_DIR"
      echo
      echo "Module library files and documentation is located in:"
      echo "$THIS_DIR"
      f_press_enter_key_to_continue
      PRESS_KEY=0
      #
      unset X
} # End of function f_main_about
#
# +----------------------------------------+
# |        Function f_main_configure       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: AAC, MENU_ITEM.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_main_configure () {
      f_initvars_menu_app "AAC"
      # When $DELIMITER is set as above, then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
      # i.e. "Colors", "Un-colors" or "Update", etc.
      # since those are not the names of executable (run-able) applications.
      #
      until [ "$AAC" = "0" ]
      do    # Start of Configuration Menu until loop.
#f_menu_term_color^0^0^0^0     #AAC Colors        - Set default font/background colors.
#f_menu_uncolor^0^0^0^0        #AAC Un-colors     - Set font color for unavailable library modules.
#f_update_software^0^0^0^0     #AAC Update        - Update this Main Menu program from the GitHub repository.
#f_menu_module_manager^0^0^0^0 #AAC Modules       - Add/Delete/Remove/Restore/Update software modules.
#f_ls_this_dir^0^0^0^0         #AAC List files    - List all support and library program files.
#f_update_edit_hist^0^0^0^0    #AAC Edit History  - Make changes to the Edit History.
#f_update_list_apps^0^0^0^1    #AAC List apps     - Update list of applications in activated software modules.
            #
            THIS_FILE="cli-app-menu.sh"
            MENU_TITLE="Configuration Menu"
            DELIMITER="#AAC" #AAC This 3rd field prevents awk from printing this line into menu options. 
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAC
            f_menu_item_process $AAC  # Outputs $MENU_ITEM.
      done  # End of Configuration Menu until loop.
            #
      unset AAC MENU_ITEM  # Throw out this variable.
} # End of function f_main_configure
#
# +----------------------------------------+
# |      Function f_main_documentation     |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X.
# Outputs: None.
#
f_main_documentation () {
      X="" # Initialize scratch variable.
      clear # Blank the screen.
      if [ ! -r $THIS_DIR"/README" ] ; then
         while [  "$X" != "YES" -a "$X" != "NO" ]
         do
               clear # Blank the screen.
               #
               # Use different color font for error messages.
               f_term_color $ECOLOR $BCOLOR
               echo $(tput bold)
               #
               echo ">>>The file README is either missing or cannot be read.<<<"
               echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
               echo
               echo -n "Download README from GitHub.com? (Y/n) "
               read X
               case $X in # Start of git download case statement.
                    "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                    MOD_FILE="README"
                    f_download_file
                    X="YES"
                    ;;
                    [Nn] | [Nn][Oo])
                    X="NO"
                    ;;
               esac         # End of git download case statement.
         done
      fi
      #
      if [ -r $THIS_DIR"/README" ] ; then
         # Display README Documentation (all lines beginning with "#:" but do not print "#:").
         # sed substitutes null for "#:" at the beginning of each line so it is not printed.
         # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^#://'p $THIS_DIR"/README" | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
      fi
      #
      unset X
} # End of function f_main_documentation
#
# +----------------------------------------+
# |      Function f_main_edit_history      |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X.
# Outputs: None.
#
f_main_edit_history () {
      X="" # Initialize scratch variable.
      clear # Blank the screen.
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
               echo -n "Download EDIT_HISTORY from GitHub.com? (Y/n) "
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
               esac         # End of git download case statement.
         done
      fi
      #
      if [ -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         # Display Edit History (all lines beginning with "##" but do not print "##").
         # sed substitutes null for "##" at the beginning of each line so it is not printed.
         # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
         sed -n 's/^##//'p $THIS_DIR"/EDIT_HISTORY" | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
         PRESS_KEY=0
      fi
      #
      unset X
} # End of function f_menu_edit_history
#
# +----------------------------------------+
# |         Function f_main_license        |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: X.
# Outputs: None.
#
f_main_license () {
      clear # Blank the screen.
      # Display License (all lines beginning with "#LIC" but do not print "#LIC").
      # sed substitutes null for "#LIC" at the beginning of each line so it is not printed.
      # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
      sed -n 's/^#LIC//'p $MAINMENU_DIR/$THIS_FILE | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
      X="" # Initialize scratch variable.
      while [  "$X" != "YES" -a "$X" != "NO" ]
      do
            clear # Blank the screen.
            echo -n "Read the full license text contained in file 'COPYING'? (Y/n) "
            read X
            case $X in # Start of license case statment.
                 ""| [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                 X="YES"
                 echo
                 if [ ! -r $THIS_DIR"/COPYING" ] ; then
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
                          echo -n "Download COPYING from GitHub.com? (Y/n) "
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
                                     echo -n "Read the full license text at http://www.gnu.org/licenses/ ? (Y/n) "
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
                                     esac         # End of gnu.org case statement.
                               done
                               X="NO"
                                               ;;
                          esac         # End of git download case statement.
                    done
                 fi
                 #
                 if [ -r $THIS_DIR"/COPYING" ] ; then
                    less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/COPYING"
                 fi
                 X="YES"
                 ;;
                 [Nn] | [Nn][Oo])
                 X="NO"
                 ;;
            esac         # End of license case statment.
      done
      #
      unset X
} # End of function f_main_license
#
# +----------------------------------------+
# |        Function f_main_list_apps       |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
# Outputs: None.
#
f_main_list_apps () {
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
         f_press_enter_key_to_continue
      fi
      # display LIST_APPS
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/LIST_APPS"
         fi
} # End of function f_main_list_apps
#
# +----------------------------------------+
# |       Function f_main_search_apps      |
# +----------------------------------------+
#
#  Inputs: THIS_DIR. 
#    Uses: None.
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
         f_press_enter_key_to_continue
      fi
      #
      if [ -r $THIS_DIR"/LIST_APPS" ] ; then
         XSTR="-1"
         while [ -n "$XSTR" ]
         do
               clear # Blank the screen.
               echo "Search for a software package featured in this menu script."
               echo
               echo "To quit, press 'Enter' key."
               echo
               echo -n "Enter name of software package or search string: "
               read XSTR
               if [ -n "$XSTR" ] ;then
                  echo
                  echo "Please note:"
                  echo "Even if '$XSTR' is found, it may not be available for your Linux distribution."
                  echo
                  echo "Not all Linux distributions will have all packages featured in this menu."
                  echo "i.e. A software package available in Red Hat may not be available in Debian,"
                  echo "     and vice versa."
                  echo
                  echo
                  echo "To start search:"
                  f_press_enter_key_to_continue
                  #
                  # Search LIST_APPS
                  grep --ignore-case -C 9 --color=always $XSTR $THIS_DIR"/LIST_APPS" | less -r -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
               fi
         done
         unset XSTR  # Throw out this variable.
      fi
} # End of function f_main_search_apps
#
# +----------------------------------------+
# |          Function f_term_color         |
# +----------------------------------------+
#
#  Inputs: $1=$FCOLOR. $2=$BCOLOR
#    Uses: CNT, TPUTX.
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
      # set background first because you must reset colors first to get true black background in some
      # virtual X-terminals. Since "tput setab 0" appears light gray, use "tput sgr0" to reset colors.
      # set CNT=1 background color then set CNT=2 font color.
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
                  echo -n $(tput sgr0)  # Black background selected. Reset colors to get true black.
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
} # End of function f_term_color
#
# +----------------------------------------+
# |        Function f_menu_term_color      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAE, MENU_ITEM, MAX, COLOR.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_menu_term_color () {
      f_initvars_menu_app "AAE"
      # When $DELIMITER is set as above, then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
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
            #f_color_wb      #AAE WB      - White   on blue (Classic "Blueprint").
            #f_color_yb      #AAE YB      - Yellow  on blue.
            #
            THIS_FILE="cli-app-menu.sh"
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
      unset AAE MENU_ITEM  # Throw out this variable.
} # End of function f_menu_term_color
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
# |          Function f_menu_uncolor       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAF, MENU_ITEM, MAX, COLOR.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_menu_uncolor () {
      f_initvars_menu_app "AAF"
      # When $DELIMITER is set as above, then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
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
            THIS_FILE="cli-app-menu.sh"
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
      unset AAF MENU_ITEM  # Throw out this variable.
} # End of function f_menu_uncolor
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
#  Inputs: FCOLOR, BCOLOR, UCOLOR, ECOLOR.
#    Uses: None.
# Outputs: File ~/.cli-app-menu.cfg over-written.
#
f_update_config_file () {
      # Update Configuration File: ~/.cli-app-menu.conf to save user chosen colors.
      echo "f_main_config () {" > ~/.cli-app-menu.cfg
      echo "      FCOLOR=\"$FCOLOR\" ; BCOLOR=\"$BCOLOR\" ; UCOLOR=\"$UCOLOR\" ; ECOLOR=\"$ECOLOR\"" >> ~/.cli-app-menu.cfg
      echo "} # End of function f_main_config" >> ~/.cli-app-menu.cfg
} # End of function f_update_config_file
#
# +----------------------------------------+
# |       Function f_update_software       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: MENU_MOD_FILE, X.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY.
#
f_update_software () {
      # Are either of the directories read-only?
      if [ ! -w $MAINMENU_DIR -o ! -w $THIS_DIR ] ; then 
         # Yes, then need sudo permissions.
         # Ask for sudo permissions password using an innocuous command.
         echo
         echo "You need sudo permissions to update this software."
         sudo cd  # &>/dev/null # 1=standard messages, 2=error messages, &=both.
      fi
      echo
      echo "Choose the branch from where you want to update the software."
      for MOD_FILE in cli-app-menu.sh lib_cli-common.lib lib_cli-menu-cat.lib lib_cli-web-sites.lib mod_apps-sample-template.lib README COPYING EDIT_HISTORY LIST_APPS
      do
         echo "_____________________________________________________________________"
         echo
         echo "Update \"$MOD_FILE\" from the GitHub software repository?"
         # Ask download from which branch and wget.
         f_wget_file
      done
      PRESS_KEY=0  # Do not use "Press Enter key" but use "Q" or "Quit" so message above is read.
                   # f_wget also sets it to 1 but if module is not downloaded then still set to 0.
      X=-1  # intialize until-loop.
      until [ "$X" = "0" ]
      do    # Start of Update Menu until loop.
            clear # Blank the screen.
            echo
            echo "Files cli-app-menu.sh and cli-app-menu.tar.gz (backup) are in folder:"
            echo "\"$MAINMENU_DIR\"."
            echo
            echo "All other software program files are in folder:"
            echo "\"$THIS_DIR\"."
            echo
            echo -n "'0', (R)eturn, to go back to the previous menu. "
            read X
            case $X in
                 [Rr] | [Rr][Ee] | [Rr][Ee][Tt]*)
                 X=0
                 ;;
	 esac
      done
      unset X
} # End of function f_update
#
# +----------------------------------------+
# |       Function f_update_edit_hist      |  
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_update_edit_hist () {
      clear # Blank the screen.
      if [ -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         APP_NAME="jed $THIS_DIR/EDIT_HISTORY"
         PRESS_KEY=0
         f_application_run
      else
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
               echo -n "Download EDIT_HISTORY from GitHub.com? (Y/n) "
               read X
               case $X in # Start of git download case statement.
                    "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                    ANS=""
                    MOD_FILE="EDIT_HISTORY"
                    f_download_file
                    X="YES"
                    ;;
                    [Nn] | [Nn][Oo])
                    X="NO"
                    ;;
               esac         # End of git download case statement.
         done
      fi
      #
      if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
         echo -n $(tput sgr0) ; f_term_color $FCOLOR $BCOLOR ; echo -n $(tput bold)
         echo
         f_press_enter_key_to_continue
      fi
} # End of function f_update_edit_hist
#
# +----------------------------------------+
# |       Function f_update_list_apps      |  
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_update_list_apps () {
      X="" # Initialize scratch variable.
      while [  "$X" != "YES" -a "$X" != "NO" ]
      do
             clear # Blank the screen.
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
             echo -n "Are you ready to update the file, \"LIST_APPS\"? (y/N) "
             read X
             case $X in
                  [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                  . lib_cli-common.lib ;  f_create_LIST_APPS
                  echo ; echo "File \"LIST_APPS\" is updated."
                  X="YES"
                  ;;
                  "" | [Nn] | [Nn][Oo])
                  echo ; echo "File \"LIST_APPS\" is not updated."
                  X="NO"
                  ;;
             esac
      done
} # End of function f_update_list_apps
#
# +----------------------------------------+
# |         Function f_ls_this_dir         |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: THIS_DIR.
# Outputs: None.
#
f_ls_this_dir () {
      clear # Blank the screen.
      ls -gGh --group-directories-first --color=always $THIS_DIR | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
} # End of function f_ls_this_dir
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
# Since the DASH environment does not recognize the ". <library> command,
# the function f_test_dash must be included in this cli-app-menu.sh script file
# rather than in the library file lib_cli-common.lib, but once in BASH, then
# common library file may be invoked.
#
# Set SCRIPT_PATH to directory path of script.
f_script_path
#
# Test the environment for DASH and if in BASH invoke the common library.
f_test_dash
#
f_main_init_once
#
# **************************************
# ***           Main Menu            ***
# **************************************
#
#  Inputs: THIS_FILE, REVISION, REVDATE.
#    Uses: AAA, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_initvars_menu_app "AAA"
      # When $DELIMITER is set as above, then f_menu_item_process does not call f_application_run and
      # try to run the menu item's name.
      # i.e. "Applications", "Help and Features" or "About CLI Menu", "Configure", etc.
      # since those are not the names of executable (run-able) applications.
      #
until [ "$AAA" = "0" ]
do    # Start of CLI Menu util loop.
#f_menu_cat_applications #AAA Applications        - Launch a command-line application.
#f_main_help #AAA Help and Features   - How to use and what can it do.
#f_main_about #AAA About CLI Menu      - What version am I using.
#f_main_configure #AAA Configure           - Update software, change colors, edit History, etc.
#f_main_documentation #AAA Documentation       - Script documentation, programmer notes, HOW-TOs.
#f_main_edit_history #AAA Edit History        - All the craziness behind the scenes.
#f_main_license #AAA License             - Licensing, GPL.
#f_main_list_apps #AAA List Applications   - List apps in active sub-menus (downloaded modules).
#f_main_search_apps #AAA Search Applications - Search within active sub-menus (downloaded modules).
      #
      THIS_FILE="cli-app-menu.sh"
      MENU_TITLE="Main Menu"
      DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu items.
      #
      f_show_menu "$MENU_TITLE" "$DELIMITER"
      read AAA
      f_menu_item_process $AAA  # Outputs $MENU_ITEM. Sets AAA=0 for item option Quit.
done  # End of Main Menu until loop.
      #
unset AAA MENU_ITEM SCRIPT_PATH # Throw out this variable.
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
# all dun dun noodles.
