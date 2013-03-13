#!/bin/bash
# File naming convention for archiving: $THIS_FILE_<YYYY-MM-DD_HHMM>.sh
#
# The double # at the beginning of lines below are used to delineate the Edit History.
#
## Edit History
##
## After each edit made, update Edit History and version (date stamp string) of
## script.
THIS_FILE="cli-app-menu.sh"
#
# Calculate revision number by counting all lines starting with "## 2013".
# grep ^ (carot sign) means grep any lines beginning with "##2013".
# grep -c means count the lines that match the pattern.
#
REVISION=$(grep ^"## 2013" -c $THIS_FILE) ; REVISION="2013.$REVISION"
REVDATE="03/13/2013 00:05"
#
#LIC ©2013 Copyright 2013 Bob Chin
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
##
## 2013-03-12   *Add copyright and license text. Add Main Menu option "License".
##              *f_menu_app_sys_monitors add f_how_to_quit_application.
##              *f_menu_app_text_editors add f_how_to_quit_application.
##              *f_menu_app_sys_monitors add application saidar.
##              *f_application_error create installation routine for glances.
##              *f_show_menu supress line-feed at options prompt, fix $MAX.
##              *f_menu_app_audio_application add avconv.
##
## 2013-03-09   *f_application_error add case statement to install bsdgames
##                if any of the games included in bsdgames are not installed.
##              *Automatically calculate revision number using grep -c(ount).
##              *Add sub-menus for Games.
##              *f_quit_app_menu, f_quit_subcat_menu delete "Quit", "Exit"
##               options leave only zero and "Return" because "Quit" is too
##               close to "Quiz" game, and "Exit" was undocumented.
##              *f_show_menu display new Quit message when in Main Menu.
##              *Change delimiter for main menu and application category menus
##               so it is obvious to differentiate from application menus.
##              *f_show_menu display help mesage only for application menus.
##              *Documented all variables used and list of delimiters.
##              *Remove hard-coding of script file-name use $THIS_FILE instead.
##              *f_application_error now extracts package name from $APP_NAME
##               when it includes additional parameters separated by spaces.
##
## 2013-03-07   *f_application_error add trap for error code 1 for sudo.
##              *Add function f_application_run to re-run newly installed apps.
##              *Rework all application menus to use f_application_run.
##
## 2013-03-06   *f_menu_app_sys_monitors add System tools, cfdisk, parted.
##              *f_menu_app_text_editors add Text tools, colordiff, diff, vimdiff, wdiff.
##
## 2013-03-04 - *Clean up displays so text fits on an 80-column wide screen.
##              *f_application_error add error message if installation fails.
##              *f_show_menu start menu option numbering at 1 not zero.
##              *f_show_menu add option 0, to quit.
##              *Delete option 0, to quit in all f_sub-menus.
##
## 2013-03-03 - *Created sub-menu, "Network Category" under Applications menu.
##              *Added Network applications smbclient, smbstatus, testparm.
##              *Add function f_press_enter_key_to_continue.
##              *Add function f_menu_app_press_enter.
##              *Add function f_menu_app_press_enter in application functions.
##              *Delete statements "read x" in application functions.
##              *f_application_error fix bad syntax [ $ERROR <> 0 ].
##              *f_application_help fix bad syntax [ $ERROR <> 0 ].
##              *f_application_help enhance and clarify error messages.
##
## 2013-02-26 - *Added cbm, a system resource monitor, and smbc, file manager
##               for Samba server shared folders.
##              *f_menu_app_text_editors add text editors, ed, emacs, pico, vi.
##              *f_menu_app_spreadsheets_editors add spreadsheets, oleo, slsc.
##              *f_menu_app_calendar-todo add calendars, cal, remind.
##              *f_menu_app_calendar-todo add To-Do list, devtodo.
##
## 2013-02-20 - *Created sub-menu, "System Category" under Applications Menu.
##              *Cleaned up menus, sorted items by function.
##              *Add function f_menu_cat_sample_template.
##
## 2013-02-19 - f_application_error, improve error message processing.
##
## 2013-02-18 - Add more applications, clean up more code.
##
## 2013-02-17 - Add case string pattern matching for all Internet applications.
##
## 2013-02-14 - *Clean up listing for readability.
##              *Create sub-menu, "Internet Category" under Applications Menu. 
##              *Add Internet application menus for web browsers, bittorrent, 
##               downloaders, email, FAX, file transfer, instant messaging,
##               Internet relay chat, news readers, network chat, podcatchers,
##               remote connection and RSS feeders.
##              *Make all application menus into functions rather than using
##               nested until loops.
##              *Add functions f_menu_app_sample_template, f_initvars_menu_app,
##               f_menu_app_internet.
##              *Bug fix f_application_error by adding f_initvars_menu_app to
##               prevent return to previous menu rather than return to the same
##               menu where the error occurred.
##
## 2013-02-12 - Create functions for each application menu to allow greater
##              flexibility to re-arrange menu structure and allow the
##              possibility of sub-menus.
##
## 2013-01-29 - Create function f_termcolor to set terminal properties.
##
## 2013-01-28 - Bug fix with option "exit" not working with CLI Menu and
##              Application Category Menu.
##
## 2013-01-26 - *Use grep to calculate the number of the last menu option.
##              *Create functions show_menu, quit_app_menu, application_help to
##               eliminate repeated code.
##              *Create function f_application_error with an option to install
##               a missing application.
##              *f_application_help, add error trapping to trap lack of help 
##               manual or help messages.
##              *Add option to quit any menu by entering "exit".
##
## 2013-01-24 - *Use sed/awk (not echo) to display menu and calculate $MAX.
##              *This took several days to figure out but now I grok awk.
##              *Add a HOW-TO Add new item under General Help.
##
## 2013-01-16 - *Edit History, improve sed to display without leading "##" by
##               using substitution of null for "##".
##              *Application menus, finish adding help options.
##              *System menu, delete application cmatrix.
##              *System menu, add application top.
##              *System menu, add application htop.
##              *System menu, add application glances.
##              *Network menu, add application iftop. 
##              *Games menu, add applications cribbage, boggle.
##              *Games menu, delete package name debian-jr-games.
##
## 2013-01-15 - *Edit History, use sed to display text.
##              *All menus, change prompt from "Choose 0 to $MAX or name" 
##               to "Enter 0 to$MAX or letters".
##              *Application menus, add help options to all applications
##               accessible from the applications menus.
##
## 2013=01-14 - CLI Menu, add Black/White screen options.
##
## 2013-01-08 - Case pattern matching for strings is enabled for all menus.
##
## 2013-01-07 - Figured out how to use pattern matching to match input string
##              in case statements.
##
## 2013-01-02 - *Put MAX variable inside current until loop to prevent inner
##               loops from changing value on exit.
##              *Do not clear screen before displaying each application menu so
##               that you can see any error messages.
##              *Add CLI Menu option 'About CLI Menu' and get menu options
##               'Help' and 'Free disk space' working.
##
## 2013-01-01 - *Change to using until loops because the while loops abnormally
##               exit if read input is not an integer.
##              *Use while loops rather than until loops since continuing to
##               loop and exiting loop is simpler, since you do not need to set
##               conditional variables to an invalid state to force looping.
##
## 2012-12-31 - *Create menu driven CLI application launcher.
##              *Case statements drove me crazy, learning pattern matching.
##
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
#:   give back to the community and perhaps others could build on and improve on
#:   what I've started.
#:
#: Please enjoy . . . bob chin (2013).
#:
#:
#: +----------------------------------------+
#: |      Why is this menu so complex?      |
#: +----------------------------------------+
#:
#: Why not use the select command? Why not be a lazier pattern matcher?
#:
#: *I used to be a MUMPS programmer and QA analyst.
#:
#: *I used to create menus in this style in MUMPS and being a QA person, my job
#:  was to try to break programs. So that's why I tried to make pattern matching
#:  so robust rather than use wild-cards.
#:
#: *My QA background also explains this crazy documentation of everything along
#:  with the fact that I am just learning bash scripting.
#:
#:
#: +----------------------------------------+
#: |             Script features            |
#: +----------------------------------------+
#:
#: *Run-time displayed text is no wider than 80-columns across.
#:
#: *You can get application help by 'man' or '--help' from the menu prompt.
#:
#: *If an application is not installed, script will automatically install it.
#:
#: *If an application needs sudo, script will automatically give a sudo option.
#:
#: *Designed for ease of extensibility and menu editing.
#:
#: *Option numbers in menu display are automatically generated.
#:  (However, case pattern matching including option numbers are hand-written).
#:
#: *More fun than just a list of CLI applications!!!
#:
#:
#: +----------------------------------------+
#: |       HOW-TO Add a new menu item       |
#: +----------------------------------------+
#:
#: 1. The menu code is contained in functions before the main program code.
#:
#: 2. Within the menu function, decide what row in the menu that you want
#:    to place the new menu item.
#:
#: 3. Add the item string: <Special Menu Option Marker beginning with #> <name
#:    of item> <space><dash><space> <description>
#:
#:    Each Special Menu Option Marker MUST be unique for each menu.
#:
#:    Note: Please see bottom of this document 
#:          for a list of Special Menu Option Markers.
#:
#: 4. Create a new case statement with a corresponding pattern for the new item.
#: 
#: 5. Adjust the case statement patterns of menu items after the new menu item.
#:    If you added the item in the middle of the menu, all case patterns for the
#:    items below it need to be adjusted.
#:
#:    i.e. The number in the case pattern would need to be incremented by 1 
#:         for the items below the new item.
#:
#:    The case patterns will accept both the menu option number, or all or part

#:    of the menu item name in upper or lower case or any mixture of case.
#:
#:
#:
#: +----------------------------------------+
#: |  List of variables used in this script |
#: +----------------------------------------+
#:
#: APP_NAME    - String; application name also command to run.
#: APP_NAME_INSTALL - String; used when APP_NAME does not match actual package
#:               name to be installed. i.e. APP_NAME="trek" but package name is
#:               actually "bsdgames". So to install "trek" game, you must
#:               instead install package "bsdgames", a collection of games.
#: APP_RUN     - String; Command to run when application is a web browser,
#:               actually also includes name of web site to browse.
#: CHOICE_APP  - String; User choice in Applications Menu. '0' means quit menu.
#:               '-1' stay in menu loop
#:               '-2' means application help invoked so don't show
#:               "Press enter key to continue" message again.
#: CHOICE_CAT  - String; User choice in Applications Category Menu.
#: CHOICE_MAIN - String; User choice in Main Menu.
#: CHOICE_SCAT - String; User choice in Sub-Category Menu.
#: DELIMITER   - String; Delimiter prefix of menu option string.
#: ERROR       - Number; Save error code number from $? function.
#: MAX         - Number; Maximum option choice number in menu.
#: MENU_TITLE  - String; Title of menu.
#: NUM         - Number; Scratch variable used in awk statement in f_show_menu.
#: REVDATE     - String; Revision date of shell script.
#: REVISION    - String; Revision number of shell script.
#: TCOLOR      - String; Background color of display terminal; Black or White.
#: THIS_FILE   - String; name of shell script.
#: WEB_SITE    - String; name of web site used when application is a web browser.
#:
#:
#: +----------------------------------------+
#: |   List of Special Menu Option Markers  |
#: +----------------------------------------+
#:
#:AAA - Main Menu
#:AAB - Application Categories Menu
#:
#:BGA - Game Categories Menu
#:BIN - Internet Categories Menu
#:BNE - Network Categories Menu
#:BSY - System Categories Menu
#:BXC - Sample Template Application Categories Menu
#:
#:MAU - Audio Applications Menu
#:MBT - Bittorrent Applications Menu
#:MCA - Calendar-ToDo Applications Menu
#:MCC - Calculator Applications Menu
#:MDL - Dowloader Applications Menu
#:MED - Education Applications Menu
#:MEM - E-mail Applications Menu
#:MFI - File Manager Applications Menu
#:MFT - File Transfer Applications Menu
#:MFX - FAX Applications Menu
#:MGB - Arcade Games
#:MGC - Board Games
#:MGD - Card Games
#:MGE - MUD (Multi-user Dungeons)
#:MGF - Puzzles
#:MGG - Quiz
#:MGH - RPG (Role-Playing Games)
#:MGI - Simulation Games
#:MGJ - Strategy Games
#:MGK - Word Games
#:MGI - Simulation Games
#:MGJ - Strategy Games
#:MGK - Word Games
#:MIG - Image-Graphics Applications Menu
#:MIM - Instant Messaging Applications Menu
#:MIR - Internet Relay Chat (IRC) Applications Menu
#:MNC - Network Chat Applications Menu
#:MNF - Network Configuration Applications Menu
#:MNM - Network Monitor Applications Menu
#:MNO - Note Applications Menu
#:MNR - News Reader Applications Menu
#:MPO - Podcatcher Applications Menu
#:MRC - Remote Connection Applications Menu
#:MRS - RSS News Feeder Applications Menu
# MSC - System Screen Applications Menu
#:MSP - Spreadsheet Applications Menu
#:MSS - Screen-saver Applications Menu
#:MLO - System Log Applications Menu
#:MSO - System Other Applications Menu
#:MTE - Text Editor Applications Menu
#:MWB - Web Browser Applications Menu
#:MXX - Sample Template Applications Menu
#:MSM - System Monitor Applications Menu
#
#
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
      CHOICE_APP=-1  # Initialize to -1 to force until loop without exiting Applications Menu.
      CHOICE_SCAT=-1 # Initialize to -1 to force until loop without exiting Sub-Category Menu.
      CHOICE_CAT=-1  # Initialize to -1 to force until loop without exiting Category Menu.
      CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting Main Menu.
} # End of f_initvars_menu_app
#
# +----------------------------------------+
# |          Function f_show_menu          |
# +----------------------------------------+
#
f_show_menu () { # function where $1=$MENU_TITLE $2=$DELIMITER
      clear # clear or blank screen
      f_term_color # Set terminal color.
      echo "--- $MENU_TITLE ---"
      echo
      if [ $DELIMITER = "#AAA" ] ; then #AAA This 3rd field prevents awk from printing this line into menu options.
         echo "0 - Quit to command line prompt." # Option for Main Menu only.
      else
         echo "0 - Return to previous menu." # Option for all other sub-menus.
      fi
      #
      # The following command grep <pattern> <filename> | awk '{<if condition>{print field}}
      # will print the menu items. The command automatically calculates the menu option numbers for you.
      #
      # Search (grep) for all lines in this file containing the special comment marker string.
      # Pass (pipe) results to awk which prints the second field delimited by the special comment string.
      # awk will not print the second field if there is a third field (lines containing 2 special comment strings).
      # The if statement conditional "($2&&!$3)" means if 2nd field exists and not a 3rd field, then print.

      # This prevents the lines of code which set the $ DELIMITER variable from being printed as part of the menu.
      #
      # The menu option numbers are incremented by using any unset variable name (such as "NUM") followed by "++",
      # However, because NUM is unset, it will increment from zero, whereas we want it to increment from one.
      # To do this, we add one before NUM so the expression is now "1+NUM++".
      # so numbering will always starts at zero. Interestingly the "++" increment command is only valid from within awk.
      #
      MAX=$(grep $DELIMITER -c $THIS_FILE) # Count number of lines containing special comment marker string to get maximum item number.
      awk -F $DELIMITER '{if ($2&&!$3){print 1+NUM++" -"$2;}}' $THIS_FILE
      case $DELIMITER in
           # Application Menu?
           "#AAA") #AAA This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-3)) # Subtract 3 total since 3 lines of code not part of menu display, contain the special comment marker.
              echo
              echo "'0', Q/quit, or E/exit to quit this script, $THIS_FILE."
           ;; 
           "#AAB") #AAB This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-2)) # Subtract 2 total since 2 lines of code not part of menu display, contain the special comment marker.
           ;;
           "#MWB") #MWB This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-3)) # Subtract 3 total since 3 lines of code not part of menu display, contain the special comment marker.
              echo
              echo "For help, type: '<app_name> --help' or 'man <app-name>'"
           ;; 
           "#M"* | "#B"*) # Only display help message in application menus. Do not display in application category menus or main menu.
              MAX=$((MAX=$MAX-1)) # Subtract 1 total since 1 line of code to set $DELIMITER contains the special comment marker.
              echo
              echo "For help, type: '<app_name> --help' or 'man <app-name>'"
           ;;
      esac
      echo
      echo -n "Enter 0 to $MAX or letters: " # echo -n supresses line-feed.
} # End of function f_show_menu
#
# +----------------------------------------+
# |        Function f_quit_app_menu        |
# +----------------------------------------+
#
f_quit_app_menu () {
      case $CHOICE_APP in
           # Quit?
           0)
              CHOICE_APP=0
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn])
           CHOICE_APP=0
           ;;
           # Commented out because there is a game with the title "Quiz" and entering "qui" would quit the menu.
           # [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           #   CHOICE_APP=0
           # ;;
      esac
} # End of function f_quit_app_menu
#
# +----------------------------------------+
# |       Function f_quit_subcat_menu      |
# +----------------------------------------+
#
f_quit_subcat_menu () {
      case $CHOICE_SCAT in
           # Quit?
           0)
              CHOICE_SCAT=0
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn])
           CHOICE_SCAT=0
           ;;
      esac
} # End of function f_quit_subcat_menu
#
# +----------------------------------------+
# |   Function f_how_to_quit_application   |
# +----------------------------------------+
#
f_how_to_quit_application () {
      clear
      echo
      echo "To quit $APP_NAME, type $1."
      f_press_enter_key_to_continue
} # End of function how_to_quit_application

