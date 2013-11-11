#!/bin/bash
# ©2013 Copyright 2013 Robert D. Chin
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
# Script cli-app-menu.sh is a menu of CLI applications and commands
# to help CLI newbies to discover what a command line can do.
#
# Please see the file README for more information.
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
# |    Revision number and Revision Date   |
# +----------------------------------------+
#
THIS_FILE="cli-app-menu.sh"
REVDATE="November-11-2013 12:01"
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
         echo "    >>> Exiting script<<<"
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
      # This function sets the $THIS_DIR variable so that lib_cli-common.lib and
      # the module libraries may reside in any directory and still be invoked from
      # the Main Menu script, cli-app-menu.sh. Please refer to README for more
      # instructions on how to set the $PATH environmental variable to do this.
      #
      # This function is called before displaying any menu.
      #
      # MAINMENU_DIR contains the script file cli-app-menu.sh.
      # This may be the same directory as $THIS_DIR or may be
      # any other directory you choose.
      #
      # If you are using a single-user PC/laptop, you may simply put the 
      # script in your personal home directory.
      #
      # If multiple users login to the PC/laptop, you may want to put
      # the script in a /usr or an /opt folder with permissions set so 
      # other users may run the script, (rwx-rx-rx) or (755) permissions.
      #
      # i.e. /home/<username_goes_here>
      #      Just put script cli-app-menu.sh in home folder. 
      #      Other users will have to do the same with their separate copy.
      #
      # i.e. /usr/local/bin/cli-app-menu 
      #      Or create this folder for a single copy of the script accessible 
      #      to all users. /usr folder holds applications for users to run.
      #
      # i.e. /opt/cli-app-menu
      #      Or create this folder for a single copy of the  script accessible 
      #      to all users. /opt folder is another location for user apps.
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
      f_valid_dir "$MAINMENU_DIR"
      f_valid_files "$MAINMENU_DIR" "cli-app-menu.sh"
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
      # it may help to name it "cli-app-menu" to use it for only project files.
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
      # Validate file names and directories.
      f_valid_dir "$THIS_DIR"
      f_valid_files "$THIS_DIR" "lib_cli-common.lib"
      f_valid_files "$THIS_DIR" "lib_cli-menu-cat.lib"
      #
      # Invoke the common library to display menus.
      . $THIS_DIR/lib_cli-common.lib    # invoke module/library.
      . $THIS_DIR/lib_cli-menu-cat.lib  # invoke module/library.
      #
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
# |           Function f_valid_dir         |
# +----------------------------------------+
#
#  Inputs: $1. Where $1=Directory
#    Uses: None.
# Outputs: None.
#
f_valid_dir () {
      if [ ! -d "$1" ] ; then
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         echo "The directory: \"$1\""
         echo "is not a valid existing directory."
         echo $(tput sgr0)
         echo "Edit file cli-app-menu.sh and scroll down to function \"f_main_init_once\"."
         echo
         echo "Set the variable to a valid, existing, writable directory."
         echo $(tput bold)
         echo "Change from:"
         grep -m 1 $1 $THIS_FILE # Stop grep after 1st matching string.
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo "______________________________"
         echo "    >>> Exiting script<<<"
         echo "______________________________"
         echo $(tput sgr0)
         echo
	 exit 1
      else
      # Check the $PATH
         if [[ ! "$PATH" == *":$1"* ]] ; then
            echo
            echo $(tput bold)'Append the directory name to your environment $PATH.'
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
            echo
	    exit 1
         fi
      fi
} # End of function f_valid_dir
#
# +----------------------------------------+
# |          Function f_valid_files        |
# +----------------------------------------+
#
#  Inputs: $1, $2. Where $1=Directory $2=File.
#    Uses: None.
# Outputs: None.
#
f_valid_files () {
      # Check for required files. Skip if directory does not exist.
      # If directory exists and file is not readable.
      if [ ! -r "$1/$2" -a -d "$1" ] ; then
         #
         # Use different color font for error messages.
         f_term_color $ECOLOR $BCOLOR
         echo $(tput bold)
         #
         echo "Required file '$2' is missing from $1."
         echo
         echo
         echo "______________________________"
         echo "    >>> Exiting script<<<"
         echo "______________________________"
         echo $(tput sgr0)
         echo
         exit 1
      fi
} # End of function f_valid_files
#
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
      #
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
               echo -n "Download EDIT_HISTORY from www.git.com? (Y/n) "
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
      until [ "$AAC" = "0" ]
      do    # Start of Configuration Menu until loop.
