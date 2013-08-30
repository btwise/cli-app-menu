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
REVDATE="August-29-2013 18:50"
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
         echo
         echo "You are using the DASH environment."
         echo "Ubuntu and Linux Mint default to DASH but also have BASH available."
         echo
         echo "*** This script cannot be run in the DASH environment. ***"
         echo
         echo "You can invoke the BASH environment by typing"
         echo "'bash cli-app-menu.sh' at the command line."
         echo
         echo ">>>The errors below disappear in the BASH environment.<<<"
         echo
      fi
} # End of function f_test_dash
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
# Since the DASH environment does not recognize the ". <library> command,
# the function f_test_dash must be included in this cli-app-menu.sh script file
# rather than in the library file lib_cli-common.lib, but once in BASH, then
# common library file may be invoked.
#
# Test the environment for DASH and if in BASH invoke the common library.
f_test_dash
# Invoke the common library to display menus.
. lib_cli-common.lib # If in DASH environment, then will program halt execution 
                     # with error ".: lib_cli-common.lib: not found".
#
# **************************************
# ***           Main Menu            ***
# **************************************
#
# Inputs: CHOICE_MAIN, MAX, THIS_FILE, REVISION, REVDATE.
#
f_initvars_menu_app
until [ $CHOICE_MAIN -eq 0 ]
do    # Start of CLI Menu util loop.
      #AAA Applications        - Launch a command-line application.
      #AAA Help and Features   - How to use and what can it do.
      #AAA About CLI Menu      - What version am I using.
      #AAA Documentation       - Script documentation, programmer notes, licensing.
      #AAA Download            - Download script program and/or software modules.
      #AAA Edit History        - All the craziness behind the scenes.
      #AAA License             - Licensing, GPL.
      #AAA List Applications   - List of all CLI applications in this menu.
      #AAA Search Applications - Is an application featured in this menu script?
      #AAA Update Edit History - Make changes to the Edit History.
      #AAA Black               - Set display white on black (works in X-terminals).
      #AAA White               - Set display black on white (except in X-terminals).
      #
      THIS_FILE="cli-app-menu.sh"
      MENU_TITLE="Main Menu"
      DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu items.
      f_show_menu $MENU_TITLE $DELIMITER 
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
      case $CHOICE_MAIN in # Start of CLI Menu case statement.
           [Aa] | [Aa][Pp]*)
           . lib_cli-menu-cat.lib # invoke module/library.
           f_menu_cat_applications
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
           [Hh] | [Hh][Ee]*)
           clear # Blank the screen.
           # Display Help (all lines beginning with "#@" but do not print "#@").
           # sed substitutes null for "#@" at the beginning of each line so it is not printed.
           # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
           sed -n 's/^#@//'p $THIS_FILE | less -P '(Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Aa] | [Aa][Bb]*)
           # Calculate project revision number by counting all lines starting with "## 2013".
           # grep ^ (carot sign) means grep any lines beginning with "##2013".
           # grep -c means count the lines that match the pattern.
           #
           PROJECT_REVISION=$(grep ^"## 2013" -c "EDIT_HISTORY") ; PROJECT_REVISION="2013.$PROJECT_REVISION"
           PROJECT_REVDATE=$(grep ^PROJECT_REVDATE= EDIT_HISTORY | awk -F "=" '{ print $2 }' | awk -F '"' '{print $2}')
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
           [Dd] | [Dd][Oo] | [Dd][Oo][Cc]*)
           X="" # Initialize scratch variable.
           clear # Blank the screen.
           if [ ! -r README ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo
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
           if [ -r README ] ; then
              # Display README Documentation (all lines beginning with "#:" but do not print "#:").
              # sed substitutes null for "#:" at the beginning of each line so it is not printed.
              # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
              sed -n 's/^#://'p README | less -P 'Page '%dB' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)
           f_initvars_menu_app
           ANS="" # Initialize before calling f_download_file.
           until [ $CHOICE_SCAT -eq 0 ] 
           do    # Start of Download Software Menu until loop.
                 #AAC Script program.
                 #AAC Modules of applications.
                 #
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 MENU_TITLE="Download Software Menu"
                 DELIMITER="#AAC" #AAC This 3rd field prevents awk from printing this line into menu options. 
                 f_show_menu $MENU_TITLE $DELIMITER 
                 #
                 read CHOICE_SCAT
                 #
                 f_common_scat_menu
                 ERROR=0 # Reset error flag.
                 #
                 case $CHOICE_SCAT in # Start of git download case statement.
                      [Ss] | [Ss][Cc]*)
                      echo
                      echo "Choose the branch from where you want to download the script program."
                      echo
                      for MOD_FILE in cli-app-menu.sh lib_cli-common.lib lib_cli-menu-cat.lib README COPYING EDIT_HISTORY LIST_APPS
                      do
                         f_download_file
                      done
                      if [ "$ANS" != "QUIT" ] ; then
                         echo "________________________________________________________________"
                         echo
                         echo "Downloaded files are in the same folder as this script."
                         echo
                         echo "The file names will be appended with a '.1'"
                         echo "and you will have to MANUALLY COPY THEM to their original names."
                         PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                      fi
                      CHOICE_SCAT=-1         # Legitimate response. Stay in menu loop.
                      ;;
                      [Mm] | [Mm][Oo]*) 
                      f_ask_which_module_download
                      CHOICE_SCAT=-1         # Legitimate response. Stay in menu loop.
                      ;;
                 esac                 # End of git download case statement.
                 #
                 # Trap bad menu choices, do not echo Press enter key to continue.
                 f_scat_bad_menu_choice
           done  # End of Download Software Menu until loop.
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ee] | [Ee][Dd]*)
           X="" # Initialize scratch variable.
           clear # Blank the screen.
           if [ ! -r EDIT_HISTORY ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo
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
           if [ -r EDIT_HISTORY ] ; then
              # Display Edit History (all lines beginning with "##" but do not print "##").
              # sed substitutes null for "##" at the beginning of each line so it is not printed.
              # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
              sed -n 's/^##//'p EDIT_HISTORY | less -P 'Page '%dB' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ll] | [Ll][Ii] | [Ll][Ii][Cc]*)
           clear # Blank the screen.
           # Display License (all lines beginning with "#LIC" but do not print "#LIC").
           # sed substitutes null for "#LIC" at the beginning of each line so it is not printed.
           # less -P customizes prompt for %f <FILENAME> page <num> of <pages> (Spacebar, PgUp/PgDn . . .)
           sed -n 's/^#LIC//'p $THIS_FILE | less -P 'Page '%dB' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)'
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
                      if [ ! -r COPYING ] ; then
                         X="" # Initialize scratch variable.
                         while [  "$X" != "YES" -a "$X" != "NO" ]
                         do
                               clear # Blank the screen.
                               echo
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
                                               APP_NAME="w3m"
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
                      if [ -r COPYING ] ; then
                         less -P 'Page '%dB' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' COPYING
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
           [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)
           X="" # Initialize scratch variable.
           if [ ! -r LIST_APPS ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo
                    echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
                    echo
                    echo -n "Download LIST_APPS from www.git.com? (Y/n) "
                    read X
                    case $X in # Start of gnu.org case statement.
                         "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                         ANS=""
                         MOD_FILE="LIST_APPS"
                         f_download_file
                         X="YES"
                         ;;
                         [Nn] | [Nn][Oo])
                         echo
                         echo "The file LIST_APPS may be automatically created/updated by:"
                         echo
                         echo "1. Copy ALL the mod_apps-*.lib files to the current directory."
                         echo
                         echo "2. Type the command below:"
                         echo
                         echo ". lib_cli-common.lib; f_create_LIST_APPS"
                         echo "<dot> <space> lib_cli-common.lib <semi-colon> <space> f_create_LIST_APPS."
                         echo
                         X="NO"
                         PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                         ;;
                    esac         # End of gnu.org case statement.
              done
           fi
           # display LIST_APPS
           if [ -r LIST_APPS ] ; then
           less -P 'Page '%dB' (Spacebar, PgUp/PgDn, Up/Dn arrows, press q to quit)' LIST_APPS
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           #
           ;;
           [Ss] | [Ss][Ee]*)
           X="" # Initialize scratch variable.
           clear # Blank the screen.
           if [ ! -r LIST_APPS ] ; then
              while [  "$X" != "YES" -a "$X" != "NO" ]
              do
                    clear # Blank the screen.
                    echo
                    echo ">>>The file LIST_APPS is either missing or cannot be read.<<<"
                    echo
                    echo -n "Download LIST_APPS from www.git.com? (Y/n) "
                    read X
                         case $X in # Start of gnu.org case statement.
                              "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                              ANS=""
                              MOD_FILE="LIST_APPS"
                              f_download_file
                              X="YES"
                              ;;
                              [Nn] | [Nn][Oo])
                              echo
                              echo "The file LIST_APPS may be automatically created/updated by:"
                              echo
                              echo "1. Copy ALL the mod_apps-*.lib files to the current directory."
                              echo
                              echo "2. Type the command below:"
                              echo
                              echo ". lib_cli-common.lib; f_create_LIST_APPS"
                              echo "<dot> <space> lib_cli-common.lib <semi-colon> <space> f_create_LIST_APPS."
                              echo
                              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                              X="NO"
                              ;;
                         esac         # End of gnu.org case statement.
              done
           fi
           #
           if [ -r LIST_APPS ] ; then
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
                       grep $XSTR LIST_APPS --ignore-case -C 9 --color=always | more -d
                       echo
                       echo "***End of search results.***"
                       f_press_enter_key_to_continue
                       echo
                    fi
              done
           fi
           ;;
           [Uu] | [Uu][Pp]*)
           clear # Blank the screen.
           if [ -r EDIT_HISTORY ] ; then
              APP_NAME="joe EDIT_HISTORY"
              echo "To get help within the joe editor, type 'Ctrl-K h'"
              f_press_enter_key_to_continue
              f_application_run
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           else
              echo
              echo "The file EDIT_HISTORY is either missing or cannot be read."
              echo
              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Bb] | [Bb][Ll]*)
           TCOLOR="black"
           f_term_color # Set terminal color.
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ww] | [Ww][Hh]*)
           TCOLOR="white"
           f_term_color # Set terminal color.
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
# all dun dun noodles.
