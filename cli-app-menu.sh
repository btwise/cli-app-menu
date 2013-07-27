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
#:   List of Special Menu Option Markers
#
THIS_FILE="cli-app-menu.sh"
#
# +----------------------------------------+
# |    Revision number and Revision Date   |
# +----------------------------------------+
#
# Calculate revision number by counting all lines starting with "## 2013".
# grep ^ (carot sign) means grep any lines beginning with "##2013".
# grep -c means count the lines that match the pattern.
#
REVISION=$(grep ^"## 2013" -c EDIT_HISTORY) ; REVISION="2013.$REVISION"
REVDATE="July-26-2013 21:51"
#
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
# +----------------------------------------+
# |          Function f_test_dash          |
# +----------------------------------------+
#
#  Inputs: $BASH_VERSION (System variable)
#    Uses: None
# Outputs: None
#
f_test_dash () {
#
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
   exit # Quit script if not in BASH environment. 
fi
} # End of function f_test_dash
##
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
# Test the environment for DASH.
f_test_dash
#
# Invoke libraries.
. lib_cli-common.lib
. lib_cli-menu-apps.lib
. lib_cli-menu-cat.lib
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
      #AAA Download            - Download the STABLE released version of this script.
      #AAA Edit History        - All the craziness behind the scenes.
      #AAA License             - Licensing, GPL.
      #AAA List Applications   - List of all CLI applications in this menu.
      #AAA Update Edit History - Make changes to the Edit History.
      #AAA Black               - Set display white on black (works in X-terminals).
      #AAA White               - Set display black on white (except in X-terminals).
      #
      THIS_FILE="cli-app-menu.sh"
      MENU_TITLE="Main Menu"
      DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu options. 
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
           f_menu_cat_applications
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
           [Hh] | [Hh][Ee]*)
           clear # Blank the screen.
           sed -n 's/^#@//'p $THIS_FILE | more -d
           # display Help Applications (all lines beginning with #@ but
           # substitute "" for "#@" so "#@" is not printed).
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Aa] | [Aa][Bb]*)
           clear # Blank the screen.
           echo "CLI Menu version: $REVISION"
           echo "       Edited on: $REVDATE"
           echo "Bash script name: $THIS_FILE"
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Dd] | [Dd][Oo] | [Dd][Oo][Cc]*)
           clear # Blank the screen.
           if [ -r README ] ; then
           # display Documentation (all lines beginning with #: but
           # substitute "" for "#:" so "#:" is not printed).
              sed -n 's/^#://'p README | more -d
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           else
              echo
              echo "The file README is either missing or cannot be read."
              echo
              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Dd] | [Dd][Oo] | [Dd][Oo][Ww]*)
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/cli-app-menu.sh"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/README"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/COPYING"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/EDIT_HISTORY"
           wget $WEB_SITE
           echo
           echo "Downloaded files are in the same folder as this script."
           echo "The file names will be appended with a '.1'"
           echo "and you will have to manually copy them to the original names."
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ee] | [Ee][Dd]*)
           clear # Blank the screen.
           if [ -r EDIT_HISTORY ] ; then
              # display Edit History (all lines beginning with ## but
              # substitute "" for "##" so "##" is not printed).
              sed -n 's/^##//'p EDIT_HISTORY | more -d
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           else
              echo
              echo "The file EDIT_HISTORY is either missing or cannot be read."
              echo
              PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           fi
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ll] | [Ll][Ii] | [Ll][Ii][Cc]*)
           clear # Blank the screen.
           # display License (all lines beginning with #LIC but
           # substitute "" for "#LIC" so "#LIC" is not printed).
           sed -n 's/^#LIC//'p $THIS_FILE | more -d
           echo
           echo -n "Read the full license text contained in file 'COPYING'? (N/y) "
           read ANS
           case $ANS in # Start of license case statment.
                [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                echo
                if [ -r COPYING ] ; then
                   cat COPYING | more -d
                else
                   echo
                   echo "The file COPYING is either missing or cannot be read."
                   echo 
                   echo -n "Read the full license text at http://www.gnu.org/licenses/ ? (N/y) "
                   read ANS
                   case $ANS in # Start of gnu.org case statement.
                        [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                        echo
                         APP_NAME="w3m"
                        WEB_SITE="http://www.gnu.org/licenses/gpl.html"
                        APP_NAME="$APP_NAME $WEB_SITE"
                        f_application_run
                        ;;
                        [Nn] | [Nn][Oo])
                        ;;
                   esac         # End of gnu.org case statement.
               fi
               ;;
               [Nn] | [Nn][Oo])
               ;;
           esac         # End of license case statment.
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           [Ll] | [Ll][Ii] | [Ll][Ii][Ss]*)
           clear # Blank the screen.
           #
           # 1. grep finds all lines containing "#M" followed by two letters in
           #    this script.
           #    .i.e. "            #MGF bastet         - Tetris-like game." #MGF This 3rd field prevents awk from  printing this line into menu options.
           #
           #    Lines starting with "#M" are applications listed in menus.
           #    The string "#M" followed by 2 letters are the special menu
           #    option marker. i.e. #MGF is the marker for Puzzle Games. #MGF This 3rd field prevents awk from  printing this line into menu options.
           #
           # 2. The first awk parses results and chosen if lines contain only
           #    one "#M"*. Results are printed, showing everything after "#M".
           #    i.e. Selected: "#MGF bastet         - Tetris-like game." #MGF This 3rd field prevents awk from  printing this line into menu options.
           #              print $2: "GF bastet         - Tetris-like game."
           #
           # 3. The second awk substitutes "" for only the first word and
           #    prints all the rest of the words.
           #    'sub' string function substitutes only the first match (word).
           #    i.e.  Piped result: "GF bastet         - Tetris-like game."
           #         result of sub: "bastet         - Tetris-like game."
           #
           # 4. 'print $0' I/O statement prints all the rest of the words.
           #         i.e. print $0: "bastet         - Tetris-like game." 
           #    (Where "GF" substituted by "".)
           #
           THIS_FILE="lib_cli-menu-apps.lib"
           grep [#][M][A-Z][A-Z] $THIS_FILE | awk -F '#M' '{if ($2&&!$3){print $2}}' | awk '{sub(/[^" "]+ /, ""); print $0}' | more -d
           #
           # The code below will work but is less elegant.
           #
           # 3. The second awk prints out the 2nd to the 15th words in the
           #    resultant string. The 1st word is skipped because it is the
           #    last 2 letters of the special menu option marker.
           #    i.e. "GF bastet         - Tetris-like game."
           #
           #    2nd to 15th words printed.
           #    i.e. "bastet - Tetris-like game."
           #
           # grep [#][M][A-Z][A-Z] $THIS_FILE | awk -F '#M' '{if ($2&&!$3){print $2}}' | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' | more -d
           #
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
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
