# ©2013 Copyright 2013 Robert D. Chin
#
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
REVDATE="July-29-2013 23:26"
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
#@       Example for help on the 'joe' text editor, 
#@              joe --help
#@
#@ 2.    man <application name>       Where 'man' is short for 'manual'
#@
#@       Example for more help on the 'joe' text editor,
#@              man joe
#@
#@ Just remember --help (after the name) or man (before the name).
#@
#
# **************************************
# ***        Program Functions       ***
# ***  Note: Functions must precede  ***
# ***        main program to work.   ***
# **************************************
#
# +----------------------------------------+
# |      Function f_initvars_menu_app      |
# +----------------------------------------+
#
f_initvars_menu_app () {
      TCOLOR="black"
      ERROR=0        # Initialize to 0 to indicate success at running last
                     # command.
      APP_NAME=""    # Initialize to null. String variable contains
                     # application name.
      CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting
                     # Main Menu.
      CHOICE_CAT=-1  # Initialize to -1 to force until loop without exiting
                     # Category Menu.
      CHOICE_SCAT=-1 # Initialize to -1 to force until loop without exiting 
                     # Sub-Category Menu.
      CHOICE_TCAT=-1 # Initialize to -1 to force until loop without exiting 
                     # 3rd-level Category Menu.
      CHOICE_APP=-1  # Initialize to -1 to force until loop without exiting 
                     # Applications Menu.
      PRESS_KEY=1    # Display "Press 'Enter' key to continue."
} # End of f_initvars_menu_app
#
# +----------------------------------------+
# |          Function f_show_menu          |
# +----------------------------------------+
#
#  Inputs: MENU_TITLE, DELIMITER, THIS_FILE, MAX.
# Outputs: MAX, XNUM.
#
f_show_menu () { # function where $1=$MENU_TITLE $2=$DELIMITER
      clear # Blank the screen.
      f_term_color # Set terminal color.
      echo "--- $MENU_TITLE ---"
      echo
      if [ $DELIMITER = "#AAA" ] ; then #AAA This 3rd field prevents awk from  printing this line into menu options.
         echo "0 - Quit to command line prompt." # Option for Main Menu only.
      else
         echo "0 - Return to previous menu." # Option for all other sub-menus.
      fi
      #
      # The following command grep <pattern> <filename> | awk '{<if condition>{print field}}
      # will print the menu items. The command automatically calculates the
      # menu option numbers for you.
      #
      # Search (grep) for all lines in this file containing the special comment
      # marker string.
      # Pass (pipe) results to awk which prints the second field delimited by
      # the special comment string.
      # awk will not print the second field if there is a third field (lines
      # containing 2 special comment strings).
      # The if statement conditional "($2&&!$3)" means if 2nd field exists and
      # not a 3rd field, then print.
      # This prevents the lines of code which set the $ DELIMITER variable from
      # being printed as part of the menu.
      #
      # The menu option numbers are incremented by using any unset variable name
      # (such as "XNUM") followed by "++",
      # However, because XNUM is unset, it will increment from zero, whereas we
      # want it to increment from one.
      # To do this, we add one before XNUM so the expression is now "1+XNUM++".
      # so numbering will always start at one. Interestingly the "++" increment
      # command is only valid from within awk.
      #
      MAX=$(grep $DELIMITER -c $THIS_FILE)
      # Count number of lines containing special comment marker string to get
      # maximum item number.
      awk -F $DELIMITER '{if ($2&&!$3){print 1+XNUM++" -"$2;}}' $THIS_FILE
      f_choice_array  # Create array to handle numeric answer to menu choices.
      #
      case $DELIMITER in
           # Application Menu?
           "#AAA") #AAA This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-3)) 
              # Subtract 3 total since 3 lines of code not part of menu display,
              # contain the special comment marker.
              echo
              echo "'0', Q/quit, to quit this script, $THIS_FILE."
           ;; 
           "#AAB") #AAB This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-2))
              # Subtract 2 total since 2 lines of code not part of menu display,
              # contain the special comment marker.
           ;;
           "#MWB") #MWB This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-3))
              # Subtract 3 total since 3 lines of code not part of menu display,
              # contain the special comment marker.
              echo
              echo "For help, type: '<application name> --help' or 'man <application name>'"
              echo "Also accepts application options i.e. <application name> --version"
           ;; 
           "#M"* | "#B"*) # Only display help message in application menus.
              # Do not display in application category menus or main menu.
              MAX=$((MAX=$MAX-1))
              # Subtract 1 total since 1 line of code to set $DELIMITER where
              # contains the special comment marker.
              echo
              echo "For help, type: '<application name> --help' or 'man <application name>'"
              echo "Also accepts application options i.e. <application name> --version"
           ;;
      esac
      echo
      echo -n "Enter 0 to $MAX or letters: " # echo -n supresses line-feed.
} # End of function f_show_menu
#
# +----------------------------------------+
# |         Function f_choice_array        |
# +----------------------------------------+
#
#  Inputs: DELIMITER, THIS_FILE.
#    Uses: XNUM, XSTR
# Outputs: CHOICE[$XNUM]
#
f_choice_array () {
# declare -A CHOICE  # Commented out; do not need to declare the array.
unset CHOICE
XNUM=1 # Initialize XNUM.
X=" "
# Code below rewritten to allow menu choice names consisting of 2 words. i.e. "ip addr", "ip route".
#
for XSTR in `awk -F $DELIMITER '{ if ( $2&&!$3 ) { print $2 } }' $THIS_FILE | awk -F " - " '{ print $1 }' | awk '{ if ( $2 ) { print $1"%"$2 } else {print $1 } }'`
# Set XSTR to first two words (delimited by "%" of menu choice name. 
# Example: Main menu option, "About CLI Menu" then XSTR="About%CLI" 
do
      XSTR=${XSTR/[%]/ }   # Substitute <space> for "%".
      CHOICE[$XNUM]=$XSTR  # If Ubuntu or Ubuntu derived distro errors here,
                           # cause is Ubuntu uses DASH instead of BASH shell.
                           # Use "bash cli-menu-app.sh" 
                           # instead of "sh cli-menu-app.sh".
      XNUM=`expr $XNUM + 1`
done
} # End of f_choice_array
#
# +----------------------------------------+
# |       Function f_common_scat_menu      |
# +----------------------------------------+
#
#  Inputs: CHOICE_SCAT.
# Outputs: CHOICE_SCAT.
#
f_common_scat_menu () {
      case $CHOICE_SCAT in
           # Quit?
           0)
           CHOICE_SCAT=0
           PRESS_KEY=0
           ;;
           [1-9] | [1-9][0-9])
           if [  $CHOICE_SCAT -ge 1 -a $CHOICE_SCAT -le $MAX ] ; then
              CHOICE_SCAT=${CHOICE[$CHOICE_SCAT]}
           fi
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu]*)
           CHOICE_SCAT=0
           PRESS_KEY=0
           ;;
      esac
} # End of function f_common_scat_menu
#
# +----------------------------------------+
# |       Function f_common_tcat_menu        |
# +----------------------------------------+
#
#  Inputs: CHOICE_TCAT, MAX, CHOICE[XNUM].
# Outputs: CHOICE_TCAT.
#
f_common_tcat_menu () {
      case $CHOICE_TCAT in
           # Quit?
           0)
           CHOICE_TCAT=0
           PRESS_KEY=0
           ;;
           [1-9] | [1-9][0-9])
           if [  $CHOICE_TCAT -ge 1 -a $CHOICE_TCAT -le $MAX ] ; then
              CHOICE_TCAT=${CHOICE[$CHOICE_TCAT]}
           fi
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu]*)
           CHOICE_TCAT=0
           PRESS_KEY=0
           ;;
      esac
} # End of function f_common_tcat_menu
#
# +----------------------------------------+
# |       Function f_common_app_menu       |
# +----------------------------------------+
#
#  Inputs: CHOICE_APP, MAX, CHOICE[XNUM].
# Outputs: CHOICE_APP.
f_common_app_menu () {
      case $CHOICE_APP in
           # Quit?
           0)
           CHOICE_APP=0
           PRESS_KEY=0
           ;;
           [1-9] | [1-9][0-9])
           if [  $CHOICE_APP -ge 1 -a $CHOICE_APP -le $MAX ] ; then
              CHOICE_APP=${CHOICE[$CHOICE_APP]}
           fi
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu]*)
           CHOICE_APP=0
           PRESS_KEY=0
           ;;
      esac
} # End of function f_common_app_menu
#
# +----------------------------------------+
# |   Function f_how_to_quit_application   |
# +----------------------------------------+
#
# Inputs: $1, $2, APP_NAME.
#
f_how_to_quit_application () { 
      # $1 typed key to quit. 
      # $2 string "no-clear" if screen should not be cleared.
      #
      if [ -z $2 ] ; then
      # if [ $2 != "no-clear" ] ; then
         clear # Blank the screen.
      fi
      echo
      echo "To quit $APP_NAME, type $1."
      f_press_enter_key_to_continue
} # End of function how_to_quit_application
#
# +----------------------------------------+
# |          Function f_term_color         |
# +----------------------------------------+
#
# Inputs: TCOLOR.
#
f_term_color () { # Set terminal display properties.
      case $TCOLOR in
           [Bb] | [Bb][Ll] | [Bb][Ll][Aa] | [Bb][Ll][Aa][Cc] | [Bb][Ll][Aa][Cc][Kk])
              setterm -reset -bold on
           ;;
           [Ww] | [Ww][Hh] | [Ww][Hh][Ii] | [Ww][Hh][Ii][Tt] | [Ww][Hh][Ii][Tt][Ee])
              setterm -reset
              setterm -foreground white -background black -inverse
           ;;  
      esac
} # End of function f_term_color
#
# +----------------------------------------+
# | Function f_press_enter_key_to_continue |
# +----------------------------------------+
#
# Inputs: None.
#
f_press_enter_key_to_continue () { # Display message and wait for user input.
      echo
      echo -n "Press '"Enter"' key to continue."
      read ANS
} # End of function f_press_enter_key_to_continue
#
# +----------------------------------------+
# |   Function f_option_press_enter_key    |
# +----------------------------------------+
#
# Inputs: PRESS_KEY.
#
f_option_press_enter_key () { # Display message and wait for user input.
      # $PRESS_KEY = 0 means Do not display "Press 'Enter' key to continue."
      # $PRESS_KEY = 1 means Display "Press 'Enter' key to continue."
      #
      if [ $PRESS_KEY -eq 1 ] ; then
         f_press_enter_key_to_continue
      fi
} # End of function f_option_press_enter_key
#
# +----------------------------------------+
# |       Function f_application_help      |
# +----------------------------------------+
#
#  Inputs: CHOICE_APP, ERROR.
# Outputs: PRESS_KEY, CHOICE_APP=-1, APP_NAME
#
f_application_help () { # function where $CHOICE_APP="<Application name> --help"
                        # or "man <Application name>"
      case $CHOICE_APP in
           *--help)
              clear # Blank screen
              # $CHOICE_APP | more -d # <Application name> --help | more -d
              $CHOICE_APP
              ERROR=$? # Save error flag condition.
              if [ $ERROR -ne 0 ] ; then
                 # Error code 1 $?=1 means no --help available.
                 # Error code 0 (zero) where $?=0 means no error.
                 echo "No --help option available for \c"; echo $CHOICE_APP | awk '{print $1;}'
                 # $CHOICE_APP = "<Application name> --help" so need awk to grab
                 # only the name.
                 # The echo -e \c option supresses the line feed after the first
                 # echo command so that the message is on a single line.
                 echo
                 echo
                 echo "This $APP_NAME application is not installed."
                 echo
                 echo "To install under Debian-based Linux use command:"
                 echo "                           sudo apt-get install <application package name>"
                 echo
                 echo "To install under Red Hat-based Linux use command:"
                 echo "                           sudo rpm -ivh <application package name>"
                 echo
                 echo "To install under Slackware-based Linux use command:"
                 echo "                           sudo installpkg <application package name>"
                 echo 
                 echo -n "Do you want to install $APP_NAME using 'apt-get' or 'rpm' (y/N)? "
                 read ANS
                 case $ANS in # Start of Install Application Option case statement.
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss]) # Yes, install the application.
                      f_application_install
                      PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                      ;;              
                      [Nn] | [Nn][Oo] | *) # No, do not install the application.
                      ERROR=0
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac # End of Install Application Option case statement.

              fi
              CHOICE_APP=-1 # Force stay in menu until loop.
              # Convert string to integer -1. Also indicates valid menu choice.
              # If valid, f_bad_application_menu_choice will not force PRESS_KEY=1.
           ;;
           man' '*)
              clear # Blank screen
              $CHOICE_APP # CHOICE_APP = man <Application name>.
              ERROR=$? # Save error flag condition.
              # If there are no man pages, ask user if wants to install app.
              # Function f_application_install needs APP_NAME as input
              # so use awk to grab only the application's name to use for APP_NAME.
              APP_NAME=$(echo $CHOICE_APP | awk '{print $2;}')
              #
              PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
              #
              if [ $ERROR -ne 0 ] ; then
                 # Error code 16 where $?=16 means no man(ual) entry.
                 # Error code 0 (zero) where $?=0 means no error.
                 # Message "No manual entry for <Application name>" 
                 echo "No manual pages available for \c"; echo $APP_NAME 
                 # The echo -e \c option supresses the line feed after the first
                 # echo command so that the message is on a single line.
                 echo
                 echo
                 echo "This application may either not be installed or is installed but man pages"
                 echo "were never written for it."
                 echo
                 echo "To install under Debian-based Linux use command:"
                 echo "                           sudo apt-get install <application package name>"
                 echo
                 echo "To install under Red Hat-based Linux use command:"
                 echo "                           sudo rpm -ivh <application package name>"
                 echo
                 echo "To install under Slackware-based Linux use command:"
                 echo "                           sudo installpkg <application package name>"
                 echo 
                 echo -n "Do you want to install $APP_NAME using 'apt-get' or 'rpm' (y/N)? "
                 read ANS
                 case $ANS in # Start of Install Application Option case statement.
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss]) # Yes, install the application.
                      f_application_install
                      PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                      ;;              
                      [Nn] | [Nn][Oo] | *) # No, do not install the application.
                      ERROR=0
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac # End of Install Application Option case statement.
              fi
              CHOICE_APP=-1 # Force stay in menu until loop.
              # Convert string to integer -1. Also indicates valid menu choice.
              # If valid, f_bad_application_menu_choice will not force PRESS_KEY=1.
           ;;
      esac
#
} # End of function f_application_help
#
# +----------------------------------------+
# |       Function f_application_run       |
# +----------------------------------------+
#
#  Inputs: APP_NAME.
# Outputs: CHOICE_APP=-1.
#
f_application_run () {
CHOICE_APP=-1 # Force stay in menu until loop.
# Convert string to integer -1. Also indicates valid menu choice.
# If valid, f_bad_application_menu_choice will not force PRESS_KEY=1.
#
clear # Blank the screen.
#
$APP_NAME # Run application.
#
ERROR=$? # Save error flag condition.
case $ERROR in
     127)  # Error code 127 means application is not installed.
     f_application_error # installs application.
     # If user decided to install application.
     if [ $ERROR=127 -a $ANS="Y" ] ; then 
        $APP_NAME           # Run application.
        f_application_error # Check for errors.
                            # If so, display appropriate error message.
     fi
     ;;
     1 | 13 | 62 | [!0])
     f_application_error # Display appropriate error message.
     ;;
esac
#
} # End of function f_application_run
#
# +----------------------------------------+
# | Function f_application_bad_menu_choice |
# +----------------------------------------+
#
#  Inputs: CHOICE_APP, APP_NAME.
# Outputs: CHOICE_APP, PRESS_KEY.
#
# Always set CHOICE_APP from string to an integer because menu until loop
# tests until [ CHOICE_APP -eq 0 ] and will error if CHOICE_APP is a string.
#
# Function f_application_run is always called before this function.
# If valid menu choice, f_application_run sets CHOICE_APP=-1 then leave alone.
# If CHOICE_APP=0 to quit menu, then leave alone.
# If invalid menu choice, CHOICE_APP is bad string or bad integer,
#    then set CHOICE_APP=-1 and do not display "Press 'Enter' key to continue."
#
f_application_bad_menu_choice () {
case $CHOICE_APP in
     "")
     CHOICE_APP=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0   # Do not display "Press 'Enter' key to continue."
     ;;
     [A-Za-z]*)
     CHOICE_APP=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0   # Do not display "Press 'Enter' key to continue."
                   # Specifically for alpha nonsense responses.
     ;;
esac
if [ $CHOICE_APP -le -2 -o $CHOICE_APP -gt $MAX ] ; then
   CHOICE_APP=-1   # Convert string to integer -1 forcing stay in until loop.
   PRESS_KEY=0     # Do not display "Press 'Enter' key to continue."
                   # Specifically for out-of-bounds numeric response.
fi
} # End of function f_application_bad_menu_choice
#
# +----------------------------------------+
# |    Function f_scat_bad_menu_choice   |
# +----------------------------------------+
#
#  Inputs: CHOICE_SCAT.
# Outputs: CHOICE_SCAT, PRESS_KEY.
#
f_scat_bad_menu_choice () {
case $CHOICE_SCAT in
     "")
     CHOICE_APP=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0   # Do not display "Press 'Enter' key to continue."
     ;;
     [A-Za-z]*)
     CHOICE_SCAT=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0    # Do not display "Press 'Enter' key to continue."
                    # Specifically for alpha nonsense responses.
     ;;
esac
if [ $CHOICE_SCAT -le -2 -o $CHOICE_SCAT -gt $MAX ] ; then
   CHOICE_SCAT=-1   # Convert string to integer -1 forcing stay in until loop.
   PRESS_KEY=0      # Do not display "Press 'Enter' key to continue."
                    # Specifically for out-of-bounds numeric response.
fi
} # End of function f_scat_bad_menu_choice
#
# +----------------------------------------+
# |    Function f_tcat_bad_menu_choice     |
# +----------------------------------------+
#
#  Inputs: CHOICE_TCAT.
# Outputs: CHOICE_TCAT, PRESS_KEY.
#
f_tcat_bad_menu_choice () {
case $CHOICE_TCAT in
     "")
     CHOICE_APP=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0   # Do not display "Press 'Enter' key to continue."
     ;;
     [A-Za-z]*)
     CHOICE_TCAT=-1 # Convert string to integer -1 forcing stay in until loop.
     PRESS_KEY=0    # Do not display "Press 'Enter' key to continue."
                    # Specifically for alpha nonsense responses.
     ;;
esac
if [ $CHOICE_TCAT -le -2 -o $CHOICE_TCAT -gt $MAX ] ; then
   CHOICE_TCAT=-1   # Convert string to integer -1 forcing stay in until loop.
   PRESS_KEY=0      # Do not display "Press 'Enter' key to continue."
                    # Specifically for out-of-bounds numeric response.
fi
} # End of function f_tcat_bad_menu_choice
#
# +----------------------------------------+
# |       Function f_application_error     |
# +----------------------------------------+
#
#  Inputs: ERROR, APP_NAME. 
# Outputs: CHOICE_MAIN, CHOICE_CAT, CHOICE_SCAT, CHOICE_APP,
#          PRESS_KEY, APP_NAME_SUDO, APP_NAME_INSTALL.
#
f_application_error () {
      if [ $ERROR -ne 0 ] ; then
         echo
         echo "**********************************************************************"
         echo ">>>>>>>>>> SEE ABOVE for application error messages, if any <<<<<<<<<<"
         echo "**********************************************************************"
         echo
         echo $THIS_FILE" says:"
         echo "              ***********"
         echo "An error code >>> $ERROR <<< has occurred" 
         echo "              ***********"
         echo "while launching this $APP_NAME application."
         # f_press_enter_key_to_continue
         #
         # Be sure variable is set to redisplay current menu afterwards.
         CHOICE_MAIN=-1 # Initialize to -1 to force until loop
                        # without exiting Main Menu.
         CHOICE_CAT=-1  # Initialize to -1 to force until loop
                        # without exiting Category Menu.
         CHOICE_SCAT=-1 # Initialize to -1 to force until loop 
                        # without exiting Sub-Category Menu.
         CHOICE_TCAT=-1 # Initialize to -1 to force until loop 
                        # without exiting 3rd-level Category Menu.
         CHOICE_APP=-1  # Initialize to -1 to force until loop
                        # without exiting Applications Menu.
      fi
      #
      case $ERROR in # Start of Error Number case statement.
           1 | 13 | 62 | [!0]) 
           #  1-general
           # 13-some unknown app?
           # 62-"command not found" freshclam log folders not set up.
           # [!0]-not zero, any non-zero error number.
           case $APP_NAME in  # Start of sudo-error case statement
                sudo' '*)
                APP_NAME_SUDO=$APP_NAME # Don't modify APP_NAME
                APP_NAME_SUDO=$(echo $APP_NAME | awk '{print $2;}')
                echo
                echo "Try running $APP_NAME_SUDO without the sudo command."
                echo "There is a possibility that the application is not installed."
                PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                ;;
                *)
                echo
                echo "Run $APP_NAME again this time using sudo?"
                echo -n "Use sudo (temporary root permissions) (y/N)? "
                read ANS
                case $ANS in  # Start of Use SUDO case statement.
                     [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                     APP_NAME_SUDO=$APP_NAME # Don't modify APP_NAME
                     sudo $APP_NAME_SUDO
                     ERROR=$? # Save error flag condition.
                     #
                     if [ $ERROR -ne 0 ] ; then # Error after running with sudo?
                        # Error code 1 $?=1 means sudo failed.
                        # Error code 0 (zero) where $?=0 means no error.
                        echo
                        echo "Running sudo $APP_NAME_SUDO failed."
                        echo "May be caused by bad sudo password, or user has no permission to use sudo,"
                        echo "or bad $APP_NAME_SUDO syntax."
                        echo "consult help using man $APP_NAME_SUDO."
                        echo
                     fi
                     PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                     ;;              
                     [Nn] | [Nn][Oo] | *)
                     ERROR=0
                     PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                     ;;
                esac     # End of Use SUDO case statement.
                ;;
           esac   # End of sudo-error case statement
           ;;
           127) # Error code 127 means application is not installed.
           echo
           echo "This $APP_NAME application is not installed."
           echo
           echo -n "Do you want to install $APP_NAME (y/N)? "
           read ANS
           case $ANS in # Start of Install Application Option case statement.
                [Yy] | [Yy][Ee] | [Yy][Ee][Ss]) # Yes, install the application.
                f_application_install
                PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                ;;              
                [Nn] | [Nn][Oo] | *) # No, do not install the application.
                ERROR=0
                PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                ;;
           esac # End of Install Application Option case statement.
           ;;
      esac # End of Error Number case statement.
      # This function needs to be followed by a f_press_enter_key_to_continue 
      # or by a f_option_press_enter_key so that messages are displayed.
} # End of function f_application_error
#
# +----------------------------------------+
# |     Function f_application_install     |
# +----------------------------------------+
#
#  Inputs: ERROR, APP_NAME. 
# Outputs: APP_NAME_INSTALL.
#
f_application_install () {
                APP_NAME_INSTALL=$APP_NAME 
                # Default of APP_NAME_INSTALL is simply APP_NAME. 
                # This may be modified below in the Installation Package Name
                # case statement.
                #
                case $APP_NAME_INSTALL in # Start of APP_NAME_INSTALL case statement.
                     *' '*)  
                     # If string APP_NAME/APP_NAME_INSTALL includes spaces for
                     # run-time parameters, then just extract package name. 
                     # i.e. "dstat 1 10", then just grab "dstat" as package name.
                     # i.e. "dstat --version", then just grab "dstat" as package name.
                     #
                     APP_NAME_INSTALL=$(echo $APP_NAME_INSTALL | awk '{print $1;}')
                     ;;
                esac                      # End of APP_NAME_INSTALL case statement.
                #
                # Below are cases where the APP_NAME is not the same as the
                # package name used to install the application.
                # i.e. The game 'trek' is installed using the package called
                # 'bsdgames'.
                #
                case $APP_NAME_INSTALL in # Start of Install Package Name case statement.
                     aria2c)
                     APP_NAME_INSTALL="aria2"
                     ;;
                     barnowl | zcrypt)
                     APP_NAME_INSTALL="barnowl"
                     ;;
                     adventure | arithmetic | atc | backgammon | battlestar | bcd | boggle | caesar | canfield | countmail | cribbage | dab | go-fish | gomoku | hack | hangman | hunt | mille | monop | morse | number | pig | phantasia | pom | ppt | primes | quiz | random | rain | robots | rot13 | sail | snake | tetris | trek | wargames | worm | worms | wump | wtf)
                     APP_NAME_INSTALL="bsdgames"
                     ;;
                     clamscan)
                     APP_NAME_INSTALL="clamav"
                     ;;
                     todo)
                     APP_NAME_INSTALL="devtodo"
                     ;;
                     fbgs)
                     APP_NAME_INSTALL="fbi"
                     ;;
                     glances) # Add repository for glances application.
                     sudo add-apt-repository ppa:arnaud-hartmann/glances-stable
                     sudo apt-get update
                     ;;
                     ifplugstatus)
                     APP_NAME_INSTALL="ifplugd"
                     ;;
                     animate | composite | compare | conjure | convert | display | identify | import | mogrify | montage | stream)
                     APP_NAME_INSTALL="imagemagick"
                     ;;
                     moc)
                     APP_NAME_INSTALL="libqt4-dev"
                     ;;
                     lynx)
                     APP_NAME_INSTALL="lynx-cur"
                     ;;
                     nagios3)
                     APP_NAME_INSTALL="nagios3-core"
                     ;;
                     tcpblast | netload | trafshow | netwatch | strobe | statnet | tcpspray)
                     APP_NAME_INSTALL="netdiag"
                     ;; 
                     mpstat | iostat | pidstat | sadf | sar)
                     APP_NAME_INSTALL="sysstat"
                     ;;
                     photorec)
                     APP_NAME_INSTALL="testdisk"
                     ;;
                     aaxine | cacaxine | fbxine)
                     APP_NAME_INSTALL="xine-console"
                     ;;
                     xz | unxz | xzcat | xzgrep)
                     APP_NAME_INSTALL="xz-utils"
                     ;;
                     esac # End of Install Package Name case statement.
                #
                if [ -d /etc/apt ] ; then 
                   # if /etc/apt directory exists, then use apt-get install
                   # for Debian-based packages.
                   sudo apt-get install $APP_NAME_INSTALL
                   ERROR=$? # Save error flag condition.
                   if [ $ERROR -ne 0 ] ; then
                      # Error code 1 $?=1 means installation failed. Error code 0 (zero) where $?=0 means no error.
                      echo
                      echo "Installation of $APP_NAME_INSTALL failed."
                      echo "Command sudo apt-get install $APP_NAME_INSTALL failed."
                      echo "May be a failure downloading package. Bad Internet connection?"
                      echo
                      f_application_web_install
                   fi
                fi
                #
                if [ -d /var/lib/rpm ] ; then 
                   # if /var/lib/rpm directory exists, then use rpm install
                   # for RPM-based packages.
                   sudo rpm -ivh $APP_NAME_INSTALL 
                   # Assume if not Debian, then Red Hat distro packages.
                   ERROR=$? # Save error flag condition.
                   if [ $ERROR -ne 0 ] ; then
                      # Error code 1 $?=1 means installation failed.
                      # Error code 0 (zero) where $?=0 means no error.
                      echo
                      echo "Installation of $APP_NAME_INSTALL failed."
                      echo "Command sudo rpm -ivh $APP_NAME_INSTALL failed."
                      echo "May be a failure downloading package. Bad Internet connection"
                      echo
                      f_application_web_install
                   fi
                fi
                #
              # if [ -d <slackware installation directory> ] ; then
                   # if <slackware installation directory> exists, then use installpkg
                   # for slackware packages.
                   # sudo installpkg <application package name>"
                   # ERROR=$? # Save error flag condition.
                   # if [ $ERROR -ne 0 ] ; then
                        # Error code 1 $?=1 means installation failed.
                        # Error code 0 (zero) where $?=0 means no error.
                        # echo
                        # echo "Installation of $APP_NAME_INSTALL failed."
                        # echo "Command sudo installpkg $APP_NAME_INSTALL failed."
                        # echo "May be a failure downloading package. Bad Internet connection"
                        # echo
                        # f_application_web_install
                   # fi
              # fi
              #
              # if [ -d <arch linux installation directory> ] ; then
                   # if <arch linux installation directory> exists, then use installpkg
                   # for arch linux packages.
                   # sudo -S <application package name>"
                   # ERROR=$? # Save error flag condition.
                   # if [ $ERROR -ne 0 ] ; then
                        # Error code 1 $?=1 means installation failed.
                        # Error code 0 (zero) where $?=0 means no error.
                        # echo
                        # echo "Installation of $APP_NAME_INSTALL failed."
                        # echo "Command sudo -S $APP_NAME_INSTALL failed."
                        # echo "May be a failure downloading package. Bad Internet connection"
                        # echo
                        # f_application_web_install
                   # fi
              # fi

} # End of function f_application_install
#
#
# +----------------------------------------+
# | Function f_application_web_install     |
# +----------------------------------------+
#
#  Inputs: APP_NAME_INSTALL.
#    Uses: WEB_SITE_INSTALL
#
f_application_web_install () {
      WEB_SITE_INSTALL=""
      case $APP_NAME_INSTALL in # Start of Web Site case statement.
      herrie)
      WEB_SITE_INSTALL="http://herrie.info/#obtaining"
      ;;
      edbrowse)
      WEB_SITE_INSTALL="http://the-brannons.com/edbrowse/"
      ;;
      fbv)
      WEB_SITE_INSTALL="http://freecode.com/projects/fbv"
      ;;
      jfbview)
      WEB_SITE_INSTALL="https://github.com/jichuan89/JFBView.git"
      ;;
      retawq)
      WEB_SITE_INSTALL="http://sourceforge.net/projects/retawq/files/retawq/retawq-0.2.6c/retawq-0.2.6c.tar.gz/download?use_mirror=hivelocity"
      ;;
      portbunny)
      WEB_SITE_INSTALL="http://portbunny.recurity.com/"
      ;;
      clcal)
      WEB_SITE_INSTALL="http://www.hyborian.demon.co.uk/clcal/download.html"
      ;;
      mencal)
      WEB_SITE_INSTALL="http://kyberdigi.cz/projects/mencal/index.php?l=en"
      ;;
      jed)
      WEB_SITE_INSTALL="http://www.jedsoft.org/jed/download.html"
      ;;
      binary-clock)
      WEB_SITE_INSTALL="http://sourceforge.net/projects/binary-clock/files/binary-clock-src/binary-clock-0.5/binary-clock-0.5.tar.gz/download?use_mirror=iweb&download="
      ;;
      cclock)
      WEB_SITE_INSTALL="http://sourceforge.net/projects/cclock/files/latest/download"
      ;;
      clockywock)
      WEB_SITE_INSTALL="http://soomka.com/"
      ;;
      grandfatherclock)
      WEB_SITE_INSTALL="http://freecode.com/projects/grandfatherclock"
      ;;
      asciiaquarium)
      WEB_SITE_INSTALL="http://www.robobunny.com/projects/asciiquarium/html/"
      ;;
      desmume)
      WEB_SITE_INSTALL="http://sourceforge.net/projects/desmume/files/desmume/"
      ;;
      handbrake-cli)
      WEB_SITE_INSTALL="http://handbrake.fr/downloads2.php"
      ;;
      yougrabber)
      WEB_SITE_INSTALL="http://sourceforge.net/projects/yougrabber/files/"
      ;;
      esac                      # End of Web Site case statement.
      #
      case $WEB_SITE_INSTALL in # Start of Web Install case statement.
      "")
      ;;
      *) # if web site is specified, then go there.
         echo
         echo "If application did not install properly, do want to use the w3m web browser"
         echo -n "to visit the project's web site to download manually (y/N)? "
         read ANS
         case $ANS in        # Start of Install case statement.
              [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
              APP_NAME="w3m $WEB_SITE_INSTALL"
              f_how_to_quit_application "q"
              f_application_run
              ;;
              [Nn] | [Nn][Oo])
              ;;
         esac                # End of Install case statement.
      ;;
      esac                         # End of Web Install case statement.
} # End of function f_application_web_install
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
   f_press_enter_key_to_continue
