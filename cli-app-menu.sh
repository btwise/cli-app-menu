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
REVDATE="October-7-2013 21:05"
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
      if [ "$BASH_VERSION" = '' ]; then
         echo $(tput bold)
         echo "You are using the DASH environment."
         echo "Ubuntu and Linux Mint default to DASH but also have BASH available."
         echo $(tput setaf 3)  # Yellow font for error message.
         echo "*** This script cannot be run in the DASH environment. ***"
         echo
         echo "You can invoke the BASH environment by typing:"
         echo "'bash cli-app-menu.sh' at the command line."
         echo
         exit 1 # Exit with value $?=1 indicating an error condition
                # and stop running script.
      fi
} # End of function f_test_dash
#
# +----------------------------------------+
# |      Function f_initvars_menu_app      |
# +----------------------------------------+
#
#  Inputs: $1=Until-Loop variable.
#    Uses: X, UNTILVAR.
# Outputs: APP_NAME, MENU_ITEM, CHOICE_MAIN, ERROR, PRESS_KEY, TCOLOR.
#
f_initvars_menu_app () {
      # This function is called before displaying any menu.
      #
      if [ $1 = "AAA" ] ; then  # Validate dirs/files only once,before Main Menu.
         #
         # MAINMENU_DIR contains the script file cli-app-menu.sh.
         # This may be the same directory as $THIS_DIR or may be
         # any other directory you choose.
         # MAINMENU_DIR does not need a trailing forward slash "/".
         MAINMENU_DIR="/home/<username_goes_here>"
         #
         f_valid_dir "$MAINMENU_DIR"
         f_valid_files "$MAINMENU_DIR" "cli-app-menu.sh"
         #
         # THIS_DIR contains files: lib_cli-*, mod_apps-*, EDIT_HISTORY,
         # README, and COPYING and (optionally) cli-app-menu.sh.
         # THIS_DIR does not need a trailing forward slash "/".
         THIS_DIR="/home/public/cli-app-menu"
         f_valid_dir "$THIS_DIR"
         f_valid_files "$THIS_DIR" "lib_cli-common.lib"
         f_valid_files "$THIS_DIR" "lib_cli-menu-cat.lib"
      fi
      #
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
      for INIT_VAR in CHOICE_MAIN MENU_ITEM $1
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
         echo
         echo $(tput bold)"The directory $1"
         echo "is not a valid existing directory."
         echo $(tput sgr0)
         echo "Edit function f_initvars_menu_app in file, cli-app-menu.sh"
         echo "and set the variable MAINMENU_DIR to a valid, existing, writable directory."
         # Display brief comments where $1 is set in this file.
         echo $(tput bold)
         grep -m 1 $1 $THIS_FILE # Stop grep after 1st matching string.
         echo $(tput setaf 3)    # Yellow font for error message.
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
            echo $(tput setaf 3)  # Yellow font for error message.
            echo "______________________________"
            echo "    >>> Exiting script<<<"
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
         echo
         echo $(tput bold) "Required file '$2' is missing from $1."
         echo $(tput setaf 3)  # Yellow font for error message.
         echo "______________________________"
         echo "    >>> Exiting script<<<"
         echo "______________________________"
         echo $(tput sgr0)
         echo
         exit 1
      fi
      unset X
} # End of function f_valid_files
#
# +----------------------------------------+
# |     Function f_menu_main_configure     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY.
#
f_menu_main_configure () {
      MENU_TITLE="Configuration Menu"
      DELIMITER="#AAC" #AAC This 3rd field prevents awk from printing this line into menu options. 
      f_initvars_menu_app "AAC"
      until [ $AAC -eq 0 ]
      do    # Start of Configuration Menu until loop.
            #AAC Colors       - Set display font/background colors.
            #AAC Edit History - Make changes to the Edit History.
            #AAC LIST_APPS    - Re-create/Update file list of all applications.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAC
            #
            f_cat_menu_item_process $AAC  # Outputs $MENU_ITEM.
            ERROR=0 # Reset error flag.
            #
            case $MENU_ITEM in # Start of Configuration Menu case statement.
                 [Cc] | [Cc][Oo]*)
                 f_menu_term_color
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ee] | [Ee][Dd]*)  # Main Menu item, "Edit History".
                 clear # Blank the screen.
                 if [ -r $THIS_DIR"/EDIT_HISTORY" ] ; then
                    APP_NAME="jed $THIS_DIR/EDIT_HISTORY"
                    f_application_run
                    PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 else
                    while [  "$X" != "YES" -a "$X" != "NO" ]
                    do
                          clear # Blank the screen.
                          echo $(tput bold)
                          echo $(tput setaf 3)  # Yellow font for error message.
                          echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
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
                               PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                               ;;
                          esac         # End of git download case statement.
                    done
                 fi
                 #
                 if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
                    echo $(tput bold)
                    echo $(tput setaf 3)  # Yellow font for error message.
                    echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
                    echo
                    PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 fi
                 ;;
                 [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)  # Main Menu item, "Update LIST_APPS".
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
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Configuration Menu case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_bad_menu_choice $MENU_ITEM  # Outputs $MENU_ITEM.
            #
            AAC=$MENU_ITEM
            #
            # If application displays information, allow user to read it.
            f_option_press_enter_key
            #
      done  # End of Configuration Menu until loop.
            #
      unset AAC MENU_ITEM  # Throw out this variable.
} # End of function f_menu_main_configure
#
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
      until [ $AAE -eq 0 ]
      do    # Start of Terminal Colors Applications until loop.
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
            #
            f_show_menu "$MENU_TITLE" "$DELIMITER" 
            read AAE
            #
            f_cat_menu_item_process $AAE ; AAE=$MENU_ITEM # Outputs $MENU_ITEM.
            ERROR=0 # Reset error flag.
            #
            case $MENU_ITEM in # Start of Configuration Menu case statement.
                 [Bb] | [Bb][Ww])
                 FCOLOR="Black" ; BCOLOR="White"
                 ;;
                 [Bb] | [Bb][Ll] | [Bb][Ll][Uu] | [Bb][Ll][Uu][Ee])
                 FCOLOR="Blue" ; BCOLOR="Black"
                 ;;
                 [Rr] | [Rr][Ww])
                 FCOLOR="Red" ; BCOLOR="White"
                 ;;
                 [Cc] | [Cc][Yy]*)
                 FCOLOR="Cyan" ; BCOLOR="Black"
                 ;;
                 [Gg] | [Gg][Rr]*)
                 FCOLOR="Green" ; BCOLOR="Black"
                 ;;
                 [Mm] | [Mm][Aa]*)
                 FCOLOR="Magenta" ; BCOLOR="Black"
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Dd])
                 FCOLOR="Red" ; BCOLOR="Black"
                 ;;
                 [Ww] | [Ww][Hh] | [Ww][Hh][Ii]*)
                 FCOLOR="White" ; BCOLOR="Black"
                 ;;
                 [Ww] | [Ww][Bb])
                 FCOLOR="White" ; BCOLOR="Blue"
                 ;;
                 [Yy] | [Yy][Ee]*)
                 FCOLOR="Yellow" ; BCOLOR="Black"
                 ;;
            esac                # End of Configuration Menu case statement.
            #
            echo -n $(tput bold) # set bold font.
            f_term_color $FCOLOR $BCOLOR # Set terminal color.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            #f_bad_menu_choice $MENU_ITEM  # Outputs $MENU_ITEM.
            #
            AAE=$MENU_ITEM
            #
            AAE=0
      done  # End of Configuration Menu until loop.
            #
      unset AAE MENU_ITEM  # Throw out this variable.
} # End of function f_menu_term_color
#
# +----------------------------------------+
# |      Function f_menu_main_download     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: AAC, MENU_ITEM, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY.
#
f_menu_main_download () {
           f_initvars_menu_app "AAD"
           until [ $AAD -eq 0 ]
           do    # Start of Download Software Menu until loop.
                 #AAD Script program.
                 #AAD Modules of applications.
                 #
                 PRESS_KEY=0 # Display "Press 'Enter' key to continue."
                 MENU_TITLE="Download Software Menu"
                 DELIMITER="#AAD" #AAD This 3rd field prevents awk from printing this line into menu options. 
                 f_show_menu "$MENU_TITLE" "$DELIMITER"
                 #
                 read AAD
                 #
                 f_cat_menu_item_process $AAD ; AAD=$MENU_ITEM  # Outputs $MENU_ITEM.
                 ERROR=0 # Reset error flag.
                 #
                 case $AAD in  # Start of git download case statement.
                      [Ss] | [Ss][Cc]*)
                      echo
                      echo "Choose the branch from where you want to download the script program."
                      echo
                      for MOD_FILE in cli-app-menu.sh lib_cli-common.lib lib_cli-menu-cat.lib README COPYING EDIT_HISTORY LIST_APPS
                      do
                         #if [ "$BRANCH" != "QUIT" ] ; then
                            echo
                            echo "File to be downloaded is $MOD_FILE."
                            f_download_file  # BRANCH is set here. Download each file one at a time.
                         #fi
                      done
                      echo "________________________________________________________________"
                      echo
                      echo "Any downloaded files are in the same folder as this script."
                      echo
                      echo "The file names will be appended with a '.1'"
                      echo "and you will have to MANUALLY COPY THEM to their original names."
                      PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                      #
                      #if [ "$BRANCH" = "QUIT" ] ; then 
                      #   BRANCH=""
                      #fi
                      ;;
                      [Mm] | [Mm][Oo]*) 
                      f_ask_which_module_download
                      #
                      if [ "$BRANCH" = "QUIT" ] ; then 
                         PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      fi
                      ;;
                 esac          # End of git download case statement.
                 #
                 # Trap bad menu choices, do not echo Press enter key to continue.
                 f_bad_menu_choice $AAD ; AAD=$MENU_ITEM  # Outputs $MENU_ITEM.
                 #
                 AAD=$MENU_ITEM
                 #
           done  # End of Download Software Menu until loop.
           unset AAD  # Throw out this variable.
} # End of function f_menu_main_download
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
# Initialize variables.
# This function sets the $THIS_DIR variable so that lib_cli-common.lib and
# the module libraries may reside in any directory and still be invoked from
# the Main Menu script, cli-app-menu.sh. Please refer to README for more
# instructions on how to set the $PATH environmental variable to do this.
f_initvars_menu_app "AAA"
#
# Invoke the common library to display menus.
. $THIS_DIR/lib_cli-common.lib
#
# **************************************
# ***           Main Menu            ***
# **************************************
#
# Inputs: CHOICE_MAIN, MAX, THIS_FILE, REVISION, REVDATE.
#
until [ $CHOICE_MAIN -eq 0 ]
do    # Start of CLI Menu util loop.
      #AAA Applications        - Launch a command-line application.
      #AAA Help and Features   - How to use and what can it do.
      #AAA About CLI Menu      - What version am I using.
      #AAA Configure           - Change default settings; terminal, browser etc.
      #AAA Documentation       - Script documentation, programmer notes, licensing.
      #AAA Download            - Download script program and/or software modules.
      #AAA Edit History        - All the craziness behind the scenes.
      #AAA License             - Licensing, GPL.
      #AAA List Applications   - List of all CLI applications in this menu.
      #AAA Search Applications - Is an application featured in this menu script?
      #
      THIS_FILE="cli-app-menu.sh"
      MENU_TITLE="Main Menu"
      DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu items.
      f_show_menu "$MENU_TITLE" "$DELIMITER"
      read CHOICE_MAIN
      case $CHOICE_MAIN in 
           # Quit?
           0) 
           CHOICE_MAIN=0
           PRESS_KEY=0
           ;;
           [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           CHOICE_MAIN=0
           PRESS_KEY=0
           ;;
           [1-9] | [1-9][0-9])
           if [  $CHOICE_MAIN -ge 1 -a $CHOICE_MAIN -le $MAX ] ; then
              CHOICE_MAIN=${CHOICE[$CHOICE_MAIN]}
           fi
           ;;
      esac
      #
      case $CHOICE_MAIN in  # Start of CLI Menu case statement.
           [Aa] | [Aa][Pp]*)  # Main Menu item, "Applications".
           . lib_cli-menu-cat.lib # invoke module/library.
           f_menu_cat_applications
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
           [Hh] | [Hh][Ee]*)  # Main Menu item, "Help and Features".
           clear # Blank the screen.
           # Display Help (all lines beginning with "#@" but do not print "#@").
           # sed substitutes null for "#@" at the beginning of each line so it is not printed.
           # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
           sed -n 's/^#@//'p $MAINMENU_DIR/$THIS_FILE | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Aa] | [Aa][Bb]*)  # Main Menu item, "About CLI Menu".
           # Calculate project revision number by counting all lines starting with "## 2013".
           # grep ^ (carot sign) means grep any lines beginning with "##2013".
           # grep -c means count the lines that match the pattern.
           #
           if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo $(tput bold)
                    echo $(tput setaf 3)  # Yellow font for error message.
                    echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
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
                         PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Cc] | [Cc][Oo]*)  # Main Menu item, "Configure".
           f_menu_main_configure
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           #
           ;;
           [Dd] | [Dd][Oo] | [Dd][Oo][Cc]*)  # Main Menu item, "Documentation".
           X="" # Initialize scratch variable.
           clear # Blank the screen.
           if [ ! -r $THIS_DIR"/README" ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo $(tput bold)
                    echo $(tput setaf 3)  # Yellow font for error message.
                    echo ">>>The file README is either missing or cannot be read.<<<"
                    echo
                    echo -n "Download README from www.git.com? (Y/n) "
                    read X
                    case $X in # Start of git download case statement.
                         "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                         ANS=""
                         MOD_FILE="README"
                         f_download_file
                         X="YES"
                         ;;
                         [Nn] | [Nn][Oo])
                         X="NO"
                         PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)  # Main Menu item, "Download".
           f_menu_main_download
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ee] | [Ee][Dd]*)  # Main Menu item, "Edit History".
           X="" # Initialize scratch variable.
           clear # Blank the screen.
           if [ ! -r $THIS_DIR"/EDIT_HISTORY" ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo $(tput bold)
                    echo $(tput setaf 3)  # Yellow font for error message.
                    echo ">>>The file EDIT_HISTORY is either missing or cannot be read.<<<"
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
                         PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ll] | [Ll][Ii] | [Ll][Ii][Cc]*)  # Main Menu item, "License".
           clear # Blank the screen.
           # Display License (all lines beginning with "#LIC" but do not print "#LIC").
           # sed substitutes null for "#LIC" at the beginning of each line so it is not printed.
           # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
           sed -n 's/^#LIC//'p $MAINMENU_DIR/$THIS_FILE | less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
                               echo $(tput bold)
                               echo $(tput setaf 3)  # Yellow font for error message.
                               echo ">>>The file COPYING is either missing or cannot be read.<<<"
                               echo
                               echo -n "Download COPYING from www.git.com? (Y/n) "
                               read X
                               case $X in # Start of git download case statement.
                                    "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                                    ANS=""
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
                      if [ -r $THIS_DIR"/COPYING" ] ; then
                         less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/COPYING"
                         PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      fi
                      X="YES"
                      ;;
                      [Nn] | [Nn][Oo])
                      X="NO"
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac         # End of license case statment.
           done
           #
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)  # Main Menu item, "List Applications".
           if [ ! -r $THIS_DIR"/LIST_APPS" ] ; then
              clear # Blank the screen.
              echo $(tput bold)
              echo $(tput setaf 3)  # Yellow font for error message.
              echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
              echo
              echo "The file LIST_APPS may be automatically created/updated by:"
              echo
              echo "Select Main Menu item:"
              echo "Configure - Change default settings; terminal, browser etc."
              echo
              echo "Select Configuration Menu item:"
              echo "LIST_APPS - Re-create/Update file list of all applications."
              echo
              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           fi
           # display LIST_APPS
           if [ -r $THIS_DIR"/LIST_APPS" ] ; then
              less -P 'Page '%dm' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' $THIS_DIR"/LIST_APPS"
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           #
           ;;
           [Ss] | [Ss][Ee]*)  # Main Menu item, "Search Applications".
           clear # Blank the screen.
           if [ ! -r $THIS_DIR"/LIST_APPS" ] ; then
              clear # Blank the screen.
              echo $(tput bold)
              echo $(tput setaf 3)  # Yellow font for error message.
              echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
              echo
              echo "The file LIST_APPS may be automatically created/updated by:"
              echo
              echo "Select Main Menu item:"
              echo "Configure - Change default settings; terminal, browser etc."
              echo
              echo "Select Configuration Menu item:"
              echo "LIST_APPS - Re-create/Update file list of all applications."
              echo
              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
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
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
      esac # End of CLI Menu case statement.
      #
      case $CHOICE_MAIN in
           "")
           CHOICE_MAIN=-1 # Convert string to integer -1 forcing stay in until loop.
           PRESS_KEY=0   # Do not display "Press 'Enter' key to continue."
           ;;
           [A-Za-z]*)
           CHOICE_MAIN=-1 # Convert string to integer -1. Stay in until loop.
           PRESS_KEY=0    # Do not display "Press 'Enter' key to continue."
                          # Specifically for alpha nonsense responses.
           ;;
      esac
      if [ $CHOICE_MAIN -le -3 -o $CHOICE_MAIN -gt $MAX ] ; then
         CHOICE_MAIN=-1  # Convert string to integer -1. Stay in until loop.
         PRESS_KEY=0     # Do not display "Press 'Enter' key to continue."
                         # Specifically for out-of-bounds numeric response.
      fi
      f_option_press_enter_key
done  # End of CLI Menu until loop.
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
# all dun dun noodles.