# +----------------------------------------+
# |          Function f_term_color         |
# +----------------------------------------+
#
f_term_color () { # Set terminal display properties.
      case $TCOLOR in
           [Bb] | [Bb][Ll] | [Bb][Ll][Aa] | [Bb][Ll][Aa][Cc] | [Bb][Ll][Aa][Cc][Kk])
              setterm -reset -bold on
              CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
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
f_press_enter_key_to_continue () { # Display message and wait for user input.
      echo
      echo "Press '"Enter"' key to continue."
      read ANS
} # End of function f_press_enter_key_to_continue
#
# +----------------------------------------+
# |   Function f_menu_app_press_enter_key  |
# +----------------------------------------+
#
f_menu_app_press_enter_key () { # Display message and wait for user input.
      # $CHOICE_APP = 0 means quit menu 
      # $CHOICE_APP = -2 means application help invoked so don't show "press enter key" message again.
      #
      if [ $CHOICE_APP -ne 0 -a $CHOICE_APP -ne -2 ] ; then
         f_press_enter_key_to_continue
      fi
} # End of function f_menu_app_press_enter_key
#
# +----------------------------------------+
# |       Function f_application_help      |
# +----------------------------------------+
#
f_application_help () { # function where $CHOICE_APP="<Application name> --help" or "man <Application name>"
      f_term_color # Set terminal color.
      case $CHOICE_APP in
           *--help)
              echo "To quit help, type '"q"'."
              f_press_enter_key_to_continue
              clear # clear screen
              $CHOICE_APP |more # <Application name> --help | more
              ERROR=$? # Save error flag condition.
              if [ $ERROR -ne 0 ] ; then
                 # Error code 1 $?=1 means no --help available. Error code 0 (zero) where $?=0 means no error.
                 # Message "No --help option available for <Application name>"
                 echo
                 echo -e "No --help option available for \c"; echo $CHOICE_APP | awk '{print $1;}' # $CHOICE_APP = "man <Application name>" so need awk to grab only the name.
                 echo # The echo -e \c option supresses the line feed after the first echo command so that the message is on a single line.
              fi
              CHOICE_APP=-2
              f_press_enter_key_to_continue
           ;;
           man' '*)
              echo "To quit help, type '"q"'."
              f_press_enter_key_to_continue
              clear # clear screen
              $CHOICE_APP # CHOICE_APP = man <Application name>.
              ERROR=$? # Save error flag condition.
              if [ $ERROR -ne 0 ] ; then
                 # Error code 16 where $?=16 means no man(ual) entry. Error code 0 (zero) where $?=0 means no error.
                 # Message "No manual entry for <Application name>" 
                 echo
                 echo "No manual pages available for \c"; echo $CHOICE_APP | awk '{print $2;}' # $CHOICE_APP = "man <Application name>" so need awk to grab only the name.
                 echo "This application may either not be installed or is installed but man pages were never written for it."
                 #
                 f_press_enter_key_to_continue
              fi
              CHOICE_APP=-2                                         
           ;;
      esac
} # End of function f_application_help
#
# +----------------------------------------+
# |       Function f_application_run       |
# +----------------------------------------+
#
f_application_run () {
if [ $DELIMITER="#MWB" ] ; then # If application is a web browser. #MWB This 3rd field prevents awk from printing this line into menu options. 
   APP_RUN="$APP_NAME $WEB_SITE"
   # echo "APP_RUN: $APP_RUN"       # Diagnostic echo
   # echo "APP_NAME: $APP_NAME"     # Diagnostic echo
   # echo "WEB_SITE: $WEB_SITE"     # Diagnostic echo
   # f_press_enter_key_to_continue  # Pause display to read echo diagnostics.
   $APP_RUN
else
   $APP_NAME # Run application.
fi
#
ERROR=$? # Save error flag condition.
      case $ERROR in
           127)  # Error code 127 means application is not installed.
           f_application_error # installs application.
           if [ $ERROR=127 -a $ANS="Y" ] ; then # If user decided to install application.
              $APP_NAME           # Run application.
              f_application_error # Check for errors. If so, display appropriate error message.
           fi
           ;;
           1)
           f_application_error # Display appropriate error message.
           ;;
      esac
} # End of function f_application_run
#
# +----------------------------------------+
# |       Function f_application_error     |
# +----------------------------------------+
#
f_application_error () {
      if [ $ERROR -ne 0 ] ; then
         echo "An error code $ERROR has occurred when launching this $APP_NAME application."      
         f_press_enter_key_to_continue
         #
         f_initvars_menu_app # Be sure variable is set to redisplay current menu afterwards.
      fi
      #
      case $ERROR in
           1)
           echo
           echo "Run $APP_NAME again this time using sudo (temporary root permissions) (y/N)?"
           echo
           read ANS
           case $ANS in
                [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                sudo $APP_NAME
                ERROR=$? # Save error flag condition.
                if [ $ERROR -ne 0 ] ; then
                   # Error code 1 $?=1 means sudo failed. Error code 0 (zero) where $?=0 means no error.
                   echo "Running sudo $APP_NAME failed."
                   echo "May be caused by bad sudo password, or user has no permission to use sudo,"
                   echo "or bad $APP_NAME syntax."
                   echo "consult help using man $APP_NAME."
                   echo
                fi
                ;;              
                [Nn] | [Nn][Oo] | *)
                ERROR=0
                ;;
           esac
           ;;
           127) # Error code 127 means application is not installed.
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
           echo "Do you want to install $APP_NAME using 'apt-get' or 'rpm' (y/N)?"
           echo
           read ANS
           case $ANS in
                [Yy] | [Yy][Ee] | [Yy][Ee][Ss])
                #
                APP_NAME_INSTALL=$APP_NAME
                #
                case $APP_NAME_INSTALL in # Set variable APP_NAME_INSTALL.
                *' '*) 
                # If string APP_NAME/APP_NAME_INSTALL includes spaces for run-time parameters, then just extract package name. 
                # i.e. "dstat 1 10", then just grab "dstat" as package name.
                #
                APP_NAME_INSTALL=$(echo $APP_NAME_INSTALL | awk '{print $1;}')
                ;;
                esac
                #
                case $APP_NAME_INSTALL in # Set variable APP_NAME_INSTALL.