fi
} # End of function f_test_dash
#
# +----------------------------------------+
# |  Function f_menu_scat_sample_template  |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_scat_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of <Sample Template> Application Category until loop.
            #BXC App Cat1
            #BXC App Cat2
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="<Sample Template> Application Category Menu"
            DELIMITER="#BXC" #BXC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of <Sample Template> Application Category case statement.
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][1])
                 f_menu_cat_name1             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][2]) 
                 f_menu_cat_name2             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of <Sample Template> Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of <Sample Template> Application Category until loop.
} # End of function f_menu_scat_sample_template
#
# +----------------------------------------+
# |  Function f_menu_tcat_sample_template  |
# +----------------------------------------+
#
#  Inputs: None
#    Uses: CHOICE_TCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_TCAT
#
f_menu_tcat_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_TCAT -eq 0 ] 
      do    # Start of <Sample Template> Application Category until loop.
            #BXC App Cat1
            #BXC App Cat2
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="<Sample Template> Application Category Menu"
            DELIMITER="#BXC" #BXC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_TCAT
            #
            f_common_tcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_TCAT in # Start of <Sample Template> Application Category case statement.
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][1])
                 f_menu_cat_name1             # Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][2]) 
                 f_menu_cat_name2             # Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of <Sample Template> Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_tcat_bad_menu_choice
      done  # End of <Sample Template> Application Category until loop.
} # End of function f_menu_tcat_sample_template
#
# +----------------------------------------+
# |   Function f_menu_app_sample_template  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of <Sample Template> Applications until loop.
            #MXX appname  - Description Application1 name.
            #MXX app2name - Description Application2 name.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="<Sample Template> Applications Menu"
            DELIMITER="#MXX" #MXX This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of <Sample Template> Applications case statement.
                 'appname '* | 'sudo appname '* | 'sudo appname')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][Nn]*)
                 APP_NAME="appname"
                 f_application_run
                 ;;
                 'app2name '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][2] | [Aa][Pp][Pp][2][Nn]*)
                 APP_NAME="app2name"
                 f_application_run
                 ;;
            esac                # End of <Sample Template> Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of <Sample Template> Applications until loop.
} # End of function f_menu_app_sample_template
#
# **************************************
# ***   Application Categories Menu  ***
# **************************************
#
# Inputs: CHOICE_CAT, MAX.
#
f_menu_cat_applications () {
      f_initvars_menu_app
      until [ $CHOICE_CAT -eq 0 ]
      do    # Start of Application Category until loop.
            #AAB Audio        - Music players, editors, utilities.
            #AAB Education    - Learn something.
            #AAB File/Dir     - copy/move/rename, encrypt, view, find, files/directories.
            #AAB Games        - Fun time!
            #AAB Image        - View images and graphics files.
            #AAB Internet     - Web, e-mail, chat, IM, RSS, ftp, torrents, etc.
            #AAB Network      - Wireless connection, network monitoring, tools.
            #AAB Office       - Editors, spreadsheets, presenters, organizers, calcs, acctg.
            #AAB Screen-saver - For when you're away.
            #AAB System       - Monitor system processes, resources, utilities, etc.
            #AAB Video        - Video players, editors, utilities.
            #
            MENU_TITLE="Application Categories Menu"
            DELIMITER="#AAB" #AAB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_CAT
            #
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_CAT in 
                 # Quit?
                 0) 
                 CHOICE_CAT=0
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu]*)
                 CHOICE_CAT=0
                 ;;
                 [1-9] | [1-9][0-9])
                 if [  $CHOICE_CAT -ge 1 -a $CHOICE_CAT -le $MAX ] ; then
                    CHOICE_CAT=${CHOICE[$CHOICE_CAT]}
                 fi
                 ;;
            esac
            #
            case $CHOICE_CAT in # Start of Application Category case statement.
                 [Aa] | [Aa][Uu]*)
                 f_menu_cat_audio             # Audio Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ee] | [Ee][Dd]*)
                 f_menu_app_education         # Education Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ff] | [Ff][Ii]*)
                 f_menu_cat_file_management   # File Management Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Gg] | [Gg][Aa]*)
                 f_menu_cat_games             # Games Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ii] | [Ii][Mm]*)
                 f_menu_cat_image             # Image-Graphics Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ii] | [Ii][Nn]*)
                 f_menu_cat_internet          # Internet Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Nn] | [Nn][Ee]*)
                 f_menu_cat_network           # Network Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Oo] | [Oo][Ff]*)
                 f_menu_cat_office            # Office Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Cc]*)
                 f_menu_app_screen_savers     # Screen-saver Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Yy]*)
                 f_menu_cat_system            # System Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 [Vv] | [Vv][Ii]*)
                 f_menu_cat_video             # Video Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
            esac # End of Application Category case statement.
            #
      done  # End of Application Category until loop.
} # End of function f_menu_cat_applications
#
# +----------------------------------------+
# |        Function f_menu_cat_audio       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_audio () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of Audio Application Category until loop.
            #BAU CD Rippers         - Copy music off CD-ROM to files.
            #BAU Editors/Converters - Edit music files and convert to different file formats.
            #BAU Music Players      - Play music CD-ROM or music files. Jukebox, playlists.
            #BAU Radio              - Listen to Internet radio stations.
            #BAU Speech Synthesis   - Text-to-speech. Have text files read back to you.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Audio Application Category Menu"
            DELIMITER="#BAU" #BAU This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of Audio Application Category case statement.
                 [Cc] | [Cc][Dd]*)
                 f_menu_app_cdrippers         # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ee] | [Ee][Dd]*)
                 f_menu_app_audio_editors     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Uu]*)
                 f_menu_app_music_players     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Rr] | [Rr][Aa]*)
                 f_menu_app_radio             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Pp]*)
                 f_menu_app_speech_synthesis  # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Audio Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Audio Application Category until loop.
} # End of function f_menu_cat_audio
#
# +----------------------------------------+
# |      Function f_menu_app_cdrippers     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_cdrippers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of CD Rippers Applications until loop.
            #MAC abcde      - Audio CD ripper.
            #MAC acripper   - Audio CD ripper.
            #MAC cdparanoia - Audio CD ripper.
            #MAC crip       - Audio CD ripper.
            #MAC jack       - Audio CD ripper.
            #MAC lxdvdrip   - Audio CD ripper.
            #MAC ripit      - Audio CD ripper.
            #MAC rubyripper - Audio CD ripper.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="CD Rippers Applications Menu"
            DELIMITER="#MAC" #MAC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of CD Rippers Applications case statement.
                 abcde' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Bb]*)
                 APP_NAME="abcde"
                 f_application_run
                 ;;
                 acripper' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Cc]*)
                 APP_NAME="acripper"
                 f_application_run
                 ;;
                 cdparanoia' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Dd]*)
                 APP_NAME="cdparanoia"
                 f_application_run
                 ;;
                 crip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Rr]*)
                 APP_NAME="crip"
                 f_application_run
                 ;;
                 jack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Aa]*)
                 APP_NAME="jack"
                 f_application_run
                 ;;
                 lxdvdrip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Xx]*)
                 APP_NAME="lxdvdrip"
                 f_application_run
                 ;;
                 ripit' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Ii]*)
                 APP_NAME="ripit"
                 f_application_run
                 ;;
                 rubyripper' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Uu]*)
                 APP_NAME="rubyripper"
                 f_application_run
                 ;;
            esac                # End of CD Rippers Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of CD Rippers Applications until loop.
} # End of function f_menu_app_cdrippers
#
# +----------------------------------------+
# |    Function f_menu_app_audio_editors   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_audio_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Audio Editor Applications until loop.
            #MAU avconv   - Audio/Video converter.
            #MAU ecasound - Multitrack audio processing, record, convert, playback, mixing.
            #MAU ffmpeg   - Multimedia Record, convert, stream and playback.
            #MAU sox      - Audio file cut/paste and combine, speed playback.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Audio Editor Applications Menu"
            DELIMITER="#MAU" #MAU This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Audio Editor Applications case statement.
                 avconv' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Aa] | [Aa][Vv]*)
                 APP_NAME="avconv"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 ecasound' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Cc]*)
                 APP_NAME="ecasound"
                 f_application_run
                 ;;
                 ffmpeg' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ff]*)
                 APP_NAME="ffmpeg"
                 f_application_run
                 ;;
                 sox' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Oo]*)
                 APP_NAME="sox"
                 f_application_run
                 ;;
            esac                # End of Audio Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Audio Editor Applications until loop.
} # End of f_menu_app_audio_editors
#
# +----------------------------------------+
# |    Function f_menu_app_music_players   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_music_players () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Music Player Applications until loop.
            #MAP cdcd     - CD player.
            #MAP cmus     - Music player.
            #MAP cplay    - CD player.
            #MAP herrie   - Music player with playlist and file browser on split screen.
            #MAP juke     - Music Jukebox.
            #MAP mcdp     - CD player ncurses-based.
            #MAP moc      - Music player.
            #MAP mpg123   - Music player MPEG 1.0/2.0/2.5 stream (layers 1, 2 and 3).
            #MAP mplayer  - Multimedia player.
            #MAP mplayer2 - Multimedia player.
            #MAP ncmpc    - Music player, ncurses-based.
            #MAP pytone   - Music Jukebox ncurses-based, cross-fading, search, mixer.
            #MAP vlc      - Multimedia VideoLAN player MPEG, MOV, WMV, QT, WebM, MP3, etc.
            #MAP yauap    - Music player based on Gstreamer.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Music Player Applications Menu"
            DELIMITER="#MAP" #MAP This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Music Player Applications case statement.
                 cdcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Dd]*)
                 APP_NAME="cdcd"
                 f_application_run
                 ;;
                 cmus' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Mm]*)
                 APP_NAME="cmus"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 cplay' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Pp]*)
                 APP_NAME="cplay"
                 f_application_run
                 ;;
                 herrie' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ee]*)
                 APP_NAME="herrie"
                 f_application_run
                 ;;
                 juke' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Uu]*)
                 APP_NAME="juke"
                 f_application_run
                 ;;
                 mcdp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Cc]*)
                 APP_NAME="mcdp"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 moc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo]*)
                 APP_NAME="moc"
                 f_application_run
                 ;;
                 mpg123' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp] | [Mm][Pp][Gg]*)
                 APP_NAME="mpg123"
                 f_application_run
                 ;;
                 mplayer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa]*)
                 APP_NAME="mplayer"
                 f_application_run
                 ;;
                 mplayer2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr][2])
                 APP_NAME="mplayer2"
                 f_application_run
                 ;;
                 ncmpc' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Cc]*)
                 f_how_to_quit_application "q"
                 APP_NAME="ncmpc"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 pytone' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Yy]*)
                 APP_NAME="pytone"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 vlc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ll]*)
                 APP_NAME="vlc"
                 f_application_run
                 ;;
                 yauap' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Aa]*)
                 APP_NAME="yauap"
                 f_application_run
                 ;;
            esac                # End of Music Player Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Music Player Applications until loop.
} # End of function f_menu_app_music_players
#
# +----------------------------------------+
# |        Function f_menu_app_radio       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_radio () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Radio Applications until loop.
            #MAR dradio   - Streaming radio on world-wide web.
            #MAR radio    - Streaming radio, ncurses-based.
            #MAR pianobar - Streaming radio player for Pandora Radio.
            #MAR shell-fm - Streaming radio player for last.fm radio.

            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Radio Applications Menu"
            DELIMITER="#MAR" #MAR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Radio Applications case statement.
                 dradio' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Dd] | [Dd][Rr]*)
                 APP_NAME="dradio"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 radio' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Rr] | [Rr][Aa]*)
                 APP_NAME="radio"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 pianobar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="pianobar"
                 f_application_run
                 ;;
                 shell-fm' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Hh]*)
                 APP_NAME="shell-fm"
                 f_application_run
                 ;;
            esac                # End of Radio Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Radio Applications until loop.
} # End of function f_menu_app_radio
#
# +----------------------------------------+
# |  Function f_menu_app_speech_synthesis  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_speech_synthesis () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Speech Synthesis Applications until loop.
            #MAS ebook-speaker - Reads aloud EPUB and MS Reader eBooks.
            #MAS edbrowse      - Audio web browser, editor, and reads aloud email.
            #MAS festival      - Reads text from text files or interactively on screen.
            #MAS screader      - Reads screen text.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Speech Synthesis Applications Menu"
            DELIMITER="#MAS" #MAS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Speech Synthesis Applications case statement.
                 ebook-speaker' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Bb]*)
                 APP_NAME="ebook-speaker"
                 f_application_run
                 ;;
                 edbrowse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Dd]*)
                 APP_NAME="edbrowse"
                 f_application_run
                 ;;
                 festival' '*)
                 f_how_to_quit_application "(quit) including the parenthesis"
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ee]*)
                 APP_NAME="festival"
                 f_how_to_quit_application "(quit) including the parenthesis"
                 f_application_run
                 ;;
                 screader' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="screader"
                 f_application_run
                 ;;
            esac                # End of Speech Synthesis Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Speech Synthesis Applications until loop.
} # End of function f_menu_app_speech_synthesis
#
# +----------------------------------------+
# |     Function f_menu_app_education      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_education () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Education Applications until loop.
            #MED aldo      - Morse code training.
            #MED cw        - Morse code training.
            #MED cwcp      - Morse code training.
            #MED diatheke  - Holy Bible research tool.
            #MED grass     - GIS Map utility (Geographic Information System).
            #MED gtypist   - Typing tutor displays a sentence for practice.
            #MED lifelines - geneology.
            #MED morse     - Morse code training.
            #MED primes    - Prime number calculator. 
            #MED typespeed - Typing tutor displays flying words arcade-style across screen.
           #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Education/Hobby Applications Menu"
            DELIMITER="#MED" #MED This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Education Applications case statement.
                 aldo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Ll]*)
                 APP_NAME="aldo"
                 f_application_run
                 ;;
                 cw' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Ww])
                 APP_NAME="cw"
                 f_application_run
                 ;;
                 cwcp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Ww] | [Cc][Ww][Cc]*)
                 APP_NAME="cwcp"
                 f_application_run
                 ;;
                 diatheke' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ii]*)
                 APP_NAME="diatheke"
                 f_application_run
                 ;;
                 grass' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Rr]*)
                 APP_NAME="grass"
                 f_application_run
                 ;;
                 gtypist' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Gg] | [Gg][Tt]*)
                 APP_NAME="gtypist"
                 f_application_run
                 ;;
                 lifelines' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ii]*)
                 APP_NAME="lifelines"
                 f_application_run
                 ;;
                 morse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo]*)
                 APP_NAME="morse"
                 clear # Blank the screen.
                 echo "morse - text to morse code."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 primes' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Rr]*)
                 APP_NAME="primes"
                 f_application_run
                 ;;
                 typespeed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Yy]*)
                 APP_NAME="typespeed"
                 f_application_run
                 ;;
            esac                # End of Education Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Education Applications until loop.
} # End of f_menu_app_education
#
# +----------------------------------------+
# |  Function f_menu_cat_file_management   |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_file_management () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of File Management Application Category until loop.
            #BFM Backup      - File Backup/archive.
            #BFM CD/DVD Burn - Write files to CD/DVD.
            #BFM Compress    - Compress files.
            #BFM Delete      - Secure deletion of files without recovery.
            #BFM Encryption  - Encrypt/Decrypt files for privacy and security.
            #BFM Find        - File search.
            #BFM FTP/HTTP    - File transfer via FTP, HTTP clients.
            #BFM Managers    - Directory tree views, rename, add/delete, files, folders.
            #BFM Splitters   - File splitters.
            #BFM Undelete    - Recover deleted files.
            #BFM Viewers     - View files a page at a time.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Management Application Category Menu"
            DELIMITER="#BFM" #BFM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Application Category case statement.
                 [Bb] | [Bb][Aa]*)
                 f_menu_app_sys_backup        # System Backup Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Dd]*)
                 f_menu_app_file_burn         # File Burn Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Oo]*)
                 f_menu_app_file_compression  # File Burn Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Dd] | [Dd][Ee]*)
                 f_menu_app_file_deletion     # File Deletion Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ee] | [Ee][Nn]*)
                 f_menu_app_file_encryption   # File Encryption Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ff] | [Ff][Ii]*)
                 f_menu_app_file_find         # File Find Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ff] | [Ff][Tt]*)
                 f_menu_app_file_transfer     # File Transfer Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Aa]*)
                 f_menu_app_file_managers     # File Manager Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Pp]*) 
                 f_menu_app_file_splitters    # File Viewers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Uu] | [Uu][Nn]*)
                 f_menu_app_file_recover      # File Recovery Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Vv] | [Vv][Ii]*)
                 f_menu_app_file_viewers      # File Viewers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of File Management Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of File Management Application Category until loop.
} # End of function f_menu_cat_file_management
#
# +----------------------------------------+
# |      Function f_menu_app_file_burn     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_burn () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Backup Applications until loop.
            #MFB bashburn     - CD burning.
            #MFB burn         - CD burning.
            #MFB cdrecord     - CD burning.
            #MFB mkcd         - CD burning.
            #MFB mybashburn   - CD burning.
            #MFB simpleburner - CD burning.
            #MFB xorriso      - CD burning.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="CD/DVD File Burning Applications Menu"
            DELIMITER="#MFB" #MFB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of CD/DVD File Burning Applications case statement.
                 bashburn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="bashburn"
                 f_application_run
                 ;;
                 burn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Uu]*)
                 APP_NAME="burn"
                 f_application_run
                 ;;
                 cdrecord' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Dd]*)
                 APP_NAME="cdrecord"
                 f_application_run
                 ;;
                 mkcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Kk]*)
                 APP_NAME="mkcd"
                 f_application_run
                 ;;
                 mybashburn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Yy]*)
                 APP_NAME="mybashburn"
                 f_application_run
                 ;;
                 simpleburner' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ii]*)
                 APP_NAME="simpleburner"
                 f_application_run
                 ;;
                 xorriso' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Xx] | [Xx][Oo]*)
                 APP_NAME="xorriso"
                 f_application_run
                 ;;
            esac                # End of CD/DVD File Burning Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of CD/DVD File Burning Applications until loop.
} # End of function f_menu_app_file_burn
#
# +----------------------------------------+
# |  Function f_menu_app_file_compression  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_compression () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Backup Applications until loop.
            #MFC atool  - Manages file archives (tar, gzip, zip etc.).
            #MFC dtrx   - Smart extract tar, zip, deb, rpm, gz, bz2, cab, 7z, lzh, rar, etc.
            #MFC gunzip - File uncompress gzip files.
            #MFC gzip   - File compress, to gzip files.
            #MFC p7zip  - File compress, to 7z files, 7z better than zip compression.
            #MFC unxc   - File uncompress xz files.
            #MFC unzip  - File uncompress zip files.
            #MFC xz     - File compress xz files.
            #MFC xzcat  - File cat xz files.
            #MFC xzgrep - File grep xz files.
            #MFC zip    - File compress files to zip files. 
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Compression Applications Menu"
            DELIMITER="#MFC" #MFC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Compression Applications case statement.
                 atool' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Tt]*)
                 APP_NAME="atool"
                 f_application_run
                 ;;
                 dtrx' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Tt]*)
                 APP_NAME="dtrx"
                 f_application_run
                 ;;
                 gunzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Uu]*)
                 APP_NAME="gunzip"
                 f_application_run
                 ;;
                 gzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Zz]*)
                 APP_NAME="gzip"
                 f_application_run
                 ;;
                 p7zip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][7]*)
                 APP_NAME="p7zip"
                 f_application_run
                 ;;
                 unxz' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Nn][Xx][Zz])
                 APP_NAME="unxz"
                 f_application_run
                 ;;
                 unzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Nn]*)
                 APP_NAME="unzip"
                 f_application_run
                 ;;
                 xz' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Xx] | [Xx][Zz])
                 APP_NAME="xz"
                 f_application_run
                 ;;
                 xzcat' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Xx] | [Xx][Zz] | [Xx][Zz][Cc]*)
                 APP_NAME="xzcat"
                 f_application_run
                 ;;
                 xzgrep' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Xx] | [Xx][Zz] | [Xx][Zz][Gg]*)
                 APP_NAME="xzgrep"
                 f_application_run
                 ;;
                 zip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Zz] | [Zz][Ii]*)
                 APP_NAME="zip"
                 f_application_run
                 ;;
            esac                # End of File Compression Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Compression Applications until loop.
} # End of function f_menu_app_file_compression
#
# +----------------------------------------+
# |   Function f_menu_app_file_encryption  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_encryption () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of File Encryption Applications until loop.
            #MFE bcrypt    - Uses the blowfish encryption algorithm.
            #MFE ccrypt    - Uses the Rijndael cipher algorithm.
            #MFE crypt     - Wrapper for mcrypt, backward compatible to old Unix crypt.
            #MFE lspgpot   - Extracts ownertrust values from PGP keyrings.
            #MFE mcrypt    - a simple crypting program, a replacement for the old Unix crypt.
            #MFE pgp       - Pretty Good Privacy (pgp).
            #MFE scrypt    - Uses the scrypt key derivation function. Better than bcrypt.
            #MFE truecrypt - Program released under TrueCrypt License (not Open-source).
            #MFE zcrypt    - Another crypt program.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Encryption Applications Menu"
            DELIMITER="#MFE" #MFE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Encryption Applications case statement.
                 bcrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Cc]*)
                 APP_NAME="bcrypt"
                 f_application_run
                 ;;
                 ccrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Cc]*)
                 APP_NAME="ccrypt"
                 f_application_run
                 ;;
                 crypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Rr]*)
                 APP_NAME="crypt"
                 f_application_run
                 ;;
                 lspgpot' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss]*)
                 APP_NAME="lspgpot"
                 f_application_run
                 ;;
                 mcrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Cc]*)
                 APP_NAME="mcrypt"
                 f_application_run
                 ;;
                 pgp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Gg]*)
                 APP_NAME="pgp"
                 f_application_run
                 ;;
                 scrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="scrypt"
                 f_application_run
                 ;;
                 truecrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="truecrypt"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 zcrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Zz] | [Zz][Cc]*)
                 APP_NAME="zcrypt"
                 f_application_run
                 ;;
            esac                # End of File Encryption Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Encryption Applications until loop.
} # End of function f_menu_app_file_encryption
#
# +----------------------------------------+
# |      Function f_menu_app_file_find     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_find () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Find File Applications until loop.
            #MFF find     - Find files using pattern matching.
            #MFF locate   - Find files using an internal database, mlocate.
            #MFF updatedb - Update the internal database, mlocate, used by locate.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Find File Applications Menu"
            DELIMITER="#MFF" #MFF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Find File Applications case statement.
                 find' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ii]*)
                 APP_NAME="find --help"
                 clear # Blank the screen.
                 echo "find - Find and search for files."
                 echo
                 echo "Usage:"
                 echo "find [-H] [-L] [-P] [-D debugopts] [-Olevel] [path...] [expression]"
                 echo
                 echo "Example: find file with name *test-file* in directory /home/user/."
                 echo "find -iname /home/user/ *\"test-file1\"*"
                 echo
                 echo "Example: find file and then delete it."
                 echo "find  -iname /home/user/ *\"test-file\"* -exec rm '{}' +"
                 echo
                 echo "*** For more help type: man find" 
                 echo
                 echo "Now run find. Usage: find --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 locate' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Oo]*)
                 APP_NAME="locate --help"
                 clear # Blank the screen.
                 echo "locate - Find and search for files."
                 echo
                 echo "The locate command is dependent on an up-to-date database, mlocate."
                 echo "To update the mlocate database, run the command, 'updatedb'."
                 echo
                 echo "Usage: locate [OPTION]... [PATTERN]..."
                 echo "Search for entries in a mlocate database."

                 echo "  -b, --basename         match only the base name of path names"
                 echo "  -c, --count            only print number of found entries"
                 echo "  -d, --database DBPATH  use DBPATH instead of default database (which is"
                 echo "                         /var/lib/mlocate/mlocate.db)"
                 echo "  -e, --existing         only print entries for currently existing files"
                 echo "  -L, --follow           follow trailing symbolic links when checking file"
                 echo "                         existence (default)"
                 echo "  -i, --ignore-case      ignore case distinctions when matching patterns"
                 echo
                 echo "Example: find all text files in the /usr directory."
                 echo "locate /usr/*.txt"
                 echo
                 echo "Example: find file with name *test-file* in directory /home/user/."
                 echo "locate /home/user/*test-file*"
                 echo
                 echo "*** For more help type: man locate" 
                 echo
                 echo "Now run find. Usage: locate --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 updatedb' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Pp]*)
                 APP_NAME="updatedb"
                 f_application_run
                 ;;
            esac                # End of Find File Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Find File Applications until loop.
} # End of function f_menu_app_file_find
#
# +----------------------------------------+
# |    Function f_menu_app_file_managers   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_managers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of File Manager Applications until loop.
            #MFI clex    - File manager.
            #MFI detox   - File name clean up.
            #MFI dired   - File manager for Emacs.
            #MFI findmnt - Find a filesystem.
            #MFI mc      - File Manager, Midnight Commander.
            #MFI ranger  - File manager.
            #MFI smbc    - Samba file manager for folder shares with Microsoft Windows.
            #MFI vfu     - File manager, ncurses-based.
            #MFI vifm    - File manager with vi-like commands.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Manager Applications Menu"
            DELIMITER="#MFI" #MFI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Manager Applications case statement.
                 clex' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Alt-q" 
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Ll]*)
                 APP_NAME="clex"
                 f_how_to_quit_application "Alt-q" 
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 detox' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ee]*)
                 APP_NAME="detox"
                 f_application_run
                 ;;
                 dired' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ii]*)
                 APP_NAME="dired"
                 f_application_run
                 ;;
                 findmnt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ii]*)
                 APP_NAME="findmnt"
                 f_application_run
                 ;;
                 mc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Cc])
                 APP_NAME="mc"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 ranger' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Rr] | [Rr][Aa]*)
                 APP_NAME="ranger"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 smbc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Mm]*)
                 APP_NAME="smbc"
                 f_application_run
                 ;;
                 vfu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Vv] | [Vv][Ff]*)
                 APP_NAME="vfu"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 vifm' '*)
                 f_how_to_quit_application "the vi command for 'quit' which is ':q' or <colon>+q"
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Vv] | [Vv][Ii]*)
                 APP_NAME="vifm"
                 f_how_to_quit_application "the vi command for 'quit' which is ':q' or <colon>+q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac               # End of File Manager Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Manager Applications until loop.
} # End of f_menu_app_file_managers
#
# +----------------------------------------+
# |   Function f_menu_app_file_splitters   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_splitters () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of File Splitter Applications until loop.
            #MFS lxsplit - Splits/Joins files even greater than 2GB.
            #MFS split   - Splits/Joins files.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Splitter Applications Menu"
            DELIMITER="#MFS" #MFS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Splitter Applications case statement.
                 lxsplit' '* | 'sudo lxsplit '* | 'sudo lxsplit')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Xx]*)
                 APP_NAME="lxsplit"
                 f_application_run
                 ;;
                 split' '* | 'sudo split '* | 'sudo split')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Pp]*)
                 APP_NAME="split --help"
                 clear # Blank the screen.
                 echo "split - Split files into smaller pieces."
                 echo
                 echo "Usage:"
                 echo "split [OPTION]... [INPUT [PREFIX]]"
                 echo
                 echo "Output  fixed-size  pieces of INPUT to PREFIXaa, PREFIXab, ...; default"
                 echo "size is 1000 lines, and default PREFIX is 'x'.  With no INPUT, or  when"
                 echo "INPUT is -, read standard input."
                 echo
                 echo "*** For more help type: man split" 
                 echo
                 echo "Now run find. Usage: split --help"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of File Splitter Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Splitter Applications until loop.
} # End of function f_menu_app_file_splitters
#
# +----------------------------------------+
# |    Function f_menu_app_file_viewers    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_viewers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of File Viewer Applications until loop.
            #MFV less - File viewer and bi-directional pager.
            #MFV more - File viewer pager.
            #MFV most - File viewer and bi-directional pager.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Viewer Applications Menu"
            DELIMITER="#MFV" #MFV This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Viewer Applications case statement.
                 less' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ll] | [Ll][Ee]*)
                 APP_NAME="less"
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
                 more' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Oo] | [Mm][Oo][Rr]*)
                 APP_NAME="more"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 most' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Oo] | [Mm][Oo][Ss]*)
                 APP_NAME="most"
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of File Viewer Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Viewer Applications until loop.
} # End of function f_menu_app_file_viewers
#
# +----------------------------------------+
# |   Function f_menu_app_file_deletion     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_deletion () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of File Recovery Applications until loop.
            #MFD shred - Delete files securely without recovery.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Deletion Applications Menu"
            DELIMITER="#MFD" #MFD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Deletion Applications case statement.
                 shred' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Hh]*)
                 APP_NAME="shred"
                 f_application_run
                 ;;
            esac                # End of File Deletion Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Deletion Applications until loop.
} # End of function f_menu_app_file_deletion
#
# +----------------------------------------+
# |   Function f_menu_app_file_recover     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_recover () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of File Recovery Applications until loop.
            #MFR foremost  - File recovery from within a *.img disk image file.
            #MFR photorec  - File recovery.
            #MFR safecopy  - File recovery.
            #MFR trash-cli - Remembers name, path, date, permissions of each trashed file.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Recovery Applications Menu"
            DELIMITER="#MFR" #MFR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Recovery Applications case statement.
                 foremost' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Oo]*)
                 APP_NAME="foremost --help"
                 clear # Blank the screen.
                 echo "foremost - Recover deleted files."
                 echo
                 echo "Usage:"
                 echo "foremost [-h] [-V] [-d] [-vqwQT] [-b <blocksize>] [-o <dir>] [-t <type>]"
                 echo "         [-s <num>] [-i <file>]"
                 echo
                 echo "Recovers these file-types: jpg, gif, png, bmp, avi, exe, mpg, wav, riff," 
                 echo "wmv, mov, pdf, ole, doc, zip, rar, htm, cpp."
                 echo
                 echo "Examples"
                 echo
                 echo "Run the default case"
                 echo "foremost image.dd"
                 echo
                 echo "Search all defined types"
                 echo "foremost -t all -i image.dd"
                 echo
                 echo "Search for gif and pdf's"
                 echo "foremost -t gif,pdf -i image.dd"
                 echo
                 echo "*** For more help type: man foremost" 
                 echo
                 echo "Now run find. Usage: foremost --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 photorec' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Hh]*)
                 APP_NAME="photorec --help"
                 clear # Blank the screen.
                 echo "photorec - Recover lost files from harddisk, digital camera and cdrom."
                 echo
                 echo "Usage:"
                 echo "photorec [/log] [/debug] [/d recup_dir] [device|image.dd|image.e01]"
                 echo
                 echo           "OPTIONS"
                 echo "         /log   create a photorec.log file"
                 echo "         /debug add debug information"
                 echo
                 echo "*** For more help type: man photorec" 
                 echo
                 echo "Now run photorec. Usage: photorec --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 safecopy' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Aa]*)
                 APP_NAME="safecopy --help"
                 clear # Blank the screen.
                 echo "safecopy - Recover lost data."
                 echo
                 echo "Usage:"
                 echo "safecopy [options] <source> <target>"
                 echo
                 echo "*** For more help type: man safecopy" 
                 echo
                 echo "Now run safecopy. Usage: safecopy --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 trash-cli' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="trash-cli"
                 f_application_run
                 ;;
            esac                # End of File Recovery Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Recovery Applications until loop.
} # End of function f_menu_app_file_recover
#
# +----------------------------------------+
# |       Function f_menu_cat_games        |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_games () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of Application Category until loop.
            #BGA Arcade Games
            #BGA Board Games
            #BGA Card Games
            #BGA MUD (Multi-user Dungeons)
            #BGA Puzzles
            #BGA Quiz Games
            #BGA RPG (Role-Playing Games)
            #BGA Simulation Games
            #BGA Strategy Games
            #BGA Word Games
            #
            MENU_TITLE="Games Category Menu"
            DELIMITER="#BGA" #BGA This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Game Category case statement.
                 [Aa] | [Aa][Rr]*)
                 f_menu_app_games_arcade      # Arcade Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Bb] | [Bb][Oo]*)
                 f_menu_app_games_board       # Board Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Aa]*)
                 f_menu_app_games_card        # Card Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Uu]*)
                 f_menu_app_games_mud         # Mud Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Uu]*)
                 f_menu_app_games_puzzle      # Puzzle Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Qq] | [Qq][Uu]*)
                 f_menu_app_games_quiz        # Quiz Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Rr] | [Rr][Pp]*)
                 f_menu_app_games_rpg         # Role Playing Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Ii]*)
                 f_menu_app_games_simulation  # Simulation Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Tt]*)
                 f_menu_app_games_strategy    # Strategy Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ww] | [Ww][Oo]*)
                 f_menu_app_games_word        # Word Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Game Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Game Category until loop.
} # End of function f_menu_cat_games
#
# +----------------------------------------+
# |    Function f_menu_app_games_arcade    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_arcade () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Arcade Games until loop.
            #MGB asciijump      - Ski jump game.
            #MGB bastet         - Tetris-like game.
            #MGB freesweep      - Minesweeper game.
            #MGB moon-buggy     - Drive a moon buggy on the moon.
            #MGB netris         - Tetris-like game.
            #MGB ninvaders      - Space invaders-like game ncurses-based.
            #MGB pacman4console - Pacman-like game ncurses-based.
            #MGB petris         - Tetris-like game.
            #MGB robots         - Be chased by killer robots.
            #MGB snake          - Be chased by a snake while collecting money.
            #MGB worm           - Be a growing worm, don't crash into yourself.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Arcade Game Menu"
            DELIMITER="#MGB" #MGB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Arcade Games case statement.
                 asciijump' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Aa] | [Aa][Ss]*)
                 APP_NAME="asciijump"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 bastet' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="bastet"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 freesweep' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Rr]*)
                 APP_NAME="freesweep"
                 f_application_run
                 ;;
                 moon-buggy' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Oo]*)
                 APP_NAME="moon-buggy"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 netris' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                 APP_NAME="netris"
                 clear # Blank the screen.
                 echo "netris - Tetris-like game."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 ninvaders' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Ii]*)
                 APP_NAME="ninvaders"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 pacman4console' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Aa]*)
                 APP_NAME="pacman4console"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 # Allows display of error message "Console window must be at least 32x29".
                 ;;
                 petris' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "(lose game and then) type 'q'"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Ee]*)
                 APP_NAME="petris"
                 f_how_to_quit_application "(lose game and then) type 'q'"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 robots' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Rr] | [Rr][Oo]*)
                 APP_NAME="robots"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 snake' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "x"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Nn]*)
                 APP_NAME="snake"
                 f_how_to_quit_application "x"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 worm' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Ctrl-C or crash into wall"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ww] | [Ww][Oo]*)
                 APP_NAME="worm"
                 f_how_to_quit_application "Ctrl-C or crash into wall"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac # End of Arcade Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Arcade Games until loop.
} # End of f_menu_app_games_arcade
#
# +----------------------------------------+
# |     Function f_menu_app_games_board    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_board () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Board Games until loop.
            #MGC atom4      - Board game strategy 2-player ncurses-based.
            #MGC backgammon - Backgammon.
            #MGC monop      - Monopoly-like game.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Board Games Menu"
            DELIMITER="#MGC" #MGC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Board Games case statement.
                 atom4' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Aa] | [Aa][Tt]*)
                 APP_NAME="atom4 -mt"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 backgammon' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="backgammon"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 monop' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q or quit"
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo]*)
                 APP_NAME="monop"
                 f_how_to_quit_application "q or quit" 
                 f_application_run
                 ;;
            esac # End of Board Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Board Games until loop.
} # End of f_menu_app_games_board
#
# +----------------------------------------+
# |     Function f_menu_app_games_card     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_card () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Card Games until loop.
            #MGD canfield - Solitaire card game with betting.
            #MGD cribbage - Cribbage Card game.
            #MGD go-fish  - Go Fish card game.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Card Game Menu"
            DELIMITER="#MGD" #MGD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Card Games case statement.
                 canfield' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Aa]*)
                 APP_NAME="canfield"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 cribbage' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Rr]*)
                 APP_NAME="cribbage"
                 clear # Blank the screen.
                 echo "cribbage - Classic card game for one player vs. the computer."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 go-fish' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Oo]*)
                 APP_NAME="go-fish"
                 f_application_run
                 ;;
            esac # End of Card Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Card Games until loop.
} # End of f_menu_app_games_card
#
# +----------------------------------------+      
# |      Function f_menu_app_games_mud     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_mud () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of MUD Games until loop.
            #MGE crawl    - Explore a cave, retrieve the Orb of Zot.
            #MGE tintin++ - Telnet client to play MUDs (Multi-User Dungeons).
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="MUD Game Menu"
            DELIMITER="#MGE" #MGE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of MUD Games case statement.
                 crawl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] |[Cc][Rr]*)
                 APP_NAME="crawl"
                 f_application_run
                 ;;
                 tintin++' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Ii]*)
                 APP_NAME="tintin++"
                 f_application_run
                 ;;
            esac # End of MUD Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of MUD Games until loop.
} # End of f_menu_app_games_mud
#
# +----------------------------------------+
# |    Function f_menu_app_games_puzzle    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_puzzle () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Puzzle Games until loop.
            #MGF bastet - Tetris-like game.
            #MGF bcd    - Reformat input as a punch card.
            #MGF dab    - 2-players try to complete the most boxes.
            #MGF netris - Tetris-like game.
            #MGF petris - Tetris-like game.
            #MGF ppt    - Reformat input as a paper tape.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Puzzle Game Menu"
            DELIMITER="#MGF" #MGF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Puzzle Games case statement.
                 bastet' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="bastet"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 bcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Cc]*)
                 APP_NAME="bcd"
                 clear # Blank the screen.
                 echo "bcd - Text to computer punch card simulation."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 dab' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Aa]*)
                 APP_NAME="dab"
                 f_application_run
                 ;;
                 netris' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                 APP_NAME="netris"
                 clear # Blank the screen.
                 echo "netris - Tetris-like game."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 petris' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "(lose game and then) type 'q'"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Ee]*)
                 APP_NAME="petris"
                 f_how_to_quit_application "(lose game and then) type 'q'"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 ppt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Pp]*)
                 APP_NAME="ppt"
                 clear # Blank the screen.
                 echo "ppt - Text to teletype paper tape simulation."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
            esac # End of Puzzle Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Puzzle Games until loop.
} # End of f_menu_app_games_puzzle
#
# +----------------------------------------+
# |      Function f_menu_app_games_quiz    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_quiz () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Quiz Games until loop.
            #MGG arithmetic - Basic arithmetic quiz.
            #MGG geekcode   - Code tells others how geeky you are.
            #MGG morse      - Morse code training.
            #MGG quiz       - Quiz with choice of assorted topics.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Quiz Game Menu"
            DELIMITER="#MGG" #MGG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Quiz Games case statement.
                 arithmetic' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Ctrl-Z"
                 f_application_run
                 ;;
                 [Aa] |[Aa][Rr]*)
                 APP_NAME="arithmetic"
                 echo "arithmetic - Quiz on basic arithmetic."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 geekcode' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Gg] | [Gg][Ee]*)
                 APP_NAME="geekcode"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 morse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo]*)
                 APP_NAME="morse"
                 clear # Blank the screen.
                 echo "morse - text to morse code."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 quiz' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Qq] | [Qq][Uu]*)
                 APP_NAME="quiz"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
            esac # End of Quiz Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Quiz Games until loop.
} # End of f_menu_app_games_quiz
#
# +----------------------------------------+
# |      Function f_menu_app_games_rpg     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_rpg () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of RPG Games until loop.
            #MGH adventure  - Explore Colossal Cave. 
            #MGH battlestar - Tropical adventure game.
            #MGH hack       - Explore the Dungeons of Doom.
            #MGH nethack    - Retrieve the Amulet of Yendor in the  20th dungeon level.
            #MGH phantasia  - Fight monsters and other players.
            #MGH slashem    - Enter the Dungeons of Doom.
            #MGH wump       - Hunt the Wumpus, watch out for bats, pits.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="RPG Game Menu"
            DELIMITER="#MGH" #MGH This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of RPG Games case statement.
                 adventure' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "quit"
                 f_application_run
                 ;;
                 [Aa] | [Aa][Dd]*)
                 APP_NAME="adventure"
                 f_how_to_quit_application "quit"
                 f_application_run
                 ;;
                 battlestar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="battlestar"
                 f_application_run
                 ;;
                 hack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [hH] | [hH][Aa]*)
                 APP_NAME="hack"
                 f_application_run
                 ;;
                 nethack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                 APP_NAME="nethack-console"
                 f_application_run
                 ;;
                 phantasia' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Hh]*)
                 APP_NAME="phantasia"
                 f_application_run
                 ;;
                 slashem' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ll]*)
                 APP_NAME="slashem"
                 f_application_run
                 ;;
                 wump' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Uu]*)
                 APP_NAME="wump"
                 f_application_run
                 ;;
            esac # End of RPG Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of RPG Games until loop.
} # End of f_menu_app_games_rpg
#
# +----------------------------------------+
# |  Function f_menu_app_games_simulation  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_simulation () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Simulation Games until loop.
            #MGI atc       - Air traffic controller.
            #MGI sail      - Command a Man O'War fighting ship.
            #MGI star wars - Star Wars movie in ASCII.
            #MGI trek      - Star Trek blast Klingons.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Simulation Games Menu"
            DELIMITER="#MGI" #MGI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Simulation Games case statement.
                 atc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Tt]*)
                 APP_NAME="atc"
                 echo "atc - Air Traffic Controller Game"
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 sail' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] |[Ss][Aa]*)
                 APP_NAME="sail"
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] |[Ss][Tt] | [Ss][Tt][Aa]*)
                 APP_NAME="telnet towel.blinkenlights.nl"
                 clear # Blank the screen.
                 echo "Star Wars ASCII Movie"
                 echo
                 echo The movie is played by running command:
                 echo telnet towel.blinkenlights.nl
                 echo
                 echo If telnet hangs while trying the ip-address,
                 echo then re-run this program and try again.
                 echo
                 echo "To quit Star Wars ASCII Movie, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running Star Wars ASCII Movie will exit this menu script."
                 echo
                 echo -n "Run Star Wars ASCII Movie and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 trek' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "at the prompt Command: terminate"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="trek"
                 f_how_to_quit_application "at the prompt Command: terminate"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac # End of Simulation Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Simulation Games until loop.
} # End of f_menu_app_games_simulation
#
# +----------------------------------------+
# |   Function f_menu_app_games_strategy   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_strategy () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Strategy Games until loop.
            #MGJ gomoku   - 2-player game of 5-in-a-row.
            #MGJ hunt     - Multi-user game. Kill everyone else.
            #MGJ mille    - Travel 700 miles card game.
            #MGJ wargames - Computer prompt from movie "War Games". 
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Strategy Game Menu"
            DELIMITER="#MGJ" #MGJ This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Strategy Games case statement.
                 gomoku' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Gg] | [Gg][Oo]*)
                 APP_NAME="gomoku"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 hunt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Hh] | [Hh][Uu]*)
                 APP_NAME="hunt"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 mille' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Mm] | [Mm][Ii]*)
                 APP_NAME="mille"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 wargames' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Aa]*)
                 APP_NAME="wargames"
                 clear # Blank the screen.
                 echo "wargames - Question asked by the WOPR super-computer."
                 echo
                 echo "From the 1983 movie 'WarGames' starring Matthew Broderick, Ally Sheedy,"
                 echo "Dabney Coleman, and John Wood. David (Matthew Broderick) unknowingly hacks into"
                 echo "the backdoor of a top-secret U.S. Air Force super-computer."
                 echo "The WOPR (War Operation Planned Response) controls the U.S. nuclear arsenal."
                 echo
                 echo "Notice the computer equipment David uses, the acoustic modem, and floppy drive."
                 echo
                 echo "WOPR asks this question when David first hacks the backdoor, making David think"
                 echo "that it is simply a recreational program."
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac # End of Strategy Games case statement
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Strategy Games until loop.
} # End of f_menu_app_games_strategy
#
# +----------------------------------------+
# |     Function f_menu_app_games_word     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_word () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Word Games until loop.
            #MGK boggle  - Word search game.
            #MGK hangman - Classic hangman word game.
            #MGK pig     - Converts text into pig-latin.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Word Game Menu"
            DELIMITER="#MGK" #MGK This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Word Games case statement.
                 boggle' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Oo]*)
                 APP_NAME="boggle"
                 f_application_run
                 ;;
                 hangman' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Aa]*)
                 APP_NAME="hangman"
                 f_application_run
                 ;;
                 pig' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="pig"
                 echo "pig - Converts text to Pig Latin"
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
            esac # End of Word Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Word Games until loop.
} # End of f_menu_app_games_word
#
# +----------------------------------------+
# |       Function f_menu_cat_image        |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_image () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of Image Application Category until loop.
            #BIG ImageMagick - Tools to manipulate images.
            #BIG Tools       - Viewers, ASCII Art, format converters, etc. 
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Image Application Category Menu"
            DELIMITER="#BIG" #BIG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Image Application Category case statement.
                 [Ii] | [Ii][Mm]*)
                 f_menu_app_imagemagick       # ImageMagic Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Tt] | [Tt][Oo]*)
                 f_menu_app_image_graphics    # Image Graphics Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Image Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Image Application Category until loop.
} # End of function f_menu_cat_image
#
# +----------------------------------------+
# |    Function f_menu_app_image_graphics   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_image_graphics () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Image-Graphics Applications until loop.
            #MIG aview      - Image and ascii art image viewer.
            #MIG caca-utils - Image viewer and converter jpg to ascii images.
            #MIG fbi        - Image viewer PhotoCD, jpeg, ppm, gif, tiff, xwd, bmp, png, etc.
            #MIG fbv        - Image viewer framebuffer console.
            #MIG fim        - Image and ascii art image viewer.
            #MIG hasciicam  - ASCII web camera images.
            #MIG jfbview    - Image viewer and framebuffer PDF viewer based on Imlib2.
            #MIG jp2a       - Convert jpg images to ascii images.
            #MIG linuxlogo  - Color ANSI system logo
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Image-Graphics Applications Menu"
            DELIMITER="#MIG" #MIG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Image-Graphics Applications case statement.
                 aview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Vv]*)
                 APP_NAME="aview"
                 f_application_run
                 ;;
                 caca-utils' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Aa]*)
                 APP_NAME="caca-utils"
                 f_application_run
                 ;;
                 fbi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb] | [Ff][Bb][Ii])
                 APP_NAME="fbi"
                 f_application_run
                 ;;
                 fbv' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb] | [Ff][Bb][Vv])
                 APP_NAME="fbv"
                 f_application_run
                 ;;
                 fim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ii]*)
                 APP_NAME="fim"
                 f_application_run
                 ;;
                 hasciicam' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Aa]*)
                 APP_NAME="hasciicam"
                 f_application_run
                 ;;
                 jfbview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Ff]*)
                 APP_NAME="jfbview"
                 f_application_run
                 ;;
                 jp2a' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Pp]*)
                 APP_NAME="jp2a"
                 f_application_run
                 ;;
                 linuxlogo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ii]*)
                 ANS=-1 # Initialize $ANS for until loop.
                 until [ $ANS -ge 1 -a $ANS -le 26 ]
                 do
                       clear # Blank the screen.
                       APP_NAME="linuxlogo -L list"
                       f_application_run
                       echo -n "Enter number (1-26): "
                       read ANS
                 done
                 #
                 APP_NAME="linuxlogo -L "$ANS
                 f_application_run
                 ;;
            esac                # End of Image-Graphics Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Image-Graphics Applications until loop.
} # End of f_menu_app_image_graphics
#
# +----------------------------------------+
# |    Function f_menu_app_imagemagick    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_imagemagick () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of ImageMagick Applications until loop.
            #MIK animate   - ImageMagick tool animates an image sequence on X-windows GUI.
            #MIK composite - ImageMagick tool overlaps one image on top of another.
            #MIK compare   - ImageMagick tool annotate differences between image versions.
            #MIK conjure   - ImageMagick tool run Magick Scripting Language (MSL).
            #MIK convert   - ImageMagick tool converts format, resize, crop, flip, etc.
            #MIK display   - ImageMagick tool display image on X-windows GUI.
            #MIK identify  - ImageMagick tool show format, characteristics of image files.
            #MIK import    - ImageMagick tool Screen capture on X-windows GUI.
            #MIK mogrify   - ImageMagick tool resize, blur, crop, dither, flip, join etc.
            #MIK montage   - ImageMagick tool create a composite image from many images.
            #MIK stream    - ImageMagick tool stream image to an archive format.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="ImageMagick Applications Menu"
            DELIMITER="#MIK" #MIK This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of ImageMagick Applications case statement.
                 animate' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Nn]*)
                 APP_NAME="animate"
                 f_application_run
                 ;;
                 composite' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo] | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Oo]*)
                 APP_NAME="composite"
                 f_application_run
                 ;;
                 compare' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo] | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Aa]*)
                 APP_NAME="compare"
                 f_application_run
                 ;;
                 conjure' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Jj] | [Cc][Oo][Nn][Jj]*)
                 APP_NAME="conjure"
                 f_application_run
                 ;;
                 convert' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Vv]*)
                 APP_NAME="convert"
                 f_application_run
                 ;;
                 display' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ii]*)
                 APP_NAME="display"
                 f_application_run
                 ;;
                 identify' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Dd]*)
                 APP_NAME="identify"
                 f_application_run
                 ;;
                 import' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Mm]*)
                 APP_NAME="import"
                 f_application_run
                 ;;
                 mogrify' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo] | [Mm][Oo][Gg]*)
                 APP_NAME="mogrify"
                 f_application_run
                 ;;
                 montage' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Oo] | [Mm][Oo][Nn]*)
                 APP_NAME="montage"
                 f_application_run
                 ;;
                 stream' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Tt]*)
                 APP_NAME="stream"
                 f_application_run
                 ;;
            esac                # End of ImageMagick Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of ImageMagick Applications until loop.
} # End of f_menu_app_imagemagick
#
# +----------------------------------------+
# |      Function f_menu_cat_internet      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_internet () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of Internet Category until loop.
            #BIN Bittorrent        - File transfer.
            #BIN Downloaders       - Download files and calculate file checksums. 
            #BIN Email             - Email clients.
            #BIN FAX               - FAX clients.
            #BIN FTP/HTTP          - File transfer via FTP, HTTP clients.
            #BIN Instant Messaging - AIM/ICQ, Yahoo!, MSN, IRC, Jabber/XMPP/Google Talk...
            #BIN IRC Clients       - Internet Relay Chat clients.
            #BIN LAN Chat          - Local Area Network Chat (not IRC).
            #BIN News Readers      - Read USEnet news.
            #BIN Podcatcher        - Podcaster readers.
            #BIN Remote Connection - Connect to other PCs remotely.
            #BIN RSS Feeders       - RSS news, messages.
            #BIN Web Browsers      - Internet web  browsers.
            #
            MENU_TITLE="Internet Category Menu"
            DELIMITER="#BIN" #BIN This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Internet Category case statement.
                 [Bb] | [Bb][Ii]*)
                 f_menu_app_bittorrent        # Bittorrent Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Dd] | [Dd][Oo]*)
                 f_menu_app_downloaders       # Downloaders Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ee] | [Ee][Mm]*)
                 f_menu_app_email             # Email Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop. 
                 ;;
                 [Ff] | [Ff][Aa]*)
                 f_menu_app_fax               # FAX Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ff] | [Ff][Tt]*)
                 f_menu_app_file_transfer     # File Transfer Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ii] | [Ii][Nn]*)
                 f_menu_app_instant_messaging #Instant Messaging Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ii] | [Ii][Rr]*)
                 f_menu_app_irc_clients       # IRC Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ll] | [Ll][Aa]*)
                 f_menu_app_lan_chat          # LAN Chat Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Nn] | [Nn][Ee]*)
                 f_menu_app_news_readers      # News Readers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Oo]*)
                 f_menu_app_podcatchers       # Podcatcher Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Mm]*)
                 f_menu_app_remote_connection # Remote Connection Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Rr] | [Rr][Ss]*)
                 f_menu_app_rssfeeders        # RSS Feeder Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ww] | [Ww][Ee]*)
                 f_menu_app_web_browsers      # Web Browser Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                # End of Internet Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Internet Category until loop.
} # End of function f_menu_cat_internet
#
# +----------------------------------------+
# |    Function f_menu_app_web_browsers    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_web_browsers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Web Browsers Applications until loop.
            #MWB elinks  - Web browser, tables, frames, forms support, tabbed browsing.
            #MWB links   - Web browser, no graphics mode.
            #MWB links2  - Web browser, has graphics mode.
            #MWB lynx    - Web browser, NLS support.
            #MWB retawq  - Web browser, multi-threaded.
            #MWB surfraw - Search the web using a web search site.
            #MWB w3m     - Web browser, tables, frames support, IPv6 support.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Web Browser Applications Menu"
            DELIMITER="#MWB" #MWB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Web Browser Applications case statement.
                 elinks' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Ee] | [Ee][Ll]*)
                 APP_NAME="elinks"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 links' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss] | [Ll][Ii][Nn][Kk][Ss]) 
                 APP_NAME="links"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 links2' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss] | [Ll][Ii][Nn][Kk][Ss][2] | [Ll][Ii][Nn][Kk][Ss][2])
                 APP_NAME="links2"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 lynx' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_application_run
                 ;;
                 [Ll] | [Ll][Yy]*)
                 APP_NAME="lynx"
                 f_web_site
                 f_application_run
                 ;;
                 retawq' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Aa]*)
                 APP_NAME="retawq"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 surfraw' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Uu]*)
                 APP_NAME="surfraw"
                 f_application_run
                 ;;
                 w3m' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Ww] | [Ww][3]*)
                 APP_NAME="w3m"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
            esac                # End of Web Browsers Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Web Browsers Applications until loop.
} # End of function f_menu_app_web_browsers
#
# +----------------------------------------+
# |          Function f_web_site           |
# +----------------------------------------+
#
#  Inputs: APP_NAME.
# Outputs: APP_NAME, WEB_SITE, PRESS_KEY.
#
f_web_site () {
case $APP_NAME in # Start of case statement.
     #
     # The order of the case pattern matching clauses is necessary.
     #
     # Does $APP_NAME start with 'sudo'?
     # Does $APP_NAME have no spaces?
     # If so, treat as a web browser without a specified web site.
     #
     'sudo '*) # Starts with 'sudo' command.
     # If so, 2nd word is an application option and not a web site.
     # Assumed format: sudo w3m
     # It is assumed that users who do "sudo <application name> <options>"
     # know what they are doing and do not need to be prompted to provide
     # a web site and do not call f_web_site in the application case statments.
     #
     # The application case statements will not allow any other sudo
     # formats i.e. sudo -width 80 links -driver atheos -html-images 0.
     # To accomodate all formats would require extensive parsing and
     # differentiating between an option and a web site.
     #
     APP_NAME_SUDO=$(echo $APP_NAME | awk '{print $2;}')
     # awk -F '#M' '{if ($2&&!$3){print $2}}' | awk '{sub(/[^" "]+ /, ""); print $0}' | more -d
     # APP_OPT=$(echo APP_NAME 
     # WEB_SITE=$(echo $APP_NAME | awk '{print $2;}')
     echo
     echo "When using the web browser or network application directly from the command line,"
     echo "use the syntax: $APP_NAME WEB_SITE"
     echo
     echo -n "Enter the name of the web site: "
     read WEB_SITE
     #
     # If no web site specified, default to a web site. Note the test command
     # has $WEB_SITE in quotes because it may not be set prior to this test.
     if [ -z "$WEB_SITE" ] ; then
         WEB_SITE="http://www.lxer.com"
     fi
     #
     APP_NAME="$APP_NAME $WEB_SITE"
     PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
     ;;
     *[!' ']*) # It has no spaces in name.
     echo
     echo "When using a web browser or network application directly from the command line,"
     echo "use the syntax: $APP_NAME WEB_SITE"
     echo
     echo -n "Enter the name of the web site: (i.e. www.lxer.com) "
     read WEB_SITE
     #
     # If no web site specified, default to a web site. Note the test command
     # has $WEB_SITE in quotes because it may not be set prior to this test.
     if [ -z "$WEB_SITE" ] ; then
         WEB_SITE="http://www.lxer.com"
     fi
     #
     APP_NAME="$APP_NAME $WEB_SITE"
     PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
     ;;
     # Does $APP_NAME have space followed by dash?
     # If so, 2nd word is an application option and not a web site.
     #
     *' '[\-]*) # Space followed by dash in name. Same as ' -'*) pattern.
                 # The pattern ' '[\-] is the same as ' -' pattern.
                 # The dash is usually used in range pattern [0-9] [a-zA-Z]
                 # but the back-slash makes dash interpreted as literal dash.
     # No action needs to be taken. Invoking application option not a web site.
     #
     echo
     echo "There is no web site specified, just a "-option" invoking an application option"
     echo "and not a web site."
     echo
    WEB_SITE="" 
    PRESS_KEY=1 # Display "Press 'Enter' key to continue."
     ;;
     # Does $APP_NAME have space not followed by dash?
     # If so, 2nd word treated as a web site.
     #
     *' '[!\-]*) # Space not followed by dash. Assume 2nd word is the web site.
     # WEB_SITE=$(echo $APP_NAME | awk '{print $2;}') # TEST LINE.
     # APP_NAME=$(echo $APP_NAME | awk '{print $1;}') # TEST LINE.
     # echo $APP_NAME to browse in $WEB_SITE          # TEST LINE.
     # f_press_enter_key_to_continue                  # TEST LINE.
     #
     PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
     ;;