#f_menu_term_color #AAC Colors       - Set default font/background colors.
#f_menu_uncolor    #AAC Un-colors    - Set font color for unavailable library modules.
#f_update          #AAC Update       - Update software program, Edit History, LIST_APP.
#f_ls_this_dir     #AAC Module files - List module library files in library directory.
            #
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
               echo -n "Download README from www.git.com? (Y/n) "
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
               echo -n "Download EDIT_HISTORY from www.git.com? (Y/n) "
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
                          echo -n "Download COPYING from www.git.com? (Y/n) "
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
         echo "The file LIST_APPS may be automatically created/updated by:"
         echo
         echo "Select Main Menu item:"
         echo "Configure - Change default settings; terminal, browser etc."
         echo
         echo "Select Configuration Menu item:"
         echo "LIST_APPS - Re-create/Update file list of all applications."
         echo
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
         echo "The file LIST_APPS may be automatically created/updated by:"
         echo
         echo "Select Main Menu item:"
         echo "Configure - Change default settings; terminal, browser etc."
         echo
         echo "Select Configuration Menu item:"
         echo "LIST_APPS - Re-create/Update file list of all applications."
         echo
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
      #
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
      MENU_TITLE="Terminal Colors Menu"
      DELIMITER="#AAE" #AAE This 3rd field prevents awk from printing this line into menu options. 
      f_initvars_menu_app "AAE"
      until [ "$AAE" = "0" ]
      do    # Start of Terminal Colors until loop.
            #AAE Red     - Red     on black.
	    #AAE Green   - Green   on black.
	    #AAE Yellow  - Yellow  on black.
            #AAE Blue    - Blue    on black.
            #AAE Magenta - Magenta on black.
            #AAE Cyan    - Cyan    on black.
            #AAE White   - White   on black.
            #AAE ------- - -----------------
            #AAE BW      - Black   on white.
            #AAE RW      - Red     on white.
            #AAE WB      - White   on blue (Classic "Blueprint").
            #AAE YB      - Yellow  on blue.
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAE
            #
            f_cat_menu_item_process $AAE ; AAE=$MENU_ITEM # Outputs $MENU_ITEM.
            ERROR=0 # Reset error flag.
            #
            case $MENU_ITEM in  # Start of Terminal Colors Menu case statement.
                 [Bb] | [Bb][Ww])
                 FCOLOR="Black" ; BCOLOR="White" ; ECOLOR="Red"
                 ;;
                 [Bb] | [Bb][Ll] | [Bb][Ll][Uu] | [Bb][Ll][Uu][Ee])
                 FCOLOR="Blue" ; BCOLOR="Black" ;  ECOLOR="Red"
                 ;;
                 [Cc] | [Cc][Yy]*)
                 FCOLOR="Cyan" ; BCOLOR="Black" ; ECOLOR="Red"
                 ;;
                 [Gg] | [Gg][Rr]*)
                 FCOLOR="Green" ; BCOLOR="Black" ; ECOLOR="Red"
                 ;;
                 [Mm] | [Mm][Aa]*)
                 FCOLOR="Magenta" ; BCOLOR="Black" ; ECOLOR="Red"
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Dd])
                 FCOLOR="Red" ; BCOLOR="Black"  ; ECOLOR="Yellow"
                 ;;
                 [Rr] | [Rr][Ww])
                 FCOLOR="Red" ; BCOLOR="White" ; ECOLOR="Blue"
                 ;;
                 [Ww] | [Ww][Hh] | [Ww][Hh][Ii]*)
                 FCOLOR="White" ; BCOLOR="Black" ; ECOLOR="Red"
                 ;;
                 [Ww] | [Ww][Bb])
                 FCOLOR="White" ; BCOLOR="Blue" ; ECOLOR="Red"
                 ;;
                 [Yy] | [Yy][Ee]*)
                 FCOLOR="Yellow" ; BCOLOR="Black" ; ECOLOR="Red"
                 ;;
                 [Yy] | [Yy][Bb])
                 FCOLOR="Yellow" ; BCOLOR="Blue" ; ECOLOR="Red"
                 ;;
            esac                # End of Terminal Colors Menu case statement.
            #
            AAE=$MENU_ITEM
      done  # End of Terminal Colors Menu until loop.
      #
      # Update Configuration File: ~/.cli-app-menu.conf to save user chosen colors.
      echo "f_main_config () {" > ~/.cli-app-menu.cfg
      echo "      FCOLOR=\"$FCOLOR\" ; BCOLOR=\"$BCOLOR\" ; UCOLOR=\"$UCOLOR\" ; ECOLOR=\"$ECOLOR\"" >> ~/.cli-app-menu.cfg
      echo "} # End of function f_main_config" >> ~/.cli-app-menu.cfg
      #
      unset AAE MENU_ITEM  # Throw out this variable.
      #
} # End of function f_menu_term_color
#
# +----------------------------------------+
# |          Function f_menu_uncolor       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAE, MENU_ITEM, MAX, COLOR.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_menu_uncolor () {
      MENU_TITLE="Colors for Unavailable Menu Items"
      DELIMITER="#AAF" #AAF This 3rd field prevents awk from printing this line into menu options. 
      f_initvars_menu_app "AAF"
      until [ "$AAF" = "0" ]
      do    # Start of Unavailable Colors until loop.
            #AAF Red        - Red.
	    #AAF Green      - Green.
	    #AAF Yellow     - Yellow.
            #AAF Blue       - Blue.
            #AAF Magenta    - Magenta.
            #AAF Cyan       - Cyan.
            #AAF White      - White.
            #AAF Gray       - Gray (not available in 8-color terminals).
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAF
            #
            f_cat_menu_item_process $AAF ; AAF=$MENU_ITEM # Outputs $MENU_ITEM.
            ERROR=0 # Reset error flag.
            #
            case $MENU_ITEM in # Start of Unavailable Colors case statement.
                 [Bb] | [Bb][Ww])
                 UCOLOR="Black"
                 ;;
                 [Bb] | [Bb][Ll] | [Bb][Ll][Uu] | [Bb][Ll][Uu][Ee])
                 UCOLOR="Blue"
                 ;;
                 [Cc] | [Cc][Yy]*)
                 UCOLOR="Cyan"
                 ;;
                 [Gg] | [Gg][Rr] | [Gg][Rr][Ee]*)
                 UCOLOR="Green"
                 ;;
                 [Mm] | [Mm][Aa]*)
                 UCOLOR="Magenta"
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Dd])
                 UCOLOR="Red"
                 ;;
                 [Rr] | [Rr][Ww])
                 UCOLOR="Red"
                 ;;
                 [Ww] | [Ww][Hh] | [Ww][Hh][Ii]*)
                 UCOLOR="White"
                 ;;
                 [Gg] | [Gg][Rr] | [Gg][Rr][Aa]*)
                 UCOLOR="Gray"
                 ;;
                 [Yy] | [Yy][Ee]*)
                 UCOLOR="Yellow"
                 ;;
            esac                # End of Unavailable Colors case statement.
            #
            AAF=$MENU_ITEM
            f_term_color $FCOLOR $BCOLOR # Set terminal color.
            echo $(tput bold) # set bold font.
            #
      done  # End of Unavailable Colors until loop.
      #
      # Update Configuration File: ~/.cli-app-menu.conf to save user chosen colors.
      echo "f_main_config () {" > ~/.cli-app-menu.cfg
      echo "      FCOLOR=\"$FCOLOR\" ; BCOLOR=\"$BCOLOR\" ; UCOLOR=\"$UCOLOR\" ; ECOLOR=\"$ECOLOR\"" >> ~/.cli-app-menu.cfg
      echo "} # End of function f_main_config" >> ~/.cli-app-menu.cfg
      #
      unset AAF MENU_ITEM  # Throw out this variable.
} # End of function f_menu_uncolor
#
# +----------------------------------------+
# |            Function f_update           |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAD, MENU_ITEM, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY.
#
f_update () {
      f_initvars_menu_app "AAD"
      until [ "$AAD" = "0" ]
      do    # Start of Update Menu until loop.
#f_updat_edit_hist #AAD Edit History - Make changes to the Edit History.
#f_update_software #AAD Update       - Update software program from the GitHub repository.
#f_updat_list_apps #AAD LIST_APPS    - Re-create/Update file list of all applications.
            #
            MENU_TITLE="Update Menu"
            DELIMITER="#AAD" #AAD This 3rd field prevents awk from printing this line into menu options. 
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAD
            f_menu_item_process $AAD  # Outputs $MENU_ITEM.
      done  # End of Update Menu until loop.
            #
      unset AAD MENU_ITEM  # Throw out this variable.
} # End of function f_update
#
# +----------------------------------------+
# |       Function f_update_software       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: MENU_MOD_FILE.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY.
#
f_update_software () {
      echo
      echo "Choose the branch from where you want to download the script program."
      echo
      for MOD_FILE in cli-app-menu.sh lib_cli-common.lib lib_cli-menu-cat.lib mod_apps-sample-template.lib README COPYING EDIT_HISTORY LIST_APPS
      do
         echo
         echo "File to be downloaded is $MOD_FILE."
         echo
         echo "Update \"$MOD_FILE\" from the GitHub software repository?"
         # Ask download from which branch and wget.
         f_wget_file
      done
      f_update_modules
      echo "________________________________________________________________"
      echo
      echo "File cli-app-menu.sh is in folder:"
      echo "\"$MAINMENU_DIR\"."
      echo
      echo "All other software program files are in folder:"
      echo "\"$THIS_DIR\"."
      echo
      echo "The file names will be appended with a '.1'"
      echo "and you will have to MANUALLY COPY THEM to their original names."
      f_press_enter_key_to_continue
} # End of function f_update
#
# +----------------------------------------+
# |       Function f_update_modules        |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: X, XSTR, XXSTR, DELIMITER, THIS_DIR, THIS_FILE, MOD_FILE.
# Outputs: None.
#
f_update_modules () {
      XXSTR=$DELIMITER  # Save $DELIMITER. 
      YSTR=$THIS_FILE   # Save $THIS_FILE.
      f_initvars_menu_app "AAB"
      DELIMITER="#AAB"
      THIS_FILE="lib_cli-menu-cat.lib"
      #echo
      #echo "Choose the branch from where you want to download the script program."
      #echo
      if [ "$DELIMITER" = "#AAB" ] ; then  # if Application Category Menu?
         # for-loop awk command uses back-ticks to execute resulting in name of mod_apps-*.lib.
         for MOD_FILE in `awk -F $DELIMITER '{if ($2&&!$3){print $1}}' $THIS_DIR/$THIS_FILE | awk -F "#" '{print $2}'`
         do
             # Display menu items in bold font if module exists or standard font if module does not exist.
             if [ -r $THIS_DIR/$MOD_FILE ] ; then  # <module file name> <Followed by whitespace>
                # Module exists so update to latest version.
                echo
                echo "Update \"$MOD_FILE\" from the GitHub software repository?"
                # Ask download from which branch and wget.
                f_wget_file
                if [ "$BRANCH" != "QUIT" ] ; then
                   # $MOD_FILE exists in current directory so make it accessible.
                   . $THIS_DIR/$MOD_FILE # Invoke module library.
                fi
             fi
         done
      fi
      DELIMITER=$XXSTR
      THIS_FILE=$YSTR
      unset X XSTR XXSTR YSTR 
} # End of function f_update
#
# +----------------------------------------+
# |       Function f_updat_edit_hist       |  
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_updat_edit_hist () {
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
               echo -n "Download EDIT_HISTORY from www.git.com? (Y/n) "
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
} # End of function f_updat_edit_hist
#
# +----------------------------------------+
# |       Function f_updat_list_apps       |  
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM.
# Outputs: ERROR, MENU_TITLE, DELIMITER.
#
f_updat_list_apps () {
      X="" # Initialize scratch variable.
      while [  "$X" != "YES" -a "$X" != "NO" ]
      do
             clear # Blank the screen.
             echo
             echo "For a COMPLETE listing of ALL applications available in ALL modules,"
             echo "ALL modules MUST be downloaded into this directory."
             echo
             echo "Otherwise, list the applications available only in the modules"
             echo "currently downloaded into this directory."
             echo 
             echo -n "Are you ready to update LIST_APPS? (y/N) "
             read X
             case $X in
                  [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                  . lib_cli-common.lib ;  f_create_LIST_APPS
                  echo ; echo "LIST_APPS is updated."
                  X="YES"
                  ;;
                  "" | [Nn] | [Nn][Oo])
                  echo ; echo "LIST_APPS is not updated."
                  X="NO"
                  ;;
             esac
      done
      f_press_enter_key_to_continue
} # End of function f_updat_list_apps
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
# +----------------------------------------+
# |    Function f_cat_menu_item_process    |
# +----------------------------------------+
#
# Inputs: $1, CHOICE[$MENU_ITEM], MAX.
# Uses: None.
# Outputs: MENU_ITEM, PRESS_KEY.
#
f_cat_menu_item_process () {
      MENU_ITEM=$* # The complete user-entered string passed as a set of arguments.
                    # i.e. "man <appname>, "<appname> --help" "<web browser><OPTIONS><URL>"
      case $MENU_ITEM in
           # Quit?
           0)
           MENU_ITEM=0
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
           [1-9] | [1-9][0-9]) # MENU_ITEM changed from numeric to alpha string.
           if [ "$MENU_ITEM" -ge 1 -a "$MENU_ITEM" -le $MAX ] ; then
              MENU_ITEM=${CHOICE[$MENU_ITEM]} #MENU_ITEM now is an alpha string.
           fi
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu]*)
           MENU_ITEM=0
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
      esac
} # End of f_cat_menu_item_process
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
until [ "$AAA" = "0" ]
do    # Start of CLI Menu util loop.
#f_menu_cat_applications #AAA Applications        - Launch a command-line application.
#f_main_help #AAA Help and Features   - How to use and what can it do.
#f_main_about #AAA About CLI Menu      - What version am I using.
#f_main_configure #AAA Configure           - Update software, change colors, edit History, etc.
#f_main_documentation #AAA Documentation       - Script documentation, programmer notes, licensing.
#f_main_edit_history #AAA Edit History        - All the craziness behind the scenes.
#f_main_license #AAA License             - Licensing, GPL.
#f_main_list_apps #AAA List Applications   - List of all CLI applications in this menu.
#f_main_search_apps #AAA Search Applications - Is an application featured in this menu script?
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
unset AAA MENU_ITEM  # Throw out this variable.
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
# all dun dun noodles.