adventure | arithmetic | atc | backgammon | battlestar | bcd | boggle | caesar | canfield | countmail | cribbage | dab | go-fish | gomoku | hack | hangman | hunt | mille | monop | morse | number | pig | phantasia | pom | ppt | primes | quiz | random | rain | robots | rot13 | sail | snake | tetris | trek | wargames | worm | worms | wump | wtf)
                APP_NAME_INSTALL="bsdgames"
                ;;
                glances) # Add repository for glances application.
                sudo add-apt-repository ppa:arnaud-hartmann/glances-stable
                sudo apt-get update
                ;;
                moc)
                APP_NAME_INSTALL="libqt4-dev"
                ;;
                esac
                #
                if [ -d /etc/apt ] ; then # if /etc/apt directory exists, then use apt-get install for Debian-based packages.
                   sudo apt-get install $APP_NAME_INSTALL
                   ERROR=$? # Save error flag condition.
                   if [ $ERROR -ne 0 ] ; then
                      # Error code 1 $?=1 means installation failed. Error code 0 (zero) where $?=0 means no error.
                      echo
                      echo "Installation of $APP_NAME failed. Command sudo apt-get install $APP_NAME_INSTALL failed."
                      echo "May be a failure downloading package. Bad Internet connection?"
                      echo
                   fi
                fi 
                if [ -d /var/lib/rpm ] ; then # if /var/lib/rpm directory exists, then use rpm install for RPM-based packages.
                   sudo rpm -ivh $APP_NAME_INSTALL # Assume if not Debian, then Red Hat distro packages.
                   ERROR=$? # Save error flag condition.
                   if [ $ERROR -ne 0 ] ; then
                      # Error code 1 $?=1 means installation failed. Error code 0 (zero) where $?=0 means no error.
                      echo
                      echo "Installation of $APP_NAME failed. Command sudo rpm -ivh $APP_NAME_INSTALL failed."
                      echo "May be a failure downloading package. Bad Internet connection"
                      echo
                   fi
                fi
                ;;              
                [Nn] | [Nn][Oo] | *)
                ERROR=0
                ;;
           esac
           ;;
      esac
  # This function needs to be followed by a f_press_enter_key_to_continue or f_menu_app_press_enter_key so that messages are displayed.
} # End of function f_application_error
#
# +----------------------------------------+
# |  Function f_menu_cat_sample_template   |
# +----------------------------------------+
#
f_menu_cat_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -ge 0 -a $CHOICE_SCAT -le $MAX ]
      do    # Start of Application Category until loop.
            #MXC App Cat1
            #MXC App Cat2
            #
            MENU_TITLE="Application Category Menu"
            DELIMITER="#MXC" #MXC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_SCAT in # Start of Application Category case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][1])
                 f_menu_cat_name1
                 ;;
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][2]) 
                 f_menu_cat_name2
                 ;;
            esac                # End of Application Category case statement.
      done  # End of Application Category until loop.
} # End of function f_menu_cat_sample_template
#
# +----------------------------------------+
# |   Function f_menu_app_sample_template  |
# +----------------------------------------+
#
f_menu_app_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of <Sample Template> Applications until loop.
            #MXX Application name - Description.
            #MXX Application2 name - Description.
            #
            MENU_TITLE="<Sample Template> Applications Menu"
            DELIMITER="#MXX" #MXX This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #APP_NAME
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of <Sample Template> Applications case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Nn] | [Aa][Pp][Pp]' '[Nn][Aa] | [Aa][Pp][Pp]' '[Nn][Aa][Mm] | [Aa][Pp][Pp]' '[Nn][Aa][Mm][Ee])
                 APP_NAME="appname"
                 f_application_run
                 ;;
                 #
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][2] | [Aa][Pp][Pp][2]' ' | [Aa][Pp][Pp][2]' '[Nn] | [Aa][Pp][Pp][2]' '[Nn][Aa] | [Aa][Pp][Pp][2]' '[Nn][Aa][Mm] | [Aa][Pp][Pp][2]' '[Nn][Aa][Mm][Ee])
                 APP_NAME="app2name"
                 f_application_run
                 ;;
            esac                # End of <Sample Template> Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of <Sample Template> Applications until loop.
} # End of function f_menu_app_sample_template
#
# **************************************
# ***   Application Categories Menu  ***
# **************************************
#
f_menu_cat_applications () {
      f_initvars_menu_app
      until [ $CHOICE_CAT -ge 0 -a $CHOICE_CAT -le $MAX ]
      do    # Start of Application Category until loop.
            #AAB Internet        - Web, e-mail, chat, IM, RSS, ftp, torrents, etc.
            #AAB Network         - Wireless connection, network monitoring, tools.
            #AAB File Managers   - Copy, move, rename, delete files/folders on localhost.
            #AAB Text Editors    - Create/Edit and compare text files.
            #AAB System          - Monitor system processes, resources, utilities, etc.
            #AAB Calendar-ToDo   - Personal organization.
            #AAB Calculator      - Simple "pocket" calculators.
            #AAB Spreadsheet     - Basic spreadsheet.
            #AAB Notebook        - Write notes in a "notebook".
            #AAB Audio           - Music players, audio utilities.
            #AAB Screensaver     - For when you're away.
            #AAB Images-Graphics - View images and graphics files.
            #AAB Education       - Learn something.
            #AAB Games           - Fun time!
            #
            MENU_TITLE="Application Categories Menu"
            DELIMITER="#AAB" #AAB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_CAT
            #
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_CAT in 
                 # Quit?
                 0) 
                 CHOICE_CAT=0
                 ;;
                 [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn]*)
                 CHOICE_CAT=0
                 ;;
            esac
            #
            case $CHOICE_CAT in # Start of Application Category case statement.
                 1 | [Ii] | [Ii][Nn] | [Ii][Nn][Tt] | [Ii][Nn][Tt][Ee] | [Ii][Nn][Tt][Ee][Rr] | [Ii][Nn][Tt][Ee][Rr][Nn] | [Ii][Nn][Tt][Ee][Rr][Nn][Ee] | [Ii][Nn][Tt][Ee][Rr][Nn][Ee][Tt])
                 #
                 f_menu_cat_internet     # Internet Applications Menu.
                 #
                 ;; # End of Internet Applications Menu case clause.
                 #
                 #
                 2 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ww] | [Nn][Ee][Tt][Ww][Oo] | [Nn][Ee][Tt][Ww][Oo][Rr] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk])
                 #
                 f_menu_cat_network     # Network Applications Menu.
                 #
                 ;; # End of Network Applications Menu case clause.
                 #
                 #
                 3 | [Ff] | [Ff][Ii] | [Ff][Ii][Ll] | [Ff][Ii][Ll][Ee] | [Ff][Ii][Ll][Ee]' ' | [Ff][Ii][Ll][Ee]' '[Mm] | [Ff][Ii][Ll][Ee]' '[Mm][Aa] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn][Aa] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn][Aa][Gg] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn][Aa][Gg][Ee] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn][Aa][Gg][Ee][Rr] | [Ff][Ii][Ll][Ee]' '[Mm][Aa][Nn][Aa][Gg][Ee][Rr][Ss])
                 #
                 f_menu_app_file_managers     # File Manager Applications Menu.
                 #
                 ;; # End of Internet File Manager Menu case clause.
                 #
                 #
                 4 | [Tt] | [Tt][Ee] | [Tt][Ee][Xx] | [Tt][Ee][Xx][Tt] | [Tt][Ee][Xx][Tt]' ' | [Tt][Ee][Xx][Tt]' '[Ee] | [Tt][Ee][Xx][Tt]' '[Ee][Dd] | [Tt][Ee][Xx][Tt]' '[Ee][Dd][Ii] | [Tt][Ee][Xx][Tt]' '[Ee][Dd][Ii][Tt] | [Tt][Ee][Xx][Tt]' '[Ee][Dd][Ii][Tt][Oo] | [Tt][Ee][Xx][Tt]' '[Ee][Dd][Ii][Tt][Oo][Rr] | [Tt][Ee][Xx][Tt]' '[Ee][Dd][Ii][Tt][Oo][Rr][Ss])
                 #
                 f_menu_app_text_editors     # Text Editor Applications Menu.
                 #
                 ;; # End of Text Editor Applications Menu case clause.
                 #
                 #
                 5 | [Ss] | [Ss][Yy] | [Ss][Yy][Ss] | [Ss][Yy][Ss][Tt] | [Ss][Yy][Ss][Tt][Ee] | [Ss][Yy][Ss][Tt][Ee][Mm])
                 #
                 f_menu_cat_system_applications     # System Applications Menu.
                 #
                 ;; # End of System Applications Menu case clause.
                 #
                 #
                 6 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Ee] | [Cc][Aa][Ll][Ee][Nn] | [Cc][Aa][Ll][Ee][Nn][Dd] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr][-] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr][-][Tt] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr][-][Tt][Oo] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr][-][Tt][Oo][Dd] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr][-][Tt][Oo][Dd][Oo])
                 #
                 f_menu_app_calendar_todo     # Calendar-ToDo Applications Menu.
                 #
                 ;; # End of Calendar-ToDo Applications Menu case clause.
                 #
                 #
                 7 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Cc] | [Cc][Aa][Ll][Cc][Uu] | [Cc][Aa][Ll][Cc][Uu][Ll] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt][Oo] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt][Oo][Rr])
                 #
                 f_menu_app_calculators     # Calculator Applications Menu.
                 #
                 ;; # End of Calculator Applications Menu case clause.
                 #
                 #
                 8 | [Ss] | [Ss][Pp] | [Ss][Pp][Rr] | [Ss][Pp][Rr][Ee] | [Ss][Pp][Rr][Ee][Aa] | [Ss][Pp][Rr][Ee][Aa][Dd] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee][Ee] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee][Ee][Tt])
                 #
                 f_menu_app_spreadsheets     # Spreadsheet Applications Menu.
                 #
                 ;; # End of Spreadsheet Applications Menu case clause.
                 #
                 #
                 9 | [Nn] | [Nn][Oo] | [Nn][Oo][Tt] | [Nn][Oo][Tt][Ee] | [Nn][Oo][Tt][Ee][Bb] | [Nn][Oo][Tt][Ee][Bb][Oo] | [Nn][Oo][Tt][Ee][Bb][Oo][Oo] | [Nn][Oo][Tt][Ee][Bb][Oo][Oo][Kk])
                 #
                 f_menu_app_note_applications     # Note Applications Menu.
                 #
                 ;; # End of Note Applications Menu case clause.
                 #
                 #
                 10 | [Aa] | [Aa][Uu] | [Aa][Uu][Dd] | [Aa][Uu][Dd][Ii] | [Aa][Uu][Dd][Ii][Oo])
                 #
                 f_menu_app_audio_applications     # Audio Applications Menu.
                 #
                 ;; # End of Audio Applications Menu case clause.
                 #
                 #
                 11 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss][Aa] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss][Aa][Vv] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss][Aa][Vv][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss][Aa][Vv][Ee][Rr])
                 #
                 f_menu_app_screen_savers     # Screen-saver Applications Menu.
                 #
                 ;; # End of Screen-saver Applications Menu case clause.
                 #
                 #
                 12 | [Ii] | [Ii][Mm] | [Ii][Mm][Aa] | [Ii][Mm][Aa][Gg] | [Ii][Mm][Aa][Gg][Ee] | [Ii][Mm][Aa][Gg][Ee][Ss] | [Ii][Mm][Aa][Gg][Ee][Ss][-] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa][Pp] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa][Pp][Hh] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa][Pp][Hh][Ii] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa][Pp][Hh][Ii][Cc] | [Ii][Mm][Aa][Gg][Ee][Ss][-][Gg][Rr][Aa][Pp][Hh][Ii][Cc][Ss])
                 #
                 f_menu_app_image_graphics_applications     # Image-Graphics Applications Menu.
                 #
                 ;; # End of Image-Graphics Applications Menu case clause.
                 #
                 #
                 13 | [Ee] | [Ee][Dd] | [Ee][Dd][Uu] | [Ee][Dd][Uu][Cc] | [Ee][Dd][Uu][Cc][Aa] | [Ee][Dd][Uu][Cc][Aa][Tt] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii][Oo] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii][Oo][Nn])
                 #
                 f_menu_app_education_applications     # Education Applications Menu.
                 #
                 ;; # End of Education Applications Menu case clause.
                 #
                 #
                 14 | [Gg] | [Gg][Aa] | [Gg][Aa][Mm] | [Gg][Aa][Mm][Ee] | [Gg][Aa][Mm][Ee][Ss]) # Games Applications Menu.
                 #
                 f_menu_cat_games
                 #
                 ;; # End of Games Applications Menu case clause.
            esac # End of Application Category case statement.
      done # End of Application Category until loop.
} # End of function f_menu_cat_applications
#
# +----------------------------------------+
# |      Function f_menu_cat_internet      |
# +----------------------------------------+
#
f_menu_cat_internet () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -ge 0 -a $CHOICE_SCAT -le $MAX ]
      do    # Start of Internet Category until loop.
            #BIN Web Browsers      - Internet web  browsers.
            #BIN Bittorrent        - File transfer.
            #BIN Downloaders       - Download files. 
            #BIN Email             - Email clients.
            #BIN FAX               - FAX clients.
            #BIN File Transfer     - FTP clients.
            #BIN Instant Messaging - AIM/ICQ, Yahoo!, MSN, IRC, Jabber/XMPP/Google Talk...
            #BIN IRC Clients       - Internet Relay Chat clients.
            #BIN News Readers      - Read USEnet news.
            #BIN Network Chat      - LAN Chat.
            #BIN Podcatcher        - Podcaster readers.
            #BIN Remote Connection - Connect to other PCs remotely.
            #BIN RSS Feeders       - RSS news, messages.
            #
            MENU_TITLE="Internet Category Menu"
            DELIMITER="#BIN" #BIN This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_SCAT in # Start of Internet Category case statement.
                 1 | [Ww] | [Ww][Ee] | [Ww][Ee][Bb] | [Ww][Ee][Bb]' ' | [Ww][Ee][Bb]' '[Bb] | [Ww][Ee][Bb]' '[Bb][Rr] | [Ww][Ee][Bb]' '[Bb][Rr][Oo] |  [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss][Ee] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss][Ee][Rr])
                 f_menu_app_web_browsers
                 ;;
                 2 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn][Tt]) 
                 f_menu_app_bittorrent
                 ;;
                 3 | [Dd] | [Dd][Oo] | [Dd][Oo][Ww] | [Dd][Oo][Ww][Nn] | [Dd][Oo][Ww][Nn][Ll] | [Dd][Oo][Ww][Nn][Ll][Oo] |  [Dd][Oo][Ww][Nn][Ll][Oo][Aa] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee][Rr] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee][Rr][Ss])
                 f_menu_app_downloaders
                 ;;
                 4 | [Ee] | [Ee][Mm] | [Ee][Mm][Aa] | [Ee][Mm][Aa][Ii] | [Ee][Mm][Aa][Ii][Ll])
                 f_menu_app_email
                 ;;
                 5 | [Ff] | [Ff][Aa] | [Ff][Aa][Xx])
                 f_menu_app_fax
                 ;;
                 6 | [Ff] | [Ff][Ii] | [Ff][Ii][Ll] | [Ff][Ii][Ll][Ee] | [Ff][Ii][Ll][Ee]' ' | [Ff][Ii][Ll][Ee]' '[Tt] | [Ff][Ii][Ll][Ee]' '[Tt][Rr] | [Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa] | [Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa][Nn] |[Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa][Nn][Ss] | [Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa][Nn][Ss][Ff] | [Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa][Nn][Ss][Ff][Ee] | [Ff][Ii][Ll][Ee]' '[Tt][Rr][Aa][Nn][Ss][Ff][Ee][Rr])
                 f_menu_app_file_transfer
                 ;;
                 7 | [Ii] | [Ii][Nn] | [Ii][Nn][Ss] | [Ii][Nn][Ss][Tt] | [Ii][Nn][Ss][Tt][Aa] | [Ii][Nn][Ss][Tt][Aa][Nn] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' ' | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii][Nn] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii][Nn][Gg])
                 f_menu_app_instant_messaging
                 ;;
                 8 | [Ii] | [Ii][Rr] | [Ii][Rr][Cc] | [Ii][Rr][Cc]' ' | [Ii][Rr][Cc]' '[Cc] | [Ii][Rr][Cc]' '[Cc][Ll] | [Ii][Rr][Cc]' '[Cc][Ll][Ii] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn][Tt] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn][Tt][Ss])
                 f_menu_app_irc_clients
                 ;;
                 9 | [Nn] | [Nn][Ee] | [Nn][Ee][Ww] | [Nn][Ee][Ww][Ss] | [Nn][Ee][Ww][Ss]' ' | [Nn][Ee][Ww][Ss]' '[Rr] | [Nn][Ee][Ww][Ss]' '[Rr][Ee] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee][Rr] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee][Rr][Ss])
                 f_menu_app_news_readers
                 ;;
                 10 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ww] | [Nn][Ee][Tt][Ww][Oo] | [Nn][Ee][Tt][Ww][Oo][Rr] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk]' ' | [Nn][Ee][Tt][Ww][Oo][Rr][Kk]' '[Cc] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk]' '[Cc][Hh] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk]' '[Cc][Hh][Aa] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk]' '[Cc][Hh][Aa][Tt])
                 f_menu_app_network_chat
                 ;;
                 11 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Cc] | [Pp][Oo][Dd][Cc][Aa] | [Pp][Oo][Dd][Cc][Aa][Tt] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee][Rr] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee][Rr][Ss])
                 f_menu_app_podcatchers
                 ;;
                 12 | [Rr] | [Rr][Ee] | [Rr][Ee][Mm] | [Rr][Ee][Mm][Oo] | [Rr][Ee][Mm][Oo][Tt] | [Rr][Ee][Mm][Oo][Tt][Ee] | [Rr][Ee][Mm][Oo][Tt][Ee]' ' | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii][Oo] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii][Oo][Nn])
                 f_menu_app_remote_connection
                 ;;
                 13 | [Rr] | [Rr][Ss] | [Rr][Ss][Ss] | [Rr][Ss][Ss]' ' | [Rr][Ss][Ss]' '[Ff] | [Rr][Ss][Ss]' '[Ff][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee][Rr] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee][Rr][Ss])
                 f_menu_app_rssfeeders
                 ;;
            esac                # End of Internet Category case statement.
      done  # End of Internet Category until loop.
} # End of function f_menu_cat_internet
#
# +----------------------------------------+
# |    Function f_menu_app_web_browsers    |
# +----------------------------------------+
#
f_menu_app_web_browsers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Web Browsers Applications until loop.
            #MWB elinks - Web browser, tables, frames, forms support, tabbed browsing.
            #MWB lynx   - Web browser, NLS support.
            #MWB links2 - Web browser, has graphics mode.
            #MWB links  - Web browser, no graphics mode.
            #MWB w3m    - Web browser, tables, frames support, IPv6 support.
            #
            MENU_TITLE="Web Browser Applications Menu"
            DELIMITER="#MWB" #MWB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Web Browser Applications case statement.
                 1 | [Ee] | [Ee][Ll] | [Ee][Ll][Ii] | [Ee][Ll][Ii][Nn] | [Ee][Ll][Ii][Nn][Kk] | [Ee][Ll][Ii][Nn][Kk][Ss]) 
                 APP_NAME="elinks"
                 f_web_site
                 f_application_run
                 ;;
                 2 | [Ll] | [Ll][Yy] | [Ll][Yy][Nn] | [Ll][Yy][Nn][Xx] | [Ll][Yy][Nn][Xx]'-' | [Ll][Yy][Nn][Xx]'-'[Cc] | [Ll][Yy][Nn][Xx]'-'[Cc][Uu] | [Ll][Yy][Nn][Xx]'-'[Cc][Uu][Rr])
                 APP_NAME="lynx-cur"
                 f_web_site
                 f_application_run
                 ;;
                 3 | [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss]) 
                 APP_NAME="links"
                 f_web_site
                 f_application_run
                 ;;
                 4 |[Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss] | [Ll][Ii][Nn][Kk][Ss][2])
                 APP_NAME="links2"
                 f_web_site
                 f_application_run
                 ;;
                 5 | [Ww] | [Ww][3] | [Ww][3][Mm])
                 APP_NAME="w3m"
                 f_web_site
                 f_application_run
                 ;;
            esac                # End of Web Browsers Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Web Browsers Applications until loop.
} # End of function f_menu_app_web_browsers
#
# +----------------------------------------+
# |          Function f_web_site           |
# +----------------------------------------+
#
f_web_site () {
echo
echo "When using the web browser directly from the command line,"
echo "use the syntax: $APP_NAME WEB_SITE"
echo
echo "Enter the name of the web site:"
read WEB_SITE
if [ -z "$WEB_SITE" ] ; then # If no web site specified, default to a web site. Note the test command has $WEB_SITE in quotes because it may not be set prior to this test.
   WEB_SITE="http://www.lxer.com"
fi
} # End of function f_web_site
#
# +----------------------------------------+
# |      Function f_menu_app_bittorrent     |
# +----------------------------------------+
#
f_menu_app_bittorrent () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Bittorrent Applications until loop.
            #MBT bittornado - Torrent file transfer.
            #MBT bittorrent - Bittorrent file transfer.
            #MBT ctorrent   - Torrent file transfer.
            #MBT rtorrent   - Torrent file transfer.
            #
            MENU_TITLE="Bittorrent Applications Menu"
            DELIMITER="#MBT" #MBT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Bittorrent Applications case statement.
                 1 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa][Dd] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa][Dd][Oo])
                 APP_NAME="bittornado"
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn][Tt])
                 APP_NAME="bittorrent"
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Tt] | [Cc][Tt][Oo] | [Cc][Tt][Oo][Rr] | [Cc][Tt][Oo][Rr][Rr] | [Cc][Tt][Oo][Rr][Rr][Ee] | [Cc][Tt][Oo][Rr][Rr][Ee][Nn] | [Cc][Tt][Oo][Rr][Rr][Ee][Nn][Tt])
                 APP_NAME="ctorrent"
                 f_application_run
                 ;;
                 4 | [Rr] | [Rr][Tt] | [Rr][Tt][Oo] | [Rr][Tt][Oo][Rr] | [Rr][Tt][Oo][Rr][Rr] | [Rr][Tt][Oo][Rr][Rr][Ee] | [Rr][Tt][Oo][Rr][Rr][Ee][Nn] | [Rr][Tt][Oo][Rr][Rr][Ee][Nn][Tt]) 
                 APP_NAME="rtorrent"
                 f_application_run
                 ;;
            esac                # End of Bittorrent Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Bittorrent Applications until loop.
} # End of function f_menu_app_bittorrent
#
# +----------------------------------------+
# |     Function f_menu_app_downloaders    |
# +----------------------------------------+
#
f_menu_app_downloaders () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Downloaders Applications until loop.
            #MDL aria2 - Downloader.
            #
            MENU_TITLE="Dowloader Applications Menu"
            DELIMITER="#MDL" #MDL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Dowloader Applications case statement.
                 1 | [Aa] | [Aa][Rr] | [Aa][Rr][Ii] | [Aa][Rr][Ii][Aa] | [Aa][Rr][Ii][Aa][2])
                 aria2
                 ERROR=$? # Save error flag condition when running this application.
                 APP_NAME="aria2"
                 ;;
            esac                # End of Downloader Applications case statement.
            f_application_error $ERROR $APP_NAME # If application is not installed display help instructions.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Downloaders Applications until loop.
} # End of function f_menu_app_downloaders
#
# +----------------------------------------+
# |        Function f_menu_app_email       |
# +----------------------------------------+
#
f_menu_app_email () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of E-mail Applications until loop.
            #MEM alpine     - E-mail, FOSS version of pine.
            #MEM cone       - E-mail.
            #MEM elmo       - E-mail.
            #MEM fetchyahoo - E-mail.
            #MEM mutt       - E-mail.
            #MEM nedmail    - E-mail.
            #MEM pine       - E-mail.
            #MEM sup        - E-mail.
            #
            MENU_TITLE="E-mail Applications Menu"
            DELIMITER="#MEM" #MEM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of E-mail Applications case statement.
                 1 | [Aa] | [Aa][Ll] | [Aa][Ll][Pp] | [Aa][Ll][Pp][Ii] | [Aa][Ll][Pp][Ii][Nn] | [Aa][Ll][Pp][Ii][Nn][Ee])
                 APP_NAME="alpine"
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Ee]) 
                 APP_NAME="cone"
                 f_application_run
                 ;;
                 3  | [Ee] | [Ee][Ll] | [Ee][Ll][Mm] | [Ee][Ll][Mm][Oo])
                 APP_NAME="elmo"
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Ee] | [Ff][Ee][Tt] | [Ff][Ee][Tt][Cc] | [Ff][Ee][Tt][Cc][Hh] | [Ff][Ee][Tt][Cc][Hh][Yy] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh][Oo] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh][Oo][Oo]) 
                 APP_NAME="fetchyahoo"
                 f_application_run
                 ;;
                 5 | [Mm] | [Mm][Uu] | [Mm][Uu][Tt] | [Mm][Uu][Tt][Tt])
                 APP_NAME="mutt"
                 f_application_run
                 ;;
                 6 | [Nn] | [Nn][Ee] | [Nn][Ee][Dd] | [Nn][Ee][Dd][Mm] | [Nn][Ee][Dd][Mm][Aa] | [Nn][Ee][Dd][Mm][Aa][Ii] | [Nn][Ee][Dd][Mm][Aa][Ii][Ll])
                 APP_NAME="nedmail"
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Ii] | [Pp][Ii][Nn] | [Pp][Ii][Nn][Ee])
                 APP_NAME="pine"
                 f_application_run
                 ;;
                 8 | [Ss] | [Ss][Uu] | [Ss][Uu][Pp] | [Ss][Uu][Pp][Pp])
                 APP_NAME="supp"
                 f_application_run
                 ;;
            esac                # End of E-mail Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of E-mail Applications until loop.
} # End of function f_menu_app_email
#
# +----------------------------------------+
# |         Function f_menu_app_fax        |
# +----------------------------------------+
#
f_menu_app_fax () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of FAX Applications until loop.
            #MFX efax           - FAX over modem.
            #MFX hylafax-client - Works with HylaFAX server software.
            #
            MENU_TITLE="FAX Applications Menu"
            DELIMITER="#MFX" #MFX This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of FAX Applications case statement.
                 1  | [Ee] | [Ee][Ff] | [Ee][Ff][Aa] | [Ee][Ff][Aa][Xx])
                 APP_NAME="efax"
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Yy] | [Hh][Yy][Ll] | [Hh][Yy][Ll][Aa] | [Hh][Yy][Ll][Aa][Ff] | [Hh][Yy][Ll][Aa][Ff][Aa] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee][Nn] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee][Nn][Tt])
                 APP_NAME="hylafax-client"
                 f_application_run
                 ;;
            esac                # End of FAX Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of FAX Applications until loop.
} # End of function f_menu_app_fax
#
# +----------------------------------------+
# |   Function f_menu_app_file_tranfer     |
# +----------------------------------------+
#
f_menu_app_file_transfer () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of File Transfer Applications until loop.
            #MFT cmdftp - File transfer client.
            #MFT curl   - File transfer.
            #MFT ftp    - File transfer.
            #MFT ftpfs  - File transfer client.
            #MFT lftp   - Sophisticated sftp/ftp/http download/upload client program.
            #MFT ncftp  - File transfer client.
            #MFT scp    - File transfer.
            #
            MENU_TITLE="File Transfer Applications Menu"
            DELIMITER="#MFT" #MFT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of File Transfer Applications case statement.
                 1 | [Cc] | [Cc][Mm] | [Cc][Mm][Dd] | [Cc][Mm][Dd][Ff] | [Cc][Mm][Dd][Ff][Tt] | [Cc][Mm][Dd][Ff][Tt][Pp])
                 APP_NAME="cmdftp"
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Uu]  | [Cc][Uu][Rr] | [Cc][Uu][Rr][Ll])
                 APP_NAME="curl"
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp])
                 APP_NAME="ftp"
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp] | [Ff][Tt][Pp][Ff] | [Ff][Tt][Pp][Ff][Ss])
                 APP_NAME="ftpfs"
                 f_application_run
                 ;;
                 5 | [Ll] | [Ll][Ff] | [Ll][Ff][Tt] | [Ll][Ff][Tt][Pp])
                 APP_NAME="lftp"
                 f_application_run
                 ;;
                 6  | [Nn] | [Nn][Cc] | [Nn][Cc][Ff] | [Nn][Cc][Ff][Tt] | [Nn][Cc][Ff][Tt][Pp])
                 APP_NAME="ncftp"
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Cc] | [Ss][Cc][Pp])
                 APP_NAME="scp"
                 f_application_run
                 ;;
            esac                # End of File Transfer Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of File Transfer Applications until loop.
} # End of function f_menu_app_file_transfer
#
# +----------------------------------------+
# | Function f_menu_app_instant_messaging  |
# +----------------------------------------+
#
f_menu_app_instant_messaging () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of FAX Applications until loop.
            #MIM bitlbee   - Jabber, Google Talk, Facebook, ICQ, AIM, MSN, Yahoo! Twitter.
            #MIM centericq - Supports the ICQ2000, Yahoo!, AIM, MSN, IRC and Jabber.
            #MIM centerim  - Supports the ICQ2000, Yahoo!, AIM, MSN, IRC and Jabber.
            #MIM finch     - AIM/ICQ, Yahoo!, MSN, IRC, Jabber/XMPP/Google Talk, Napster, etc.
            #MIM freetalk  - Jabber client.
            #MIM mcabber   - Jabber client.
            #
            MENU_TITLE="Instant Messaging Applications Menu"
            DELIMITER="#MIM" #MIM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Instant Messaging Applications case statement.
                 1 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Ll] | [Bb][Ii][Tt][Ll][Bb] | [Bb][Ii][Tt][Ll][Bb][Ee] | [Bb][Ii][Tt][Ll][Bb][Ee][Ee])
                 APP_NAME="bitlbee"
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Cc] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Cc][Qq])
                 APP_NAME="centericq"
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Mm])
                 APP_NAME="centerim"
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Cc] | [Ff][Ii][Nn][Cc][Hh])
                 APP_NAME="finch"
                 f_application_run
                 ;;
                 5 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ee] | [Ff][Rr][Ee][Ee][Tt] | [Ff][Rr][Ee][Ee][Tt][Aa] | [Ff][Rr][Ee][Ee][Tt][Aa][Ll] | [Ff][Rr][Ee][Ee][Tt][Aa][Ll][Kk])
                 APP_NAME="freetalk"
                 f_application_run
                 ;;
                 6 | [Mm] | [Mm][Cc] | [Mm][Cc][Aa] | [Mm][Cc][Aa][Bb] | [Mm][Cc][Aa][Bb][Bb] | [Mm][Cc][Aa][Bb][Bb][Ee] | [Mm][Cc][Aa][Bb][Bb][Ee][Rr])
                 APP_NAME="mcabber"
                 f_application_run
                 ;;
            esac                # End of Instant Messaging Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Instant Messaging Applications until loop.
} # End of function f_menu_app_instant_messaging
#
# +----------------------------------------+
# |    Function f_menu_app_irc_clients     |
# +----------------------------------------+
#
f_menu_app_irc_clients () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of IRC Clients Applications until loop.
            #MIR epic5 - IRC client based on ircI.
            #MIR ii    - Minimalist FIFO and filesystem-based IRC client. Based on sic.
            #MIR ircii - Termcap based interface. Supports "/encrypt -cast".
            #MIR irssi - Supports SILC and ICB protocols via plugins.
            #MIR pork  - Ncurses-based AOL Instant Messenger and IRC client.
            #MIR sic   - Fast small IRC client.
            #
            MENU_TITLE="IRC Clients Applications Menu"
            DELIMITER="#MIR" #MIR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of IRC Clients Applications case statement.
                 1 | [Ee] | [Ee][Pp] | [Ee][Pp][Ii] | [Ee][Pp][Ii][Cc])
                 APP_NAME="epic"
                 f_application_run
                 ;;
                 2 | [Ii] |[Ii][Ii])
                 APP_NAME="ii"
                 f_application_run
                 ;;
                 3 | [Ii] | [Ii][Rr] | [Ii][Rr][Cc] | [Ii][Rr][Cc][Ii] | [Ii][Rr][Cc][Ii][Ii])
                 APP_NAME="ircii"
                 f_application_run
                 ;;
                 4 | [Ii] | [Ii][Rr] | [Ii][Rr][Ss] | [Ii][Rr][Ss][Ss] | [Ii][Rr][Ss][Ss][Ii])
                 APP_NAME="irssi"
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Oo] | [Pp][Oo][Rr] | [Pp][Oo][Rr][Kk])
                 APP_NAME="pork"
                 f_application_run
                 ;;
                 6 | [Ss] | [Ss][Ii] | [Ss][Ii][Cc])
                 APP_NAME="sic"
                 f_application_run
                 ;;
            esac                # End of IRC Clients Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of IRC Clients Applications until loop.
} # End of function f_menu_app_irc_clients
#
# +----------------------------------------+
# |     Function f_menu_app_news_readers    |
# +----------------------------------------+
#
f_menu_app_news_readers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of RSS Feeder Applications until loop.
            #MNR gnus - News reader.
            #MNR nn   - News reader.
            #MNR rn   - News reader.
            #MNR slrn - News reader.
            #MNR tin  - News reader.
            #MNR trn  - News reader.
            #
            MENU_TITLE="News Reader Applications Menu"
            DELIMITER="#MNR" #MNR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of News Reader Applications case statement.
                 1 | [Gg] | [Gg][Nn] | [Gg][Nn][Uu] | [Gg][Nn][Uu][Ss])
                 APP_NAME="gnus"
                 f_application_run
                 ;;
                 2 | [Nn] | [Nn][Nn]) 
                 APP_NAME="nn"
                 f_application_run
                 ;;
                 3 | [Rr] | [Rr][Nn])
                 APP_NAME="rn"
                 f_application_run
                 ;;
                 4  | [Ss] | [Ss][Ll] | [Ss][Ll][Rr] | [Ss][Ll][Rr][Nn]) 
                 APP_NAME="slrn"
                 f_application_run
                 ;;
                 5 | [Tt] | [Tt][Ii] | [Tt][Ii][Nn])
                 APP_NAME="tin"
                 f_application_run
                 ;;
                 6 | [Tt] | [Tt][Rr] | [Tt][Rr][Nn])
                 APP_NAME="trn"
                 f_application_run
                 ;;
            esac                # End of News Reader Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of News Reader Applications until loop.
} # End of function f_menu_app_news_readers
#
# +----------------------------------------+
# |    Function f_menu_app_network_chat    |
# +----------------------------------------+
#
f_menu_app_network_chat () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Network Chat Applications until loop.
            #MNC talk  - Copies lines from your terminal to that of another user.
            #MNC ytalk - Multi-user chat program can do multiple connections.
            #
            MENU_TITLE="Network Chat Applications Menu"
            DELIMITER="#MNC" #MNC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Network Chat Applications case statement.
                 1 | [Tt] | [Tt][Aa] | [Tt][Aa][Ll] | [Tt][Aa][Ll][Kk])
                 APP_NAME="talk"
                 f_application_run
                 ;;
                 2 | [Yy] | [Yy][Tt] | [Yy][Tt][Aa] | [Yy][Tt][Aa][Ll] | [Yy][Tt][Aa][Ll][Kk])
                 APP_NAME="ytalk"
                 f_application_run
                 ;;
            esac                # End of Network Chat Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Network Chat Applications until loop.
} # End of function f_menu_app_network_chat
#
# +----------------------------------------+
# |     Function f_menu_app_podcatchers     |
# +----------------------------------------+
#
f_menu_app_podcatchers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Podcatcher Applications until loop.
            #MPO bashpodder - Podcatcher.
            #MPO goldenpod  - Podcatcher.
            #MPO hpodder    - Podcatcher.
            #MPO podget     - Podcatcher.
            #MPO podracer   - Podcatcher.
            #MPO uraniacast - Podcatcher.
            #
            MENU_TITLE="Podcatcher Applications Menu"
            DELIMITER="#MPO" #MPO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Podcatcher Applications case statement.
                 1 | [Bb] | [Bb][Aa]| [Bb][Aa][Ss] | [Bb][Aa][Ss][Hh] | [Bb][Aa][Ss][Hh][Pp] | [Bb][Aa][Ss][Hh][Pp[Oo]  | [Bb][Aa][Ss][Hh][Pp[Oo][Dd] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd][Ee] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd][Ee][Rr])
                 APP_NAME="bashpodder"
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Oo] | [Gg][Oo][Ll] | [Gg][Oo][Ll][Dd] | [Gg][Oo][Ll][Dd][Ee] | [Gg][Oo][Ll][Dd][Ee][Nn] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp][Oo] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp][Oo][Dd])
                 APP_NAME="goldenpod"
                 f_application_run
                 ;;
                 3 | [Hh] | [Hh][Pp] | [Hh][Pp][Oo] | [Hh][Pp][Oo][Dd] | [Hh][Pp][Oo][Dd][Dd] | [Hh][Pp][Oo][Dd][Dd][Ee] | [Hh][Pp][Oo][Dd][Dd][Ee][Rr])
                 APP_NAME="hpodder"
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Gg] | [Pp][Oo][Dd][Gg][Ee] | [Pp][Oo][Dd][Gg][Ee][Tt])
                 APP_NAME="podget"
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Rr] | [Pp][Oo][Dd][Rr][Aa] | [Pp][Oo][Dd][Rr][Aa][Cc] | [Pp][Oo][Dd][Rr][Aa][Cc][Ee] | [Pp][Oo][Dd][Rr][Aa][Cc][Ee][Rr])
                 APP_NAME="podracer"
                 f_application_run
                 ;;
                 6 | [Uu] | [Uu][Rr] | [Uu][Rr][Aa] | [Uu][Rr][Aa][Nn] | [Uu][Rr][Aa][Nn][Ii] | [Uu][Rr][Aa][Nn][Ii][Aa] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa][Ss] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa][Ss][Tt])
                 APP_NAME="uraniacast"
                 f_application_run
                 ;;
            esac                # End of Podcatcher Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Podcatcher Applications until loop.
} # End of function f_menu_app_podcatchers
#
# +----------------------------------------+
# |  Function f_menu_app_remote_connection |
# +----------------------------------------+
#
f_menu_app_remote_connection () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Remote Connection Applications until loop.
            #MRC cpu     - Remote connection.
            #MRC openssh - Remote connection.
            #MRC ssh     - Remote connection.
            #MRC sslh    - Remote connection.
            #
            MENU_TITLE="Remote Connection Applications Menu"
            DELIMITER="#MRC" #MRC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Remote Connection Applications case statement.
                 1 | [Cc] | [Cc][Pp] | [Cc][Pp][Uu])
                 APP_NAME="cpu"
                 f_application_run
                 ;;
                 2 | [Oo] | [Oo][Pp] | [Oo][Pp][Ee] | [Oo][Pp][Ee][Nn] | [Oo][Pp][Ee][Nn][Ss] | [Oo][Pp][Ee][Nn][Ss][Ss] | [Oo][Pp][Ee][Nn][Ss][Ss][Hh])
                 APP_NAME="openssh"
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Ss] | [Ss][Ss][Hh])
                 APP_NAME="ssh"
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Ss] | [Ss][Ss][Ll] | [Ss][Ss][Ll][Hh])
                 APP_NAME="sslh"
                 f_application_run
                 ;;
            esac                # End of Remote Connection Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of Remote Connection Applications until loop.
} # End of function f_menu_app_remote_connection
#
# +----------------------------------------+
# |     Function f_menu_app_rssfeeders      |
# +----------------------------------------+
#
f_menu_app_rssfeeders () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
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
            MENU_TITLE="RSS Feeder Applications Menu"
            DELIMITER="#MRS" #MRS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of RSS Feeder Applications case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Nn] | [Cc][Aa][Nn][Tt] | [Cc][Aa][Nn][Tt][Oo])
                 APP_NAME="canto"
                 f_application_run
                 ;;
                 2 | [Nn] | [Nn][Ee] | [Nn][Ee][Ww] | [Nn][Ee][Ww][Ss] | [Nn][Ee][Ww][Ss][Bb] | [Nn][Ee][Ww][Ss][Bb][Ee] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt][Ee] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt][Ee][Rr])
                 APP_NAME="newsbeuter"
                 f_application_run
                 ;;
                 3 | [Nn] | [Nn][Rr] | [Nn][Rr][Ss] | [Nn][Rr][Ss][Ss])
                 APP_NAME="nrss"
                 f_application_run
                 ;;
                 4 | [Oo] | [Oo][Ll] | [Oo][Ll][Ii] | [Oo][Ll][Ii][Vv] | [Oo][Ll][Ii][Vv][Ee])
                 APP_NAME="olive"
                 f_application_run
                 ;;
                 5 | [Rr] | [Rr][Aa] | [Rr][Aa][Gg] | [Rr][Aa][Gg][Gg] | [Rr][Aa][Gg][Gg][Ll] | [Rr][Aa][Gg][Gg][Ll][Ee])
                 APP_NAME="raggle"
                 f_application_run
                 ;;
                 6 | [Rr] | [Rr][Aa] | [Rr][Aa][Ww] | [Rr][Aa][Ww][Dd] | [Rr][Aa][Ww][Dd][Oo] | [Rr][Aa][Ww][Dd][Oo][Gg])
                 APP_NAME="rawdog"
                 f_application_run
                 ;;
                 7 | [Rr] | [Rr][Ss] | [Rr][Ss][Ss]  | [Rr][Ss][Ss][Tt]  | [Rr][Ss][Ss][Tt][Aa]  | [Rr][Ss][Ss][Tt][Aa][Ii]  | [Rr][Ss][Ss][Tt][Aa][Ii][Ll])
                 APP_NAME="rsstail"
                 f_application_run
                 ;;
                 8 | [Ss] | [Ss][Nn] | [Ss][Nn][Oo] | [Ss][Nn][Oo][Ww] | [Ss][Nn][Oo][Ww][Nn] | [Ss][Nn][Oo][Ww][Nn][Ee] | [Ss][Nn][Oo][Ww][Nn][Ee][Ww] | [Ss][Nn][Oo][Ww][Nn][Ee][Ww][Ss])
                 APP_NAME="snownews"
                 f_application_run
                 ;;
            esac                # End of RSS Feeder Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done  # End of RSS Feeder Applications until loop.
} # End of function f_menu_app_rssfeeders
#
# +----------------------------------------+
# |       Function f_menu_cat_network      |
# +----------------------------------------+
#
f_menu_cat_network () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -ge 0 -a $CHOICE_SCAT -le $MAX ]
      do    # Start of Network Application Category until loop.
            #BNE Configuration - scan for wireless networks, display wired/wireless config and routing tables.
            #BNE Monitors - LAN monitors, network packet analyzers, network mappers.
            #
            MENU_TITLE="Network Application Category Menu"
            DELIMITER="#BNE" #BNE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_SCAT in # Start of Network Application Category case statement.
                 1 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Ff] | [Cc][Oo][Nn][Ff][Ii] | [Cc][Oo][Nn][Ff][Ii][Gg] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr][Aa] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr][Aa][Tt] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr][Aa][Tt][Ii] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr][Aa][Tt][Ii][Oo] | [Cc][Oo][Nn][Ff][Ii][Gg][Uu][Rr][Aa][Tt][Ii][Oo][Nn])
                 f_menu_app_network_config
                 ;;
                 2 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Ii] | [Mm][Oo][Nn][Ii][Tt] | [Mm][Oo][Nn][Ii][Tt][Oo] | [Mm][Oo][Nn][Ii][Tt][Oo][Rr] | [Mm][Oo][Nn][Ii][Tt][Oo][Rr][Ss])
                 f_menu_app_network_monitors
                 ;;
            esac                # End of Network Application Category case statement.
      done  # End of Network Application Category until loop.
} # End of function f_menu_cat_network
#
# +----------------------------------------+
# |   Function f_menu_app_network_config   |
# +----------------------------------------+
#
f_menu_app_network_config () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Network Configuration Applications until loop.
            #MNF ifconfig    - NIC configuration.
            #MNF ip route    - Shows routing.
            #MNF route       - Shows routing table.
            #MNF mtr         - Traceroute tool, has features of ping and traceroute.
            #MNF wicd-curses - Wireless scan and connect to wired/wireless networks.
            #MNF iwconfig    - Wireless NIC configuration.
            #MNF smbc        - Samba file manager for folder shares with Microsoft Windows
            #MNF smbclient   - Samba client (share folders with Microsoft Windows).
            #MNF smbstatus   - Samba files lock status.
            #MNF testparm    - Samba configuration display.
            #
            MENU_TITLE="Network Configuration Applications Menu"
            DELIMITER="#MNF" #MNF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Network Configuration Applications case statement.
                 1 | [Ii] | [Ii][Ff] | [Ii][Ff][Cc] | [Ii][Ff][Cc][Oo] | [Ii][Ff][Cc][Oo][Nn] | [Ii][Ff][Cc][Oo][Nn][Ff] | [Ii][Ff][Cc][Oo][Nn][Ff][Ii] | [Ii][Ff][Cc][Oo][Nn][Ff][Ii][Gg])
                 APP_NAME="ifconfig"
                 f_application_run
                 ;;
                 2 | [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Rr] | [Ii][Pp]' '[Rr][Oo] | [Ii][Pp]' '[Rr][Oo][Uu] | [Ii][Pp]' '[Rr][Oo][Uu][Tt] | [Ii][Pp]' '[Rr][Oo][Uu][Tt][Ee])
                 APP_NAME="ip route"
                 f_application_run
                 ;;
                 3 | [Rr] | [Rr][Oo] | [Rr][Oo][Uu] | [Rr][Oo][Uu][Tt] | [Rr][Oo][Uu][Tt][Ee])
                 APP_NAME="route"
                 f_application_run
                 ;;
                 4 | [Mm] | [Mm][Tt] | [Mm][Tt][Rr])
                 APP_NAME="mtr"
                 f_application_run
                 ;;
                 5 | [Ww] | [Ww][Ii] | [Ww][Ii][Cc] | [Ww][Ii][Cc][Dd] | [Ww][Ii][Cc][Dd][-] | [Ww][Ii][Cc][Dd][-][Cc] | [Ww][Ii][Cc][Dd][-][Cc][Uu] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss][Ee] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss][Ee][Ss])
                 APP_NAME="wicd-curses"
                 f_application_run
                 ;;
                 6 | [Ii] | [Ii][Ww] | [Ii][Ww][Cc] | [Ii][Ww][Cc][Oo] | [Ii][Ww][Cc][Oo][Nn] | [Ii][Ww][Cc][Oo][Nn][Ff] | [Ii][Ww][Cc][Oo][Nn][Ff][Ii] | [Ii][Ww][Cc][Oo][Nn][Ff][Ii][Gg])
                 APP_NAME="iwconfig"
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc])
                 APP_NAME="smbc"
                 f_application_run
                 ;;
                 8 | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc] | [Ss][Mm][Bb][Cc][Ll] | [Ss][Mm][Bb][Cc][Ll][Ii] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee][Nn] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee][Nn][Tt])
                 APP_NAME="smbclient"
                 f_application_run
                 ;;
                 9 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Ss] | [Ss][Mm][Bb][Ss][Tt] | [Ss][Mm][Bb][Ss][Tt][Aa] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt][Uu] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt][Uu][Ss])
                 APP_NAME="smbstatus"
                 f_application_run
                 ;;
                 10 | [Tt] | [Tt][Ee] | [Tt][Ee][Ss] | [Tt][Ee][Ss][Tt] | [Tt][Ee][Ss][Tt][Pp] | [Tt][Ee][Ss][Tt][Pp][Aa] | [Tt][Ee][Ss][Tt][Pp][Aa][Rr] | [Tt][Ee][Ss][Tt][Pp][Aa][Rr][Mm])
                 APP_NAME="testparm"
                 f_application_run
                 ;;
            esac                # End of Network Configuration Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Network Configuration Applications until loop.
} # End of function f_menu_app_network_config
#
# +----------------------------------------+
# |Function f_menu_app_network_monitors    |
# +----------------------------------------+
#
f_menu_app_network_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Network Monitor Applications until loop.
            #MNM cbm         - Color Bandwidth Meter, ncurses based display.
            #MNM iftop       - IP LAN monitor.
            #MNM iptraf      - IP LAN monitor.
            #MNM nc          - Netcat reads/writes data across network.
            #MNM ngrep       - Network packet analyzer.
            #MNM nmap        - Network Mapper, mapping, auditing, security scanning.
            #
            MENU_TITLE="Network Monitor Applications Menu"
            DELIMITER="#MNM" #MNM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Network Monitor Applications case statement.
                 1 | [Cc] | [Cc][Bb] | [Cc][Bb][Mm])
                 APP_NAME="cbm"
                 f_application_run
                 ;;
                 2 | [Ii] | [Ii][Ff] | [Ii][Ff][Tt] | [Ii][Ff][Tt][Oo] | [Ii][Ff][Tt][Oo][Pp])
                 APP_NAME="iftop"
                 f_application_run
                 ;;
                 3 | [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Rr] | [Ii][Pp][Tt][Rr][Aa] | [Ii][Pp][Tt][Rr][Aa][Ff])
                 APP_NAME="iptraf"
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Cc])
                 APP_NAME="nc"
                 f_application_run
                 ;;
                 5 | [Nn] | [Nn][Gg] | [Nn][Gg][Rr] | [Nn][Gg][Rr][Ee] | [Nn][Gg][Rr][Ee][Pp])
                 APP_NAME="ngrep"
                 f_application_run
                 ;;
                 6 | [Nn] | [Nn][Mm] | [Nn][Mm][Aa] | [Nn][Mm][Aa][Pp])
                 APP_NAME="nmap"
                 f_application_run
                 ;;
            esac                # End of Network Monitor Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Network Monitor Applications until loop.
} # End of function f_menu_app_network_monitors
#
# +----------------------------------------+
# |    Function f_menu_app_file_managers   |
# +----------------------------------------+
#
f_menu_app_file_managers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of File Manager Applications until loop.
            #MFI  clex   - File manager.
            #MFI  mc     - File Manager, Midnight Commander.
            #MFI  ranger - File manager.
            #MFI  smbc   - Samba file manager for folder shares with Microsoft Windows.
            #MFI  vfu    - File manager, ncurses-based.
            #MFI  vifm   - File manager with vi-like commands.
            #MFI  detox  - File name clean up.
            #MFI  jless  - File viewer pager.
            #MFI  most   - File viewer pager.
            #
            MENU_TITLE="File Manager Applications Menu"
            DELIMITER="#MFI" #MFI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of File Manager Applications case statement.
                 1 | [Cc] | [Cc][Ll] | [Cc][Ll][Ee] | [Cc][Ll][Ee][Xx])
                 APP_NAME="clex"
                 f_application_run
                 ;;
                 2 | [Mm] | [Mm][Cc])
                 APP_NAME="mc"
                 f_application_run
                 ;;
                 3 | [Rr] | [Rr][Aa] | [Rr][Aa][Nn] | [Rr][Aa][Nn][Gg] | [Rr][Aa][Nn][Gg][Ee] | [Rr][Aa][Nn][Gg][Ee][Rr])
                 APP_NAME="ranger"
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc])
                 APP_NAME="smbc Samba Commander"
                 f_application_run
                 ;;
                 5 | [Vv] | [Vv][Ff] | [Vv][Ff][Uu]) 
                 APP_NAME="vfu"
                 f_application_run
                 ;;
                 6 | [Vv] | [Vv][Ii] | [Vv][Ii][Ff] | [Vv][Ii][Ff][Mm])
                 APP_NAME="vifm"
                 f_application_run
                 ;;
                 7 | [Dd] | [Dd][Ee] | [Dd][Ee][Tt] | [Dd][Ee][Tt][Oo] | [Dd][Ee][Tt][Oo][Xx])
                 APP_NAME="detox"
                 f_application_run
                 ;;
                 8 | [Jj] | [Jj][Ll] | [Jj][Ll][Ee] | [Jj][Ll][Ee][Ss] | [Jj][Ll][Ee][Ss][Ss])
                 APP_NAME="jless"
                 f_application_run
                 ;;
                 9 | [Mm] | [Mm][Oo] | [Mm][Oo][Ss] | [Mm][Oo][Ss][Tt])
                 APP_NAME="most"
                 f_application_run
                 ;;
            esac               # End of File Manager Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of File Manager Applications until loop.
} # End of f_menu_app_file_managers
#
# +----------------------------------------+
# |     Function f_menu_app_text_editors   |
# +----------------------------------------+
#
f_menu_app_text_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Text Editor Applications until loop.
            #MTE beav      - Binary editor and viewer.
            #MTE dav       - Text editor.
            #MTE ed        - Classic CLI text editor.
            #MTE emacs     - Full screen text editor with plugins.
            #MTE joe       - Text editor. Ctrl-K H for help.
            #MTE nano      - Simple full-screen text editor.
            #MTE pico      - Simple full-screen text editor.
            #MTE vi        - Classic full-screen text editor.
            #MTE vim       - vi "Improved" text editor.
            #MTE doconce   - Text markup language to transform text formats.
            #MTE imediff2  - Interactive 2-way file merge.
            #MTE txt2man   - Converts ASCII format to man format.
            #MTE colordiff - Differences between two text files shown in color.
            #MTE diff      - Differences between two text files shown using <> signs.
            #MTE vimdiff   - Differences between two text files shown in color highlights.
            #MTE wdiff     - Differences between two text files shown using +/- signs.

            #
            MENU_TITLE="Text Editor Applications Menu"
            DELIMITER="#MTE" #MTE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Text Editor Applications case statement.
                 1 | [Bb] | [Bb][Ee] | [Bb][Ee][Aa] | [Bb][Ee][Aa][Vv] | [Bb][Ee][Aa][Vv][Ee])
                 APP_NAME="beav"
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Aa] | [Dd][Aa][Vv])
                 APP_NAME="dav"
                 f_how_to_quit_application "<F5>"
                 f_application_run
                 ;;
                 3 | [Ee] | [Ee][Dd])
                 APP_NAME="ed"
                 f_application_run
                 ;;
                 4 | [Ee] | [Ee][Mm] | [Ee][Mm][Aa] | [Ee][Mm][Aa][Cc] | [Ee][Mm][Aa][Cc][Ss])
                 APP_NAME="emacs"
                 f_application_run
                 ;;
                 5 | [Jj] | [Jj][Oo] | [Jj][Oo][Ee])
                 APP_NAME="joe"
                 f_application_run
                 ;;
                 6 | [Nn] | [Nn][Aa] | [Nn][Aa][Nn] | [Nn][Aa][Nn][Oo])
                 APP_NAME="nano"
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Ii] | [Pp][Ii][Cc] | [Pp][Ii][Cc][Oo])
                 APP_NAME="pico"
                 f_application_run
                 ;;
                 8 | [Vv] | [Vv][Ii])
                 APP_NAME="vi"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 9 | [Vv] | [Vv][Ii] | [Vv][Ii][Mm])
                 APP_NAME="vim"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 10 | [Dd] | [Dd][Oo] | [Dd][Oo][Cc] | [Dd][Oo][Cc][Oo] | [Dd][Oo][Cc][Oo][Nn] | [Dd][Oo][Cc][Oo][Nn][Cc] | [Dd][Oo][Cc][Oo][Nn][Cc][Ee])
                 APP_NAME="doconce"
                 f_application_run
                 ;;
                 11 | [Ii] | [Ii][Mm] | [Ii][Mm][Ee] | [Ii][Mm][Ee][Dd] | [Ii][Mm][Ee][Dd][Ii] | [Ii][Mm][Ee][Dd][Ii][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff][2])
                 APP_NAME="imediff"
                 f_application_run
                 ;;
                 12 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Mm] | [Tt][Xx][Tt][2][M][Aa] | [Tt][Xx][Tt][2][Mm][Aa][Nn])
                 APP_NAME="txt2man"
                 f_application_run
                 ;;
                 13 | [Cc] | [Cc][Oo] | [Cc][Oo][Ll] | [Cc][Oo][Ll][Oo] | [Cc][Oo][Ll][Oo][Rr] | [Cc][Oo][Ll][Oo][Rr][Dd] | [Cc][Oo][Ll][Oo][Rr][[Dd][Ii] | [Cc][Oo][Ll][Oo][Rr][Dd][Ii][Ff] | [Cc][Oo][Ll][Oo][Rr][Dd][Ii][Ff][Ff])
                 APP_NAME="colordiff"
                 f_application_run
                 ;;
                 14 | [Dd] | [[Dd][Ii] | [Dd][Ii][Ff] | [Dd][Ii][Ff][Ff])
                 APP_NAME="diff"
                 f_application_run
                 ;;
                 15 | [Vv] | [Vv][Ii] | [Vv][Ii][Mm] | [Vv][Ii][Mm][Dd] | [Vv][Ii][Mm][Dd][Ii] | [Vv][Ii][Mm][Dd][Ii][Ff] | [Vv][Ii][Mm][Dd][Ii][Ff][Ff])
                 APP_NAME="vimdiff"
                 f_application_run
                 ;;
                 16 | [Ww] | [Ww][Dd] | [Ww][Dd][Ii] | [Ww][Dd][Ii][Ff] | [Ww][Dd][Ii][Ff][Ff])
                 APP_NAME="wdiff"
                 ;;
            esac                # End of Text Editor Applications case statement.
            f_application_error $ERROR $APP_NAME # If application is not installed display help instructions.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Text Editor Applications until loop.
} # End of f_menu_app_text_editors
#
# +----------------------------------------+
# | Function f_menu_cat_system_applications|
# +----------------------------------------+
#
f_menu_cat_system_applications () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -ge 0 -a $CHOICE_SCAT -le $MAX ]
      do    # Start of System Category until loop.
            #BSY Logs     - System Log file viewers.
            #BSY Monitors - System processes, resources, and disk I/O monitors.
            #BSY Other    - Screen capture, file compression, DOS Emulators.
            #BSY Screens  - Multiple screen sessions.
            #
            MENU_TITLE="System Category Menu"
            DELIMITER="#BSY" #BSY This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_SCAT in # Start of System Category case statement.
                 1 | [Ll] | [Ll][Oo] | [Ll][Oo][Gg] | [Ll][Oo][Gg][Ss]) 
                 f_menu_app_sys_logs
                 ;;
                 2 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Ii] | [Mm][Oo][Nn][Ii][Tt]] | [Mm][Oo][Nn][Ii][Tt]][Oo] | [Mm][Oo][Nn][Ii][Tt]][Oo][Rr] | [Mm][Oo][Nn][Ii][Tt]][Oo][Rr][Ss])
                 f_menu_app_sys_monitors
                 ;;
                 3 | [Oo] | [Oo][Tt] | [Oo][Tt][Hh] | [Oo][Tt][Hh][Ee] | [Oo][Tt][Hh][Ee][Rr]) 
                 f_menu_app_sys_other
                 ;;
                 4 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss]) 
                 f_menu_app_sys_screens
                 ;;
            esac                # End of System Category case statement.
      done  # End of System Category until loop.
} # End of function f_menu_cat_system_applications
#
# +----------------------------------------+
# |    Function f_menu_app_sys_monitors    |
# +----------------------------------------+
#
f_menu_app_sys_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of System Monitors until loop.
            #MSM atop      - System process and resource manager.
            #MSM glances   - System process and resource manager.
            #MSM htop      - System process and resource manager.
            #MSM top       - System process and resource manager.
            #MSM dstat     - View system resources.
            #MSM iotop     - Disk i/o process monitor.
            #MSM ncdu      - Disk usage monitor, ncurses-based.
            #MSM cfdisk    - Disk partition tool.
            #MSM parted    - Disk partition tool.
            #MSM saidar    - Monitor system processes, network I/O, disks I/O, free space.
            #MSM yacpi     - ACPI monitor, ncurses-based.
            #
            MENU_TITLE="System Monitors Menu"
            DELIMITER="#MSM" #MSM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of System Monitors case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Oo] | [Aa][Tt][Oo][Pp])
                 APP_NAME="atop"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Ll] | [Gg][Ll][Aa] | [Gg][Ll][Aa][Nn] | [Gg][Ll][Aa][Nn][Cc] | [Gg][Ll][Aa][Nn][Cc][Ee] | [Gg][Ll][Aa][Nn][Cc][Ee][Ss])
                 APP_NAME="glances"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 3 | [Hh] | [Hh][Tt] | [Hh][Tt][Oo] | [Hh][Tt][Oo][Pp])
                 APP_NAME="htop"
                 f_how_to_quit_application "q or <F10>"
                 f_application_run
                 ;;
                 4 | [Tt] | [Tt][Oo] | [Tt][Oo][Pp])
                 APP_NAME="top"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 5 | [Dd] | [Dd][Ss] | [Dd][Ss][Tt] | [Dd][Ss][Tt][Aa] | [Dd][Ss][Tt][Aa][Tt])
                 APP_NAME="dstat 1 10"
                 f_application_run
                 ;;
                 6 | [Ii]| [Ii][Oo] | [Ii][Oo][Tt] | [Ii][Oo][Tt][Oo] | [Ii][Oo][Tt][Oo][Pp])
                 APP_NAME="iotop"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 7 | [Nn] | [Nn][Cc] | [Nn][Cc][Dd] | [Nn][Cc][Dd][Uu])
                 APP_NAME="ncdu"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 8 | [Cc] | [Cc][Ff] | [Cc][Ff][Dd] | [Cc][Ff][Dd][Ii] | [Cc][Ff][Dd][Ii][Ss] | [Cc][Ff][Dd][Ii][Ss][Kk])
                 APP_NAME="cfdisk"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 9 | [Pp] | [Pp][Aa] | [Pp][Aa][Rr] | [Pp][Aa][Rr][Tt] | [Pp][Aa][Rr][Tt][Ee] | [Pp][Aa][Rr][Tt][Ee][Dd])
                 APP_NAME="parted"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 10 | [Ss] | [Ss][Aa] | [Ss][Aa][Ii] | [Ss][Aa][Ii][Dd] | [Ss][Aa][Ii][Dd][Aa] | [Ss][Aa][Ii][Dd][Aa][Rr])
                 APP_NAME="saidar"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 11 | [Yy] | [Yy][Aa] | [Yy][Aa][Cc] | [Yy][Aa][Cc][Pp] | [Yy][Aa][Cc][Pp][Ii])
                 APP_NAME="yacpi"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
            esac                # End of System Monitors case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of System Monitors until loop.
} # End of f_menu_app_sys_monitors
#
# +----------------------------------------+
# |      Function f_menu_app_sys_logs      |
# +----------------------------------------+
#
f_menu_app_sys_logs () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of System Logs until loop.
            #MLO multitail - View multiple log files using multiple panes.
            #
            MENU_TITLE="System Logs Menu"
            DELIMITER="#MLO" #MLO This 3rd field prevents awk from printing this line into menu options.
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of System Logs case statement.
                 1 | [Mm] | [Mm][Uu] | [Mm][Uu][Ll] | [Mm][Uu][Ll][Tt] | [Mm][Uu][Ll][Tt][Ii] | [Mm][Uu][Ll][Tt][Ii][Tt] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa][Ii] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa][Ii][Ll])
                 APP_NAME="multitail"
                 f_application_run
                 ;;
            esac                # End of System Logs case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of System Logs until loop.
} # End of f_menu_app_sys_logs
#
# +----------------------------------------+
# |    Function f_menu_app_sys_screens     |
# +----------------------------------------+
#
f_menu_app_sys_screens () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of System Screens until loop.
            #MSC byobu     - Multiple sessions.
            #MSC screen    - Multiple sessions via split or pager screens.
            #MSC tmux      - Multiple sessions with multiplexing.
            #
            MENU_TITLE="System Screens Menu"
            DELIMITER="#MSC" #MSC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of System Screens case statement.
                 1 | [Bb] | [Bb][Yy] | [Bb][Yy][Oo] | [Bb][Yy][Oo][Bb] | [Bb][Yy][Oo][Bb][Uu])
                 APP_NAME="byobu"
                 f_application_run
                 ;;
                 2 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn])
                 APP_NAME="screen"
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Mm] | [Tt][Mm][Uu] | [Tt][Mm][Uu][Xx])
                 APP_NAME="tmux"
                 f_application_run
                 ;;
            esac                # End of System Screens case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of System Screens until loop.
} # End of f_menu_app_sys_screens
#
# +----------------------------------------+
# |     Function f_menu_app_sys_other      |
# +----------------------------------------+
#
f_menu_app_sys_other () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of System Other until loop.
            #MSO dosemu    - DOS emulator.
            #MSO dtrx      - Extract tar, zip, deb, rpm, gz, bz2, cab, 7z, lzh, rar, etc.
            #MSO scrot     - Screen capture.
            #
            MENU_TITLE="Other System Applications Menu"
            DELIMITER="#MSO" #MSO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Other System Applications case statement.
                 1 | [Dd] | [Dd][Oo] | [Dd][Oo][Ss] | [Dd][Oo][Ss][Ee] | [Dd][Oo][Ss][Ee][Mm] | [Dd][Oo][Ss][Ee][Mm][Uu])
                 APP_NAME="dosemu"
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Tt] | [Dd][Tt][Rr] | [Dd][Tt][Rr][Xx])
                 APP_NAME="dtrx"
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Oo] | [Ss][Cc][Rr][Oo][Tt])
                 APP_NAME="scrot"
                 f_application_run
                 ;;
            esac                # End of Other System Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Other System Applications until loop.
} # End of f_menu_app_sys_other
#
# +----------------------------------------+
# |    Function f_menu_app_calendar_todo   |
# +----------------------------------------+
#
f_menu_app_calendar_todo () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Calendar-ToDo Applications until loop.
            #MCA cal     - Displays a monthly calendar.
            #MCA gcalcli - Google calendar.
            #MCA pal     - Calendar.
            #MCA pom     - Display phase of moon on given date.
            #MCA remind  - Sophisticated calendar with alarms. Sunrise, sunset, moon phases.
            #MCA when    - Calendar.
            #MCA wyrd    - Calendar, ncurses-based.
            #MCA devtodo - To-Do List hierarchical.
            #MCA yaGTD   - To-Do List.
            #
            MENU_TITLE="Calendar-ToDo Applications Menu"
            DELIMITER="#MCA" #MCA This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Calendar-ToDo Applications case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll])
                 APP_NAME="cal"
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Cc] | [Gg][Cc][Aa] | [Gg][Cc][Aa][Ll] | [Gg][Cc][Aa][Ll][Cc] | [Gg][Cc][Aa][Ll][Cc][Ll] | [Gg][Cc][Aa][Ll][Cc][Ll][Ii])
                 APP_NAME="gcalcli"
                 f_application_run
                 ;;
                 3 | [Pp] | [Pp][Aa] | [Pp][Aa][Ll])
                 APP_NAME="pal"
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Oo] | [Pp][Oo][Mm])
                 APP_NAME="pom"
                 f_application_run
                 ;;
                 5 | [Rr] | [Rr][Ee] | [Rr][Ee][Mm | [Rr][Ee][Mm][Ii] | [Rr][Ee][Mm][Ii][Nn] | [Rr][Ee][Mm][Ii][Nn][Dd)
                 APP_NAME="remind"
                 f_application_run
                 ;;
                 6 | [Ww] | [Ww][Hh] | [Ww][Hh][Ee] | [Ww][Hh][Ee][Nn])
                 APP_NAME="when"
                 f_application_run
                 ;;
                 7 | [Ww] | [Ww][Yy] | [Ww][Yy][Rr] | [Ww][Yy][Rr][Dd])
                 APP_NAME="wyrd"
                 f_application_run
                 ;;
                 8 | [Dd] | [Dd][Ee] | [Dd][Ee][Vv] | [Dd][Ee][Vv][Tt] | [Dd][Ee][Vv][Tt][Oo] | [Dd][Ee][Vv][Tt][Oo][Dd] | [Dd][Ee][Vv][Tt][Oo][Dd][Oo])
                 APP_NAME="devtodo"
                 f_application_run
                 ;;
                 9 | [Yy] | [Yy][Aa] | [Yy][Aa][Gg] | [Yy][Aa][Gg][Tt] | [Yy][Aa][Gg][Tt][Dd])
                 APP_NAME="yaGTD"
                 f_application_run
                 ;;
            esac                # End of Calendar-ToDo Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Calendar-ToDo Applications until loop.
} # End of f_menu_app_calendar_todo
#
# +----------------------------------------+
# |     Function f_menu_app_calculators    |
# +----------------------------------------+
#
f_menu_app_calculators () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Calculator Applications until loop.
            #MCC bc       - Calculator.
            #MCC orpie    - RPN Reverse Polish Notation calculator.
            #MCC tapecalc - Tape-like calculator.
            #
            MENU_TITLE="Calculator Applications Menu"
            DELIMITER="#MCC" #MCC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Calculator Applications case statement.
                 2 | [Bb] | [Bb][Cc])
                 APP_NAME="bc"
                 f_how_to_quit_application "quit"
                 f_application_run
                  ;;
                 3 | [Oo] | [Oo][Rr] | [Oo][Rr][Pp] | [Oo][Rr][Pp][Ii] | [Oo][Rr][Pp][Ii][Ee])
                 APP_NAME="orpie"
                 f_application_run
                 ;;
                 1 | [Tt] | [Tt][Aa] | [Tt][Aa][Pp] | [Tt][Aa][Pp][Ee] | [Tt][Aa][Pp][Ee][Cc] | [Tt][Aa][Pp][Ee][Cc][Aa] | [Tt][Aa][Pp][Ee][Cc][Aa][Ll] | [Tt][Aa][Pp][Ee][Cc][Aa][Ll][Cc])
                 APP_NAME="tapecalc"
                 f_application_run
                 ;;
            esac                # End of Calculator Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Calculator Applications until loop.
} # End of f_menu_app_calculators
#
# +----------------------------------------+
# |    Function f_menu_app_spreadsheets    |
# +----------------------------------------+
#
f_menu_app_spreadsheets () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Spreadsheet Applications until loop.
            #MSP oleo - Full-screen spreadsheet having a more Emacs-like feel.
            #MSP sc   - Spreadsheet.
            #MSP slsc - Spreadsheet based on sc.
            #
            MENU_TITLE="Spreadsheet Applications Menu"
            DELIMITER="#MSP" #MSP This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Spreadsheet Applications case statement.
                 1 | [Oo] | [Oo][Ll] | [Oo][Ll][Ee] | [Oo][Ll][Ee][Oo])
                 APP_NAME="oleo"
                 f_application_run
                 ;;
                 1 | [Ss] | [Ss][Cc])
                 APP_NAME="sc"
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Ll] | [Ss][Ll][Ss] | [Ss][Ll][Ss][Cc])
                 APP_NAME="slsc"
                 f_application_run
                 ;;
            esac                # End of Spreadsheet Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Spreadsheet Applications until loop.} # End of menu_app_spreadsheets
} # End of f_menu_app_spreadsheets
#
# +----------------------------------------+
# |  Function f_menu_app_note_applications |
# +----------------------------------------+
#
f_menu_app_note_applications () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Note Applications until loop.
            #MNO hnb - Hierarchical notebook.
            #
            MENU_TITLE="Note Applications Menu"
            DELIMITER="#MNO" #MNO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Note Applications case statement.
                 1 | [Hh] | [Hh][Nn] | [Hh][Nn][Bb])
                 APP_NAME="hnb"
                 f_application_run
                 ;;
            esac                # End of Note Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Note Applications until loop.
} # End of f_menu_note_applications
#
# +----------------------------------------+
# | Function f_menu_app_audio_applications |
# +----------------------------------------+
#
f_menu_app_audio_applications () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Audio Applications until loop.
            #MAU abcde         - Audio CD ripper.
            #MAU avconv        - Audio/Video converter.
            #MAU cmus          - Music player.
            #MAU juke          - Music Jukebox.
            #MAU moc           - Music player.
            #MAU ncmpc         - Music player, ncurses-based.
            #MAU ffmpeg        - Multimedia Record, convert, stream and play. 
            #MAU mplayer       - Multimedia player.
            #MAU dradio        - Radio on world-wide web.
            #MAU radio         - Radio, ncurses-based.
            #MAU ebook-speaker - Speech synthesizer reads EPUB and MS Reader eBooks.
            #MAU festival      - Speech synthesizer reads text.
            #MAU screader      - Speech synthesizer reads screen text.
            #
            MENU_TITLE="Audio Applications Menu"
            DELIMITER="#MAU" #MAU This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Audio Applications case statement.
                 1 | [Aa] | [Aa][Bb] | [AA][Bb][Cc] | [Aa][Bb][Cc][Dd] | [Aa][Bb][Cc][Dd][Ee)
                 APP_NAME="abcde"
                 f_application_run
                 ;;
                 2 | [Aa] | [Aa][Vv] | [Aa][Vv][Cc] | [Aa][Vv][Cc][Oo] | [Aa][Vv][Cc][Oo][Nn] | [Aa][Vv][Cc][Oo][Nn][Vv])
                 APP_NAME="avconv"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Mm] | [Cc][Mm][Uu] | [Cc][Mm][Uu][Ss])
                 APP_NAME="cmus"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 4 | [Jj] | [Jj][Uu] | [Jj][Uu][Kk] | [Jj][Uu][Kk][Ee])
                 APP_NAME="juke"
                 f_application_run
                 f_press_enter_key_to_continue
                 ;;
                 5 | [Mm] | [Mm][Oo] | [Mm][Oo][Cc])
                 APP_NAME="moc"
                 f_application_run
                 ;;
                 6 | [Nn] | [Nn][Cc] | [Nn][Cc][Mm] | [Nn][Cc][Mm][Pp] | [Nn][Cc][Mm][Pp][Cc])
                 f_how_to_quit_application "q"
                 APP_NAME="ncmpc"
                 f_application_run
                 ;;
                 7 | [Ff] | [Ff][Ff] | [Ff][Ff][Mm] | [Ff][Ff][Mm][Ee] | [Ff][Ff][Mm][Ee][Gg])
                 APP_NAME="ffmpeg"
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr])
                 APP_NAME="mplayer"
                 f_application_run
                 f_press_enter_key_to_continue
                 ;;
                 9 | [Dd] | [Dd][Rr] | [Dd][Rr][Aa] | [Dd][Rr][Aa][Dd] | [Dd][Rr][Aa][Dd][Ii] | [Dd][Rr][Aa][Dd][Ii][Oo])
                 APP_NAME="dradio"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 10 | [Rr] | [Rr][Aa] | [Rr][Aa][Dd] | [Rr][Aa][Dd][Ii] | [Rr][Aa][Dd][Ii][Oo])
                 APP_NAME="radio"
                 f_application_run
                 ;;
                 11 | [Ee] | [Ee][Bb] | [Ee][Bb][Oo] | [Ee][Bb][Oo][Oo] | [Ee][Bb][Oo][Oo][Kk] | [Ee][Bb][Oo][Oo][Kk][–] | [Ee][Bb][Oo][Oo][Kk][–][Ss] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk][Ee] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk][Ee][Rr])
                 APP_NAME="ebook-speaker"
                 f_application_run
                 ;;
                 12 | [Ff] | [Ff][Ee] | [Ff][Ee][Ss] | [Ff][Ee][Ss][Tt] | [Ff][Ee][Ss][Tt][Ii] | [Ff][Ee][Ss][Tt][Ii][Vv] | [Ff][Ee][Ss][Tt][Ii][Vv][Aa] | [Ff][Ee][Ss][Tt][Ii][Vv][Aa][Ll])
                 APP_NAME="festival"
                 f_application_run
                 ;;
                 13 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Aa] | [Ss][Cc][Rr][Ee][Aa][Dd] | [Ss][Cc][Rr][Ee][Aa][Dd][Ee] | [Ss][Cc][Rr][Ee][Aa][Dd][Ee][Rr])
                 APP_NAME="screader"
                 f_application_run
                 ;;
            esac                # End of Audio Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Audio Applications until loop.
} # End of f_menu_app_audio_applications
#
# +----------------------------------------+
# |    Function f_menu_app_screen_savers   |
# +----------------------------------------+
#
f_menu_app_screen_savers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Screen-saver Applications until loop.
            #MSS cmatrix   - Matrix-like screen-saver.
            #MSS rain      - Rain on screen.
            #MSS tty-clock - Display a digital clack full-screen.
            #MSS worms     - Worms wiggle on the screen.
            #
            MENU_TITLE="Screen-saver Applications Menu"
            DELIMITER="#MSS" #MSS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Screen-saver Applications case statement.
                 1 | [Cc] | [Cc][Mm] | [Cc][Mm][Aa] | [Cc][Mm][Aa][Tt] | [Cc][Mm][Aa][Tt][Rr] | [Cc][Mm][Aa][Tt][Rr][Ii] | [Cc][Mm][Aa][Tt][Rr][Ii][Xx])
                 APP_NAME="cmatrix"
                 f_application_run
                 ;;
                 2 | [Rr] | [Rr][Aa] | [Rr][Aa][Ii] | [Rr][Aa][Ii][Nn])
                 APP_NAME="rain"
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Tt] | [Tt][Tt][Yy] | [Tt][Tt][Yy][-] | [Tt][Tt][Yy][–][Cc] | [Tt][Tt][Yy][–][Cc][Ll] | [Tt][Tt][Yy][–][Cc][Ll][Oo] | [Tt][Tt][Yy][–][Cc][Ll][Oo][Cc] | [Tt][Tt][Yy][–][Cc][Ll][Oo][Cc][Kk])
                 APP_NAME="tty-clock"
                 f_application_run
                 ;;
                 4 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Mm] | [Ww][Oo][Rr][Mm][Ss])
                 APP_NAME="worms"
                 f_application_run
                 ;;
            esac                # End of Screen-saver Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Screen-saver Applications until loop.
} # End of f_menu_app_screen_savers
#
# +----------------------------------------+
# | Function                               |
# |  f_menu_app_image_graphic_applications |
# +----------------------------------------+
#
f_menu_app_image_graphics_applications () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Image-Graphics Applications until loop.
            #MIG aview      - ASCII art and image viewer
            #MIG hasciicam  - ASCII web camera images.
            #MIG caca-utils - Image viewer and converter jpg to ascii images.
            #MIG jp2a       - Convert jpg images to ascii images.
            #MIG linuxlogo  - Color ANSI system logo
            #
            MENU_TITLE="Image-Graphics Applications Menu"
            DELIMITER="#MIG" #MIG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Image-Graphics Applications case statement.
                 1 | [Aa] | [Aa][Vv] | [Aa][Vv][Ii] | [Aa][Vv][Ii][Ee] | [Aa][Vv][Ii][Ee][Ww])
                 APP_NAME="aview"
                 f_application_run
                 f_press_enter_key_to_continue
                 ;;
                 2 | [Hh] | [Hh][Aa] | [Hh][Aa][Ss] | [Hh][Aa][Ss][Cc] | [Hh][Aa][Ss][Cc][Ii] | [Hh][Aa][Ss][Cc][Ii][Ii] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc][Aa] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc][Aa][Mm])
                 APP_NAME="hasciicam"
                 f_application_run
                 f_press_enter_key_to_continue
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Cc] | [Cc][Aa][Cc][Aa] | [Cc][Aa][Cc][Aa][-] | [Cc][Aa][Cc][Aa][-][Uu] | [Cc][Aa][Cc][Aa][-][Uu][Tt] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii][Ll] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii][Ll][Ss])
                 APP_NAME="caca-utils"
                 f_application_run
                 ;;
                 4 | [Jj] | [Jj][Pp] | [Jj][Pp][2] | [Jj][Pp][2][Aa])
                 APP_NAME="jp2a"
                 f_application_run
                 ;;
                 5 | [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Uu] | [Ll][Ii][Nn][Uu][Xx] | [Ll][Ii][Nn][Uu][Xx][Ll] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo][Gg] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo][Gg][Oo])
                 APP_NAME="linuxlogo"
                 f_application_run
                 ;;
            esac                # End of Image-Graphics Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Image-Graphics Applications until loop.
} # End of f_menu_app_image_graphics_applications
#
# +----------------------------------------+
# | Function                               |
# |    f_menu_app_education_applications   |
# +----------------------------------------+
#
f_menu_app_education_applications () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Education Applications until loop.
            #MED aldo  - Morse code training.
            #MED cw    - Morse code training.
            #MED cwcp  - Morse code training.
            #MED morse - Morse code training.
            #MED primes - Prime number calculator. 
           #
            MENU_TITLE="Education Applications Menu"
            DELIMITER="#MED" #MED This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Education Applications case statement.
                 1 | [Aa] | [Aa][Ll] | [Aa][Ll][Dd] | [Aa][Ll][Dd][Oo])
                 APP_NAME="aldo"
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Ww])
                 APP_NAME="cw"
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Ww] | [Cc][Ww][Cc] | [Cc][Ww][Cc][Pp])
                 APP_NAME="cwcp"
                 f_application_run
                 ;;
                 4 | [Mm] | [Mm][Oo] | [Mm][Oo][Rr] | [Mm][Oo][Rr][Ss] | [Mm][Oo][Rr][Ss][Ee])
                 APP_NAME="morse"
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Rr] | [Pp][Rr][Ii] | [Pp][Rr][Ii][Mm] | [Pp][Rr][Ii][Mm][Ee] | [Pp][Rr][Ii][Mm][Ee][Ss])
                 APP_NAME="primes"
                 f_application_run
                 ;;
            esac                # End of Education Applications case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Education Applications until loop.
} # End of f_menu_app_education_applications
#
# +----------------------------------------+
# |       Function f_menu_cat_games        |
# +----------------------------------------+
#
f_menu_cat_games () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -ge 0 -a $CHOICE_SCAT -le $MAX ]
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
            f_quit_subcat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_SCAT in # Start of Game Category case statement.
                 1 | [Aa] | [Aa][Rr] | [Aa][Rr][Cc] | [Aa][Rr][Cc][Aa] | [Aa][Rr][Cc][Aa][Dd] | [Aa][Rr][Cc][Aa][Dd][Ee]) 
                 f_menu_app_games_arcade
                 ;;
                 2 | [Bb] | [Bb][Oo] | [Bb][Oo][Aa] | [Bb][Oo][Aa][Rr] | [Bb][Oo][Aa][Rr][Dd])
                 f_menu_app_games_board
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Rr] | [Cc][Aa][Rr][Dd])
                 f_menu_app_games_card
                 ;;
                 4 | [Mm] | [Mm][Uu] | [Mm][Uu][Dd])
                 f_menu_app_games_mud
                 ;;
                 5 | [Pp] | [Pp][Uu] | [Pp][Uu][Zz] | [Pp][Uu][Zz][Zz] | [Pp][Uu][Zz][Zz][Ll] | [Pp][Uu][Zz][Zz][Ll][Ee] | [Pp][Uu][Zz][Zz][Ll][Ee][Ss])
                 f_menu_app_games_puzzle
                 ;;
                 6 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Zz])
                 f_menu_app_games_quiz
                 ;;
                 7 | [Rr] | [Rr][Pp] | [Rr][Pp][Gg])
                 f_menu_app_games_rpg
                 ;;
                 8 | [Ss] | [Ss][Ii] | [Ss][Ii][Mm] | [Ss][Ii][Mm][Uu] | [Ss][Ii][Mm][Uu][Ll] | [Ss][Ii][Mm][Uu][Ll][Aa] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii][Oo] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii][Oo][Nn])
                 f_menu_app_games_simulation
                 ;;
                 9 | [Ss] | [Ss][Tt] | [Ss][Tt][Rr] | [Ss][Tt][Rr][Aa] | [Ss][Tt][Rr][Aa][Tt] | [Ss][Tt][Rr][Aa][Tt][Ee] | [Ss][Tt][Rr][Aa][Tt][Ee][Gg] | [Ss][Tt][Rr][Aa][Tt][Ee][Gg][Yy])
                 f_menu_app_games_strategy
                 ;;
                 10 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Dd])
                 f_menu_app_games_word
                 ;;
            esac                # End of Game Category case statement.
      done  # End of Game Category until loop.
} # End of function f_menu_cat_games
#
# +----------------------------------------+
# |    Function f_menu_app_games_arcade    |
# +----------------------------------------+
f_menu_app_games_arcade () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Arcade Games until loop.
            #MGB freesweep      - Minesweeper game.
            #MGB moon-buggy     - Drive a moon buggy on the moon.
            #MGB ninvaders      - Space invaders-like game ncurses-based.
            #MGB pacman4console - Pacman-like game ncurses-based.
            #MGB robots         - Be chased by killer robots.
            #MGB snake          - Be chased by a snake while collecting money.
            #MGB worm           - Be a growing worm, don't crash into yourself.
            #
            MENU_TITLE="Arcade Game Menu"
            DELIMITER="#MGB" #MGB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Arcade Games case statement.
                 1 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ee] | [Ff][Rr][Ee][Ee][Ss] | [Ff][Rr][Ee][Ee][Ss][Ww] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee][Ee] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee][Ee][Pp])
                 APP_NAME="freeswap"
                 f_application_run
                 ;;
                 2 | [Mm] | [Mm][Oo] | [Mm][Oo][Oo] | [Mm][Oo][Oo][Nn] | [Mm][Oo][Oo][Nn][-] | [Mm][Oo][Oo][Nn][-][Bb] | [Mm][Oo][Oo][Nn][-][Bb][Uu] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg][Gg] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg][Gg][Yy])
                 APP_NAME="moon-buggy"
                 f_application_run
                 ;;
                 3 | [Nn] | [Nn][Ii] | [Nn][Ii][Nn] | [Nn][Ii][Nn][Vv] | [Nn][Ii][Nn][Vv][Aa] | [Nn][Ii][Nn][Vv][Aa][Dd] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee][Rr] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee][Rr][Ss])
                 APP_NAME="ninvaders"
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Aa] | [Pp][Aa][Cc] | [Pp][Aa][Cc][Mm] | [Pp][Aa][Cc][Mm][Aa] | [Pp][Aa][Cc][Mm][Aa][Nn] | [Pp][Aa][Cc][Mm][Aa][Nn][4] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo][Ll] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo][Ll][Ee])
                 APP_NAME="pacman4console"
                 f_application_run
                 ;;
                 5 | [Rr] | [Rr][Oo] | [Rr][Oo][Bb] | [Rr][Oo][Bb][Oo] | [Rr][Oo][Bb][Oo][Tt] | [Rr][Oo][Bb][Oo][Tt][Ss])
                 APP_NAME="robots"
                 f_application_run
                 ;;
                 6 | [Ss] | [Ss][Nn] | [Ss][Nn][Aa] | [Ss][Nn][Aa][Kk] | [Ss][Nn][Aa][Kk][Ee])
                 APP_NAME="snake"
                 f_application_run
                 ;;
                 7 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Mm])
                 APP_NAME="worm"
                 f_application_run
                 ;;
            esac # End of Arcade Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Arcade Games until loop.
} # End of f_menu_app_games_arcade
#
#
# +----------------------------------------+
# |     Function f_menu_app_games_board    |
# +----------------------------------------+
f_menu_app_games_board () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Board Games until loop.
            #MGC atom4          - Board game strategy 2-player ncurses-based.
            #MGC backgammon     - Backgammon.
            #MGC monop          - Monopoly-like game.
            #
            MENU_TITLE="Board Games Menu"
            DELIMITER="#MGC" #MGC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Board Games case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Oo] | [Aa][Tt][Oo][Mm] | [Aa][Tt][Oo][Mm][4])
                 APP_NAME="atom4"
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Aa] | [Bb][Aa][Cc] | [Bb][Aa][Cc][Kk] | [Bb][Aa][Cc][Kk][Gg] | [Bb][Aa][Cc][Kk][Gg][Aa] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm][Oo] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm][Oo][Nn])
                 APP_NAME="backgammon"
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Oo] | [Mm][Oo][Nn][Oo][Pp])
                 APP_NAME="monop"
                 f_application_run
                 ;;
            esac # End of Board Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Board Games until loop.
} # End of f_menu_app_games_board
#
# +----------------------------------------+
# |     Function f_menu_app_games_card     |
# +----------------------------------------+
f_menu_app_games_card () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Card Games until loop.
            #MGD canfield       - Solitaire card game with betting.
            #MGD cribbage       - Cribbage Card game.
            #MGD go-fish        - Go Fish card game.
            #
            MENU_TITLE="Card Game Menu"
            DELIMITER="#MGD" #MGD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Card Games case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Nn] | [Cc][Aa][Nn][Ff] | [Cc][Aa][Nn][Ff][Ii] | [Cc][Aa][Nn][Ff][Ii][Ee] | [Cc][Aa][Nn][Ff][Ii][Ee][Ll] | [Cc][Aa][Nn][Ff][Ii][Ee][Ll][Dd)
                 APP_NAME="canfield"
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Rr] | [Cc][Rr][Ii] | [Cc][Rr][Ii][Bb] | [Cc][Rr][Ii][Bb][Bb] | [Cc][Rr][Ii][Bb][Bb][Aa] | [Cc][Rr][Ii][Bb][Bb][Aa][Gg] | [Cc][Rr][Ii][Bb][Bb][Aa][Gg][Ee])
                 APP_NAME="cribbage"
                 f_application_run
                 ;;
                 3 | [Gg] | [Gg][Oo] | [Gg][Oo][-] | [Gg][Oo][-][Ff] | [Gg][Oo][-][Ff][Ii] | [Gg][Oo][-][Ff][Ii][Ss] | [Gg][Oo][-][Ff][Ii][Ss][Hh])
                 APP_NAME="go-fish"
                 f_application_run
                 ;;
            esac # End of Card Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Card Games until loop.
} # End of f_menu_app_games_card
#
# +----------------------------------------+	
# |      Function f_menu_app_games_mud     |
# +----------------------------------------+
f_menu_app_games_mud () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of MUD Games until loop.
            #MGE crawl          - Explore a cave, retrieve the Orb of Zot.
            #MGE tintin++       - Telnet client to play MUDs (Multi-User Dungeons).
            #
            MENU_TITLE="MUD Game Menu"
            DELIMITER="#MGE" #MGE This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of MUD Games case statement.
                 1 |[Cc] |[Cc][Rr] |[Cc][Rr][Aa] |[Cc][Rr][Aa][Ww] |[Cc][Rr][Aa][Ww][Ll])
                 APP_NAME="crawl"
                 f_application_run
                 ;;
                 2 | [Tt] | [Tt][Ii] | [Tt][Ii][Nn] | [Tt][Ii][Nn][Tt] | [Tt][Ii][Nn][Tt][Ii] | [Tt][Ii][Nn][Tt][Ii][Nn] | [Tt][Ii][Nn][Tt][Ii][Nn][+] | [Tt][Ii][Nn][Tt][Ii][Nn][+][+])
                 APP_NAME="tintin++"
                 f_application_run
                 ;;
            esac # End of MUD Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of MUD Games until loop.
} # End of f_menu_app_games_mud
#
#
# +----------------------------------------+
# |    Function f_menu_app_games_puzzle    |
# +----------------------------------------+
f_menu_app_games_puzzle () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Puzzle Games until loop.
            #MGF bastet         - Tetris-like game.
            #MGF bcd            - Reformat input as a punch card.
            #MGF dab            - 2-players try to complete the most boxes.
            #MGF netris         - Tetris-like game.
            #MGF petris         - Tetris-like game.
            #MGF ppt            - Reformat input as a paper tape.
            #
            MENU_TITLE="Puzzle Game Menu"
            DELIMITER="#MGF" #MGF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Puzzle Games case statement.
                 1 | [Bb] | [Bb][Aa] | [Bb][Aa][Ss] | [Bb][Aa][Ss][Tt] | [Bb][Aa][Ss][Tt][Ee] | [Bb][Aa][Ss][Tt][Ee][Tt])
                 APP_NAME="bastet"
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Cc] | [Bb][Cc][Dd])
                 APP_NAME="bcd"
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Aa] | [Dd][Aa][Bb])
                 APP_NAME="dab"
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Rr] | [Nn][Ee][Tt][Rr][Ii] | [Nn][Ee][Tt][Rr][Ii][Ss])
                 APP_NAME="netris"
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Ee] | [Pp][Ee][Tt] | [Pp][Ee][Tt][Rr] | [Pp][Ee][Tt][Rr][Ii] | [Pp][Ee][Tt][Rr][Ii][Ss])
                 APP_NAME="petris"
                 f_application_run
                 ;;
                 6 | [Pp] | [Pp][Pp] | [Pp][Pp][Tt])
                 APP_NAME="ppt"
                 f_application_run
                 ;;
            esac # End of Puzzle Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Puzzle Games until loop.
} # End of f_menu_app_games_puzzle
#
# +----------------------------------------+
# |      Function f_menu_app_games_quiz    |
# +----------------------------------------+
f_menu_app_games_quiz () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Quiz Games until loop.
            #MGG arithmetic     - Basic arithmetic quiz.
            #MGG geekcode       - Code tells others how geeky you are.
            #MGG morse          - Morse code training.
            #MGG quiz           - Quiz with choice of assorted topics.
            #
            MENU_TITLE="Quiz Game Menu"
            DELIMITER="#MGG" #MGG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Quiz Games case statement.
                 1 |[Aa] |[Aa][Rr] |[Aa][Rr][Ii] |[Aa][Rr][Ii][Tt] |[Aa][Rr][Ii][Tt][Hh] |[Aa][Rr][Ii][Tt][Hh][Mm] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt][Ii] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt][Ii][Cc])
                 APP_NAME="arithmetic"
                 f_how_to_quit_application "Ctrl-Z"
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Ee] | [Gg][Ee][Ee] | [Gg][Ee][Ee][Kk] | [Gg][Ee][Ee][Kk][Cc] | [Gg][Ee][Ee][Kk][Cc][Oo] | [Gg][Ee][Ee][Kk][Cc][Oo][Dd] | [Gg][Ee][Ee][Kk][Cc][Oo][Dd][Ee])
                 APP_NAME="geekcode"
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Rr] | [Mm][Oo][Rr][Ss] | [Mm][Oo][Rr][Ss][Ee])
                 APP_NAME="morse"
                 f_application_run
                 ;;
                 4 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Zz])
                 APP_NAME="quiz"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
            esac # End of Quiz Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Quiz Games until loop.
} # End of f_menu_app_games_quiz
#
# +----------------------------------------+
# |      Function f_menu_app_games_rpg    |
# +----------------------------------------+
f_menu_app_games_rpg () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of RPG Games until loop.
            #MGH adventure      - Explore Colossal Cave. 
            #MGH battlestar     - Tropical adventure game.
            #MGH hack           - Explore the Dungeons of Doom.
            #MGH nethack        - Retrieve the Amulet of Yendor in the  20th dungeon level.
            #MGH phantasia      - Fight monsters and other players.
            #MGH slashem        - Enter the Dungeons of Doom.
            #MGH wump           - Hunt the Wumpus, watch out for bats, pits.
            #
            MENU_TITLE="RPG Game Menu"
            DELIMITER="#MGH" #MGH This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of RPG Games case statement.
                 1 | [Aa] | [Aa][Dd] | [Aa][Dd][Vv] | [Aa][Dd][Vv][Ee] | [Aa][Dd][Vv][Ee][Nn] | [Aa][Dd][Vv][Ee][Nn][Tt] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu][Rr] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu][Rr][Ee])
                 APP_NAME="adventure"
                 f_how_to_quit_application "quit"
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Aa] | [Bb][Aa][Tt] | [Bb][Aa][Tt][Tt] | [Bb][Aa][Tt][Tt][Ll] | [Bb][Aa][Tt][Tt][Ll][Ee] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt][Aa] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt][Aa][Rr])
                 APP_NAME="battlestar"
                 f_application_run
                 ;;
                 3 | [hH] | [hH][Aa] | [hH][Aa][Cc] | [hH][Aa][Cc][Kk])
                 APP_NAME="hack"
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][hH] | [Nn][Ee][Tt][hH][Aa] | [Nn][Ee][Tt][hH][Aa][Cc] | [Nn][Ee][Tt][hH][Aa][Cc][Kk])
                 APP_NAME="nethack-console"
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Hh] | [Pp][Hh][Aa] | [Pp][Hh][Aa][Nn] | [Pp][Hh][Aa][Nn][Tt] | [Pp][Hh][Aa][Nn][Tt][Aa] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss][Ii] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss][Ii][Aa])
                 APP_NAME="phantasia"
                 f_application_run
                 ;;
                 6 | [Ss] | [Ss][Ll] | [Ss][Ll][Aa] | [Ss][Ll][Aa][Ss] | [Ss][Ll][Aa][Ss][Hh] | [Ss][Ll][Aa][Ss][Hh][Ee] | [Ss][Ll][Aa][Ss][Hh][Ee][Mm])
                 APP_NAME="slashem"
                 f_application_run
                 ;;
                 7 | [Ww] | [Ww][Uu] | [Ww][Uu][Mm] | [Ww][Uu][Mm][Pp])
                 APP_NAME="wump"
                 f_application_run
                 ;;
            esac # End of RPG Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of RPG Games until loop.
} # End of f_menu_app_games_rpg
#
# +----------------------------------------+
# |  Function f_menu_app_games_simulation  |
# +----------------------------------------+
f_menu_app_games_simulation () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Simulation Games until loop.
            #MGI atc            - Air traffic controller.
            #MGI sail           - Command a Man O'War fighting ship.
            #MGI trek           - Star Trek blast Klingons.
            #
            MENU_TITLE="Simulation Games Menu"
            DELIMITER="#MGI" #MGI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Simulation Games case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Cc])
                 APP_NAME="atc"
                 f_application_run
                 ;;
                 2 |[Ss] |[Ss][Aa] |[Ss][Aa][Ii] |[Ss][Aa][Ii][Ll])
                 APP_NAME="sail"
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Rr] | [Tt][Rr][Ee] | [Tt][Rr][Ee][Kk])
                 APP_NAME="trek"
                 f_how_to_quit_application "at the prompt Command: terminate"
                 f_application_run
                 ;;
            esac # End of Simulation Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Simulation Games until loop.
} # End of f_menu_app_games_simulation
#
# +----------------------------------------+
# |   Function f_menu_app_games_strategy   |
# +----------------------------------------+
f_menu_app_games_strategy () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Strategy Games until loop.
            #MGJ gomoku         - 2-player game of 5-in-a-row.
            #MGJ hunt           - Multi-user game. Kill everyone else.
            #MGJ mille          - Travel 700 miles card game.
            #MGJ wargames       - Computer prompt from movie "War Games". 
            #
            MENU_TITLE="Strategy Game Menu"
            DELIMITER="#MGJ" #MGJ This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Strategy Games case statement.
                 1 | [Gg] | [Gg][Oo] | [Gg][Oo][Mm] | [Gg][Oo][Mm][Oo] | [Gg][Oo][Mm][Oo][Kk] | [Gg][Oo][Mm][Oo][Kk][Uu])
                 APP_NAME="gomoku"
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Uu] | [Hh][Uu][Nn] | [Hh][Uu][Nn][Tt])
                 APP_NAME="hunt"
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Ii] | [Mm][Ii][Ll] | [Mm][Ii][Ll][Ll] | [Mm][Ii][Ll][Ll][Ee])
                 APP_NAME="mille"
                 f_application_run
                 ;;
                 4 | [Ww] | [Ww][Aa] | [Ww][Aa][Rr] | [Ww][Aa][Rr][Gg] | [Ww][Aa][Rr][Gg][Aa] | [Ww][Aa][Rr][Gg][Aa][Mm] | [Ww][Aa][Rr][Gg][Aa][Mm][Ee] | [Ww][Aa][Rr][Gg][Aa][Mm][Ee][Ss])
                 APP_NAME="wargames"
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
                 f_press_enter_key_to_continue
                 f_application_run
                 # For some unknown reason, wargames does not like f_menu_app_press_enter_key so had to add function below. 
                 f_press_enter_key_to_continue
                 ;;
            esac # End of Strategy Games case statement
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Strategy Games until loop.
} # End of f_menu_app_games_strategy
#
# +----------------------------------------+
# |     Function f_menu_app_games_word     |
# +----------------------------------------+
f_menu_app_games_word () {
      f_initvars_menu_app
      until [ $CHOICE_APP -ge 0 -a $CHOICE_APP -le $MAX ]
      do    # Start of Word Games until loop.
            #MGK boggle         - Word search game.
            #MGK hangman        - Classic hangman word game.
            #MGK pig            - Converts text into pig-latin.
            #
            MENU_TITLE="Word Game Menu"
            DELIMITER="#MGK" #MGK This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Clear application name.
            #
            case $CHOICE_APP in # Start of Word Games case statement.
                 1 | [Bb] | [Bb][Oo] | [Bb][Oo][Gg] | [Bb][Oo][Gg][Gg] | [Bb][Oo][Gg][Gg][Ll] | [Bb][Oo][Gg][Gg][Ll][Ee])
                 APP_NAME="boggle"
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Aa] | [Hh][Aa][Nn] | [Hh][Aa][Nn][Gg] | [Hh][Aa][Nn][Gg][Mm] | [Hh][Aa][Nn][Gg][Mm][Aa] | [Hh][Aa][Nn][Gg][Mm][Aa][Nn])
                 APP_NAME="hangman"
                 f_application_run
                 ;;
                 3 | [Pp] | [Pp][Ii] | [Pp][Ii][Gg])
                 APP_NAME="pig"
                 f_application_run
                 ;;
            esac # End of Word Games case statement.
            f_menu_app_press_enter_key # If application displays information to stdout, allow user to read it.
      done # End of Word Games until loop.
} # End of f_menu_app_games_word
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
# **************************************
# ***Initialize script-wide variables***
# **************************************
f_initvars_menu_app
TCOLOR="black"
ERROR=0 # Initialize to 0 to indicate success at running last command.
APP_NAME="" # Initialize to null. Contains application name.
#
# **************************************
# ***           Main Menu            ***
# **************************************
#
until [ $CHOICE_MAIN -ge 0 -a $CHOICE_MAIN -le $MAX ]
do    # Start of CLI Menu util loop.
      #AAA Applications   - Launch a command-line application.
      #AAA Help           - How to get help on an application.
      #AAA Disk status    - Free disk space and mount-points.
      #AAA Documentation  - Script documentation, programmer notes, licensing.
      #AAA Black          - '(Screen white on black)'.
      #AAA White          - '(Screen black on white) Will not work in X-windows'.
      #AAA About CLI Menu - What version am I using.
      #AAA Edit History   - All the craziness behind the scenes.
      #AAA License        - Licensing, GPL.
      #
      MENU_TITLE="Main Menu"
      DELIMITER="#AAA" #AAA This 3rd field prevents awk from printing this line into menu options. 
      f_show_menu $MENU_TITLE $DELIMITER 
      read CHOICE_MAIN
      case $CHOICE_MAIN in 
           # Quit?
           0) 
           CHOICE_MAIN=0
           ;;
           [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           CHOICE_MAIN=0
           ;;
           [Ee] | [Ee][Xx] |[Ee][Xx][Ii] | [Ee][Xx][Ii][Tt])
           CHOICE_MAIN=0
           ;;
      esac
      #
      #
      case $CHOICE_MAIN in # Start of CLI Menu case statement.
           1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][Ll] | [Aa][Pp][Pp][Ll][Ii] | [Aa][Pp][Pp][Ll][Ii][Cc] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn][Ss])
           f_menu_cat_applications
           ;;
           2 | [Hh] | [Hh][Ee] | [Hh][Ee][Ll] | [Hh][Ee][Ll][Pp])
           clear
           echo "To quit help, type '"q"'."
           f_press_enter_key_to_continue
           sed -n 's/^#@//'p $THIS_FILE |more
           f_press_enter_key_to_continue
           # display Help Applications (all lines beginning with #@ but substitute "" for "#@" so "#@" is not printed).
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
           3 | [Dd] | [Dd][Ii] | [Dd][Ii][Ss] | [Dd][Ii][Ss][Kk] | [Dd][Ii][Ss][Kk]' ' | [Dd][Ii][Ss][Kk]' '[Ss] | [Dd][Ii][Ss][Kk]' '[Ss][Tt] | [Dd][Ii][Ss][Kk]' '[Ss][Tt][Aa] | [Dd][Ii][Ss][Kk]' '[Ss][Tt][Aa][Tt] | [Dd][Ii][Ss][Kk]' '[Ss][Tt][Aa][Tt][Uu] | [Dd][Ii][Ss][Kk]' '[Ss][Tt][Aa][Tt][Uu][Ss])
           clear
           df -hT
           f_press_enter_key_to_continue
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
           4 | [Dd] | [Dd][Oo] | [Dd][Oo][Cc] | [Dd][Oo][Cc][Uu] | [Dd][Oo][Cc][Uu][Mm] | [Dd][Oo][Cc][Uu][Mm][Ee] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii][Oo] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii][Oo][Nn])
           clear
           echo "To quit documentation, type '"q"'."
           f_press_enter_key_to_continue
           sed -n 's/^#://'p $THIS_FILE |more 
           f_press_enter_key_to_continue
           # display Documentation (all lines beginning with #: but substitute "" for "#:" so "#:" is not printed).
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
           5 | [Bb] | [Bb][Ll] | [Bb][Ll][Aa] | [Bb][Ll][Aa][Cc] | [Bb][Ll][Aa][Cc][Kk])
           TCOLOR="black"
           f_term_color # Set terminal color.
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
           6 | [Ww] | [Ww][Hh] | [Ww][Hh][Ii] | [Ww][Hh][Ii][Tt] | [Ww][Hh][Ii][Tt][Ee])
           TCOLOR="white"
           f_term_color # Set terminal color.
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;  
           7 | [Aa][Bb] | [Aa][Bb][Oo] | [Aa][Bb][Oo][Uu] | [Aa][Bb][Oo][Uu][Tt] | [Aa][Bb][Oo][Uu][Tt]' ' | [Aa][Bb][Oo][Uu][Tt]' '[Cc] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' ' | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee][Nn] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee][Nn][Uu])
           clear
           echo "CLI Menu version: $REVISION"
           echo "       Edited on: $REVDATE"
           echo "Bash script name: $THIS_FILE"
           f_press_enter_key_to_continue
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
           8 | [Ee] | [Ee][Dd] | [Ee][Dd][Ii] | [Ee][Dd][Ii][Tt] | [Ee][Dd][Ii][Tt]' '[Hh] | [Ee][Dd][Ii][Tt]' '[Hh][Ii] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr][Yy])
           clear
           echo "To quit reading Edit History, type '"q"'."
           f_press_enter_key_to_continue
           sed -n 's/^##//'p $THIS_FILE |more
           f_press_enter_key_to_continue
           # display Edit History (all lines beginning with ## but substitute "" for "##" so "##" is not printed).
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;; # End of Application Category case clause.
           9 | [Ll] | [Ll][Ii] | [Ll][Ii][Cc] | [Ll][Ii][Cc][Ee] | [Ll][Ii][Cc][Ee][Nn] | [Ll][Ii][Cc][Ee][Nn][Cc] | [Ll][Ii][Cc][Ee][Nn][Cc][Ee])
           clear
           echo "To quit reading License, type '"q"'."
           f_press_enter_key_to_continue
           sed -n 's/^#LIC//'p $THIS_FILE |more
           f_press_enter_key_to_continue
           # display License (all lines beginning with #LIC but substitute "" for "#LIC" so "#LIC" is not printed).
           CHOICE_MAIN=-1 # Initialize to -1 to force until loop without exiting.
           ;;
      esac # End of CLI Menu case statement.
done # End of CLI Menu until loop.
# all dun dun noodles.