esac # End of case statement.
} # End of function f_web_site
#
# +----------------------------------------+
# |      Function f_menu_app_bittorrent    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_bittorrent () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Bittorrent Applications until loop.
            #MBT aria2c       - Downloader supports BitTorrent/HTTP/HTTPS/FTP/Metalink.
            #MBT bittornado   - Torrent file transfer.
            #MBT bittorrent   - Torrent file transfer.
            #MBT ctorrent     - Torrent file transfer.
            #MBT deluge       - Torrent downloader, user-interfaces GTK+, web, console.
            #MBT mldonkey     - Downloader supports BitTorrent/eDonkey/HTTP/FTP.
            #MBT rtorrent     - Torrent file transfer.
            #MBT transmission - Torrent client web, console, Mac, GTK+ and Qt GUI clients.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Bittorrent Applications Menu"
            DELIMITER="#MBT" #MBT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Bittorrent Applications case statement.
                 aria2c' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr]*)
                 APP_NAME="aria2c" # aria2c is included in package aria2. There is no application "aria2".
                 f_application_run
                 ;;
                 bittornado' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn]*)
                 APP_NAME="bittornado"
                 f_application_run
                 ;;
                 bittorrent' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr]*)
                 APP_NAME="bittorrent"
                 f_application_run
                 ;;
                 ctorrent' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Tt]*)
                 APP_NAME="ctorrent"
                 f_application_run
                 ;;
                 deluge' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ee]*)
                 APP_NAME="deluge"
                 f_application_run
                 ;;
                 mldonkey' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ll]*)
                 APP_NAME="mldonkey"
                 f_application_run
                 ;;
                 rtorrent' '*) 
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Tt]*)
                 APP_NAME="rtorrent"
                 f_application_run
                 ;;
                 transmission' '*) 
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="transmission"
                 f_application_run
                 ;;
            esac                # End of Bittorrent Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Bittorrent Applications until loop.
} # End of function f_menu_app_bittorrent
#
# +----------------------------------------+
# |     Function f_menu_app_downloaders    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_downloaders () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Downloaders Applications until loop.
            #MDL aria2c   - Downloader supports HTTP/HTTPS/FTP/BitTorrent/Metalink.
            #MDL md5pass  - Create a password hash. Usage: md5pass [PASSWORD][SALT]
            #MDL md5sum   - Display md5 checksum. Usage: md5sum [OPTION] [FILE]
            #MDL sha1pass - Create a password hash. Usage: sha1pass [PASSWORD][SALT]
            #MDL sha1sum  - Display sha1 checksum. Usage: sha1sum [OPTION] [FILE]
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Downloader-Checksum Applications Menu"
            DELIMITER="#MDL" #MDL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Dowloader Applications case statement.
                 aria2c' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr]*)
                 APP_NAME="aria2c" # aria2c is included in package aria2. There is no application "aria2".
                 f_application_run
                 ;;
                 md5pass' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Dd] | [Mm][Dd][5] | [Mm][Dd][5][Pp]*)
                 APP_NAME="md5pass"
                 clear # Blank the screen.
                 echo "md5pass - Create a password hash."
                 echo
                 echo "Usage:"
                 echo "md5pass [PASSWORD] [SALT]"
                 echo
                 echo "*** For more help type: man md5pass"
                 echo
                 echo "md5pass without any SALT value causes a random salt value to be generated."
                 echo "Now run md5pass. Usage: 'md5pass'."
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 md5sum' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm][ | [Mm][Dd] | [Mm][Dd][5] | [Mm][Dd][5][Ss]*)
                 APP_NAME="man md5sum"
                 clear # Blank the screen.
                 echo "md5sum - Display md5 checksum."
                 echo
                 echo "Usage:"
                 echo "md5sum [OPTION]... [FILE]..."
                 echo
                 echo "*** For more help type: md5sum --hep"
                 echo "Now show help. Usage: man md5sum"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 sha1pass' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Hh] | [Ss][Hh][Aa] | [Ss][Hh][Aa][1] | [Ss][Hh][Aa][1][Pp]*)
                 APP_NAME="sha1pass"
                 clear # Blank the screen.
                 echo "sha1pass - Create a password hash."
                 echo
                 echo "Usage:"
                 echo "sha1pass [PASSWORD] [SALT]"
                 echo "*** For more help type: man sha1pass"
                 echo
                 echo "sha1pass without any SALT value causes a random salt value to be generated."
                 echo "Now run sha1pass. Usage: 'sha1pass'."
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 sha1sum' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Hh] | [Ss][Hh][Aa] | [Ss][Hh][Aa][1] | [Ss][Hh][Aa][1][Ss]*)
                 APP_NAME="man sha1sum"
                 clear # Blank the screen.
                 echo "sha1sum - Display sha1 checksum."
                 echo
                 echo "Usage:"
                 echo "sha1sum [OPTION]... [FILE]..."
                 echo
                 echo "*** For more help type: sha1sum --help"
                 echo "Now show help. Usage: man sha1sum"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of Downloader Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Downloaders Applications until loop.
} # End of function f_menu_app_downloaders
#
# +----------------------------------------+
# |        Function f_menu_app_email       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_email () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of E-mail Applications until loop.
            #MEM alpine         - E-mail client, FOSS version of pine.
            #MEM cone           - E-mail client.
            #MEM elmo           - E-mail client.
            #MEM fetchyahoo     - E-mail client.
            #MEM gnus           - Email, NNTP, RSS client for Emacs.
            #MEM heirloom-mailx - E-mail client.
            #MEM mu4e           - Email client for Emacs.
            #MEM mutt           - E-mail client.
            #MEM nedmail        - E-mail client.
            #MEM pine           - E-mail client.
            #MEM sup            - E-mail client.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="E-mail Applications Menu"
            DELIMITER="#MEM" #MEM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of E-mail Applications case statement.
                 alpine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Ll]*)
                 APP_NAME="alpine"
                 f_application_run
                 ;;
                 cone' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo]*)
                 APP_NAME="cone"
                 f_application_run
                 ;;
                 elmo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Ll]*)
                 APP_NAME="elmo"
                 f_application_run
                 ;;
                 fetchyahoo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ee]*)
                 APP_NAME="fetchyahoo"
                 f_application_run
                 ;;
                 gnus' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg]  | [Gg][Nn]*)
                 APP_NAME="gnus"
                 f_application_run
                 ;;
                 heirloom-mailx' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ee]*)
                 APP_NAME="heirloom-mailx"
                 f_application_run
                 ;;
                 mu4e' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][4] | [Mm][Uu][4]*)
                 APP_NAME="mu4e"
                 f_application_run
                 ;;
                 mutt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Uu] | [Mm][Uu][Tt]*)
                 APP_NAME="mutt"
                 f_application_run
                 ;;
                 nedmail' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                 APP_NAME="nedmail"
                 f_application_run
                 ;;
                 pine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="pine"
                 f_application_run
                 ;;
                 supp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Uu]*)
                 APP_NAME="supp"
                 f_application_run
                 ;;
            esac                # End of E-mail Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of E-mail Applications until loop.
} # End of function f_menu_app_email
#
# +----------------------------------------+
# |         Function f_menu_app_fax        |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_fax () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of FAX Applications until loop.
            #MFX efax           - FAX over modem.
            #MFX hylafax-client - Works with HylaFAX server software.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="FAX Applications Menu"
            DELIMITER="#MFX" #MFX This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of FAX Applications case statement.
                 efax' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Ff]*)
                 APP_NAME="efax"
                 f_application_run
                 ;;
                 hylafax-client' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Yy]*)
                 APP_NAME="hylafax-client"
                 f_application_run
                 ;;
            esac                # End of FAX Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of FAX Applications until loop.
} # End of function f_menu_app_fax
#
# +----------------------------------------+
# |   Function f_menu_app_file_tranfer     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_transfer () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of File Transfer Applications until loop.
            #MFT cmdftp - File transfer client.
            #MFT curl   - File transfer.
            #MFT ftp    - File transfer.
            #MFT ftpfs  - File transfer client.
            #MFT lftp   - Sophisticated sftp/ftp/http download/upload client program.
            #MFT ncftp  - File transfer client.
            #MFT scp    - File transfer.
            #MFT woof   - Woof (Web Offer One File) copies files via the HTTP protocol.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Transfer Applications Menu"
            DELIMITER="#MFT" #MFT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Transfer Applications case statement.
                 cmdftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Mm]*)
                 APP_NAME="cmdftp"
                 f_application_run
                 ;;
                 curl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Uu]*)
                 APP_NAME="curl"
                 f_application_run
                 ;;
                 ftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Tt] | [Ff][Tt][Pp])
                 APP_NAME="ftp"
                 f_application_run
                 ;;
                 ftpfs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Tt] | [Ff][Tt][Pp] | [Ff][Tt][Pp][Ff]*)
                 APP_NAME="ftpfs"
                 f_application_run
                 ;;
                 lftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ff]*)
                 APP_NAME="lftp"
                 f_application_run
                 ;;
                 ncftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Cc]*)
                 APP_NAME="ncftp"
                 f_application_run
                 ;;
                 scp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="scp"
                 f_application_run
                 ;;
                 woof' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [WW][Oo]*)
                 APP_NAME="woof"
                 f_application_run
                 ;;
            esac                # End of File Transfer Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of File Transfer Applications until loop.
} # End of function f_menu_app_file_transfer
#
# +----------------------------------------+
# | Function f_menu_app_instant_messaging  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_instant_messaging () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Internet Messaging Applications until loop.
            #MIM barnowl      - BarnOwl supports AIM, IRC, Jabber, Zephyr.
            #MIM bitlbee      - Jabber, Google Talk, Facebook, ICQ, AIM, MSN, Yahoo! Twitter.
            #MIM centericq    - Supports the ICQ2000, Yahoo, AIM, MSN, IRC and Jabber.
            #MIM centerim     - Supports the ICQ2000, Yahoo, AIM, MSN, IRC and Jabber.
            #MIM emacs-jabber - Jabber client for Emacs.
            #MIM finch        - AIM/ICQ, Yahoo, MSN, IRC, Jabber/XMPP/Google Talk, Napster.
            #MIM freetalk     - Jabber client.
            #MIM mcabber      - Jabber client.          	
            #MIM naim         - Supports AIM, IRC, ICQ, Lily, CMC.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Instant Messaging Applications Menu"
            DELIMITER="#MIM" #MIM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Instant Messaging Applications case statement.
                 barnowl' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application ":q (colon q)" "no-clear"
                 f_application_run
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="barnowl"
                 clear # Blank the screen.
                 echo "BarnOwl - Internet Messenger."
                 echo
                 echo "Usage:"
                 echo "barnowl"
                 echo "Inside barnowl type ':help' (colon help) for built-in help page."
                 echo
                 echo "*** For more help type: man barnowl"
                 echo
                 echo "Now run barnowl. Usage: barnowl"
                 echo
                 f_how_to_quit_application ":q (colon q)" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 bitlbee' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ii]*)
                 APP_NAME="bitlbee"
                 f_application_run
                 ;;
                 centericq' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Cc]*)
                 APP_NAME="centericq"
                 f_application_run
                 ;;
                 centerim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Mm])
                 APP_NAME="centerim"
                 f_application_run
                 ;;
                 emacs-jabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee][Mm]*)
                 APP_NAME="emacs-jabber"
                 f_application_run
                 ;;
                 finch' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ii]*)
                 APP_NAME="finch"
                 f_application_run
                 ;;
                 freetalk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Rr]*)
                 APP_NAME="freetalk"
                 f_application_run
                 ;;
                 mcabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Cc]*)
                 APP_NAME="mcabber"
                 f_application_run
                 ;;
                 naim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Aa]*)
                 APP_NAME="naim"
                 f_application_run
                 ;;
            esac                # End of Instant Messaging Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Instant Messaging Applications until loop.
} # End of function f_menu_app_instant_messaging
#
# +----------------------------------------+
# |    Function f_menu_app_irc_clients     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_irc_clients () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of IRC Clients Applications until loop.
            #MIR epic5   - IRC client based on ircI.
            #MIR erc     - IRC client for Emacs, powerful, modular, and extensible.
            #MIR ii      - Minimalist FIFO and filesystem-based IRC client. Based on sic.
            #MIR ircii   - Termcap based interface. Supports "/encrypt -cast".
            #MIR irssi   - Supports SILC and ICB protocols via plugins.
            #MIR pork    - Ncurses-based AOL Instant Messenger and IRC client.
            #MIR scrollz - An advanced, faster IRC client based on ircII code.
            #MIR sic     - Fast small IRC client.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="IRC Clients Applications Menu"
            DELIMITER="#MIR" #MIR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of IRC Clients Applications case statement.
                 epic' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Pp]*)
                 APP_NAME="epic"
                 f_application_run
                 ;;
                 erc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Rr]*)
                 APP_NAME="erc"
                 f_application_run
                 ;;
                 ii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] |[Ii][Ii])
                 APP_NAME="ii"
                 f_application_run
                 ;;
                 ircii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Rr] | [Ii][Rr][Cc]*)
                 APP_NAME="ircii"
                 f_application_run
                 ;;
                 irssi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Rr] | [Ii][Rr][Ss]*)
                 APP_NAME="irssi"
                 f_application_run
                 ;;
                 pork' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Oo]*)
                 APP_NAME="pork"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 scrollz' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="scrollz"
                 f_application_run
                 ;;
                 sic' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ii]*)
                 APP_NAME="sic"
                 f_application_run
                 ;;
            esac                # End of IRC Clients Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of IRC Clients Applications until loop.
} # End of function f_menu_app_irc_clients
#
# +----------------------------------------+
# |     Function f_menu_app_news_readers    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_news_readers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of RSS Feeder Applications until loop.
            #MNR gnus - News reader and E-mail client for Emacs.
            #MNR nn   - News reader.
            #MNR rn   - News reader.
            #MNR slrn - News reader.
            #MNR tin  - News reader.
            #MNR trn  - News reader.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="News Reader Applications Menu"
            DELIMITER="#MNR" #MNR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of News Reader Applications case statement.
                 gnus' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Nn]*)
                 APP_NAME="gnus"
                 f_application_run
                 ;;
                 nn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Nn]) 
                 APP_NAME="nn"
                 f_application_run
                 ;;
                 rn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Nn])
                 APP_NAME="rn"
                 f_application_run
                 ;;
                 slrn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ll]*)
                 APP_NAME="slrn"
                 f_application_run
                 ;;
                 tin' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Ii] | [Tt][Ii][Nn])
                 APP_NAME="tin"
                 f_application_run
                 ;;
                 trn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="trn"
                 f_application_run
                 ;;
            esac                # End of News Reader Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of News Reader Applications until loop.
} # End of function f_menu_app_news_readers
#
# +----------------------------------------+
# |      Function f_menu_app_lan_chat      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_lan_chat () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of LAN Chat Applications until loop.
            #MNC talk    - Copies lines from your terminal to that of another user.
            #MNC weechat - WeeChat (Wee Enhanced Environment for Chat) fast, light client.
            #MNC ytalk   - Multi-user chat program can do multiple connections.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="LAN Chat Applications Menu"
            DELIMITER="#MNC" #MNC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of LAN Chat Applications case statement.
                 talk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Aa]*)
                 APP_NAME="talk"
                 f_application_run
                 ;;
                 weechat' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Ee]*)
                 APP_NAME="weechat"
                 f_application_run
                 ;;
                 ytalk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Tt]*)
                 APP_NAME="ytalk"
                 f_application_run
                 ;;
            esac                # End of LAN Chat Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of LAN Chat Applications until loop.
} # End of function f_menu_app_lan_chat
#
# +----------------------------------------+
# |     Function f_menu_app_podcatchers     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_podcatchers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Podcatcher Applications until loop.
            #MPO bashpodder - Podcatcher.
            #MPO goldenpod  - Podcatcher.
            #MPO hpodder    - Podcatcher.
            #MPO podget     - Podcatcher.
            #MPO podracer   - Podcatcher.
            #MPO uraniacast - Podcatcher.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Podcatcher Applications Menu"
            DELIMITER="#MPO" #MPO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Podcatcher Applications case statement.
                 bashpodder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Aa]*)
                 APP_NAME="bashpodder"
                 f_application_run
                 ;;
                 goldenpod' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Oo]*)
                 APP_NAME="goldenpod"
                 f_application_run
                 ;;
                 hpodder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Pp]*)
                 APP_NAME="hpodder"
                 f_application_run
                 ;;
                 podget' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Gg]*)
                 APP_NAME="podget"
                 f_application_run
                 ;;
                 podracer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Rr]*)
                 APP_NAME="podracer"
                 f_application_run
                 ;;
                 uraniacast' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Rr]*)
                 APP_NAME="uraniacast"
                 f_application_run
                 ;;
            esac                # End of Podcatcher Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Podcatcher Applications until loop.
} # End of function f_menu_app_podcatchers
#
# +----------------------------------------+
# |  Function f_menu_app_remote_connection |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_remote_connection () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Remote Connection Applications until loop.
            #MRC cpu     - Remote connection.
            #MRC openssh - Remote connection.
            #MRC ssh     - Remote connection.
            #MRC sslh    - Remote connection.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Remote Connection Applications Menu"
            DELIMITER="#MRC" #MRC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Remote Connection Applications case statement.
                 cpu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Pp]*)
                 APP_NAME="cpu"
                 f_application_run
                 ;;
                 openssh' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Oo] | [Oo][Pp]*)
                 APP_NAME="openssh"
                 f_application_run
                 ;;
                 ssh' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ss] | [Ss][Ss][Hh])
                 APP_NAME="ssh"
                 f_application_run
                 ;;
                 sslh' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ss] | [Ss][Ss][Ll] | [Ss][Ss][Ll]*)
                 APP_NAME="sslh"
                 f_application_run
                 ;;
            esac                # End of Remote Connection Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Remote Connection Applications until loop.
} # End of function f_menu_app_remote_connection
#
# +----------------------------------------+
# |     Function f_menu_app_rssfeeders      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_rssfeeders () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of RSS Feeder Applications until loop.
            #MRS canto      - RSS feeder.
            #MRS newsbeuter - RSS feeder.
            #MRS nrss       - RSS feeder.
            #MRS olive      - RSS feeder.
            #MRS raggle     - RSS feeder.
            #MRS rawdog     - RSS feeder.
            #MRS rsstail    - RSS feeder.
            #MRS snownews   - RSS feeder.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="RSS Feeder Applications Menu"
            DELIMITER="#MRS" #MRS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of RSS Feeder Applications case statement.
                 canto' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Aa]*)
                 APP_NAME="canto"
                 f_application_run
                 ;;
                 newsbeuter' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                 APP_NAME="newsbeuter"
                 f_application_run
                 ;;
                 nrss' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Rr]*)
                 APP_NAME="nrss"
                 f_application_run
                 ;;
                 olive' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Oo] | [Oo][Ll]*)
                 APP_NAME="olive"
                 f_application_run
                 ;;
                 raggle' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Aa] | [Rr][Aa][Gg]*)
                 APP_NAME="raggle"
                 f_application_run
                 ;;
                 rawdog' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Aa] | [Rr][Aa][Ww]*)
                 APP_NAME="rawdog"
                 f_application_run
                 ;;
                 rsstail' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Ss]*)
                 APP_NAME="rsstail"
                 f_application_run
                 ;;
                 snownews' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Nn]*)
                 APP_NAME="snownews"
                 f_application_run
                 ;;
            esac                # End of RSS Feeder Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of RSS Feeder Applications until loop.
} # End of function f_menu_app_rssfeeders
#
# +----------------------------------------+
# |       Function f_menu_cat_network      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_network () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of Network Application Category until loop.
            #BNE Firewalls    - Configure firewalls.
            #BNE LAN-WAN      - Test network connectivity, speed, routing.
            #BNE Monitors     - LAN monitors, network mappers.
            #BNE NIC Tools    - Configure wired/wireless cards, scan for wireless networks.
            #BNE Packet Tools - Packet sniffers, packet analyzers.
            #BNE Sharing      - Share files on NetWare & Microsoft Windows PCs/networks.
            #
            MENU_TITLE="Network Application Category Menu"
            DELIMITER="#BNE" #BNE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Network Application Category case statement.
                 [Ff] | [Ff][Ii]*)
                 f_menu_app_firewalls         # Firewall Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ll] | [Ll][Aa]*)
                 f_menu_app_lanwan            # LANWAN Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Oo]*)
                 f_menu_tcat_network_monitors # Network Monitors Category Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Nn] | [Nn][Ii]*)
                 f_menu_app_nic_tools         # NIC Tools Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Aa]*)
                 f_menu_app_packet_tools      # Packet Tools Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Hh]*)
                 f_menu_app_network_sharing   # Network Sharing Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                # End of Network Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Network Application Category until loop.
} # End of function f_menu_cat_network
#
# +----------------------------------------+
# |      Function f_menu_app_firewalls     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_firewalls () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Firewall Applications until loop.
            #MNF arptables - Firewall configuration rules for an ARP chain.
            #MNF iptables  - Firewall configuration rules for an IP chain.
            #MNF iptstate  - Monitor traffic in IP Tables state table; ncurses based display.
            #MNF portbunny - Port scanner created by Recurity Labs.
            #MNF strobe    - Port scanner.
            #MNF ufw       - Firewall configuration and status.
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Firewall Applications Menu"
            DELIMITER="#MNF" #MNF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Firewall Applications case statement.
                 arptables' '* | 'sudo arptables '* | 'sudo arptables')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr]*)
                 APP_NAME="sudo arptables --list"
                 clear # Blank the screen.
                 echo "arptables - Administration tool for ARP tables."
                 echo
                 echo "Usage:"
                 echo "arptables [-t table] -[AD] chain rule-specification [options]"
                 echo "arptables [-t table] -[RI] chain rulenum rule-specification [options]"
                 echo "arptables [-t table] -D chain rulenum [options]"
                 echo "arptables [-t table] -[LFZ] [chain] [options]"
                 echo "arptables [-t table] -[NX] chain"
                 echo "arptables [-t table] -E old-chain-name new-chain-name"
                 echo "arptables [-t table] -P chain target [options]"
                 echo
                 echo "arptables  is  a user space tool, it is used to set up and maintain the"
                 echo "tables of ARP rules in the Linux kernel. These rules  inspect  the  ARP"
                 echo "frames  which  they  see.   arptables is analogous to the iptables user"
                 echo "space tool, but arptables is less complicated."
                 echo
                 echo "*** For more help type: man arptables"
                 echo
                 echo "List all ARP chains on this PC (localhost)."
                 echo
                 echo "Now run arptables. Usage: sudo arptables --list"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 iptables' '* | 'sudo iptables '* | 'sudo iptables')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Aa]*)
                 APP_NAME="iptables --list"
                 clear # Blank the screen.
                 echo "iptables - Administration tool for IPv4 packet filtering and NAT."
                 echo
                 echo "Usage:"
                 echo "iptables [-t table] {-A|-C|-D} chain rule-specification"
                 echo
                 echo "*** For more help type: man iptables"
                 echo
                 echo "List all chains of the IPv4 packet filter (firewall) on this PC (localhost)."
                 echo
                 echo "Now run iptables. Usage: iptables --list"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 iptstate' '* | 'sudo iptstate '* | 'sudo iptstate')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Ss]*)
                 APP_NAME="iptstate"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 portbunny' '* | 'sudo portbunny '* | 'sudo portbunny')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Oo]*)
                 APP_NAME="portbunny"
                 clear # Blank the screen.
                 echo "portbunny - Fast TCP-SYN port scanner."
                 echo
                 echo "Usage:"
                 echo "portbunny <HOST>"
                 echo
                 echo "*** For more help type: man portbunny"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 strobe' '* | 'sudo strobe '* | 'sudo strobe')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Tt]*)
                 APP_NAME="strobe"
                 f_application_run
                 ;;
                 ufw' '* | 'sudo ufw '* | 'sudo ufw')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Ff]*)
                 APP_NAME="ufw status verbose"
                 clear # Blank the screen.
                 echo "ufw - Manage the netfilter firewall."
                 echo
                 echo "Usage:"
                 echo "ufw [--dry-run] enable|disable|reload"
                 echo "ufw [--dry-run] default allow|deny|reject [incoming|outgoing]"
                 echo "ufw [--dry-run] logging on|off|LEVEL"
                 echo "ufw [--dry-run] reset"
                 echo "ufw [--dry-run] status [verbose|numbered]"
                 echo "ufw [--dry-run] show REPORT"
                 echo "ufw [--dry-run] [delete] [insert NUM] allow|deny|reject|limit [in|out]"
                 echo "    [log|log-all] PORT[/protocol]"
                 echo "ufw [--dry-run] [delete] [insert NUM] allow|deny|reject|limit [in|out"
                 echo "    on INTERFACE] [log|log-all] [proto protocol]"
                 echo "    [from ADDRESS [port PORT]] [to ADDRESS [port PORT]]"
                 echo "ufw [--dry-run] delete NUM"
                 echo "ufw [--dry-run] app list|info|default|update"
                 echo
                 echo "Display ufw firewall status of this PC (localhost) as an example."
                 echo
                 echo "Now run ufw. Usage: ufw status verbose"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of Firewall Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Firewall Applications until loop.	
} # End of function f_menu_app_firewalls
#
# +----------------------------------------+
# |       Function f_menu_app_lanwan       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_lanwan () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of LAN/WAN Applications until loop.
            #MNL arping      - Check LAN connectivity by pinging MAC, IP address or hostname.
            #MNL dig         - Query Internet domain name servers.
            #MNL ip          - Shows routing, devices, policy routing and tunnels.
            #MNL ip addr     - protocol (IP or IPv6) address on a device.
            #MNL ip link     - Shows network device.
            #MNL ip neighbor - ARP or NDISC cache entry.
            #MNL ip route    - Shows routing.
            #MNL mtr         - Traceroute tool, has features of ping and traceroute.
            #MNL nslookup    - Query Internet domain name servers.
            #MNL ping        - Check LAN/WAN connectivity by pinging IP address or hostname.
            #MNL route       - Shows routing table.
            #MNL speedometer - Check LAN/WAN connectivity speed.
            #MNL ss          - Show sockets, PACKET, TCP, UDP, DCCP, RAW, state filtering.
            #MNL traceroute  - Traceroute tool, trace network path to destination. 
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="LAN/WAN Applications Menu"
            DELIMITER="#MNL" #MNL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of LAN/WAN Applications case statement.
                 'sudo arping')
                 APP_NAME="sudo arping localhost -c 5"
                 f_application_run
                 ;;
                 arping' '* | 'sudo arping '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr]*)
                 APP_NAME="arping localhost -c 5"
                 clear # Blank the screen.
                 echo "arping - Send ICMP ECHO_REQUEST to network hosts."
                 echo
                 echo "Usage:"
                 echo "arping [-fqbDUAV] [-c count] [-w timeout] [-I device] [-s source] destination"
                 echo "       -f : quit on first reply"
                 echo "       -q : be quiet"
                 echo "       -b : keep broadcasting, don't go unicast"
                 echo "       -D : duplicate address detection mode"
                 echo "       -U : Unsolicited ARP mode, update your neighbours"
                 echo "       -A : ARP answer mode, update your neighbours"
                 echo "       -V : print version and exit"
                 echo "       -c count : how many packets to send"
                 echo "       -w timeout : how long to wait for a reply"
                 echo "       -I device : which ethernet device to use (eth0)"
                 echo "       -s source : source ip address"
                 echo "       destination : ask for what ip address"
                 echo
                 echo "*** For more help type: man arping" 
                 echo
                 echo "Arpinging this PC (localhost) for 5 times as an example."
                 echo
                 echo "Now run arping. Usage: arping localhost -c 5"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 dig' '* | 'sudo dig '* | 'sudo dig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ii] | [Dd][Ii][Gg])
                 APP_NAME="dig"
                 f_application_run
                 ;;
                 ip' '* | 'sudo ip '* | 'sudo ip')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp])
                 APP_NAME="ip"
                 clear # Blank the screen.
                 echo "IP - manipulate routing, devices, policy routing and tunnels."
                 echo
                 echo "Usage:"
                 echo "ip [ OPTIONS ] OBJECT { COMMAND | help }"
                 echo
                 echo "OBJECT := { link | addr | addrlabel | route | rule | neigh | tunnel | maddr |"
                 echo " mroute }"
                 echo "link      - network device."
                 echo "address   - protocol (IP or IPv6) address on a device."
                 echo "addrlabel - label configuration for protocol address selection."
                 echo "neighbour - ARP or NDISC cache entry."
                 echo "route     - routing table entry."
                 echo "rule      - rule in routing policy database."
                 echo "maddress  - multicast address."
                 echo "mroute    - multicast routing cache entry."
                 echo "tunnel    - tunnel over IP."
                 echo
                 echo "OPTIONS := { -V[ersion] | -s[tatistics] | -r[esolve] | -f[amily] { inet | inet6"
                 echo "             | ipx | dnet | link } | -o   OBJECT"
                 echo
                 echo "*** For more help type: man ip" 
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 'ip addr '* | 'sudo ip addr '* | 'sudo ip addr')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Aa]*)
                 APP_NAME="ip addr"
                 f_application_run
                 ;;
                 'ip link '* | 'sudo ip link '* | 'sudo ip link')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Ll]*)
                 APP_NAME="ip link"
                 f_application_run
                 ;;
                 'ip neighbor '* | 'sudo ip neighbor '* | 'sudo ip neighbor')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Nn]*)
                 APP_NAME="ip neighbor"
                 f_application_run
                 ;;
                 'ip route '* | 'sudo ip route '* | 'sudo ip route')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Rr]*)
                 APP_NAME="ip route"
                 f_application_run
                 ;;
                 mtr' '* | 'sudo mtr '* | 'sudo mtr')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Tt]*)
                 APP_NAME="mtr"
                 clear # Blank the screen.
                 echo "mtr - Network diagnostic tool with the functionality of traceroute and ping."
                 echo
                 echo "Usage:"
                 echo "mtr [-hvrctglspniu46]  [--help] [--version] [--report] [--report-wide]"
                 echo "    [--report-cycles COUNT] [--curses] [--split] [--raw] [--no-dns] [--gtk]"
                 echo "    [--address IP.ADD.RE.SS] [--interval SECONDS] [--psize BYTES | -s BYTES]"
                 echo "    HOSTNAME [PACKETSIZE]"
                 echo
                 echo "*** For more help type: man mtr" 
                 echo
                 echo "mtr of this PC (localhost) as an example."
                 echo
                 echo "Now run mtr. Usage: mtr localhost"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 nslookup' '* |  'sudo nslookup '*)
                 APP_NAME=$CHOICE_APP
                 # f_web_site # Don't use f_web_site since web site may have already been entered.
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 'sudo nslookup')
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Ss]*)
                 APP_NAME="nslookup"
                 f_web_site
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 ping' '* | 'sudo ping '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 'sudo ping')
                 APP_NAME="sudo ping localhost -c 5"
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="ping localhost -c 5"
                 clear # Blank the screen.
                 echo "ping - Send ICMP ECHO_REQUEST to network hosts."
                 echo
                 echo "Usage:"
                 echo "ping  [-LRUbdfnqrvVaAB] [-c count] [-m mark] [-i interval] [-l preload]"
                 echo "      [-p pattern] [-s packetsize] [-t ttl] [-w deadline] [-F flowlabel]"
                 echo "      [-I interface]  [-M  hint] [-N nioption] [-Q tos] [-S sndbuf]"
                 echo "      [-T timestamp option] [-W timeout] [hop ...] destination"
                 echo
                 echo "Usage: ping destination where destination may be an IP-address or url."
                 echo "       i.e. ping 192.168.1.1 or ping www.sourceforge.net"
                 echo
                 echo "*** For more help type: man ping" 
                 echo
                 echo "Pinging this PC (localhost) for 5 times as an example."
                 echo
                 echo "Now run ping. Usage: ping localhost -c 5"
                 echo
                 echo "Many web sites block pings resulting in a message: '100% packet loss'."
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 route' '* | 'sudo route '* | 'sudo route')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Oo]*)
                 APP_NAME="route"
                 f_application_run
                 ;;
                 speedometer' '* | 'sudo speedometer '* | 'sudo speedometer')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Pp]*)
                 APP_NAME="speedometer"
                 f_application_run
                 ;;
                 ss' '* | 'sudo ss '* | 'sudo ss')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ss])
                 APP_NAME="ss"
                 clear # Blank the screen.
                 echo "ss - Display TCP/UDP Network and Socket Information."
                 echo
                 echo "Usage:"
                 echo  "ss [options] [ FILTER ]"
                 echo "    -h, --help      Show summary of options."
                 echo "    -a, --all       Display  both  listening  and  non-listening sockets."
                 echo "    -l, --listening Display only listening sockets."
                 echo "    -e, --extended  Show detailed socket information"
                 echo "    -m, --memory    Show socket memory usage."
                 echo "    -p, --processes Show process using socket."
                 echo "    -i, --info      Show internal TCP information."
                 echo "    -s, --summary   Print summary statistics."
                 echo "    -4, --ipv4      Display only IP version 4 sockets (alias for -f inet)."
                 echo "    -6, --ipv6      Display only IP version 6 sockets (alias for -f inet6)."
                 echo "    -0, --packet    Display PACKET sockets (alias for -f link)."
                 echo "    -t, --tcp       Display TCP sockets."
                 echo "    -u, --udp       Display UDP sockets."
                 echo "    -d, --dccp      Display DCCP sockets."
                 echo "    -w, --raw       Display RAW sockets."
                 echo
                 echo "*** For more help type: man ss" 
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 traceroute' '* | 'sudo traceroute '* )
                 APP_NAME=$CHOICE_APP
                 # f_web_site # Don't use f_web_site since web site may have already been entered.
                 f_application_run
                 ;;
                 'sudo traceroute')
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="traceroute"
                 clear # Blank the screen.
                 echo "traceroute - Trace path to network host."
                 echo
                 echo "Usage:"
                 echo "traceroute [-46dFITUnreAV] [-f first_ttl] [-g gate,...]"
                 echo "           [-i device] [-m max_ttl] [-p port] [-s src_addr]"
                 echo "           [-q nqueries] [-N squeries] [-t tos] [-l flow_label]"
                 echo "           [-w waittime] [-z sendwait] [-UL] [-P proto] [--sport=port]"
                 echo "           [-M method] [-O mod_options] [--mtu] [--back]"
                 echo "host [packet_len]"
                 echo "traceroute6  [options]"
                 echo "tcptraceroute  [options]"
                 echo "lft  [options]"
                 echo
                 echo "*** For more help type: man traceroute" 
                 echo
                 echo "traceroute of this PC (localhost) as an example."
                 echo
                 echo "Now run traceroute. Usage: traceroute <URL or web-site or IP-address>"
                 f_press_enter_key_to_continue
                 f_web_site
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
            esac                # End of LAN/WAN Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of LAN/WAN Applications until loop.
} # End of function f_menu_app_lanwan
#
# +----------------------------------------+
# |      Function f_menu_app_nic_tools     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_nic_tools () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of NIC Tools Applications until loop.
            #MNN ethtool      - NIC configuration.
            #MNN ifconfig     - NIC configuration.
            #MNN ifplugstatus - Wireless USB NIC status.
            #MNN iwconfig     - Wireless NIC configuration.
            #MNN iwlist       - Get detailed information from wired/wireless interface.
            #MNN mii-tool     - NIC configuration of Media Independent Interface Unit.
            #MNN mii-diag     - NIC configuration of network cards.
            #MNN netload      - NIC network load; ncurses based.
            #MNN nictools-pci - NIC configuration of specific oem network cards.
            #MNN wicd-curses  - Wireless scan and connect to wired/wireless networks.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="NIC Tools Applications Menu"
            DELIMITER="#MNN" #MNN This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of NIC Tools Applications case statement.
                 ethtool' '* | 'sudo ethtool '* | 'sudo ethtool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Tt]*)
                  clear # Blank the screen.
                  echo "ethtool - Query and control network driver and hardware settings."
                  echo
                  echo "Usage:" 
                  echo "ethtool <options> <NIC device name>"
                  echo
                  echo "*** For more help type: man ethtool" 
                  echo
                  echo "Now run ethtool. Usage: ethtool -i <NIC device name>"
                  echo "Option -i shows network driver information for <NIC device name>"
                  f_press_enter_key_to_continue
                  f_find_NIC
                  APP_NAME="ethtool -i $ANS"
                 f_application_run
                 ;;
                 ifconfig' '* | 'sudo ifconfig '* | 'sudo ifconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Ff] | [Ii][Ff][Cc]*)
                 APP_NAME="ifconfig"
                 f_application_run
                 ;;
                 ifplugstatus' '* | 'sudo ifplugstatus '* | 'sudo ifplugstatus')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Ff] | [Ii][Ff][Pp]*)
                 APP_NAME="ifplugstatus"
                 f_application_run
                 ;;
                 iwconfig' '* | 'sudo iwconfig '* | 'sudo iwconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Ww] | [Ii][Ww][Cc]*)
                 APP_NAME="iwconfig"
                 f_application_run
                 ;;
                 iwlist' '* | 'sudo iwlist '* | 'sudo iwlist')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Ww] | [Ii][Ww][Ll]*)
                 APP_NAME="iwlist"
                 f_application_run
                 ;;
                 mii-diag' '* | 'sudo mii-diag '* | 'sudo mii-diag')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ii] | [Mm][Ii][Ii] | [Mm][Ii][Ii][-] | [Mm][Ii][Ii][-][Dd]*)
                 APP_NAME="mii-diag"
                 f_application_run
                 ;;
                 mii-tool' '* | 'sudo mii-tool '* | 'sudo mii-tool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ii] | [Mm][Ii][Ii] | [Mm][Ii][Ii][-] | [Mm][Ii][Ii][-][Tt]*)
                 APP_NAME="mii-tool"
                 f_application_run
                 ;;
                 netload' '* | 'sudo netload '* | 'sudo netload')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee]*)
                  f_find_NIC
                  APP_NAME="netload $ANS"
                 f_application_run
                 ;;
                 nictools-pci' '* | 'sudo nictools-pci '* | 'sudo nictools-pci')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ii]*)
                 APP_NAME="nictools-pci"
                 f_application_run
                 ;;
                 wicd-curses' '* | 'sudo wicd-curses '* | 'sudo wicd-curses')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ww] | [Ww][Ii]*)
                 APP_NAME="wicd-curses"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of NIC Tools Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of NIC Tools Applications until loop.
} # End of function f_menu_app_nic_tools
#
# +----------------------------------------+
# |   Function f_menu_app_network_sharing  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_network_sharing () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Network Configuration Applications until loop.
            #MNS ncpfs     - NetWare file/printer server utilities; nprint, pserver.
            #MNS smbc      - Samba file manager for folder shares with Microsoft Windows.
            #MNS smbclient - Samba client (share folders with Microsoft Windows).
            #MNS smbstatus - Samba files lock status.
            #MNS testparm  - Samba configuration display.
            #MNS woof      - Woof (Web Offer One File) copies files via the HTTP protocol.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Sharing Applications Menu"
            DELIMITER="#MNS" #MNS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Network Sharing Applications case statement.
                 ncpfs' '* | 'sudo ncpfs '* | 'sudo ncpfs')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Cc]*)
                 APP_NAME="ncpfs"
                 f_application_run
                 ;;
                 smbc' '* | 'sudo smbc '* | 'sudo smbc')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc])
                 APP_NAME="man smbc"
                 clear # Blank the screen.
                 echo "man smbc - Display help for smbc (Samba Commander)."
                 echo
                 echo "Use on networks with Microsoft Windows PCs."
                 echo
                 echo "Now show help. Usage: man smbc"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 smbclient' '* | 'sudo smbclient '* | 'sudo smbclient')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc] | [Ss][Mm][Bb][Cc][Ll]*)
                 APP_NAME="smbclient"
                 f_application_run
                 ;;
                 smbstatus' '* | 'sudo smbstatus '* | 'sudo smbstatus')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Ss]*)
                 APP_NAME="smbstatus"
                 f_application_run
                 ;;
                 testparm' '* | 'sudo testparm '* | 'sudo testparm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Ee]*)
                 APP_NAME="testparm"
                 f_application_run
                 ;;
                 woof' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [WW][Oo]*)
                 APP_NAME="woof"
                 f_application_run
                 ;;
            esac                # End of Network Sharing Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Network Sharing Applications until loop.
} # End of function f_menu_app_network_sharing
#
# +----------------------------------------+
# |  Function f_menu_tcat_network_monitors |
# +----------------------------------------+
#
#  Inputs: None
#    Uses: CHOICE_TCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_TCAT
#
f_menu_tcat_network_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_TCAT -eq 0 ] 
      do    # Start of Network Monitor Application Category until loop.
            #BNM Bandwidth - Bandwidth monitors.
            #BNM Structure - Management, status, connections, devices, hosts.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Monitor Application Category Menu"
            DELIMITER="#BNM" #BNM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_TCAT
            #
            f_common_tcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_TCAT in # Start of Network Monitor Application Category case statement.
                 [Bb] | [Bb][Aa]*) 
                 f_menu_app_network_bandwidth # Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Tt]*) 
                 f_menu_app_network_monitors  # Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Network Monitor Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_tcat_bad_menu_choice
      done  # End of Network Monitor Application Category until loop.
} # End of function f_menu_tcat_network_monitors
#
# +----------------------------------------+
# |   Function f_menu_app_network_monitors |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_network_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Network Monitor Applications until loop.
            #MNM iptraf   - IP LAN monitor, ncurses based display.
            #MNM nagios3  - IP LAN monitor. Display network hosts, devices, connections.
            #MNM nc       - Netcat reads/writes data across network.
            #MNM netstat  - Print network connections, routing tables, interface stats, etc.
            #MNM netwatch - Protocol monitor; ncurses based.
            #MNM ntop     - Display network usage and status information in a web browser.
            #MNM opennms  - Network management application. Discovery, reports, statistics.
            #MNM pmacct   - Traffic information monitor.
            #MNM slurm    - Network interface I/O load monitor.
            #MNM sntop    - IP LAN monitor. Display network hosts and connections.
            #MNM vnstat   - Traffic information monitor.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Monitor Applications Menu"
            DELIMITER="#MNM" #MNM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Network Monitor Applications case statement.
                 iptraf' '* | 'sudo iptraf '* | 'sudo iptraf')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ii] | [Ii][Pp]*)
                 APP_NAME="iptraf"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 nagios3' '* | 'sudo nagios3 '* | 'sudo nagios3')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Aa]*)
                 APP_NAME="nagios3"
                 clear # Blank the screen.
                 echo "nagios3 - network/systems status monitoring daemon."
                 echo
                 echo "nagios3  is a daemon program that monitors the status of various network"
                 echo "accessible systems, devices, and more.  For more information, please consult"
                 echo "the online documentation available at http://www.nagios.org, or on your"
                 echo "nagios server's web page."
                 echo
                 echo "Usage:"
                 echo "nagios3 [-h] [-v] [-s] [-d] <main_config_file>"
                 echo
                 echo "*** For more help type: man nagios3" 
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 nc' '* | 'sudo nc '* | 'sudo nc')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Cc])
                 APP_NAME="nc"
                 f_application_run
                 ;;
                 netstat' '* | 'sudo netstat '* | 'sudo netstat')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ss]*)
                 APP_NAME="netstat -l"
                 clear # Blank the screen.
                 echo "netstat - Print network connections, routing tables, interface statistics,"
                 echo "          masquerade connections, and multicast memberships."
                 echo
                 echo "Usage:"
                 echo "netstat [address_family_options]  [--tcp|-t] [--udp|-u] [--raw|-w]"
                 echo "[--listening|-l] [--all|-a] [--numeric|-n] [--numeric-hosts]  ...etc."
                 echo
                 echo "netstat {--route|-r}  [address_family_options] [--extend|-e[--extend|-e]]"
                 echo "[--verbose|-v]  [--numeric|-n]  [--numeric-hosts]   [--numeric-ports] ...etc."
                 echo
                 echo "netstat {--interfaces|-i}  [--all|-a] [--extend|-e[--extend|-e]] ...etc."
                 echo
                 echo "netstat {--groups|-g} [--numeric|-n] [--numeric-hosts] [--numeric-ports] ..etc."
                 echo
                 echo "netstat {--masquerade|-M} [--extend|-e] [--numeric|-n] [--numeric-hosts] ..etc."
                 echo
                 echo "netstat {--statistics|-s} [--tcp|-t] [--udp|-u] [--raw|-w]"
                 echo
                 echo "*** For more help type: man traceroute" 
                 echo
                 echo "netstat of this PC (localhost) as an example."
                 echo
                 echo "Now run netstat. Usage: netstat -l"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 ;;
                 netwatch' '* | 'sudo netwatch '* | 'sudo netwatch')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ww]*)
                 f_find_NIC
                 APP_NAME="netwatch -e $ANS"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 ntop' '* | 'sudo ntop '* | 'sudo ntop')
                 APP_NAME=$CHOICE_APP
                 clear # Blank the screen.
                 echo "ntop - Traffic probe with network usage."
                 echo
                 echo "This command starts the ntop process."
                 echo "To use ntop, open a web browser to URL localhost:3000 or 127.0.0.1:3000"
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 [Nn] | [Nn][Tt]*)
                 APP_NAME="sudo ntop"
                 clear # Blank the screen.
                 echo "ntop - Traffic probe with network usage."
                 echo
                 echo "This command starts the ntop process."
                 echo "To use ntop, open a web browser to URL localhost:3000 or 127.0.0.1:3000"
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 opennms' '* | 'sudo opennms '* | 'sudo opennms')
                 APP_NAME=$CHOICE_APP
                 f_application_run

                 ;;
                 [Oo] | [Oo][Pp]*)
                 APP_NAME="opennms"
                 clear # Blank the screen.
                 echo "OpenNMS - A commercial open source application and is in the menu for"
                 echo "          reference only."
                 echo
                 echo "Description from the OpenNMS website:"
                 echo "OpenNMS is an award winning network management application platform with a long"
                 echo "track record of providing solutions for enterprises and carriers."
                 echo "OpenNMS main features are Automated and Directed Discovery, Event and"
                 echo "Notification Management, Service Assurance, Performance Measurement."
                 echo
                 echo "http://www.opennms.org/about/ or http://sourceforge.net/projects/opennms/"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 pmacct' '* | 'sudo pmacct '* | 'sudo pmacct')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Mm]*)
                 APP_NAME="pmacct"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 slurm' '* | 'sudo slurm '* | 'sudo slurm')
                 f_how_to_quit_application "q" "no-clear"
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ll]*)
                 f_find_NIC
                 APP_NAME="slurm -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 ;;
                 sntop' '* | 'sudo sntop '* | 'sudo sntop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Nn]*)
                 APP_NAME="sntop --refresh=3"
                 clear # Blank the screen.
                 echo "sntop - Network status display polls a list of hosts every few seconds."
                 echo
                 echo "sntop for every 3 seconds as an example."
                 echo
                 echo "Now run sntop. Usage: sntop --refresh=3"
                 echo
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 vnstat' '* | 'sudo vnstat '* | 'sudo vnstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Nn]*)
                 APP_NAME="vnstat"
                 f_application_run
                 ;;
            esac                # End of Network Monitor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Network Monitor Applications until loop.
} # End of function f_menu_app_network_monitors
#
# +----------------------------------------+
# |Function f_menu_app_network_bandwidth   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_network_bandwidth () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Network Bandwidth Applications until loop.
            #MNB bmon     - Bandwidth monitor and rate estimator.
            #MNB cbm      - Color Bandwidth Meter, ncurses based display.
            #MNB ifstat   - Bandwidth statistics. (See also dstat, System Monitors Menu).
            #MNB iftop    - Bandwidth statistics.
            #MNB jnettop  - Bandwidth statistics across streams.
            #MNB nethogs  - Bandwidth statistics by process.
            #MNB nload    - Bandwidth graphical monitor in real-time; ncurses based display.
            #MNB pktstat  - Display active connections and bandwidth in real-time.
            #MNB statnet  - Bandwidth statistics.
            #MNB trafshow - Bandwidth statistics; ncurses based.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Bandwidth Applications Menu"
            DELIMITER="#MNB" #MNB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Network Bandwidth Applications case statement.
                 bmon' '* | 'sudo bmon '* | 'sudo bmon')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Bb] | [Bb][Mm]*)
                 APP_NAME="bmon"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 cbm' '* | 'sudo cbm '* | 'sudo cbm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Bb]*)
                 APP_NAME="cbm"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 ifstat' '* | 'sudo ifstat '* | 'sudo ifstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Ff] | [Ii][Ff][Ss]*)
                 APP_NAME="ifstat 2 5"
                 clear # Blank the screen.
                 echo "ifstat - Display bandwidth statistics."
                 echo
                 echo "ifstat this PC's NIC (localhost) for 5 times every 2 seconds as an example."
                 echo
                 echo "Now run ifstat. Usage: ifstat 2 5"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 iftop' '* | 'sudo iftop '* | 'sudo iftop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ii] | [Ii][Ff] | [Ii][Ff][Tt]*)
                 f_find_NIC
                 APP_NAME="iftop -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 jnettop' '* | 'sudo jnettop '* | 'sudo jnettop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Jj] | [Jj][Nn]*)
                 f_find_NIC
                 APP_NAME="jnettop -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
                 nethogs' '* | 'sudo nethogs '* | 'sudo nethogs')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Hh]*)
                 APP_NAME="nethogs"
                 f_application_run
                 ;;
                 nload' '* | 'sudo nload '* | 'sudo nload')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Ll]*)
                 APP_NAME="nload"
                 f_find_NIC
                 APP_NAME="nload $ANS"                  
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 pktstat' '* | 'sudo pktstat '* | 'sudo pkstat')
                 APP_NAME=$CHOICE_APP
                 echo
                 echo "It may take a while to quit; wait while pktstat resolves addresses."
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Kk]*)
                 APP_NAME="pktstat"
                 echo
                 echo "It may take a while to quit; wait while pktstat resolves addresses."
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 statnet' '* | 'sudo statnet '* | 'sudo statnet')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Tt]*)
                 APP_NAME="statnet"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 trafshow' '* | 'sudo trafshow '* | 'sudo trafshow')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="trafshow"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Network Bandwidth Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Network Bandwidth Applications until loop.
} # End of function f_menu_app_network_bandwidth
#
# +----------------------------------------+
# |    Function f_menu_app_packet_tools    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_packet_tools () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Packet Tools Applications until loop.
            #MNP kismet    - Wireless network detector, packet sniffer, auditor.
            #MNP ngrep     - Network packet analyzer.
            #MNP nmap      - Network Mapper, mapping, auditing, security scanning.
            #MNP snort     - Packet sniffer/logger, Network Intrusion Detection System.
            #MNP tcpdump   - Packet sniffer/logger.
            #MNP wireshark - Packet sniffer/logger.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Packet Tools Applications Menu"
            DELIMITER="#MNP" #MNP This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Packet Tools Applications case statement.
                 kismet' '* | 'sudo kismet '* | 'sudo kismet')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Kk] | [Kk][Ii]*)
                 APP_NAME="kismet"
                 f_application_run
                 ;;
                 ngrep' '* | 'sudo ngrep '* | 'sudo ngrep')
                 APP_NAME=$CHOICE_APP
                 clear # Blank the screen.
                 echo "ngrep - Network packet analyzer."
                 echo
                 echo "Note: ngrep needs root permissions."
                 echo "      You need to use 'sudo ngrep'."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 [Nn] | [Nn][Gg]*)
                 APP_NAME="ngrep"
                 clear # Blank the screen.
                 echo "ngrep - Network packet analyzer."
                 echo
                 echo "Note: ngrep needs root permissions."
                 echo "      You need to use 'sudo ngrep'."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 nmap' '* | 'sudo nmap '* | 'sudo nmap')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Mm]*)
                 APP_NAME="nmap"
                 f_application_run
                 ;;
                 snort' '* | 'sudo snort '* | 'sudo snort')
                 APP_NAME=$CHOICE_APP
                 clear # Blank the screen.
                 echo "snort - Packet sniffer/logger, Network Intrusion Detection System."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 [Ss]| [Ss][Nn] | [Ss][Nn][Oo] | [Ss][Nn][Oo][Rr] | [Ss][Nn][Oo][Rr][Tt])
                 clear # Blank the screen.
                 echo "snort - Packet sniffer/logger, Network Intrusion Detection System."
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_find_NIC
                      APP_NAME="snort -i $ANS"
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 tcpdump' '* | 'sudo tcpdump '* | 'sudo tcpdump')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Cc]*)
                 f_find_NIC
                 APP_NAME="tcpdump -i $ANS -c 5"
                 clear # Blank the screen.
                 echo "tcpdump - Packet sniffer/logger."
                 echo
                 echo "tcpdump this PC's NIC (localhost) for 5 packets an example."
                 echo
                 echo "Now run tcpdump. Usage: tcpdump -i $ANS -c 5"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 wireshark' '* | 'sudo wireshark '* | 'sudo wireshark')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Ii]*)
                 APP_NAME="wireshark"
                 f_application_run
                 ;;
            esac                # End of Packet Tools Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Packet Tools Applications until loop.
} # End of function f_menu_app_packet_tools
#
# +----------------------------------------+
# |          Function f_find_NIC           |
# +----------------------------------------+
#
#  Inputs: None.
# Outputs: ANS.
#
f_find_NIC () {
# Search for "Link" in ifconfig output and parse first word (network interface).
ifconfig |  grep Link | awk '{print $1;}'
echo -n "Enter FULL-NAME of network interface to monitor with $APP_NAME: "
read ANS
# There is not yet any error checking on $ANS.
} # End of function f_find_NIC
#
# +----------------------------------------+
# |       Function f_menu_cat_office       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_office () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of Office Application Category until loop.
            #BOF Accounting   - Accounting (with with double-entry).
            #BOF Calculators  - Simple "pocket" calculators.
            #BOF Calendar     - Calendars.
            #BOF Clocks       - Alarm clocks, specialized clocks.
            #BOF Notebooks    - Write notes in a "notebook".
            #BOF PDF-PS docs  - view, edit, compare, merge pdf and ps documents.
            #BOF Presenters   - Text slideshow presentation.
            #BOF Spreadsheets - Basic spreadsheet.
            #BOF Text         - Create/Edit text files, text format converters, etc.        
            #BOF ToDo         - To-Do lists.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Office Application Category Menu"
            DELIMITER="#BOF" #BOF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Office Application Category case statement.
                 [Aa] | [Aa][Cc]*)
                 f_menu_app_accounting        # Accounting Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Cc]*)
                 f_menu_app_calculators       # Calculator Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Ee]*)
                 f_menu_app_calendar          # Calendar Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Cc] | [Cc][Ll]*)
                 f_menu_app_clocks            # Clock Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Nn] | [Nn][Oo]*)
                 f_menu_app_note              # Note Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Dd]*)
                 f_menu_app_pdfps             # PDF-PS Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Rr]*)
                 f_menu_app_presentation      # Presentation Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Pp]*)
                 f_menu_app_spreadsheets      # Spreadsheet Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Tt] | [Tt][Ee]*)
                 f_menu_cat_text              # Text Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Tt] | [Tt][Oo]*)
                 f_menu_app_todo
                 CHOICE_SCAT=-1  # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Office Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Office Application Category until loop.
} # End of function f_menu_cat_office
#
# +----------------------------------------+
# |     Function f_menu_app_accounting     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_accounting () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Accounting Applications until loop.
            #MAA hledger       - Same as "ledger" but using the Haskell Programming Language.
            #MAA hledger-chart - hledger pie chart generator.
            #MAA hledger-vty   - hledger n-curses style interface.
            #MAA hledger-web   - hledger web interface.
            #MAA ledger        - Ledger using double-entry.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Accounting Applications Menu"
            DELIMITER="#MAA" #MAA This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calculator Applications case statement.
                 hledger' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr])
                 APP_NAME="hledger"
                 f_application_run
                 ;;
                 hledger-chart' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc]*)
                 APP_NAME="hledger-chart"
                 f_application_run
                 ;;
                 hledger-vty' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Vv]*)
                 APP_NAME="hledger-vty"
                 f_application_run
                 ;;
                 hledger-web' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Ww]*)
                 APP_NAME="hledger-web"
                 f_application_run
                 ;;
                 ledger' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ee]*)
                 APP_NAME="ledger"
                 f_application_run
                 ;;
            esac                # End of Accounting Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Accounting Applications until loop.
} # End of f_menu_app_accounting
#
# +----------------------------------------+
# |     Function f_menu_app_calculators    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_calculators () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Calculator Applications until loop.
            #MCC bc       - Calculator.
            #MCC dc       - RPN arbitrary precision reverse-polish calculator.
            #MCC orpie    - RPN Reverse Polish Notation calculator.
            #MCC tapecalc - Tape-like calculator.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Calculator Applications Menu"
            DELIMITER="#MCC" #MCC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calculator Applications case statement.
                 bc' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "quit"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Bb] | [Bb][Cc])
                 APP_NAME="bc"
                 f_how_to_quit_application "quit"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 dc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Cc])
                 APP_NAME="dc"
                 f_application_run
                 ;;
                 orpie' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Oo] | [Oo][Rr]*)
                 APP_NAME="orpie"
                 f_application_run
                 ;;
                 tapecalc' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Aa]*)
                 APP_NAME="tapecalc"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Calculator Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Calculator Applications until loop.
} # End of f_menu_app_calculators
#
# +----------------------------------------+
# |      Function f_menu_app_calendar      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_calendar () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Calendar Applications until loop.
            #MCA cal         - Displays a monthly calendar.
            #MCA calcurse    - Calendar ncurses-based.
            #MCA ccal        - Calendar color.
            #MCA clcal       - Calendar and appointment reminders.
            #MCA emacs-calfw - Displays a calendar view in the Emacs buffer.
            #MCA gcal        - Calendar, almost the same as cal.
            #MCA gcalcli     - Google calendar.
            #MCA mencal      - Calendar to track repeating periodic events every nn days.
            #MCA ncal        - Calendar with vertical days.
            #MCA pal         - Calendar with events.
            #MCA pcal        - Generate PostScript or HTML Calendars.
            #MCA pom         - Display phase of moon on given date.
            #MCA remind      - Calendar alarms, Sun rise/set, moon phases.
            #MCA when        - Calendar.
            #MCA wyrd        - Calendar, ncurses-based.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Calendar Applications Menu"
            DELIMITER="#MCA" #MCA This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calendar Applications case statement.
                 cal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Aa] | [Cc][Aa][Ll])
                 APP_NAME="cal"
                 f_application_run
                 ;;
                 calcurse' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Cc]*)
                 APP_NAME="calcurse"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 ccal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Cc]*)
                 APP_NAME="ccal"
                 f_application_run
                 ;;
                 clcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Ll]*)
                 APP_NAME="clcal"
                 f_application_run
                 ;;
                 emacs-calfw' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee][Mm]*)
                 APP_NAME="emacs-calfw"
                 f_application_run
                 ;;
                 gcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Cc] | [Gg][Cc][Aa] | [Gg][Cc][Aa][Ll])
                 APP_NAME="gcal"
                 f_application_run
                 ;;
                 gcalcli' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Cc] | [Gg][Cc][Aa] | [Gg][Cc][Aa][Ll] | [Gg][Cc][Aa][Ll][Cc]*)
                 APP_NAME="gcalcli"
                 f_application_run
                 ;;
                 mencal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ee]*)
                 APP_NAME="mencal"
                 f_application_run
                 ;;
                 ncal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Cc]*)
                 APP_NAME="ncal"
                 f_application_run
                 ;;
                 pal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Aa]*)
                 APP_NAME="pal"
                 f_application_run
                 ;;
                 pcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Cc]*)
                 APP_NAME="pcal"
                 f_application_run
                 ;;
                 pom' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Oo]*)
                 APP_NAME="pom"
                 f_application_run
                 ;;
                 remind' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Mm]*)
                 APP_NAME="remind"
                 f_application_run
                 ;;
                 when' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Hh]*)
                 APP_NAME="when"
                 f_application_run
                 ;;
                 wyrd' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ww] | [Ww][Yy]*)
                 APP_NAME="wyrd"
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Calendar Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Calendar Applications until loop.
} # End of f_menu_app_calendar
#
# +----------------------------------------+
# |       Function f_menu_app_clocks       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_clocks () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Clock Applications until loop.
            #MCL binary-clock     - Binary numbers 1/0 tells time.
            #MCL cclock           - Digital clock with huge numbers fills entire screen.
            #MCL clockywock       - Analog clock, ncurses-based.
            #MCL grandfatherclock - Clock chimes Big-Ben, Cuckoo, 'Close Encounters'.
            #MCL saytime          - Audio clock.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Clock Applications Menu"
            DELIMITER="#MCL" #MCL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Clock Applications case statement.
                 binary-clock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ii]*)
                 APP_NAME="binary-clock"
                 f_application_run
                 ;;
                 cclock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Cc]*)
                 APP_NAME="cclock"
                 f_application_run
                 ;;
                 clockywock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Ll]*)
                 APP_NAME="clockywock"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 grandfatherclock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Rr]*)
                 APP_NAME="grandfatherclock"
                 f_application_run
                 ;;
                 saytime' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Aa]*)
                 APP_NAME="saytime"
                 f_application_run
                 ;;
            esac                # End of Clock Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Clock Applications until loop.
} # End of f_menu_app_clocks
#
# +----------------------------------------+
# |         Function f_menu_app_note       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_note () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Note Applications until loop.
            #MNO hnb - Hierarchical notebook.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Note Applications Menu"
            DELIMITER="#MNO" #MNO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Note Applications case statement.
                 hnb' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Nn]*)
                 APP_NAME="hnb"
                 f_application_run
                 ;;
            esac                # End of Note Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Note Applications until loop.
} # End of f_menu_app_note
#
# +----------------------------------------+
# |       Function f_menu_app_pdfps       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_pdfps () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Tool Applications until loop.
            #MPS diffpdf  - Compare pdf files.
            #MPS fbdjvu   - DjVu viewer similar to fbpdf.
            #MPS fbgs     - GhostScript, PostScript, and PDF viewer.
            #MPS fbpdf    - Framebuffer PDF viewer based on MuPDF with Vim keybindings.
            #MPS gs       - GhostScript, PostScript, and PDF viewer.
            #MPS jfbview  - Image viewer and framebuffer PDF viewer based on Imlib2.
            #MPS pdfjam   - Merge pdf files into a single file.
            #MPS pdftex   - Typesetter creates pdf files.
            #MPS pdftk    - Merge/split, rotate, watermark, bookmarks/metadata attach files.
            #MPS pdftops  - Converts PDF to PS (PostScript) format.
            #MPS ps2ascii - Converts PS (PostScript) to text format.
            #MPS ps2pdf   - Converts PS (PostScript) to PDF format.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="PDF and PS Applications Menu"
            DELIMITER="#MPS" #MPS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of PDF and PS Applications case statement.
                 diffpdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ii]*)
                 APP_NAME="diffpdf"
                 f_application_run
                 ;;
                 fbdjvu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb] | [Ff][Bb][Dd]*)
                 APP_NAME="fbdjvu"
                 f_application_run
                 ;;
                 fbgs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb] | [Ff][Bb][Gg]*)
                 APP_NAME="fbgs"
                 f_application_run
                 ;;
                 fbpdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb] | [Ff][Bb][Pp]*)
                 APP_NAME="fbpdf"
                 f_application_run
                 ;;
                 gs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Ss])
                 APP_NAME="gs"
                 f_application_run
                 ;;
                 jfbview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Ff]*)
                 APP_NAME="jfbview"
                 f_application_run
                 ;;
                 pdfjam' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Jj]*)
                 APP_NAME="pdfjam"
                 f_application_run
                 ;;
                 pdftex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Tt] | [Pp][Dd][Ff][Tt][Ee]*)
                 APP_NAME="pdftex"
                 f_application_run
                 ;;
                 pdftk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Tt] | [Pp][Dd][Ff][Tt][Kk])
                 APP_NAME="pdftk"
                 f_application_run
                 ;;
                 pdftops' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Tt] | [Pp][Dd][Ff][Tt][Oo]*)
                 APP_NAME="pdftops"
                 f_application_run
                 ;;
                 ps2ascii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ss] | [Pp][Ss][2] | [Pp][Ss][2][Aa]*)
                 APP_NAME="ps2ascii"
                 f_application_run
                 ;;
                 ps2pdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ss] | [Pp][Ss][2] | [Pp][Ss][2][Pp]*)
                 APP_NAME="ps2pdf"
                 f_application_run
                 ;;
            esac                # End of PDF and PS Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of pdf-ps Applications until loop.
} # End of f_menu_app_pdfps
#
# +----------------------------------------+
# |    Function f_menu_app_presentation    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_presentation () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Presentation Applications until loop.
            #MPR tpp  - "Text Presentation Program", slideshow, ncurses-based.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Presentation Applications Menu"
            DELIMITER="#MPR" #MPR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Presentation Applications case statement.
                 tpp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Pp]*)
                 APP_NAME="tpp"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Presentation Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Presentation> Applications until loop.
} # End of function f_menu_app_presentation
#
# +----------------------------------------+
# |    Function f_menu_app_spreadsheets    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_spreadsheets () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Spreadsheet Applications until loop.
            #MSP oleo - Full-screen spreadsheet having a more Emacs-like feel.
            #MSP sc   - Spreadsheet.
            #MSP slsc - Spreadsheet based on sc.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Spreadsheet Applications Menu"
            DELIMITER="#MSP" #MSP This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Spreadsheet Applications case statement.
                 oleo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Oo] | [Oo][Ll]*)
                 APP_NAME="oleo"
                 f_application_run
                 ;;
                 sc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc])
                 APP_NAME="sc"
                 f_application_run
                 ;;
                 slsc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ll]*)
                 APP_NAME="slsc"
                 f_application_run
                 ;;
            esac                # End of Spreadsheet Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Spreadsheet Applications until loop.} # End of menu_app_spreadsheets
} # End of f_menu_app_spreadsheets
#
# +----------------------------------------+
# |         Function f_menu_cat_text       |
# +----------------------------------------+
#
#  Inputs: None
#    Uses: CHOICE_TCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_TCAT
#
f_menu_cat_text () {
      f_initvars_menu_app
      until [ $CHOICE_TCAT -eq 0 ] 
      do    # Start of Text Application Category until loop.
            #BTX Compare    - Show differences between text files.
            #BTX Converters - Convert between text document/file formats.
            #BTX Editors    - Create/Edit text documents/files.
            #BTX Tools      - Viewers,text markup language.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Text Application Category Menu"
            DELIMITER="#BTX" #BTX This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_TCAT
            #
            f_common_tcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_TCAT in # Start of Text Application Category case statement.
                 [Cc] | [Cc][Oo] | [Cc][Oo][Mm]*)
                 f_menu_app_text_compare      # Text Compare Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;               
                 [Cc] | [Cc][Oo] | [Cc][Oo][Nn]*)
                 f_menu_app_text_converters   # Text Converter Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ee] | [Ee][Dd]*)
                 f_menu_app_text_editors      # Text Editor Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Tt] | [Tt][Oo]*)
                 f_menu_app_text_tools        # Text Tool Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Text Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_tcat_bad_menu_choice
      done  # End of Text Application Category until loop.
} # End of function f_menu_cat_text
#
# +----------------------------------------+
# |    Function f_menu_app_text_compare    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_compare () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Compare Applications until loop.
            #MTC colordiff - Differences between two text files shown in color.
            #MTC diff      - Differences between two text files shown using <> signs.
            #MTC imediff2  - Interactive 2-way file merge.
            #MTC vimdiff   - Differences between two text files shown in color highlights.
            #MTC wdiff     - Differences between two text files shown using +/- signs.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Text Compare Applications Menu"
            DELIMITER="#MTC" #MTC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Compare Applications case statement.
                 colordiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Oo]*)
                 APP_NAME="colordiff"
                 f_application_run
                 ;;
                 diff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [[Dd][Ii]*)
                 APP_NAME="diff"
                 f_application_run
                 ;;
                 imediff2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii] | [Ii][Mm] | [Ii][Mm][Ee] | [Ii][Mm][Ee][Dd] | [Ii][Mm][Ee][Dd][Ii] | [Ii][Mm][Ee][Dd][Ii][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff][2])
                 APP_NAME="imediff2"
                 f_application_run
                 ;;
                 vimdiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ii]*)
                 APP_NAME="vimdiff"
                 f_application_run
                 ;;
                 wdiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Dd]*)
                 APP_NAME="wdiff"
                 f_application_run
                 ;;
            esac                # End of Text Compare Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Text Compare Applications until loop.
} # End of f_menu_app_text_compare
#
# +----------------------------------------+
# |   Function f_menu_app_text_converters  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_converters () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Converter Applications until loop.
            #MTV txt2html   - Converts plain ASCII text to HTML format.
            #MTV txt2man    - Converts plain ASCII text to man format.
            #MTV txt2pdbdoc - Converts plain ASCII text to PDB doc format for Palm Pilots.
            #MTV txt2regex  - Converts human sentences to regex. Regular Expression Wizard.
            #MTV txt2tags   - Converts plain ASCII text to a variety of formats.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Text Converter Applications Menu"
            DELIMITER="#MTV" #MTV This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Converter Applications case statement.
                 txt2html' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Hh]*)
                 APP_NAME="man txt2html"
                 clear # Blank the screen.
                 echo "txt2html - Convert plain text files to html." 
                 echo
                 echo "Usage:"
                 echo "txt2html [ --append_file filename ] [ --append_head filename ]"
                 echo "         [ --body_deco string ] [ --bold_delimiter string ]"
                 echo "         [ --bullets string ] [ --bullets_ordered string ]"
                 echo "         [ --caps_tag tag ]"
                 echo
                 echo "*** For more help type: txt2html --help"
                 echo "Now show help. Usage: man txt2html"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 txt2man' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Mm]*)
                 APP_NAME="man txt2man"
                 clear # Blank the screen.
                 echo "txt2man - Convert plain text files to man pages." 
                 echo
                 echo "Usage:"
                 echo "txt2man [-hpTX] [-t mytitle] [-P pname] [-r rel] [-s sect] [-v vol]"
                 echo "        [-I txt] [-B txt] [-d date] [ifile]"
                 echo
                 echo "*** For more help type: txt2man --help"
                 echo "Now show help. Usage: man txt2man"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 txt2pdbdoc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Pp]*)
                 APP_NAME="man txt2pdbdoc"
                 clear # Blank the screen.
                 echo "txt2pdbdoc - Convert plain text files to (Palm Pilot Database) Doc file *.pdb."
                 echo "             for PalmPilots & DocReaders. (Does anyone still have a PalmPilot?)"
                 echo
                 echo "Usage: txt2pdbdoc [-b] [-c] [-v] document-name file.txt file.pdb"
                 echo "       txt2pdbdoc -d [-D] [-v] file.pdb [ file.txt ]"
                 echo "       txt2pdbdoc -V"
                 echo
                 echo "*** For more help type: txt2pdbdoc --help"
                 echo "Now show help. Usage: man txt2pdbdoc"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 txt2regex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Rr]*)
                 APP_NAME="man txt2regex"
                 clear # Blank the screen.
                 echo "txt2regex - Convert human sentences to regex." 
                 echo
                 echo "Usage:"
                 echo "txt2regex --all|--prog <p1,p2,...,pN>"
                 echo
                 echo "*** For more help type: txt2regex --help"
                 echo "Now show help. Usage: man txt2regex"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 txt2tags' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Tt]*)
                 APP_NAME="man txt2tags"
                 clear # Blank the screen.
                 echo "txt2tags - Convert plain text files to ASCII Art, AsciiDoc, Creole, DocBook,"
                 echo "           DokuWiki, Google Code Wiki, HTML, LaTeX, Lout, MagicPoint, Man page,"
                 echo "           MoinMoin, PageMaker, Plain Text, PmWiki, SGML, Wikipedia and XHTML."
                 echo 
                 echo "Usage:"
                 echo "txt2tags [options] [FILE...]"
                 echo
                 echo "*** For more help type: txt2tags --help"
                 echo "Now show help. Usage: man txt2tags"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of Text Converter Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Text Converter Applications until loop.
} # End of f_menu_app_text_converters
#
# +----------------------------------------+
# |     Function f_menu_app_text_editors   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Editor Applications until loop.
            #MTE beav  - Binary editor and viewer.
            #MTE dav   - Text editor.
            #MTE dex   - Support for ctags and parsing compiler errors.
            #MTE ed    - Classic CLI text editor.
            #MTE emacs - Full screen text editor with plugins.
            #MTE groff - Uses macros to format text, create man pages to PS printers.
            #MTE jed   - JED text editor.
            #MTE joe   - Text editor. Ctrl-K H for help.
            #MTE nano  - Simple full-screen text editor.
            #MTE pico  - Simple full-screen text editor.
            #MTE vi    - Classic full-screen text editor.
            #MTE vim   - vi "Improved" text editor.
            #MTE zile  - Very small Emacs-subset editor.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Text Editor Applications Menu"
            DELIMITER="#MTE" #MTE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Editor Applications case statement.
                 beav' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ee]*)
                 APP_NAME="beav"
                 f_application_run
                 ;;
                 dav' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "<F5>"
                 f_application_run
                 ;;
                 [Dd] | [Dd][Aa]*)
                 APP_NAME="dav"
                 f_how_to_quit_application "<F5>"
                 f_application_run
                 ;;
                 dex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ee]*)
                 APP_NAME="dex"
                 f_application_run
                 ;;
                 ed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Dd])
                 APP_NAME="ed"
                 f_application_run
                 ;;
                 emacs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Mm]*)
                 APP_NAME="emacs"
                 f_application_run
                 ;;
                 groff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Gg] | [Gg][Rr]*)
                 APP_NAME="groff"
                 clear # Blank the screen.
                 echo "groff - Use macro command language to output formatted text"
                 echo "        for PostScript printers."
                 echo
                 echo "Usage:" 
                 echo "groff [-abcegiklpstzCEGNRSUVXZ] [-d cs] [-D arg] [-f fam] [-F dir] [-I dir]"
                 echo "      [-K arg] [-L arg] [-m name] [-M dir] [-n num] [-o list] [-P arg]"
                 echo "      [-r cn] [-T dev] [-w name] [-W name] [file ...]"
                 echo "groff -h | --help"
                 echo "groff -v | --version [option ...]"
                 echo
                 echo "*** For more help type: $APP_NAME --help"
                 echo "Now show help. Usage: man $APP_NAME"
                 APP_NAME="groff --help"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 jed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Jj] | [Jj][Ee]*)
                 APP_NAME="jed"
                 f_application_run
                 ;;
                 joe' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Ctrl-k x"
                 f_application_run
                 ;;
                 [Jj] | [Jj][Oo]*)
                 APP_NAME="joe"
                 f_how_to_quit_application "Ctrl-k x"
                 f_application_run
                 ;;
                 nano' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Nn] | [Nn][Aa]*)
                 APP_NAME="nano"
                 f_application_run
                 ;;
                 pico' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="pico"
                 f_application_run
                 ;;
                 vi' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ii])
                 APP_NAME="vi"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 vim' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ii] | [Vv][Ii][Mm])
                 APP_NAME="vim"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 zile' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Zz] | [Zz][Ii]*)
                 APP_NAME="zile"
                 f_application_run
                 ;;
            esac                # End of Text Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Text Editor Applications until loop.
} # End of f_menu_app_text_editors
#
# +----------------------------------------+
# |     Function f_menu_app_text_tools     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_tools () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Tool Applications until loop.
            #MTT antiword - Microsoft Word document viewer/converter to txt, pdf, ps, xml.
            #MTT doconce  - Text markup language to manipulate, transform, and convert text.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Text Tool Applications Menu"
            DELIMITER="#MTT" #MTT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Editor Applications case statement.
                 antiword' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Nn]*)
                 APP_NAME="antiword"
                 f_application_run
                 ;;
                 doconce' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Oo]*)
                 APP_NAME="doconce"
                 f_application_run
                 ;;
            esac                # End of Text Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Text Tool Applications until loop.
} # End of f_menu_app_text_tools
#
# +----------------------------------------+
# |        Function f_menu_app_todo        |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_todo () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of ToDo Applications until loop.
            #MTD doneyet - To-Do List.
            #MTD hnb     - To-Do List and note taker, ncurses-based application.
            #MTD todo    - To-Do List hierarchical. Install package 'devtodo'.
            #MTD tudu    - To-Do List hierarchical tasks.
            #MTD yaGTD   - To-Do List based on "Getting Things Done" methodology.
            #MTD yokadi  - Project/task manager which uses SQLite.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="To-Do Applications Menu"
            DELIMITER="#MTD" #MTD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of ToDo Applications case statement.
                 doneyet' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Oo]*)
                 APP_NAME="doneyet"
                 f_application_run
                 ;;
                 hnb' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Hh] | [Hh][Nn]*)
                 APP_NAME="hnb"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 todo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Oo]*)
                 APP_NAME="todo"
                 clear # Blank the screen.
                 echo "todo - Simple To-Do list using hidden file .todo as a database list."
                 echo
                 echo "todo [<options>]"
                 echo "       With no options, displays the items in the current directory."
                 echo
                 echo "tda [-p <priority>] [-g <index>] [<text>]"
                 echo "      Add a new item, optionally grafting it as a child of the given item."
                 echo
                 echo "tde <index>"
                 echo "     Edit the given item."
                 echo
                 echo "tdr <indices>"
                 echo "     Remove the given items."
                 echo
                 echo "tdd <indices>"
                 echo "     Mark the specified items as being done."
                 echo
                 echo "*** For more help type: man todo"
                 echo
                 echo "todo -a to add a new note, todo -A -all to show all notes."
                 echo 
                 echo "Now run todo. Usage: todo"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 tudu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Uu]*)
                 APP_NAME="tudu"
                 f_application_run
                 ;;
                 yagtd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Aa]*)
                 APP_NAME="yagtd"
                 f_application_run
                 ;;
                 yokadi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Oo]*)
                 APP_NAME="yokadi"
                 f_application_run
                 ;;
            esac                # End of ToDo Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of ToDo Applications until loop.
} # End of f_menu_app_todo
#
# +----------------------------------------+
# |    Function f_menu_app_screen_savers   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_screen_savers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Screen-saver Applications until loop.
            #MSS asciiaquarium - Aquarium on screen.
            #MSS cmatrix       - Matrix-like screen-saver.
            #MSS rain          - Rain on screen.
            #MSS tty-clock     - Display a digital clack full-screen.
            #MSS worms         - Worms wiggle on the screen.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Screen-saver Applications Menu"
            DELIMITER="#MSS" #MSS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Screen-saver Applications case statement.
                 asciiaquarium' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Ss]*)
                 APP_NAME="asciiaquarium"
                 f_application_run
                 ;;
                 cmatrix' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Mm]*)
                 APP_NAME="cmatrix"
                 f_application_run
                 ;;
                 rain' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Aa]*)
                 APP_NAME="rain"
                 f_application_run
                 ;;
                 tty-clock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Tt]*)
                 APP_NAME="tty-clock"
                 f_application_run
                 ;;
                 worms' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ww] | [Ww][Oo]*)
                 APP_NAME="worms"
                 f_application_run
                 ;;
            esac                # End of Screen-saver Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Screen-saver Applications until loop.
} # End of f_menu_app_screen_savers
#
# +----------------------------------------+
# |        Function f_menu_cat_system      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_system () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of System Category until loop.
            #BSY Backup      - File Backup.
            #BSY Disks       - Disk information.
            #BSY Health      - Anti-virus scanners, root-kit detectors, stress tests etc.
            #BSY Logs        - Log file viewers.
            #BSY Mainboard   - Information on PC mainboard, memory, etc.
            #BSY Monitors    - Resources, and disk I/O monitors.
            #BSY Other       - Screen capture, DOS and Nintendo Emulators, etc.
            #BSY Peripherals - Information on PC peripherals, PCI devices, hard drives, etc.
            #BSY Process     - System process monitoring, killing.
            #BSY Screens     - Multiple screen sessions and terminal emulators.
            #BSY Software    - (Un)Install and manage software packages (programs).
            #
            MENU_TITLE="System Category Menu"
            DELIMITER="#BSY" #BSY This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of System Category case statement.
                 [Bb] | [Bb][Aa]*)
                 f_menu_app_sys_backup        # System Backup Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Dd] | [Dd][Ii]*)
                 f_menu_app_sys_disks         # System Disks Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Hh] | [Hh][Ee]*)
                 f_menu_app_sys_health        # System Health Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ll] | [Ll][Oo]*)
                 f_menu_app_sys_logs          # System Logs Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Aa]*)
                 f_menu_app_sys_mainboard     # System Mainboard Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Mm] | [Mm][Oo]*)
                 f_menu_app_sys_monitors      # System Monitors Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Oo] | [Oo][Tt]*)
                 f_menu_app_sys_other         # System Other Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Ee]*)
                 f_menu_app_sys_peripherals   # System Peripherals Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Rr]*)
                 f_menu_app_sys_process       # System Process Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Cc]*)
                 f_menu_app_sys_screens       # System Screens Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Ss] | [Ss][Oo]*)
                 f_menu_app_sys_software      # System Software Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of System Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of System Category until loop.
} # End of function f_menu_cat_system
#
# +----------------------------------------+
# |     Function f_menu_app_sys_backup     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_backup () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Backup Applications until loop.
            #MSB dtrx - Use tar without remembering which flags for each file to use.
            #MSB rsync - File backup, mirror, directories and files.
            #MSB tar   - File backup, compress files.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Backup/Archive Applications Menu"
            DELIMITER="#MSB" #MSB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Backup Applications case statement.
                 dtrx' '* | 'sudo dtrx' | 'sudo dtrx '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Tt]*)
                 APP_NAME="dtrx"
                 f_application_run
                 ;;
                 rsync' '* | 'sudo rsync' | 'sudo rsync '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Ss]*)
                 APP_NAME="rsync"
                 f_application_run
                 ;;
                 tar' '* | 'sudo tar' | 'sudo tar '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Aa]*)
                 APP_NAME="tar"
                 f_application_run
                 ;;
            esac                # End of Backup Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Backup Applications until loop.
} # End of function f_menu_app_sys_backup
#
# +----------------------------------------+
# |      Function f_menu_app_sys_disks     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_disks () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of System Disks Information Applications until loop.
            #MSD blkid  - Block devices.
            #MSD cfdisk - Disk partition tool.
            #MSD df     - Disk usage and mount points, usage: -hT.
            #MSD dfc    - Disk usage and mount points, graphical display.
            #MSD du     - Disk usage monitor by directory.
            #MSD gt5    - A diff-capable du-browser.
            #MSD hdparm - Show/set disk parameters, settings. 
            #MSD lsblk  - List block devices (disks).
            #MSD ncdu   - Disk usage monitor, ncurses-based.
            #MSD parted - Disk partition tool.
            #MSD pydf   - Disk usage df clone written in python.
            #MSD uuid   - Use ls -l to show disk uuid number.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Disks Information Menu"
            DELIMITER="#MSD" #MSD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Disks Information Applications case statement.
                 blkid' '* | 'sudo blkid '* | 'sudo blkid')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ll]*)
                 APP_NAME="blkid"
                 f_application_run
                 ;;
                 cfdisk' '* | 'sudo cfdisk '* | 'sudo cfdisk')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Ff]*)
                 APP_NAME="cfdisk"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 df' '* | 'sudo df '* | 'sudo df')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ff])
                 APP_NAME="df -hT"
                 clear # Blank the screen.
                 echo "df - Displays free space on disk"
                 echo
                 echo "Usage:"
                 echo "df [OPTION]... [FILE]..."
                 echo "df [OPTION]... --files0-from=F"
                 echo "   -h, --human-readable    format (e.g., 1K 234M 2G)"
                 echo "   --total                 produce a grand total"
                 echo "   -t, --type=TYPE         limit listing to specific file systems"
                 echo "   -T, --print-type        print file system type"
                 echo "   -x, --exclude-type=TYPE limit listing to file systems not of type TYPE"
                 echo
                 echo "*** For more help type: man df"
                 echo
                 echo "Display total disk usage in human-readable format."
                 echo
                 echo "Now run du. Usage: df -hT"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 dfc' '* | 'sudo dfc '* | 'sudo dfc')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ff]| [Dd][Ff][Cc])
                 APP_NAME="dfc"
                 f_application_run
                 ;;
                 du' '* | 'sudo du '* | 'sudo du')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Uu])
                 APP_NAME="du -hsc"
                 clear # Blank the screen.
                 echo "du - Displays disk usage per directory"
                 echo
                 echo "Usage:"
                 echo "du [OPTION]... [FILE]..."
                 echo "du [OPTION]... --files0-from=F"
                 echo "   -h, --human-readable  human-readable format (e.g., 1K 234M 2G)"
                 echo "   -c, --total           produce a grand total"
                 echo "   -S, --separate-dirs   do not include sub-folders"
                 echo "   -s, --summarize       display only a total"
                 echo "   --exclude=PATTERN     exclude files matching PATTERN"
                 echo "   -d, --max-depth=N     N  or  fewer  levels  below"
                 echo
                 echo "*** For more help type: man du"
                 echo
                 echo "Display total disk usage in human-readable format."
                 echo
                 echo "Now run du. Usage: du -hc"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 gt5' '* | 'sudo gt5 '* | 'sudo gt5')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Gg] | [Gg][Tt]*)
                 APP_NAME="gt5"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 hdparm' '* | 'sudo hdparm '* | 'sudo hdparm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Dd]*)
                 APP_NAME="hdparm"
                 f_application_run
                 ;;
                 lsblk' '* | 'sudo lsblk '* | 'sudo lsblk')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss]*)
                 APP_NAME="lsblk"
                 f_application_run
                 ;;
                 ncdu' '* | 'sudo ncdu '* | 'sudo ncdu')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Cc]*)
                 APP_NAME="ncdu"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 parted' '* | 'sudo parted '* | 'sudo parted')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Pp] | [Pp][Aa]*)
                 APP_NAME="parted"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 pydf' '* | 'sudo pydf '* | 'sudo pydf')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Yy]*)
                 APP_NAME="pydf -hT"
                 clear # Blank the screen.
                 echo "pydf - Displays free space on disk"
                 echo
                 echo "Usage:"
                 echo "pydf [OPTION]... [FILE]..."
                 echo "pydf [OPTION]... --files0-from=F"
                 echo "   -h, --human-readable    format (e.g., 1K 234M 2G)"
                 echo "   --total                 produce a grand total"
                 echo "   -t, --type=TYPE         limit listing to specific file systems"
                 echo "   -T, --print-type        print file system type"
                 echo "   -x, --exclude-type=TYPE limit listing to file systems not of type TYPE"
                 echo
                 echo "*** For more help type: man df"
                 echo
                 echo "Display total disk usage in human-readable format."
                 echo
                 echo "Now run df. Usage: df -hT"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 uuid' '* | 'sudo uuid '* | 'sudo uuid')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Uu]*)
                 clear # Blank the screen.
                 echo To find the UUID of a disk, type: ls -l /dev/disk/by-uuid.
                 APP_NAME="ls -l /dev/disk/by-uuid"
                 f_application_run             
                 ;;
            esac                # End of System Disks Information> Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Disks Information Applications until loop.
} # End of function f_menu_app_sys_disks
#
# +----------------------------------------+
# |     Function f_menu_app_sys_health     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_health () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of System Health Applications until loop.
            #MSH arp-scan   - Discover, fingerprint hosts on LAN using MAC addresses.
            #MSH arpalert   - Checks MAC addresses against list of known MACs, runs script.
            #MSH arpon      - ArpON detects/blocks arp poisoning/spoofing attacks.
            #MSH arpwatch   - Detects unknown MAC addresses and IP addresses, like ArpON.
            #MSH chkrootkit - Root Kit detector.
            #MSH clamscan   - Clam anti-virus program scans for viruses.
            #MSH freshclam  - Clam anti-virus database definition update.
            #MSH lynis      - security auditing tool that tests for security holes in a PC.
            #MSH rkhunter   - Root Kit detector.
            #MSH tripwire   - Detects/Reports changes in system files.
            #MSH stress     - Stress test can simulate a heavy load on CPU.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Health Applications Menu"
            DELIMITER="#MSH" #MSH This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Health Applications case statement.
                 arp-scan' '* | 'sudo arp-scan '* | 'sudo arp-scan')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][-]*)
                 clear # Blank the screen.
                 echo "arp-scan - ARP Scanner."
                 echo
                 echo "Usage:"
                 echo "arp-scan [options] [hosts...]"
                 echo
                 echo "       --localnet or -l"
                 echo "              Generate addresses from network  interface  configuration.   Use"
                 echo "              the  network  interface  IP address and network mask to generate"
                 echo "              the list of target host addresses.  The list  will  include  the"
                 echo "              network  and  broadcast  addresses,  so  an interface address of"
                 echo "              10.0.0.1 with netmask 255.255.255.0 would  generate  256  target"
                 echo "              hosts  from  10.0.0.0  to 10.0.0.255 inclusive."
                 echo
                 echo "       --interface=<s> or -I <s>"
                 echo "              Use  network  interface  <s>."
                 echo
                 echo "Now run arp-scan on this PC as an example."
                 echo "Usage: arp-scan -l -I <interface>"
                 echo
                 f_press_enter_key_to_continue
                 f_find_NIC
                 APP_NAME="arp-scan -l -I $ANS"
                 f_application_run
                 ;;
                 arpalert' '* | 'sudo arpalert '* | 'sudo arpalert')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Aa]*)
                 APP_NAME="arpalert"
                 f_application_run
                 ;;
                 arpon' '* | 'sudo arpon '* | 'sudo arpon')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Oo]*)
                 APP_NAME="arpon"
                 f_application_run
                 ;;
                 arpwatch' '* | 'sudo arpwatch '* | 'sudo arpwatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Ww]*)
                 APP_NAME="arpwatch"
                 clear # Blank the screen.
                 echo "arpwatch - Keep track of ethernet/ip address pairings"
                 echo
                 echo "Arpwatch  keeps  track  for  ethernet/ip  address  pairings. It syslogs"
                 echo "activity and reports certain changes via email.  Arpwatch uses  pcap(3)"
                 echo "to listen for arp packets on a local ethernet interface."
                 echo
                 echo "Usage:"
                 echo "arpwatch [-dN] [-f datafile] [-i interface] [-n net[/width]] [-r file]"
                 echo "         [-s sendmail_path] [-p] [-a] [-m addr] [-u username]"
                 echo "         [-R seconds ] [-Q] [-z ignorenet/ignoremask]"
                 echo
                 echo "Now run man arpwatch. Usage: man arpwatch"
                 echo
                 f_press_enter_key_to_continue
                 APP_NAME="man arpwatch"
                 f_application_run
                 ;;
                 chkrootkit' '* | 'sudo chkrootkit '* | 'sudo chkrootkit')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Hh]*)
                 APP_NAME="chkrootkit"
                 f_application_run
                 ;;
                 clamscan' '* | 'sudo clamscan '* | 'sudo clamscan')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Cc] | [Cc][Ll]*)
                 APP_NAME="clamscan -r /home"
                 clear # Blank the screen.
                 echo "clamscan -  Anti-virus scanner"
                 echo
                 echo "Usage:" 
                 echo "clamscan [options] [file/directory/-]"
                 echo "         -r, --recursive will recursively scan your home directory."
                 echo
                 echo "*** For more help type: clamscan --help"
                 echo
                 echo "Clam anti-virus will now scan the folder, please be patient"
                 echo "since Clam anti-virus is slow to scan, but thorough."
                 f_press_enter_key_to_continue
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 freshclam' '* | 'sudo freshclam '* | 'sudo freshclam')
                 APP_NAME=$CHOICE_APP
                 # f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 [Ff] | [Ff][Rr]*)
                 APP_NAME="freshclam"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 lynis' '* | 'sudo lynis '* | 'sudo lynis')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Yy]*)
                 APP_NAME="lynis"
                 f_application_run
                 ;;
                 rkhunter' '* | 'sudo rkhunter '* | 'sudo rkhunter')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Kk]*)
                 APP_NAME="rkhunter"
                 f_application_run
                 ;;
                 stress' '* | 'sudo stress '* | 'sudo stress')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Tt]*)
                 APP_NAME="stress"
                 clear # Blank the screen.
                 echo "stress - A tool to impose load on and stress test a computer system"
                 echo
                 echo "The application, 'stress' is a tool that imposes a configurable amount of CPU,"
                 echo "memory, I/O, or disk stress on a POSIX-compliant operating system and reports"
                 echo "any errors it detects."
                 echo
                 echo "The application 'stress' is not a benchmark."
                 echo
                 echo "It is a tool used by:"
                 echo "System Administrators to evaluate how well their systems will scale,"
                 echo "Kernel Programmers to evaluate perceived performance characteristics, and by"
                 echo "Systems Programmers to expose the classes of bugs which only or more frequently"
                 echo "manifest themselves when the system is under heavy load."
                 echo
                 echo "*** For more help type: man stress"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 tripwire' '* | 'sudo tripwire '* | 'sudo tripwire')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Rr]*)
                 APP_NAME="man tripwire"
                 clear # Blank the screen.
                 echo "tripwire - Detects unauthorized file changes"
                 echo
                 echo "*** For more help type: man tripwire for use and operation."
                 echo "*** For more help type: man twadmin - create, encode policy, config files."
                 echo "*** For more help type: man twprint - print database."
                 echo "*** For more help type: man siggen - display hash values for files."
                 echo "*** For more help type: man twconfig - explanation of config files."
                 echo "*** For more help type: man twpolicy - explanation of policy files."
                 echo "*** For more help type: man twfiles - overview of files, settings."
                 echo
                 echo "Usage:"
                 echo "Database Initialization:  tripwire [-m i|--init] [options]"
                 echo "Integrity Checking:  tripwire [-m c|--check] [object1 [object2...]]"
                 echo "Database Update:  tripwire [-m u|--update]"
                 echo "Policy Update:  tripwire [-m p|--update-policy] policyfile.txt"
                 echo "Test:  tripwire [-m t|--test] --email address"
                 echo "Type 'tripwire [mode] --help' OR"
                 echo "'tripwire --help mode [mode...]' OR"
                 echo "'tripwire --help all' for extended help"
                 echo
                 echo "Now run man tripwire. Usage: man tripwire"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of System Health Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Health Applications until loop.
} # End of function f_menu_app_sys_health
#
# +----------------------------------------+
# |   Function f_menu_app_sys_mainboard    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_mainboard () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Information until loop.
            #MSI dmidecode   - Main board information.
            #MSI free        - Memory usage RAM and swap.
            #MSI hdparm      - Hard disk drive information.
            #MSI lsb_release - Linux distro and LSB (Linux Standard Base).
            #MSI lscpu       - CPU information.
            #MSI lshw        - Main board information.
            #MSI lsmod       - Linux kernel module information.
            #MSI slabtop     - Kernel slab cache information in real time.
            #MSI uname       - Linux kernel information.
            #MSI vmstat      - Memory usage RAM and swap, CPU information.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Mainboard Information Menu"
            DELIMITER="#MSI" #MSI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Mainboard System Information case statement.
                 dmidecode' '* | 'sudo dmidecode '* | 'sudo dmidecode')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Mm]*)
                 APP_NAME="dmidecode"
                 f_application_run
                 ;;
                 free' '* | 'sudo free '* | 'sudo free')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Rr]*)
                 APP_NAME="free -m -t -s 2 -c 5"
                 clear # Blank the screen.
                 echo "free - Display the amount of free and used memory both RAM and swap"
                 echo
                 echo "Usage:"
                 echo "free [-b|-k|-m|-g] [-c count] [-l] [-o] [-t] [-s delay] [-V]"
                 echo
                 echo "*** For more help type: man free"
                 echo
                 echo "Display in MB Megabytes with column totals, for 5 times every 2 seconds."
                 echo
                 echo "Now run free. Usage: free -m -t -s 2 -c 5"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 hdparm' '* | 'sudo hdparm '* | 'sudo hdparm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Dd]*)
                 APP_NAME="hdparm -I /dev/sda"
                 clear # Blank the screen.
                 echo "hdparm - Get SATA/IDE hard disk drive parameters."
                 echo
                 echo "Usage:"
                 echo "hdparm [options..] [device ...]"
                 echo
                 echo "*** For more help type: man hdparm"
                 echo
                 echo "Find information about the first hard disk drive: /dev/sda on this PC (localhost)."
                 echo
                 echo "Now run hdparm. Usage: 'hdparm -I /dev/sda'"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 lsb_release' '* | 'sudo lsb_release '* | 'sudo lsb_release')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Bb]*)
                 APP_NAME="lsb_release -a"
                 f_application_run
                 ;;
                 lscpu' '* | 'sudo lscpu '* | 'sudo lscpu')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Cc]*)
                 APP_NAME="lscpu"
                 f_application_run
                 ;;
                 lshw' '* | 'sudo lshw '* | 'sudo lshw')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Hh]*)
                 APP_NAME="lshw -short"
                 clear # Blank the screen.
                 echo "lshw - Displays main board information"
                 echo
                 echo "Usage:"
                 echo "lshw [ -version ]"
                 echo "lshw [ -help ]"
                 echo "lshw [ -X ]"
                 echo "lshw  [ -html ] [ -short ] [ -xml ] [ -json ] [ -businfo ] [ -dump filename ]"
                 echo "[ -class class... ] [ -disable test... ] [ -enable test... ] [ -sanitize ]"
                 echo "[ -numeric ] [ -quiet ]"
                 echo
                 echo "*** For more help type: man lshw"
                 echo
                 echo "Display short report."
                 echo
                 echo "Now run lshw. Usage: lshw -short"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 lsmod' '* | 'sudo lsmod '* | 'sudo lsmod')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Mm]*)
                 APP_NAME="lsmod "
                 f_application_run
                 ;;
                 slabtop' '* | 'sudo slabtop '* | 'sudo slabtop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Ll]*)
                 APP_NAME="slabtop"
                 clear # Blank the screen.
                 echo "slabtop - Display kernel slab cache information in real time."
                 echo
                 echo "slabtop displays a listing of the top caches sorted by  one  of  the  listed"
                 echo "sort  criteria.   It also displays a statistics header filled with slab"
                 echo "layer information."
                 echo
                 echo "Usage:"
                 echo "slabtop [options]"
                 echo
                 echo "slabtop  displays  detailed kernel slab cache information in real time."
                 echo
                 echo "*** For more help type: man slabtop"
                 echo
                 echo "If you get error message: 'fopen /proc/slabinfo: Permission denied'"
                 echo "Then try running with sudo command i.e. 'sudo slabtop'."
                 echo
                 f_press_enter_key_to_continue
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 uname' '* | 'sudo uname '* | 'sudo uname')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Nn]*)
                 APP_NAME="uname -a"
                 f_application_run
                 ;;
                 vmstat' '* | 'sudo vmstat '* | 'sudo vmstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Mm]*)
                 APP_NAME="vmstat"
                 f_application_run
                 ;;
            esac                # End of Mainboard System Information case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Mainboard System Information until loop.
} # End of f_menu_app_sys_mainboard
#
# +----------------------------------------+
# |   Function f_menu_app_sys_peripherals  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_peripherals () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Peripheral System Information until loop.
            #MSL acpitool  - ACPI power/battery settings.
            #MSL blkid     - Block devices information.
            #MSL lsblk     - List block devices (disks).
            #MSL lsof      - Display information about open files.
            #MSL lspci     - PCI buses and connected devices.
            #MSL lspcmcia  - PCMCIA extended debugging information.
            #MSL lsusb     - USB devices.
            #MSL pccardctl - PCMCIA card devices.
            #MSL printenv  - Environmental variables.
            #MSL uptime    - Display how long PC has been running, # users, load average.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Peripheral System Information Menu"
            DELIMITER="#MSL" #MSL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Peripheral System Information case statement.
                 acpitool' '* | 'sudo acpitool '* | 'sudo acpitool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Cc]*)
                 APP_NAME="acpitool"
                 f_application_run
                 ;;
                 blkid' '* | 'sudo blkid '* | 'sudo blkid')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Ll]*)
                 APP_NAME="blkid"
                 clear # Blank the screen.
                 echo "blkid - Locate/print block device attributes"
                 echo
                 echo "The blkid program is the command-line interface to working with the libblkid(3)"
                 echo "library.  It can determine the type of content (e.g. filesystem or swap) that a"
                 echo "block device holds, and also attributes (tokens, NAME=value pairs) from the"
                 echo "content metadata (e.g. LABEL or UUID fields)."
                 echo
                 echo "blkid has two main forms of operation: either searching for a device with a"
                 echo "specific NAME=value pair, or displaying NAME=value pairs  for  one  or more"
                 echo "specified devices."
                 echo
                 echo "Usage:"
                 echo "blkid -L label | -U uuid"
                 echo "blkid [-dghlv] [-c file] [-w file] [-o format] [-s tag] [-t NAME=value][device]"
                 echo "blkid -p [-O offset] [-S size] [-o format] [-s tag] [-n list] [-u list] device"
                 echo "blkid -i [-o format] [-s tag] device ..."
                 echo
                 echo "*** For more help type: man blkid"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 lsblk' '* | 'sudo lsblk '* | 'sudo lsblk')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Bb]*)
                 APP_NAME="lsblk"
                 f_application_run
                 ;;
                 lsof' '* | 'sudo lsof '* | 'sudo lsof')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Oo]*)
                 APP_NAME="lsof"
                 f_application_run
                 ;;
                 lspci' '* | 'sudo lspci '* | 'sudo lspci')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Pp] | [Ll][Ss][Pp][Cc] | [Ll][Ss][Pp][Cc][Ii])
                 APP_NAME="lspci"
                 f_application_run
                 ;;
                 lspcmcia' '* | 'sudo lspcmcia '* | 'sudo lspcmcia')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Pp] | [Ll][Ss][Pp][Cc] | [Ll][Ss][Pp][Cc][Mm]*)
                 APP_NAME="lspcmcia"
                 clear # Blank the screen.
                 echo "lspcmcia - Display extended PCMCIA debugging information."
                 echo
                 echo "lspcmcia is an alias for pccardctl ls, provided for convenience."
                 echo
                 echo "Usage:"
                 echo "lspcmcia [-V] [-v ...] [socket]"
                 echo
                 echo "*** For more help type: man lspcmcia"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 lsusb' '* | 'sudo lsusb '* | 'sudo lsusb')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll] | [Ll][Ss] | [Ll][Ss][Uu]*)
                 APP_NAME="lsusb"
                 f_application_run
                 ;;
                 pccardctl' '* | 'sudo pccardctl '* | 'sudo pccardctl')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Cc]*)
                 APP_NAME="pccardctl"
                 clear # Blank the screen.
                 echo "pccardctl - PCMCIA card control utility."
                 echo
                 echo "pccardctl  is  used  to monitor and control the state of PCMCIA sockets."
                 echo "If a socket number is specified, the command will be applied to just one"
                 echo "socket; otherwise, all sockets will be affected."
                 echo
                 echo "If pccardctl is executed by root, all commands are available."
                 echo "If it is executed by an unpriviledged user, only the informational commands"
                 echo "are accessible."
                 echo
                 echo "Usage:"
                 echo "pccardctl [-V] [-v ...] command [socket]"
                 echo
                 echo "*** For more help type: man pccardctl"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 printenv' '* | 'sudo printenv '* | 'sudo printenv')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Rr]*)
                 APP_NAME="printenv"
                 f_application_run
                 ;;
                 uptime' '* | 'sudo uptime '* | 'sudo uptime')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Pp]*)
                 APP_NAME="uptime"
                 f_application_run
                 ;;
            esac                # End of Peripheral System Information case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Peripheral System Information until loop.
} # End of f_menu_app_sys_peripherals
#
# +----------------------------------------+
# |      Function f_menu_app_sys_logs      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_logs () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Logs until loop.
            #MLO ccze      - A robust and modular log coloriser, with plugins. 
            #MLO multitail - View multiple log files using multiple panes.
            #MLO swatch    - Log file viewer with regexp matching, highlighting & hooks.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Logs Menu"
            DELIMITER="#MLO" #MLO This 3rd field prevents awk from printing this line into menu options.
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Logs case statement.
                 ccze' '* | 'sudo ccze '* | 'sudo ccze')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Cc]*)
                 APP_NAME="ccze"
                 f_application_run
                 ;;
                 multitail' '* | 'sudo multitail '* | 'sudo multitail')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Uu]*)
                 APP_NAME="multitail"
                 f_application_run
                 ;;
                 swatch' '* | 'sudo swatch '* | 'sudo swatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ww]*)
                 APP_NAME="swatch"
                 f_application_run
                 ;;
            esac                # End of System Logs case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Logs until loop.
} # End of f_menu_app_sys_logs
#
# +----------------------------------------+
# |    Function f_menu_app_sys_monitors    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Monitors until loop.
            #MSM cacti     - Frontend to rrdtool for monitoring systems and services.
            #MSM chkconfig - System update/query run-level processes at boot time.
            #MSM dstat     - View system resources, replaces vmstat, iostat, ifstat.
            #MSM glances   - View system processes/resources, CPU/Load/Mem/Swap/Disk/BW.
            #MSM iostat    - CPU usage and disk I/O process monitor.
            #MSM iotop     - Disk I/O process monitor.
            #MSM last      - Users' login/logout times from /var/log/wtmp.
            #MSM mpstat    - CPU microprocessor usage monitor.
            #MSM nmon      - CPU usage, memory, network, disk usage, processes, resources.
            #MSM rrdtool   - The Round Robin Database Tool stores/displays time-series data.
            #MSM saidar    - Monitor system processes, network I/O, disks I/O, free space.
            #MSM sar       - CPU usage statistics, user/nice/system/iowait/steal/idle.
            #MSM swatch    - Log file viewer with regexp matching, highlighting & hooks.
            #MSM tload     - System load average graphical monitor.
            #MSM yacpi     - ACPI monitor, ncurses-based.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Monitors Menu"
            DELIMITER="#MSM" #MSM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Monitors case statement.
                 cacti' '* | 'sudo cacti '* | 'sudo cacti')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Aa]*)
                 APP_NAME="cacti"
                 clear # Blank the screen.
                 echo "cacti - Frontend to rrdtool for monitoring systems and services."
                 echo
                 echo "Cacti is a complete frontend to rrdtool, it stores all of the necessary"
                 echo "information to create graphs and populates them with data in a MySQL"
                 echo "database.  The frontend is completely PHP driven.  Along with being able"
                 echo "to maintain Graphs, Data Sources, and Round Robin Archives in a"
                 echo "database, cacti handles the data gathering also.  There is also SNMP"
                 echo "support for those used to creating traffic graphs with MRTG."
                 echo
                 echo "This package requires a functional MySQL database server on either the"
                 echo "installation host or remotely accessible system.  If you do not already"
                 echo "have a database server available, you should also install mysql-server."
                 echo
                 echo "Homepage: http://www.cacti.net/"
                 echo
                 echo "*** For more help type: man cacti"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 chkconfig' '* | 'sudo chkconfig '* | 'sudo chkconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Hh]*)
                 APP_NAME="chkconfig -l"
                 clear # Blank the screen.
                 echo "chkconfig - Manipulate run-level services at boot time."
                 echo
                 echo "Usage:"
                 echo "chkconfig -t|--terse [names]"
                 echo "chkconfig -s|--set [name state]"
                 echo "chkconfig -e|--edit [names]"
                 echo "chkconfig -c|--check name [state]"
                 echo "chkconfig -l|--list [--deps] [names]"
                 echo "chkconfig -A|--allservices"
                 echo "chkconfig -a|--add [names]"
                 echo "chkconfig -d|--del [names]"
                 echo
                 echo "*** For more help type: man chkconfig"
                 echo
                 echo "Now run chkconfig. Usage: chkconfig -l"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 dstat' '* | 'sudo dstat '* | 'sudo dstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Dd] | [Dd][Ss]*)
                 APP_NAME="dstat 1 10"
                 clear # Blank the screen.
                 echo "dstat - Display system resource statistics."
                 echo
                 echo "Usage:"
                 echo "dstat [-afv] [options..] [delay [count]]"
                 echo
                 echo "*** For more help type: man dstat"
                 echo
                 echo "dstat this PC (localhost) for 10 times as an example."
                 echo
                 echo "Now run dstat. Usage: dstat 1 10"
                 f_press_enter_key_to_continue
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 glances' '* | 'sudo glances '* | 'sudo glances')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Gg] | [Gg][Ll]*)
                 APP_NAME="glances"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 iotop' '* | 'sudo iotop '* | 'sudo iotop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ii]| [Ii][Oo] | [Ii][Oo][Tt]*)
                 APP_NAME="iotop"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 iostat' '* | 'sudo iostat '* | 'sudo iostat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ii]| [Ii][Oo] | [Ii][Oo][Ss]*)
                 APP_NAME="iostat"
                 f_application_run
                 ;;
                 last' '* | 'sudo last '* | 'sudo last')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ll]| [Ll][Aa]*)
                 APP_NAME="last"
                 f_application_run
                 ;;
                 mpstat' '* | 'sudo mpstat '* | 'sudo mpstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp]*)
                 APP_NAME="mpstat 2 5"
                 clear # Blank the screen.
                 echo "mpstat - Display CPU statistics."
                 echo
                 echo "Usage:"
                 echo "mpstat [ -A ] [ -I { SUM | CPU | SCPU | ALL } ] [ -u ]"
                 echo "[ -P { cpu [,...] | ON | ALL } ] [ -V ] [ interval [ count ] ]"
                 echo
                 echo "*** For more help type: man mpstat"
                 echo
                 echo "mpstat this PC's CPU (localhost) for 5 times every 2 seconds as an example."
                 echo
                 echo "Now run mpstat. Usage: dstat 2 5"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 nmon' '-h* | 'sudo nmon '-h*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 nmon' '* | 'sudo nmon '* | 'sudo nmon')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Nn] | [Nn][Mm]*)
                 APP_NAME="nmon"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 rrdtool' '* | 'sudo rrdtool '* | 'sudo rrdtool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Rr]*)
                 APP_NAME="rrdtool"
                 clear # Blank the screen.
                 echo "rrdtool   - The Round Robin Database Tool stores/displays time-series data."
                 echo
                 echo "The Round Robin Database Tool (RRDtool) is a system to store and display"
                 echo "time-series data (e.g. network bandwidth, machine-room temperature,"
                 echo "server load average). It stores the data in Round Robin Databases (RRDs),"
                 echo "a very compact way that will not expand over time. RRDtool processes the"
                 echo "extracted data to enforce a certain data density, allowing for useful"
                 echo "graphical representation of data values."
                 echo
                 echo "RRDtool is often used via various wrappers that can poll data from devices"
                 echo "and feed data into RRDs, as well as provide a friendlier user interface and"
                 echo "customized graphs."
                 echo
                 echo "*** For more help type: man rrdtool"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 saidar' '* | 'sudo saidar '* | 'sudo saidar')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Ss] | [Ss][Aa] | [Ss][Aa][Ii]*)
                 APP_NAME="saidar"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 sar' '* | 'sudo sar '* | 'sudo sar')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Aa] | [Ss][Aa][Rr])
                 APP_NAME="sar"
                 f_application_run
                 ;;
                 swatch' '* | 'sudo swatch '* | 'sudo swatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Ww]*)
                 APP_NAME="swatch"
                 f_application_run
                 ;;
                 tload' '* | 'sudo tload '* | 'sudo tload')
                 APP_NAME=$CHOICE_APP
                 clear # Blank the screen.
                 echo tload - System load average graphical monitor.
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 [Tt] | [Tt][Ll]*)
                 APP_NAME="tload"
                 clear # Blank the screen.
                 echo tload - System load average graphical monitor.
                 echo
                 echo "To quit $APP_NAME, type Ctrl-Z or Ctrl-C."
                 echo "(There is no way to cleanly return to the menu)."
                 echo "Running $APP_NAME will exit this menu script."
                 echo
                 echo -n "Run $APP_NAME and exit script? (y/N)? "
                 read ANS
                 case $ANS in
                      [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                      f_application_run
                      ;;
                      [Nn] | [Nn][Oo] | *)
                      PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                      ;;
                 esac
                 ;;
                 yacpi' '* | 'sudo yacpi '* | 'sudo yacpi')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Yy] | [Yy][Aa]*)
                 APP_NAME="yacpi"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of System Monitors case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Monitors until loop.
} # End of f_menu_app_sys_monitors
#
# +----------------------------------------+
# |     Function f_menu_app_sys_other      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_other () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Other until loop.
            #MSO desmume - Nintendo DS emulator.
            #MSO dosemu  - DOS emulator.
            #MSO scrot   - Screen capture.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Other System Applications Menu"
            DELIMITER="#MSO" #MSO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Other System Applications case statement.
                 desmume' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Ee]*)
                 APP_NAME="desmume"
                 f_application_run
                 ;;
                 dosemu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Oo]*)
                 APP_NAME="dosemu"
                 f_application_run
                 ;;
                 scrot' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="scrot"
                 f_application_run
                 ;;
            esac                # End of Other System Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Other System Applications until loop.
} # End of f_menu_app_sys_other
#
# +----------------------------------------+
# |     Function f_menu_app_sys_process    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_process () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of System Process Applications until loop.
            #MSR atop      - View system processes/resources, CPU/Mem/Swap/Page/Disk/Net.
            #MSR htop      - View system processes/resources; bar graph of CPU/Mem/Swap.
            #MSR killall   - Kill processes based on full-name of process.
            #MSR pgrep     - Search ps output for full/partial name of process.
            #MSR pidstat   - View system processes/resources, PID/USR/System/Guest/CPU/Cmd.
            #MSR pkill     - Kill processes based on partial name of process.
            #MSR pmap      - View process memory usage.
            #MSR ps        - View system processes/resources, PID/PGID/SID/TTY/Time/Cmd.
            #MSR pstree    - Tree view system processes/resources, like "ps" command.
            #MSR pswatcher - Execute commands when certain processes are run.
            #MSR pwdx      - Report current working directory of a process.
            #MSR strace    - Trace process system calls and signals.
            #MSR sysctl    - Configure kernel parameters at runtime.
            #MSR top       - View system PID/User/PR/NI/VERT/RES/SHR/CPU/MEM/Time/Cmd.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Process Applications Menu"
            DELIMITER="#MSR" #MSR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Process Applications case statement.
                 atop' '* | 'sudo atop '* | 'sudo atop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Aa] | [Aa][Tt]*)
                 APP_NAME="atop"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 htop' '* | 'sudo htop '* | 'sudo htop')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q or <F10>"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Hh] | [Hh][Tt]*)
                 APP_NAME="htop"
                 f_how_to_quit_application "q or <F10>"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 killall' '* | 'sudo killall '* | 'sudo killall')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Kk] | [Kk][Ii]*)
                 APP_NAME="killall"
                 f_application_run
                 ;;
                 pgrep' '* | 'sudo pgrep '* | 'sudo pgrep')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Gg]*)
                 APP_NAME="pgrep"
                 f_application_run
                 ;;
                 pidstat' '* | 'sudo pidstat '* | 'sudo pidstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ii]*)
                 APP_NAME="pidstat 2 3"
                 clear # Blank the screen.
                 echo "pidstat - View system processes/resources, PID/USR/System/Guest/CPU/Cmd."
                 echo
                 echo "pidstat this PC's CPU (localhost) for 3 times every 2 seconds as an example."
                 echo
                 echo "*** For more help type: man pidstat"
                 echo
                 echo "Now run pidstat. Usage: pidstat 2 3"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 pkill' '* | 'sudo pkill '* | 'sudo pkill')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Kk]*)
                 APP_NAME="pkill"
                 f_application_run
                 ;;
                 pmap' '* | 'sudo pmap '* | 'sudo pmap')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Mm]*)
                 APP_NAME="pmap"
                 f_application_run
                 ;;
                 ps' '* | 'sudo ps '* | 'sudo ps')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ss])
                 APP_NAME="ps -ejH"
                 clear # Blank the screen.
                 echo "ps - View system processes/resources, PID/PGID/SID/TTY/Time/Cmd."
                 echo
                 echo "Usage:"
                 echo "To see every process on the system using standard syntax:"
                 echo "[ps -e ] [ ps -ef ] [ ps -eF ] [ ps -ely ]"
                 echo
                 echo "To see every process on the system using BSD syntax:"
                 echo "[ ps ax] [ ps axu ]"
                 echo
                 echo "To print a process tree:"
                 echo "[ ps -ejH ] [ ps axjf ]"
                 echo
                 echo "To get info about threads:"
                 echo "[ ps -eLf ] [ ps axms ]"
                 echo
                 echo "To see every process running as root (real & effective ID) in user format:"
                 echo "[ ps -U root -u root u ]"
                 echo
                 echo "*** For more help type: man ps"
                 echo
                 echo "Now run ps. Usage: ps -ejH"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 pstree' '* | 'sudo pstree '* | 'sudo pstree')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ss] | [Pp][Ss][Tt]*)
                 APP_NAME="pstree"
                 f_application_run
                 ;;
                 pswatcher' '* | 'sudo pswatcher '* | 'sudo pswatcher')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ss] | [Pp][Ss][Ww]*)
                 APP_NAME="pswatcher"
                 clear # Blank the screen.
                 echo "pswatcher - Monitor a system via ps-like commands."
                 echo
                 echo "This program runs the ps command periodically and triggers commands on matches."
                 echo "The match patterns are Perl regular expressions which can refer to the process"
                 echo "information via variables."
                 echo "For example it can be used to ensure that a daemon is running, or is not"
                 echo "running too many times. It can also be used to determine when a process has"
                 echo "consumed too many resources, perhaps due to a memory leak."
                 echo "Homepage: http://ps-watcher.sourceforge.net/"
                 echo
                 echo "*** For more help type: man pswatcher"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 pwdx' '* | 'sudo pwdx '* | 'sudo pwdx')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Pp] | [Pp][Ww]*)
                 APP_NAME="pwdx"
                 f_application_run
                 ;;
                 strace' '* | 'sudo strace '* | 'sudo strace')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Tt]*)
                 APP_NAME="strace"
                 f_application_run
                 ;;
                 sysctl' '* | 'sudo sysctl '* | 'sudo sysctl')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Yy]*)
                 APP_NAME="sysctl"
                 clear # Blank the screen.
                 echo "sysctl - Configure kernel parameters at runtime."
                 echo
                 echo "sysctl is used to modify kernel parameters at runtime."
                 echo "The parameters available are those listed under /proc/sys/."
                 echo "Procfs is required for sysctl support in Linux.  You can use sysctl to both"
                 echo "read and write sysctl data."
                 echo
                 echo "Usage:"
                 echo "       sysctl [-n] [-e] variable ..."
                 echo "       sysctl [-n] [-e] [-q] -w variable=value ..."
                 echo "       sysctl [-n] [-e] [-q] -p [filename]"
                 echo "       sysctl [-n] [-e] -a"
                 echo "       sysctl [-n] [-e] -A"
                 echo
                 echo "EXAMPLES"
                 echo "       /sbin/sysctl -a"
                 echo "       /sbin/sysctl -n kernel.hostname"
                 echo "       /sbin/sysctl -w kernel.domainname='example.com'"
                 echo "       /sbin/sysctl -p /etc/sysctl.conf"
                 echo
                 echo "*** For more help type: man sysctl"
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 top' '* | 'sudo top '* | 'sudo top')
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 [Tt] | [Tt][Oo]*)
                 APP_NAME="top"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of System Process Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Process Applications until loop.
} # End of function f_menu_app_sys_process
#
# +----------------------------------------+
# |    Function f_menu_app_sys_screens     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_screens () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Screens until loop.
            #MSC byobu  - Multiple sessions.
            #MSC dtach  - Emulates detach feature of screen.
            #MSC dvtm   - dwm-style (tiling) window manager.
            #MSC fbterm - Fast terminal emulator, multiple fonts, multiple windows.
            #MSC screen - Multiple sessions via split or pager screens.
            #MSC vlock  - Locks virtual console or current terminal.
            #MSC tmux   - Multiple sessions with multiplexing.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Screens Menu"
            DELIMITER="#MSC" #MSC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Screens case statement.
                 byobu' '* | 'sudo byobu '* | 'sudo byobu')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Bb] | [Bb][Yy]*)
                 APP_NAME="byobu"
                 f_application_run
                 ;;
                 dtach' '* | 'sudo dtach '* | 'sudo dtach')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Tt]*)
                 APP_NAME="dtach"
                 f_application_run
                 ;;
                 dvtm' '* | 'sudo dvtm '* | 'sudo dvtm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Vv]*)
                 APP_NAME="dvtm"
                 f_application_run
                 ;;
                 fbterm' '* | 'sudo fbterm '* | 'sudo fbterm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb]*)
                 APP_NAME="fbterm"
                 f_application_run
                 ;;
                 screen' '* | 'sudo screen '* | 'sudo screen')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Cc]*)
                 APP_NAME="screen"
                 clear # Blank the screen.
                 echo "screen - Multiple screen-window sessions."
                 echo 
                 echo "Usage:"
                 echo "Ctrl-A <double-quote> List all windows."
                 echo "Ctrl-A N     Show window title."
                 echo "Ctrl-A a     Name title of the window."
                 echo
                 echo "Ctrl-A c     Create new window."
                 echo "Ctrl-A n     Switch to next window."
                 echo "Ctrl-A p     Switch to previous window."
                 echo "Ctrl-A l     Refresh window."
                 echo "Ctrl-A <single-quote> Prompt window number to use."
                 echo "Ctrl-A (0-9 or -)  Switch to window number to use."
                 echo
                 echo "Ctrl-A k     Kill window."
                 echo "Ctrl-A S     Split window horizontally."
                 echo "Ctrl-A <tab> Toggle between split window areas."
                 echo "Ctrl-A x     Kill split window area."
                 echo
                 echo "*** For more help type: man screen"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 tmux' '* | 'sudo tmux '* | 'sudo tmux')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Tt] | [Tt][Mm]*)
                 APP_NAME="tmux"
                 f_application_run
                 ;;
                 vlock' '* | 'sudo vlock '* | 'sudo vlock')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ll]*)
                 APP_NAME="vlock"
                 f_application_run
                 ;;
            esac                # End of System Screens case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of System Screens until loop.
} # End of f_menu_app_sys_screens
#
# +----------------------------------------+
# |    Function f_menu_app_sys_software    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_software () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of System Softare Applications until loop.
            #MSF alien    - Converts rpm to deb packages.
            #MSF apt      - Debian package manager.
            #MSF aptitude - Debian package manager.
            #MSF aptoncd  - GUI makes a CD of Debian packages for installation w/o Internet.
            #MSF dpkg     - Debian package manager.
            #MSF rpm      - RPM (Red Hat) package manager.
            #MSF synaptic - GUI Debian package manager.
            #MSF unshield - Extracts CAB files from InstallShield installers for MS Windows.
            #MSF urpmi    - Mandriva, Mageia package manager.
            #MSF YaST     - GUI OpenSUSE package manager.
            #MSF yum      - "Yellow Dog Updated" package manager.
            #MSF zypper   - OpenSUSE package manager on which is based YaST GUI.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Software Applications Menu"
            DELIMITER="#MSF" #MSF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Software Applications case statement.
                 alien' '* | 'sudo alien '* | 'sudo alien')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Ll]*)
                 APP_NAME="alien"
                 f_application_run
                 ;;
                 apt' '* | 'apt-'* | 'sudo apt' | 'sudo apt '* | 'sudo apt-'*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Tt])
                 APP_NAME="apt"
                 clear # Blank the screen.
                 echo "apt - Debian package manager."
                 echo
                 echo "Usage:"
                 echo "apt-cache showpkg <package name> Show package general information."
                 echo "apt-cache show <package name> Show package description and information."
                 echo "apt-cache depends <package name> Show package dependency information."
                 echo "apt-cache rdepends <package name> Show package reverse dependency information."
                 echo "apt-cache unmet <package name> Show package's unmet dependencies."
                 echo "apt-get check Check for broken dependencies."
                 echo "apt-get update Updates package information prior to updating or installing."
                 echo "apt-get upgrade Upgrade packages to latest versions."
                 echo "apt-get dist-upgrade Usually used after an 'apt-get upgrade' to upgrade kernel."
                 echo "apt-get install <package name> Installs a new software package."
                 echo "apt-get remove <package name> Uninstalls a software package."
                 echo "apt-get purge <package name> Uninstalls a package and its configuration files."
                 echo "apt-get autoclean Remove obsolete packages from the local repository."
                 echo "apt-get autoremove remove packages that are no longer needed."
                 echo
                 echo "*** For more help type: man apt / man apt-cache / man apt-get"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 aptitude' '* | 'sudo aptitude '* | 'sudo aptitude')
                 APP_NAME=$CHOICE_APP
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 f_application_run
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Tt] | [Aa][Pp][Tt][Ii]*)
                 APP_NAME="aptitude"
                 clear # Blank the screen.
                 echo "aptitude - Debian package manager."
                 echo 
                 echo "Usage:"
                 echo "aptitude [-S fname] [-u|-i]"
                 echo "aptitude [options] <action> ..."
                 echo 
                 echo "Options:"
                 echo " -h    This help text."
                 echo " -D    Show the dependencies of automatically changed packages."
                 echo " -v    Display extra information. (may be supplied multiple times)."
                 echo " -f    Aggressively try to fix broken packages."
                 echo  
                 echo "Actions (if none is specified, aptitude will enter interactive mode):"
                 echo "search    - Search for a package by name and/or expression."
                 echo "show      - Display detailed information about a package."
                 echo "install   - Install/upgrade packages."
                 echo "reinstall - Download and (possibly) reinstall a currently installed package."
                 echo "remove    - Remove packages."
                 echo "purge     - Remove packages and their configuration files."
                 echo "update    - Download lists of new/upgradable packages."
                 echo
                 echo "*** For more help type: man apt / man apt-cache / man apt-get"
                 f_press_enter_key_to_continue
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 f_application_run
                 ;;
                 'aptoncd '* | 'sudo aptoncd '* | 'sudo aptoncd')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Pp] | [Aa][Pp][Tt] | [Aa][Pp][Tt][Oo]*)
                 APP_NAME="aptoncd"
                 clear # Blank the screen.
                 echo "APTonCD - A GUI application and is in the menu for reference only."
                 echo
                 echo "However, like many GUI applications, it can be launched by from the CLI."
                 echo "APTonCD can be launched from the command line with the 'aptoncd' command."
                 echo
                 echo "APTonCD allows you to create an installation CD with all the debian packages"
                 echo "installed on the localhost PC from the /var/cache/apt/archives/ directory."
                 echo "It is one way to backup the software installed on your PC but such would"
                 echo "have to be reconfigured afterwards."
                 echo
                 echo "APTonCD is fully supported in Ubuntu and works in Debian Etch and Sid."
                 echo
                 f_press_enter_key_to_continue
                 ;;
                 dpkg' '* | 'dpkg-'* | 'sudo dpkg '* | 'sudo dpkg' | 'sudo dpkg-'*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Dd] | [Dd][Pp]*)
                 APP_NAME="dpkg"
                 clear # Blank the screen.
                 echo "dpkg - Debian package manager."
                 echo
                 echo "Usage:"
                 echo "dpkg --get-selections List all installed packages."
                 echo "dpkg-query -l <package name> Show package installation status."
                 echo "dpkg-query -p <package name> Show package description and information."
                 echo "dpkg -i <package name> Installs a new software package."
                 echo "dpkg -r <package name> Uninstalls a software package."
                 echo "dpkg -P <package name> Uninstalls a package and its configuration files."
                 echo
                 echo "*** For more help type: man dpkg / man dpkg-query"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 rpm' '* | 'sudo rpm '* | 'sudo rpm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Rr] | [Rr][Pp]*)
                 APP_NAME="rpm"
                 clear # Blank the screen.
                 echo "rpm - RPM (Red Hat) package manager."
                 echo
                 echo "Usage:"
                 echo "rpm -q <package name> Show package description and information."
                 echo "rpm --query <package name> Show package description and information."
                 echo "rpm -U <package name> Upgrade/Install a package."
                 echo "rpm --upgrade <package name> Upgrade/Install a package."
                 echo "rpm -I <package name> Installs new software packages."
                 echo "rpm --install <package name> Installs new software packages."
                 echo "rpm -e <package name> Uninstalls software packages."
                 echo "rpm --erase <package name> Uninstalls software packages."
                 echo "rpm -V <package name> Verifies packages."
                 echo "rpm --verify <package name> Verifies packages."
                 echo "rpm -F <package name> Freshen (upgrade) installed packages."
                 echo "rpm --freshen<package name> Freshen (upgrade) installed packages."
                 echo "rpm --initdb Initialize package database."
                 echo "rpm --rebuilddb Rebuild package database."
                 echo
                 echo "*** For more help type: man rpm"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 synaptic' '* | 'sudo synaptic '* | 'sudo synaptic')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ss] | [Ss][Yy]*)
                 APP_NAME="synaptic"
                 clear # Blank the screen.
                 echo "Synaptic - A GUI package manager and is in the menu for reference only."
                 echo
                 echo "However, like many GUI applications, it can be launched by from the CLI."
                 echo "Synaptic can be launched from the command line with the 'synaptic' command."
                 echo
                 f_press_enter_key_to_continue
                 ;;
                 unshield' '* | 'sudo unshield '* | 'sudo unshield')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | Uu][Nn]*)
                 APP_NAME="unshield"
                 f_application_run
                 ;;
                 urpmi' '* |  'sudo urpmi '* | 'sudo urpmi')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Uu] | [Uu][Rr]*)
                 APP_NAME="urpmi"
                 f_application_run
                 ;;
                 yast' '* | 'sudo yast '* | 'sudo yast')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Aa]*)
                 APP_NAME="yast"
                 clear # Blank the screen.
                 echo "YaST - A GUI package manager and is in the menu for reference only."
                 echo
                 echo "However, like many GUI applications, it can be launched by from the CLI."
                 echo "YaST can be launched from the command line with the 'yast' command."
                 echo
                 f_press_enter_key_to_continue
                 ;;
                 yum' '* | 'sudo yum '* | 'sudo yum')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Uu]*)
                 APP_NAME="yum"
                 clear # Blank the screen.
                 echo "yum - 'Yellow Dog Updated' package manager."
                 echo
                 echo "Usage:"
                 echo "yum upgrade <package name> Upgrade/Install a package."
                 echo "yum -list <package name> Show package description and information."
                 echo "yum search <text> Searches package names, descriptions, summaries."
                 echo "yum provides <text> Searches files, packages providing a function."
                 echo "yum update Upgrade packages to latest versions."
                 echo "yum install <package name> Installs new software packages."
                 echo "yum groupinstall <application name> Installs new software packages."
                 echo "yum remove <package name> Uninstalls software packages."
                 echo
                 echo "*** For more help type: man yum"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 zypper' '* | 'sudo zypper '* | 'sudo zypper')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Zz] | [Zz][Yy]*)
                 APP_NAME="zypper"
                 clear # Blank the screen.
                 echo "zypper - Zypper package manager."
                 echo
                 echo "Usage:"
                 echo "zypper search -is List installed packages."
                 echo "zypper search -d <text> searches package names, descriptions, summaries."
                 echo "zypper update Upgrade packages to latest versions."
                 echo "zypper install <package name> Installs new software packages."
                 echo "zypper remove <package name> Uninstalls software packages."
                 echo "zypper refresh Refresh repository package information."
                 echo "zypper list-updates List updates available for installed packages."
                 echo "zypper dist-upgrade Upgrade kernel to next version."
                 echo
                 echo "*** For more help type: man zypper"
                 echo
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
            esac                # End of Synstem Software Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Synstem Software Applications until loop.
} # End of function f_menu_app_sys_software
#
# +----------------------------------------+
# |        Function f_menu_cat_video       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_video () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
      do    # Start of Video Application Category until loop.
            #BVI Editors - Video editors, transcoders, converters.
            #BVI Players - Video players/downloaders.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Video Application Category Menu"
            DELIMITER="#BVI" #BVI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_common_scat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of Video Application Category case statement.
                 [Ee] | [Ee][Dd]*)
                 f_menu_app_video_editors     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 [Pp] | [Pp][Ll]*)
                 f_menu_app_video_players     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Video Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_scat_bad_menu_choice
      done  # End of Video Application Category until loop.
} # End of function f_menu_cat_video
#
# +----------------------------------------+
# |    Function f_menu_app_video_editors   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_video_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Video Applications until loop.
            #MVE avconv        - Audio/Video converter.
            #MVE avidemux      - Editor for simple cutting, filtering, encoding.
            #MVE ffmpeg        - Multimedia Record, convert, stream and play. 
            #MVE handbrake-cli - Transcoder ideal for batch mkv/x264 ripping.
            #MVE mencoder      - Mplayer's encoder AVI/ASF/OGG/DVD/VCD/VOB/MPG/MOV etc.
            #MVE mjpegtools    - MJPEG video playback, editing, video capture.
            #MVE mpgtx         - Editor splits/joins MPEG, MP3. video/audio files.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Video Editor Applications Menu"
            DELIMITER="#MVE" #MVE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Video Editor Applications case statement.
                 avconv' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 [Aa] | [Aa][Vv] | [Aa][Vv][Cc]*)
                 APP_NAME="avconv"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 avidemux' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Vv] | [Aa][Vv][Ii]*)
                 APP_NAME="avidemux"
                 f_application_run
                 ;;
                 ffmpeg' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Ff]*)
                 APP_NAME="ffmpeg"
                 f_application_run
                 ;;
                 handbrake-cli' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Hh] | [Hh][Aa]*)
                 APP_NAME="handbrake-cli"
                 f_application_run
                 ;;
                 mencoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ee]*)
                 APP_NAME="mencoder"
                 f_application_run
                 ;;
                 mjpegtools' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Jj]*)
                 APP_NAME="mjpegtools"
                 f_application_run
                 ;;
                 mpgtx' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp]*)
                 APP_NAME="mpgtx"
                 f_application_run
                 ;;
            esac                # End of Video Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Video Editor Applications until loop.
} # End of function f_menu_app_video_editors
#
# +----------------------------------------+
# |    Function f_menu_app_video_players   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMITER, PRESS_KEY, CHOICE_APP
#
f_menu_app_video_players () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
      do    # Start of Video Applications until loop.
            #MVI aaxine       - xine video player.
            #MVI cacaxine     - xine video player.
            #MVI cclive       - Download/Play Youtube videos.
            #MVI episoder     - Reads "tv.com" and "epguides.com" for new TV episodes.
            #MVI fbxine       - xine video player.
            #MVI mencoder     - Mplayer's encoder AVI/ASF/OGG/DVD/VCD/VOB/MPG/MOV etc.
            #MVI mplayer      - Multimedia player MPEG,AVI, Ogg/OGM, QT/MOV/MP4, ASF/WMA/WMV.
            #MVI mplayer2     - Multimedia player MPEG,AVI, Ogg/OGM, QT/MOV/MP4, ASF/WMA/WMV.
            #MVI vlc          - VideoLAN media player MPEG, MOV, WMV, QT, WebM, MP3, etc.
            #MVI xine-console - xine video player AVI, DVD, SVCD, VCD, MPEG, QuickTime.
            #MVI yougrabber   - Download/Play Youtube videos.
            #MVI youtube-dl   - Download/Play Youtube videos.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Video Player/Downloader Applications Menu"
            DELIMITER="#MVI" #MVI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_common_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Video Player/Downloader Applications case statement.
                 aaxine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Aa] | [Aa][Aa]*)
                 APP_NAME="aaxine"
                 f_application_run
                 ;;
                 cacaxine'*')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Aa]*)
                 APP_NAME="cacaxine"
                 f_application_run
                 ;;
                 cclive' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Cc] | [Cc][Cc]*)
                 APP_NAME="cclive"
                 f_application_run
                 ;;
                 episoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ee] | [Ee][Pp]*)
                 APP_NAME="episoder"
                 f_application_run
                 ;;
                 fbxine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Ff] | [Ff][Bb]*)
                 APP_NAME="fbxine"
                 f_application_run
                 ;;
                 mencoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Ee]*)
                 APP_NAME="mencoder"
                 f_application_run
                 ;;
                 mplayer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr])
                 APP_NAME="mplayer"
                 f_application_run
                 ;;
                 mplayer2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr][2])
                 APP_NAME="mplayer2"
                 f_application_run
                 ;;
                 vlc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Vv] | [Vv][Ll]*)
                 APP_NAME="vlc"
                 f_application_run
                 ;;
                 xine-console' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Xx] | [Xx][Ii]*)
                 APP_NAME="xine-console"
                 f_application_run
                 ;;
                 yougrabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Oo] | [Yy][Oo][Uu] | [Yy][Oo][Uu][Gg]*)
                 APP_NAME="yougrabber"
                 f_application_run
                 ;;
                 youtube-dl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 [Yy] | [Yy][Oo] | [Yy][Oo][Uu] | [Yy][Oo][Uu][Tt]*)
                 APP_NAME="youtube-dl"
                 f_application_run
                 ;;
            esac                # End of Video Player/Downloader Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done  # End of Video Player/Downloader  Applications until loop.
} # End of function f_menu_app_video_players
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
# Test the environment for DASH.
f_test_dash
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
           echo -n "Download from which branch? (STABLE/testing/quit): "
           read ANS
           case $ANS in
                [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
                PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                ;;
                [Tt] | [Tt][Ee] | [Tt][Ee][Ss]| [Tt][Ee][Ss][Tt]*)
                
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/cli-app-menu.sh"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/lib_cli-common.lib"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/lib_cli-menu-apps.lib"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/lib_cli-menu-cat.lib"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/README"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/COPYING"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/testing/EDIT_HISTORY"
                wget $WEB_SITE
                ANS="TESTING"
                echo "Downloaded files from github $ANS branch." 
                echo "Downloaded files are in the same folder as this script."
                echo
                echo "The file names will be appended with a '.1'"
                echo "and you will have to MANUALLY COPY THEM to the original names."
                PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                ;;                  
                "" | [Ss] | [Ss][Tt] | [Ss][Tt][Aa] | [Ss][Tt][Aa][Bb]*)  
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/cli-app-menu.sh"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/README"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/COPYING"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/EDIT_HISTORY"
                wget $WEB_SITE
                ANS="STABLE"
                echo "Downloaded files from github $ANS branch." 
                echo "Downloaded files are in the same folder as this script."
                echo
                echo "The file names will be appended with a '.1'"
                echo "and you will have to MANUALLY COPY THEM to the original names."
                PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                ;;
           esac
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
           #    one "#M". Results are printed, showing everything after "#M".
           #    i.e.      Selected: "#MGF bastet         - Tetris-like game." #MGF This 3rd field prevents awk from  printing this line into menu options.
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
