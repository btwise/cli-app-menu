#!/bin/bash 
#
# ©2013 Copyright 2013 Robert D. Chin
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
# Script cli-app-menu.sh is a menu of CLI applications and commands
# to help CLI newbies to discover what a command line can do.
#
THIS_FILE="cli-app-menu.sh"
#
# File naming convention for archiving:
# $THIS_FILE_<YYYY-MM-DD_HHMM>.sh
#
# +----------------------------------------+
# | FILE LOCATIONS of cli-app-menu project |
# +----------------------------------------+
#
# Edit history is now documented in a separate file/script 'EDIT_HISTORY'.
# The files EDIT_HISTORY, COPYING, README must be in the same folder/directory
# as this file/script so the Main Menu options to view/edit 'Edit History' or
# to view 'License' can work.
#
# +----------------------------------------+
# |        HOW-TO Update this script       |
# +----------------------------------------+
#
# After each edit made, update the version (date stamp string) of this script
# in both the EDIT_HISTORY file and this file.
# Also update the edit history in the EDIT_HISTORY file.
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
REVDATE="June-3-2013 00:59"
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
#: *Optimized for 80x24 display or 640x480 pixel displays.
#:  Run-time displayed text is no wider than 80-columns across.
#:  Run-time menus are no longer than 17 items for 24 row displays.
#:  Although the game, "Pacman for Console" needs 32 rows minimum to play.
#:
#: *Limited to 4 menu levels below the Main Menu to run any application.
#:
#: *You can get application help by 'man' or '--help' from the menu prompt.
#:
#: *If an application is not installed, script will automatically install it.
#:
#: *Designed for ease of extensibility and menu editing.
#:
#: *If an application needs sudo, script will automatically give a sudo option.
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
#: The template to add a new category menu is:     f_menu_cat_sample_template
#: The template to add a new sub-category menu is: f_menu_scat_sample_template
#: The template to add a new application menu is:  f_menu_app_sample_template
#:
#: In brief:
#
#: 1. The menu code is contained in functions before the main program code.
#:    The main program code, "Main Menu" is at the bottom of this listing.
#:
#: 2. If you are adding a new application within an application menu, 
#:    a) decide what row in the menu that you want to place the new menu item.
#:    b) Add the item string: <Special Menu Option Marker beginning with #> 
#:       <name of item> <space><dash><space> <description>
#:    c) Each Special Menu Option Marker MUST be unique for each menu.
#:
#:    Note: Please see bottom of this document
#:          for a list of Special Menu Option Markers.
#:
#:    d) Create a new case statement for the new item.
#:    e) Adjust the case statement patterns of menu items below the new item.
#:       If you added the item in the middle of the menu, all case patterns for
#:       the items below it need to be adjusted.
#:
#:    i.e. The number in the case pattern would need to be incremented by 1 
#:         for the items below the new item.
#:
#:    The case patterns will accept both the menu option number, or all or part
#:    of the menu item name in upper or lower case or any mixture of case.
#:
#: 3. If you are adding a new category or sub-category menu, please use the
#:    templates for this very purpose.
#:    f_menu_cat_sample_template or f_menu_scat_sample_template.
#:
#: 4. If you are adding a new application menu, please use the template for
#:    this very purpose, f_menu_app_sample_template.
#:
#:
#: +----------------------------------------+
#: |   Trouble-shooting a new menu item     |
#: +----------------------------------------+
#:
#: 1. Some or all of the menu items are missing.
#:
#:    If you copied from a template or another menu, check the Special Menu
#:    Option Markers for consistency.
#:    In the example below, #MXX is before each menu item and in DELIMITER. #MXX This 3rd field prevents awk from printing this line into "List Applications".
#:
#:            #MXX appname  - Description Application1 name.
#:            #MXX app2name - Description Application2 name.
#:            #
#:            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
#:            MENU_TITLE="<Sample Template> Applications Menu"
#:            DELIMITER="#MXX" #MXX This 3rd field prevents awk from printing this line into menu options.
#:
#: 2. Menu items only display when the number is selected, not letters.
#:
#:    Check the case patterns of the letters.
#:    Wrong! 1 | [Aa][Pp][Pp][Nn][Aa][Mm][Ee])
#:    Right! 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][Nn] | [Aa][Pp][Pp][Nn][Aa] | [Aa][Pp][Pp][Nn][Aa][Mm] | [Aa][Pp][Pp][Nn][Aa][Mm][Ee])
#:
#: 3. Menu items only display when the letters are selected, not the number.
#:    Or Wrong application is run when I select the number.
#:
#:    Check to see that you do not have duplicate numbers or out of sequence
#:    numbers in the case patterns.
#:
#:
#: +----------------------------------------+
#: |  List of variables used in this script |
#: +----------------------------------------+
#:
#: ANS         - String; Answer to question.
#: APP_NAME    - String; application name also command to run.
#:
#: APP_NAME_INSTALL - String; used when APP_NAME does not match actual package
#:               name to be installed. i.e. APP_NAME="trek" but package name is
#:               actually "bsdgames". So to install "trek" game, you must
#:               instead install package "bsdgames", a collection of games.
#:
#: APP_RUN     - String; Command to run when application is a web browser,
#:               actually also includes name of web site to browse.
#:
#: CHOICE_APP  - String; User choice in Applications Menu (alpha-numeric).
#:               First few letters of user choice from menu.
#:               ' 0' means quit menu.
#:               '-1' stay in menu loop, display "Press enter key to continue."
#:
#: CHOICE_CAT  - String; User choice in Applications Category Menu (alpha-
#:                    numeric).
#:               ' 0' means quit menu.
#:               '-1' stay in menu loop, legitimate choice.
#:
#: CHOICE_MAIN - String; User choice in Main Menu (alpha-numeric).
#:               ' 0' means quit menu.
#:               '-1' stay in menu loop, legitimate choice.
#:
#: CHOICE_SCAT - String; User choice in Sub-Category Menu (alpha-numeric).
#:               ' 0' means quit menu.
#:               '-1' stay in menu loop, legitimate choice.
#:
#: CHOICE_TCAT - String; User choice in 3rd-level Category Menu (alpha-numeric).
#:               ' 0' means quit menu.
#:               '-1' stay in menu loop, legitimate choice.
#:
#: DELIMITER   - String; Delimiter prefix of menu option string.
#: ERROR       - Number; Save error code number from $? function.
#: MAX         - Number; Maximum option choice number in menu.
#: MENU_TITLE  - String; Title of menu.
#:
#: PRESSKEY    - Number: Ask "Press Enter key to continue".
#:               '0' Do not ask "Press Enter key to continue".
#:               '1' Ask "Press Enter key to continue".
#:
#: REVDATE     - String; Revision date of shell script.
#: REVISION    - String; Revision number of shell script.
#: TCOLOR      - String; Background color of display terminal; Black or White.
#: THIS_FILE   - String; name of shell script.
#: WEB_SITE    - String; name of web site used when application is a web browser.
#: XNUM        - Number; Scratch variable used in awk statement in f_show_menu.
#: XSTR        - String; Scratch variable.
#:
#:
#: +----------------------------------------+
#: |   List of Special Menu Option Markers  |
#: +----------------------------------------+
#:
#:AAA - Main Menu
#:AAB - Application Categories Menu
#:
#:BAU - Audio Categories Menu
#:BFM - File Management Categories Menu
#:BGA - Game Categories Menu
#:BIG - Image Categories Menu
#:BIN - Internet Categories Menu
#:BNE - Network Categories Menu
#:BOF - Office Categories Menu
#:BSY - System Categories Menu
#:BTX - Text Categories Menu
#:BVI - Video Categories Menu
#:BXC - Sample Template Categories Menu
#:
#:MAA - Accounting Applications Menu
#:MAC - Audio CD Ripper Applications Menu
#:MAP - Audio Player Applications Menu
#:MAR - Audio Radio Applications Menu
#:MAS - Audio Speech Synthesis Applications Menu
#:MAU - Audio Editor Applications Menu
#:MBT - Bittorrent Applications Menu
#:MCA - Calendar-ToDo Applications Menu
#:MCC - Calculator Applications Menu
#:MDL - Dowloader Applications Menu
#:MED - Education Applications Menu
#:MEM - E-mail Applications Menu
#:MFD - File Deletion Applications Menu
#:MFE - File Encryption Applications Menu
#:MFF - File Search and find Applications Menu
#:MFI - File Manager Applications Menu
#:MFR - File Recovery/Deletion Applications Menu
#:MFS - File Splitter Applications Menu
#:MFT - File Transfer Applications Menu
#:MFV - File Viewer Applications Menu
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
#:MIG - Image-Graphics Applications Menu
#:MIK - ImageMagick Applications Menu
#:MIM - Instant Messaging Applications Menu
#:MIR - Internet Relay Chat (IRC) Applications Menu
#:MNC - LAN Chat Applications Menu
#:MNF - Firewalls Applications Menu
#:MNL - LAN/WAN Applications Menu
#:MNM - Network Monitor Applications Menu
#:MNN - NIC Diagnostic Tools Applications Menu
#:MNO - Note Applications Menu
#:MNP - Network Packet Applications Menu
#:MNR - News Reader Applications Menu
#:MNS - Network Sharing Applications Menu
#:MPO - Podcatcher Applications Menu
#:MPR - Presentation Applications Menu
#:MPS - PDF-PS Applications Menu
#:MRC - Remote Connection Applications Menu
#:MRS - RSS News Feeder Applications Menu
# MSB - System Backup Applications Menu
#:MSC - System Screen Applications Menu
#:MSD - System Disk Information Applications Menu
#:MSF - System Software Package Applications Menu
#:MSH - System Health Applications Menu
#:MSI - System Mainboard Information Applications Menu
#:MSL - System Peripherals Information Applications Menu
#:MSM - System Monitor Applications Menu
#:MSP - Spreadsheet Applications Menu
#:MSR - System Process Applications Menu
#:MSS - Screen-saver Applications Menu
#:MLO - System Log Applications Menu
#:MSO - System Other Applications Menu
#:MTC - Text Compare Applications Menu
#:MTD - To-Do Applications Menu
#:MTE - Text Editor Applications Menu
#:MTT - Text Tool Applications Menu
#:MTV - Text Converter Applications Menu
#:MVE - Video Editor Applications Menu
#:MVI - Video Player/Downloader Applications Menu
#:MWB - Web Browser Applications Menu
#:MXX - Sample Template Applications Menu
#
#
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
      MAX=$(grep $DELIMITER -c $THIS_FILE) .

      # Count number of lines containing special comment marker string to get
      # maximum item number.
      awk -F $DELIMITER '{if ($2&&!$3){print 1+XNUM++" -"$2;}}' $THIS_FILE
      case $DELIMITER in
           # Application Menu?
           "#AAA") #AAA This 3rd field prevents awk from printing this line into menu options.
              MAX=$((MAX=$MAX-3)) 
              # Subtract 3 total since 3 lines of code not part of menu display,
              # contain the special comment marker.
              echo
              echo "'0', Q/quit, or E/exit to quit this script, $THIS_FILE."
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
# |       Function f_quit_subcat_menu      |
# +----------------------------------------+
#
#  Inputs: CHOICE_SCAT.
# Outputs: CHOICE_SCAT.
#
f_quit_subcat_menu () {
      case $CHOICE_SCAT in
           # Quit?
           0)
           CHOICE_SCAT=0
           PRESS_KEY=0
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn])
           CHOICE_SCAT=0
           PRESS_KEY=0
           ;;
      esac
} # End of function f_quit_subcat_menu
#
# +----------------------------------------+
# |       Function f_quit_tcat_menu        |
# +----------------------------------------+
#
#  Inputs: CHOICE_TCAT.
# Outputs: CHOICE_TCAT.
#
f_quit_tcat_menu () {
      case $CHOICE_TCAT in
           # Quit?
           0)
           CHOICE_TCAT=0
           PRESS_KEY=0
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn])
           CHOICE_TCAT=0
           PRESS_KEY=0
           ;;
      esac
} # End of function f_quit_tcat_menu#
#
# +----------------------------------------+
# |        Function f_quit_app_menu        |
# +----------------------------------------+
#
#  Inputs: CHOICE_APP.
# Outputs: CHOICE_APP.
f_quit_app_menu () {
      case $CHOICE_APP in
           # Quit?
           0)
           CHOICE_APP=0
           PRESS_KEY=0
           ;;
           [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn])
           CHOICE_APP=0
           PRESS_KEY=0
           ;;
           # Commented out because there is a game with the title "Quiz" and
           # entering "qui" would quit the menu.
           # [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           #   CHOICE_APP=0
           # ;;
      esac
} # End of function f_quit_app_menu
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
# |    Function f_subcat_bad_menu_choice   |
# +----------------------------------------+
#
#  Inputs: CHOICE_SCAT.
# Outputs: CHOICE_SCAT, PRESS_KEY.
#
f_subcat_bad_menu_choice () {
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
} # End of function f_subcat_bad_menu_choice
#
# +----------------------------------------+
# |    Function f_tcat_bad_menu_choice     |
# +----------------------------------------+
#
#  Inputs: CHOICE_TCAT.
# Outputs: CHOICE_TCAT, PRESS_KEY.
#
f_subcat_bad_menu_choice () {
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
                     adventure | arithmetic | atc | backgammon | battlestar | bcd | boggle | caesar | canfield | countmail | cribbage | dab | go-fish | gomoku | hack | hangman | hunt | mille | monop | morse | number | pig | phantasia | pom | ppt | primes | quiz | random | rain | robots | rot13 | sail | snake | tetris | trek | wargames | worm | worms | wump | wtf)
                     APP_NAME_INSTALL="bsdgames"
                     ;;
                     animate | composite | compare | conjure | convert | display | identify | import | mogrify | montage | stream)
                     APP_NAME_INSTALL="imagemagick"
                     ;;
                     aria2c)
                     APP_NAME_INSTALL="aria2"
                     ;;
                     barnowl | zcrypt)
                     APP_NAME_INSTALL="barnowl"
                     ;;
                     clamscan)
                     APP_NAME_INSTALL="clamav"
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
                     lynx)
                     APP_NAME_INSTALL="lynx-cur"
                     ;;
                     moc)
                     APP_NAME_INSTALL="libqt4-dev"
                     ;;
                     mpstat | iostat | pidstat | sadf | sar)
                     APP_NAME_INSTALL="sysstat"
                     ;;
                     nagios3)
                     APP_NAME_INSTALL="nagios3-core"
                     ;;
                     photorec)
                     APP_NAME_INSTALL="testdisk"
                     ;;
                     todo)
                     APP_NAME_INSTALL="devtodo"
                     ;;
                     aaxine | cacaxine | fbxine)
                     APP_NAME_INSTALL="xine-console"
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
                   # sudo pacman -S <application package name>"
                   # ERROR=$? # Save error flag condition.
                   # if [ $ERROR -ne 0 ] ; then
                        # Error code 1 $?=1 means installation failed.
                        # Error code 0 (zero) where $?=0 means no error.
                        # echo
                        # echo "Installation of $APP_NAME_INSTALL failed."
                        # echo "Command sudo pacman -S $APP_NAME_INSTALL failed."
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
#
# +----------------------------------------+
# |  Function f_menu_scat_sample_template  |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_scat_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of <Sample Template> Application Category case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][1])
                 f_menu_cat_name1             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][2]) 
                 f_menu_cat_name2             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of <Sample Template> Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of <Sample Template> Application Category until loop.
} # End of function f_menu_scat_sample_template
#
# +----------------------------------------+
# |  Function f_menu_tcat_sample_template  |
# +----------------------------------------+
#
#  Inputs: None
#    Uses: CHOICE_TCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_TCAT
#
f_menu_tcat_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_TCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_tcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_TCAT in # Start of <Sample Template> Application Category case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][1])
                 f_menu_cat_name1             # Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp]' ' | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa] | [Aa][Pp][Pp]' '[Cc][Aa][Tt] | [Aa][Pp][Pp]' '[Cc][Aa][Tt][2]) 
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sample_template () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of <Sample Template> Applications case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][Nn] | [Aa][Pp][Pp][Nn][Aa] | [Aa][Pp][Pp][Nn][Aa][Mm] | [Aa][Pp][Pp][Nn][Aa][Mm][Ee])
                 APP_NAME="appname"
                 f_application_run
                 ;;
                 [Aa][Pp][Pp][Nn][Aa][Mm][Ee]' '* | 'sudo appname '* | 'sudo appname')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][2] | [Aa][Pp][Pp][2] | [Aa][Pp][Pp][2][Nn] | [Aa][Pp][Pp][2][Nn][Aa] | [Aa][Pp][Pp][2][Nn][Aa][Mm] | [Aa][Pp][Pp][2][Nn][Aa][Mm][Ee])
                 APP_NAME="app2name"
                 f_application_run
                 ;;
                 [Aa][Pp][Pp][2][Nn][Aa][Mm][Ee]' '*)
                 APP_NAME=$CHOICE_APP
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
                 [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Uu] | [Rr][Ee][Tt][Uu][Rr] | [Rr][Ee][Tt][Uu][Rr][Nn]*)
                 CHOICE_CAT=0
                 ;;
            esac
            #
            case $CHOICE_CAT in # Start of Application Category case statement.
                 1 | [Aa] | [Aa][Uu] | [Aa][Uu][Dd] | [Aa][Uu][Dd][Ii] | [Aa][Uu][Dd][Ii][Oo])
                 f_menu_cat_audio             # Audio Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Ee] | [Ee][Dd] | [Ee][Dd][Uu] | [Ee][Dd][Uu][Cc] | [Ee][Dd][Uu][Cc][Aa] | [Ee][Dd][Uu][Cc][Aa][Tt] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii][Oo] | [Ee][Dd][Uu][Cc][Aa][Tt][Ii][Oo][Nn])
                 f_menu_app_education         # Education Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Ff] | [Ff][Ii] | [Ff][Ii][Ll] | [Ff][Ii][Ll][Ee] | [Ff][Ii][Ll][Ee][/] | [Ff][Ii][Ll][Ee][/][Dd] | [Ff][Ii][Ll][Ee][/][Dd][Ii] | [Ff][Ii][Ll][Ee][/][Dd][Ii][Rr])
                 f_menu_cat_file_management   # File Management Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Gg] | [Gg][Aa] | [Gg][Aa][Mm] | [Gg][Aa][Mm][Ee] | [Gg][Aa][Mm][Ee][Ss])
                 f_menu_cat_games             # Games Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Ii] | [Ii][Mm] | [Ii][Mm][Aa] | [Ii][Mm][Aa][Gg] | [Ii][Mm][Aa][Gg][Ee] | [Ii][Mm][Aa][Gg][Ee][Ss] | [Ii][Mm][Aa][Gg][Ee][Ss])
                 f_menu_cat_image             # Image-Graphics Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Ii] | [Ii][Nn] | [Ii][Nn][Tt] | [Ii][Nn][Tt][Ee] | [Ii][Nn][Tt][Ee][Rr] | [Ii][Nn][Tt][Ee][Rr][Nn] | [Ii][Nn][Tt][Ee][Rr][Nn][Ee] | [Ii][Nn][Tt][Ee][Rr][Nn][Ee][Tt])
                 f_menu_cat_internet          # Internet Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ww] | [Nn][Ee][Tt][Ww][Oo] | [Nn][Ee][Tt][Ww][Oo][Rr] | [Nn][Ee][Tt][Ww][Oo][Rr][Kk])
                 f_menu_cat_network           # Network Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Oo] | [Oo][Ff] | [Oo][Ff][Ff] | [Oo][Ff][Ff][Ii] | [Oo][Ff][Ff][Ii][Cc] | [Oo][Ff][Ff][Ii][Cc][Ee])
                 f_menu_cat_office            # Office Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn] | [Ss][Cc][Rr][Ee][Ee][Nn][-] | [Ss][Cc][Rr][Ee][Ee][Nn][-][Ss] | [Ss][Cc][Rr][Ee][Ee][Nn][-][Ss][Aa] | [Ss][Cc][Rr][Ee][Ee][Nn][-][Ss][Aa][Vv] | [Ss][Cc][Rr][Ee][Ee][Nn][-][Ss][Aa][Vv][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn][-][Ss][Aa][Vv][Ee][Rr])
                 f_menu_app_screen_savers     # Screen-saver Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 10 | [Ss] | [Ss][Yy] | [Ss][Yy][Ss] | [Ss][Yy][Ss][Tt] | [Ss][Yy][Ss][Tt][Ee] | [Ss][Yy][Ss][Tt][Ee][Mm])
                 f_menu_cat_system            # System Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
                 11 | [Vv] | [Vv][Ii] | [Vv][Ii][Dd] | [Vv][Ii][Dd][Ee] | [Vv][Ii][Dd][Ee][Oo])
                 f_menu_cat_video             # Video Applications Menu.
                 CHOICE_CAT=-1                # Legitimate response. Stay in menu loop.
                 ;;
            esac # End of Application Category case statement.
            #
      done # End of Application Category until loop.
} # End of function f_menu_cat_applications
#
# +----------------------------------------+
# |        Function f_menu_cat_audio       |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_audio () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of Audio Application Category case statement.
                 1 | [Cc] | [Cc][Dd] | [Cc][Dd]' ' | [CC][Dd]' '[Rr] | [CC][Dd]' '[Rr][Ii] | [CC][Dd]' '[Rr][Ii][Pp] | [CC][Dd]' '[Rr][Ii][Pp][Pp] | [CC][Dd]' '[Rr][Ii][Pp][Pp][Ee] | [CC][Dd]' '[Rr][Ii][Pp][Pp][Ee][Rr] | [CC][Dd]' '[Rr][Ii][Pp][Pp][Ee][Rr][Ss])
                 f_menu_app_cdrippers         # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Ee] | [Ee][Dd] | [Ee][Dd][Ii] | [Ee][Dd][Ii][Tt] | [Ee][Dd][Ii][Tt][Oo] | [Ee][Dd][Ii][Tt][Oo][Rr] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/' | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee][Rr] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee][Rr][Tt] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee][Rr] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]'/'[Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee][Rr][Ss])
                 f_menu_app_audio_editors     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Mm] | [Mm][Uu] | [Mm][Uu][Ss] | [Mm][Uu][Ss][Ii] | [Mm][Uu][Ss][Ii][Cc] | [Mm][Uu][Ss][Ii][Cc]' ' | [Mm][Uu][Ss][Ii][Cc]' '[Pp] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll][Aa] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll][Aa][Yy] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll][Aa][Yy][Ee] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll][Aa][Yy][Ee][Rr] | [Mm][Uu][Ss][Ii][Cc]' '[Pp][Ll][Aa][Yy][Ee][Rr][Ss])
                 f_menu_app_music_players     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Rr] | [Rr][Aa] | [Rr][Aa][Dd] | [Rr][Aa][Dd][Ii] | [Rr][Aa][Dd][Ii][Oo])
                 f_menu_app_radio             # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Ss] | [Ss][Pp] | [Ss][Pp][Ee] | [Ss][Pp][Ee][Ee] | [Ss][Pp][Ee][Ee][Cc] | [Ss][Pp][Ee][Ee][Cc][Hh] | [Ss][Pp][Ee][Ee][Cc][Hh]' ' | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt][Hh] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt][Hh][Ee] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt][Hh][Ee][Ss] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt][Hh][Ee][Ss][Ii] | [Ss][Pp][Ee][Ee][Cc][Hh]' '[Ss][Yy][Nn][Tt][Hh][Ee][Ss][Ii][Ss])
                 f_menu_app_speech_synthesis  # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Audio Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Audio Application Category until loop.
} # End of function f_menu_cat_audio
#
# +----------------------------------------+
# |      Function f_menu_app_cdrippers     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_cdrippers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of CD Rippers Applications case statement.
                 1 | [Aa] | [Aa][Bb] | [AA][Bb][Cc] | [Aa][Bb][Cc][Dd] | [Aa][Bb][Cc][Dd][Ee])
                 APP_NAME="abcde"
                 f_application_run
                 ;;
                 abcde' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Aa] | [Aa][Cc] | [Aa][Cc][Rr] | [Aa][Cc][Rr][Ii] | [Aa][Cc][Rr][Ii][Pp] | [Aa][Cc][Rr][Ii][Pp][P] | [Aa][Cc][Rr][Ii][Pp][P][Ee] | [Aa][Cc][Rr][Ii][Pp][P][Ee][Rr])
                 APP_NAME="acripper"
                 f_application_run
                 ;;
                 acripper' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Dd] | [Cc][Dd][Pp] | [Cc][Dd][Pp][Aa] | [Cc][Dd][Pp][Aa][Rr] | [Cc][Dd][Pp][Aa][Rr][Aa] | [Cc][Dd][Pp][Aa][Rr][Aa][Nn] | [Cc][Dd][Pp][Aa][Rr][Aa][Nn][Oo] | [Cc][Dd][Pp][Aa][Rr][Aa][Nn][Oo][Ii] | [Cc][Dd][Pp][Aa][Rr][Aa][Nn][Oo][Ii][Aa])
                 APP_NAME="cdparanoia"
                 f_application_run
                 ;;
                 cdparanoia' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Cc] | [Cc][Rr] | [Cc][Rr][Ii] | [Cc][Rr][Ii][Pp])
                 APP_NAME="crip"
                 f_application_run
                 ;;
                 crip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Jj] | [Jj][Aa] | [Jj][Aa][Cc] | [Jj][Aa][Cc][Kk])
                 APP_NAME="jack"
                 f_application_run
                 ;;
                 jack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ll] | [Ll][Xx] | [Ll][Xx][Dd] | [Ll][Xx][Dd][Vv] | [Ll][Xx][Dd][Vv][Dd] | [Ll][Xx][Dd][Vv][Dd][Rr] | [Ll][Xx][Dd][Vv][Dd][Rr][Ii] | [Ll][Xx][Dd][Vv][Dd][Rr][Ii][Pp])
                 APP_NAME="lxdvdrip"
                 f_application_run
                 ;;
                 lxdvdrip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Rr] | [Rr][Ii] | [Rr][Ii][Pp] | [Rr][Ii][Pp][Ii] | [Rr][Ii][Pp][Ii][Tt])
                 APP_NAME="ripit"
                 f_application_run
                 ;;
                 ripit' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Rr] | [Rr][Uu] | [Rr][Uu][Bb] | [Rr][Uu][Bb][Yy] | [Rr][Uu][Bb][Yy][Rr] | [Rr][Uu][Bb][Yy][Rr][Ii] | [Rr][Uu][Bb][Yy][Rr][Ii][Pp] | [Rr][Uu][Bb][Yy][Rr][Ii][Pp][Pp] | [Rr][Uu][Bb][Yy][Rr][Ii][Pp][Pp][Ee] | [Rr][Uu][Bb][Yy][Rr][Ii][Pp][Pp][Ee][Rr])
                 APP_NAME="rubyripper"
                 f_application_run
                 ;;
                 rubyripper' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Audio Editor Applications case statement.
                 1 | [Aa] | [Aa][Vv] | [Aa][Vv][Cc] | [Aa][Vv][Cc][Oo] | [Aa][Vv][Cc][Oo][Nn] | [Aa][Vv][Cc][Oo][Nn][Vv])
                 APP_NAME="avconv"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 avconv' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ee] | [Ee][Cc] | [Ee][Cc][Aa] | [Ee][Cc][Aa][Ss] | [Ee][Cc][Aa][Ss][Oo] | [Ee][Cc][Aa][Ss][Oo][Uu] | [Ee][Cc][Aa][Ss][Oo][Uu][Nn] | [Ee][Cc][Aa][Ss][Oo][Uu][Nn][Dd])
                 APP_NAME="ecasound"
                 f_application_run
                 ;;
                 ecasound' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Ff] | [Ff][Ff][Mm] | [Ff][Ff][Mm][Ee] | [Ff][Ff][Mm][Ee][Gg])
                 APP_NAME="ffmpeg"
                 f_application_run
                 ;;
                 ffmpeg' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Oo] | [Ss][Oo][Xx])
                 APP_NAME="sox"
                 f_application_run
                 ;;
                 sox' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Audio Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Audio Editor Applications until loop.
} # End of f_menu_app_audio_editors
#
# +----------------------------------------+
# |    Function f_menu_app_music_players   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_music_players () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Music Player Applications until loop.
            #MAP cdcd     - CD player.
            #MAP cplay    - CD player.
            #MAP mcdp     - CD player ncurses-based.
            #MAP juke     - Music Jukebox.
            #MAP pytone   - Music Jukebox ncurses-based, cross-fading, search, mixer.
            #MAP cmus     - Music player.
            #MAP herrie   - Music player with playlist and file browser on split screen.
            #MAP moc      - Music player.
            #MAP mpg123   - Music player MPEG 1.0/2.0/2.5 stream (layers 1, 2 and 3).
            #MAP ncmpc    - Music player, ncurses-based.
            #MAP yauap    - Music player based on Gstreamer.
            #MAP mplayer  - Multimedia player.
            #MAP mplayer2 - Multimedia player.
            #MAP vlc      - Multimedia VideoLAN player MPEG, MOV, WMV, QT, WebM, MP3, etc.
            #MAP pianobar - Streaming radio player for Pandora Radio.
            #MAP shell-fm - Streaming radio player for last.fm radio.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Music Player Applications Menu"
            DELIMITER="#MAP" #MAP This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Music Player Applications case statement.
                 1 | [Cc] | [Cc][DD] | [Cc][Dd][Cc] | [CC][Dd][Cc][Dd])
                 APP_NAME="cdcd"
                 f_application_run
                 ;;
                 cdcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Pp] | [Cc][Pp][Ll] | [Cc][Pp][Ll][Aa] | [Cc][Pp][Ll][Aa][Yy])
                 APP_NAME="cplay"
                 f_application_run
                 ;;
                 cplay' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Cc] | [Mm][Cc][Dd] | [Mm][Cc][Dd][Pp])
                 APP_NAME="mcdp"
                 f_application_run
                 ;;
                 mcdp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Jj] | [Jj][Uu] | [Jj][Uu][Kk] | [Jj][Uu][Kk][Ee])
                 APP_NAME="juke"
                 f_application_run
                 ;;
                 juke' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Yy] | [Pp][Yy][Tt] | [Pp][Yy][Tt][Oo] | [Pp][Yy][Tt][Oo][Nn] | [Pp][Yy][Tt][Oo][Nn][Ee])
                 APP_NAME="pytone"
                 f_application_run
                 ;;
                 pytone' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Cc] | [Cc][Mm] | [Cc][Mm][Uu] | [Cc][Mm][Uu][Ss])
                 APP_NAME="cmus"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 cmus' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Hh] | [Hh][Ee] | [Hh][Ee][Rr] | [Hh][Ee][Rr][Rr] | [Hh][Ee][Rr][Rr][Ii] | [Hh][Ee][Rr][Rr][Ii][Ee])
                 APP_NAME="herrie"
                 f_application_run
                 ;;
                 herrie' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Oo] | [Mm][Oo][Cc])
                 APP_NAME="moc"
                 f_application_run
                 ;;
                 moc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Mm] | [Mm][Pp] | [Mm][Pp][Gg] | [Mm][Pp][Gg][1] | [Mm][Pp][Gg][1][2] | [Mm][Pp][Gg][1][2][3])
                 APP_NAME="mpg123"
                 f_application_run
                 ;;
                 mpg123' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Nn] | [Nn][Cc] | [Nn][Cc][Mm] | [Nn][Cc][Mm][Pp] | [Nn][Cc][Mm][Pp][Cc])
                 f_how_to_quit_application "q"
                 APP_NAME="ncmpc"
                 f_application_run
                 ;;
                 ncmpc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Yy] | [Yy][Aa] | [Yy][Aa][Uu] | [Yy][Aa][Uu][Aa] | [Yy][Aa][Uu][Aa][Pp])
                 APP_NAME="yauap"
                 f_application_run
                 ;;
                 yauap' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr])
                 APP_NAME="mplayer"
                 f_application_run
                 ;;
                 mplayer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr][2])
                 APP_NAME="mplayer2"
                 f_application_run
                 ;;
                 mplayer2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Vv] | [Vv][Ll] | [Vv][Ll]Cc])
                 APP_NAME="vlc"
                 f_application_run
                 ;;
                 vlc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 15 | [Pp] | [Pp][Ii] | [Pp][Ii][Aa] | [Pp][Ii][Aa][Nn] | [Pp][Ii][Aa][Nn][Oo] | [Pp][Ii][Aa][Nn][Oo][Bb] | [Pp][Ii][Aa][Nn][Oo][Bb][Aa] | [Pp][Ii][Aa][Nn][Oo][Bb][Aa][Rr])
                 APP_NAME="pianobar"
                 f_application_run
                 ;;
                 pianobar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 16 | [Ss] | [Ss][Hh] | [Ss][Hh][Ee] | [Ss][Hh][Ee][Ll] | [Ss][Hh][Ee][Ll][Ll] | [Ss][Hh][Ee][Ll][Ll][-] | [Ss][Hh][Ee][Ll][Ll][-][Ff] | [Ss][Hh][Ee][Ll][Ll][-][Ff][Mm])
                 APP_NAME="shell-fm"
                 f_application_run
                 ;;
                 shell-fm' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_radio () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Radio Applications case statement.
                 1 | [Dd] | [Dd][Rr] | [Dd][Rr][Aa] | [Dd][Rr][Aa][Dd] | [Dd][Rr][Aa][Dd][Ii] | [Dd][Rr][Aa][Dd][Ii][Oo])
                 APP_NAME="dradio"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 dradio' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Rr] | [Rr][Aa] | [Rr][Aa][Dd] | [Rr][Aa][Dd][Ii] | [Rr][Aa][Dd][Ii][Oo])
                 APP_NAME="radio"
                 f_application_run
                 ;;
                 radio' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Pp] | [Pp][Ii] | [Pp][Ii][Aa] | [Pp][Ii][Aa][Nn] | [Pp][Ii][Aa][Nn][Oo] | [Pp][Ii][Aa][Nn][Oo][Bb] | [Pp][Ii][Aa][Nn][Oo][Bb][Aa] | [Pp][Ii][Aa][Nn][Oo][Bb][Aa][Rr])
                 APP_NAME="pianobar"
                 f_application_run
                 ;;
                 pianobar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Hh] | [Ss][Hh][Ee] | [Ss][Hh][Ee][Ll] | [Ss][Hh][Ee][Ll][Ll] | [Ss][Hh][Ee][Ll][Ll][-] | [Ss][Hh][Ee][Ll][Ll][-][Ff] | [Ss][Hh][Ee][Ll][Ll][-][Ff][Mm])
                 APP_NAME="shell-fm"
                 f_application_run
                 ;;
                 shell-fm' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_speech_synthesis () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Speech Synthesis Applications case statement.
                 1 | [Ee] | [Ee][Bb] | [Ee][Bb][Oo] | [Ee][Bb][Oo][Oo] | [Ee][Bb][Oo][Oo][Kk] | [Ee][Bb][Oo][Oo][Kk][–] | [Ee][Bb][Oo][Oo][Kk][–][Ss] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk][Ee] | [Ee][Bb][Oo][Oo][Kk][–][Ss][Pp][Ee][Aa][Kk][Ee][Rr])
                 APP_NAME="ebook-speaker"
                 f_application_run
                 ;;
                 ebook-speaker' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ee] | [Ee][Dd] | [Ee][Dd][Bb] | [Ee][Dd][Bb][Rr] | [Ee][Dd][Bb][Rr][Oo] | [Ee][Dd][Bb][Rr][Oo][Ww] | [Ee][Dd][Bb][Rr][Oo][Ww][Ss] | [Ee][Dd][Bb][Rr][Oo][Ww][Ss][Ee])
                 APP_NAME="edbrowse"
                 f_application_run
                 ;;
                 edbrowse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Ee] | [Ff][Ee][Ss] | [Ff][Ee][Ss][Tt] | [Ff][Ee][Ss][Tt][Ii] | [Ff][Ee][Ss][Tt][Ii][Vv] | [Ff][Ee][Ss][Tt][Ii][Vv][Aa] | [Ff][Ee][Ss][Tt][Ii][Vv][Aa][Ll])
                 APP_NAME="festival"
                 f_how_to_quit_application "(quit)"
                 f_application_run
                 ;;
                 festival' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Aa] | [Ss][Cc][Rr][Ee][Aa][Dd] | [Ss][Cc][Rr][Ee][Aa][Dd][Ee] | [Ss][Cc][Rr][Ee][Aa][Dd][Ee][Rr])
                 APP_NAME="screader"
                 f_application_run
                 ;;
                 screader' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_education () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Education Applications until loop.
            #MED lifelines - geneology.
            #MED grass     - GIS Map utility (Geographic Information System).
            #MED diatheke  - Holy Bible research tool.
            #MED aldo      - Morse code training.
            #MED cw        - Morse code training.
            #MED cwcp      - Morse code training.
            #MED morse     - Morse code training.
            #MED primes    - Prime number calculator. 
            #MED gtypist   - Typing tutor displays a sentence for practice.
            #MED typespeed - Typing tutor displays flying words arcade-style across screen.
           #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Education/Hobby Applications Menu"
            DELIMITER="#MED" #MED This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Education Applications case statement.
                 1 | [Ll] | [Ll][Ii] | [Ll][Ii][Ff] | [Ll][Ii][Ff][Ee] | [Ll][Ii][Ff][Ee][Ll] | [Ll][Ii][Ff][Ee][Ll][Ii] | [Ll][Ii][Ff][Ee][Ll][Ii][Nn] | [Ll][Ii][Ff][Ee][Ll][Ii][Nn][Ee] | [Ll][Ii][Ff][Ee][Ll][Ii][Nn][Ee][Ss])
                 APP_NAME="lifelines"
                 f_application_run
                 ;;
                 lifelines' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Rr] | [Gg][Rr][Aa] | [Gg][Rr][Aa][Ss] | [Gg][Rr][Aa][Ss][Ss])
                 APP_NAME="grass"
                 f_application_run
                 ;;
                 grass' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Ii] | [Dd][Ii][Aa] | [Dd][Ii][Aa][Tt] | [Dd][Ii][Aa][Tt][Hh] | [Dd][Ii][Aa][Tt][Hh][Ee] | [Dd][Ii][Aa][Tt][Hh][Ee][Kk] | [Dd][Ii][Aa][Tt][Hh][Ee][Kk][Ee])
                 APP_NAME="diatheke"
                 f_application_run
                 ;;
                 diatheke' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Aa] | [Aa][Ll] | [Aa][Ll][Dd] | [Aa][Ll][Dd][Oo])
                 APP_NAME="aldo"
                 f_application_run
                 ;;
                 aldo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Cc] | [Cc][Ww])
                 APP_NAME="cw"
                 f_application_run
                 ;;
                 cw' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Cc] | [Cc][Ww] | [Cc][Ww][Cc] | [Cc][Ww][Cc][Pp])
                 APP_NAME="cwcp"
                 f_application_run
                 ;;
                 cwcp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Mm] | [Mm][Oo] | [Mm][Oo][Rr] | [Mm][Oo][Rr][Ss] | [Mm][Oo][Rr][Ss][Ee])
                 APP_NAME="morse"
                 f_application_run
                 ;;
                 morse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Pp] | [Pp][Rr] | [Pp][Rr][Ii] | [Pp][Rr][Ii][Mm] | [Pp][Rr][Ii][Mm][Ee] | [Pp][Rr][Ii][Mm][Ee][Ss])
                 APP_NAME="primes"
                 f_application_run
                 ;;
                 primes' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Gg] | [Gg][Tt] | [Gg][Tt][Yy] | [Gg][Tt][Yy][Pp] | [Gg][Tt][Yy][Pp][Ii] | [Gg][Tt][Yy][Pp][Ii][Ss] | [Gg][Tt][Yy][Pp][Ii][Ss][Tt])
                 APP_NAME="gtypist"
                 f_application_run
                 ;;
                 gtypist' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Tt] | [Tt][Yy] | [Tt][Yy][Pp] | [Tt][Yy][Pp][Ee] | [Tt][Yy][Pp][Ee][Ss] | [Tt][Yy][Pp][Ee][Ss][Pp] | [Tt][Yy][Pp][Ee][Ss][Pp][Ee] | [Tt][Yy][Pp][Ee][Ss][Pp][Ee][Ee] | [Tt][Yy][Pp][Ee][Ss][Pp][Ee][Ee][Dd])
                 APP_NAME="typespeed"
                 f_application_run
                 ;;
                 typespeed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Education Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Education Applications until loop.
} # End of f_menu_app_education
#
# +----------------------------------------+
# |  Function f_menu_cat_file_management   |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_file_management () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of File Management Application Category until loop.
            #BFM Backup     - File Backup/archive to CD-ROM or compressed files.
            #BFM Encryption - Encrypt/Decrypt files for privacy and security.
            #BFM Find       - File search.
            #BFM FTP        - FTP clients (File Tranfer Protocol).
            #BFM Managers   - Directory tree views, rename, add/delete, files, folders.
            #BFM Splitters  - File splitters.
            #BFM Viewers    - View files a page at a time.
            #BFM Delete     - Secure deletion of files without recovery.
            #BFM Undelete   - Recover deleted files.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Management Application Category Menu"
            DELIMITER="#BFM" #BFM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Application Category case statement.
                 1 | [Bb] | [Bb][Aa] | [Bb][Aa][Cc] | [Bb][Aa][Cc][Kk] | [Bb][Aa][Cc][Kk][Uu] | [Bb][Aa][Cc][Kk][Uu][Pp])
                 f_menu_app_sys_backup        # System Backup Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Ee] | [Ee][Nn] | [Ee][Nn][Cc] | [Ee][Nn][Cc][Rr] | [Ee][Nn][Cc][Rr][Yy] | [Ee][Nn][Cc][Rr][Yy][Pp] | [Ee][Nn][Cc][Rr][Yy][Pp][Tt] | [Ee][Nn][Cc][Rr][Yy][Pp][Tt][Ii] | [Ee][Nn][Cc][Rr][Yy][Pp][Tt][Ii][Oo] | [Ee][Nn][Cc][Rr][Yy][Pp][Tt][Ii][Oo][Nn])
                 f_menu_app_file_encryption   # File Encryption Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Dd])
                 f_menu_app_file_find         # File Find Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp])
                 f_menu_app_file_transfer     # File Transfer Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Mm] | [Mm][Aa] | [Mm][Aa][Nn] | [Mm][Aa][Nn][Aa] | [Mm][Aa][Nn][Aa][Gg] | [Mm][Aa][Nn][Aa][Gg][Ee] | [Mm][Aa][Nn][Aa][Gg][Ee][Rr] | [Mm][Aa][Nn][Aa][Gg][Ee][Rr][Ss])
                 f_menu_app_file_managers     # File Manager Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Ss] | [Ss][Pp] | [Ss][Pp][Ll] | [Ss][Pp][Ll][Ii] | [Ss][Pp][Ll][Ii][Tt] | [Ss][Pp][Ll][Ii][Tt][Tt] | [Ss][Pp][Ll][Ii][Tt][Tt][Ee] | [Ss][Pp][Ll][Ii][Tt][Tt][Ee][Rr] | [Ss][Pp][Ll][Ii][Tt][Tt][Ee][Rr][Ss]) 
                 f_menu_app_file_splitters    # File Viewers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Vv] | [Vv][Ii] | [Vv][Ii][Ee] | [Vv][Ii][Ee][Ww] | [Vv][Ii][Ee][Ww][Ee] | [Vv][Ii][Ee][Ww][Ee][Rr] | [Vv][Ii][Ee][Ww][Ee][Rr][Ss]) 
                 f_menu_app_file_viewers      # File Viewers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Dd] | [Dd][Ee] | [Dd][Ee][Ll] | [Dd][Ee][Ll][Ee] | [Dd][Ee][Ll][Ee][Tt] | [Dd][Ee][Ll][Ee][Tt][Ee])
                 f_menu_app_file_deletion       # File Deletion Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Uu] | [Uu][Nn] | [Uu][Nn][Dd] | [Uu][Nn][Dd][Ee] | [Uu][Nn][Dd][Ee][Ll] | [Uu][Nn][Dd][Ee][Ll][Ee] | [Uu][Nn][Dd][Ee][Ll][Ee][Tt] | [Uu][Nn][Dd][Ee][Ll][Ee][Tt][Ee])
                 f_menu_app_file_recover      # File Recovery Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of File Management Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of File Management Application Category until loop.
} # End of function f_menu_cat_file_management
#
# +----------------------------------------+
# |   Function f_menu_app_file_encryption  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_encryption () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of File Encryption Applications until loop.
            #MFE bcrypt    - Uses the blowfish encryption algorithm.
            #MFE ccrypt    - Uses the Rijndael cipher algorithm.
            #MFE crypt     - Wrapper for mcrypt, backward compatible to old Unix crypt.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Encryption Applications case statement.
                 1 | [Bb] | [Bb][Cc] | [Bb][Cc][Rr] | [Bb][Cc][Rr][Yy] | [Bb][Cc][Rr][Yy][Pp] | [Bb][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="bcrypt"
                 f_application_run
                 ;;
                 bcrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Cc] | [Cc][Cc][Rr] | [Cc][Cc][Rr][Yy] | [Cc][Cc][Rr][Yy][Pp] | [Cc][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="ccrypt"
                 f_application_run
                 ;;
                 ccrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Rr] | [Cc][Rr][Yy] | [Cc][Rr][Yy][Pp] | [Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="crypt"
                 f_application_run
                 ;;
                 crypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Mm] | [Mm][Cc] | [Mm][Cc][Rr] | [Mm][Cc][Rr][Yy] | [Mm][Cc][Rr][Yy][Pp] | [Mm][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="mcrypt"
                 f_application_run
                 ;;
                 mcrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Gg] | [Pp][Gg][Pp])
                 APP_NAME="pgp"
                 f_application_run
                 ;;
                 pgp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Yy] | [Ss][Cc][Rr][Yy][Pp] | [Ss][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="scrypt"
                 f_application_run
                 ;;
                 scrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Tt] | [Tt][Rr] | [Tt][Rr][Uu] | [Tt][Rr][Uu][Ee] | [Tt][Rr][Uu][Ee][Cc] | [Tt][Rr][Uu][Ee][Cc][Rr] | [Tt][Rr][Uu][Ee][Cc][Rr][Yy] | [Tt][Rr][Uu][Ee][Cc][Rr][Yy][Pp] | [Tt][Rr][Uu][Ee][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="truecrypt"
                 f_application_run
                 ;;
                 truecrypt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Zz] | [Zz][Cc] | [Zz][Cc][Rr] | [Zz][Cc][Rr][Yy] | [Zz][Cc][Rr][Yy][Pp] | [Zz][Cc][Rr][Yy][Pp][Tt])
                 APP_NAME="zcrypt"
                 f_application_run
                 ;;
                 zcrypt' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_find () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Find File Applications case statement.
                 1 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Dd])
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
                 find' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ll] | [Ll][Oo] | [Ll][Oo][Cc] | [Ll][Oo][Cc][Aa] | [Ll][Oo][Cc][Aa][Tt] | [Ll][Oo][Cc][Aa][Tt][Ee])
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
                 locate' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Uu] | [Uu][Pp] | [Uu][Pp][Dd] | [Uu][Pp][Dd][Aa] | [Uu][Pp][Dd][Aa][Tt] | [Uu][Pp][Dd][Aa][Tt][Ee] | [Uu][Pp][Dd][Aa][Tt][Ee][Dd] | [Uu][Pp][Dd][Aa][Tt][Ee][Dd][Bb])
                 APP_NAME="updatedb"
                 f_application_run
                 ;;
                 updatedb' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_managers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of File Manager Applications until loop.
            #MFI clex    - File manager.
            #MFI dired   - File manager for Emacs.
            #MFI mc      - File Manager, Midnight Commander.
            #MFI ranger  - File manager.
            #MFI smbc    - Samba file manager for folder shares with Microsoft Windows.
            #MFI vfu     - File manager, ncurses-based.
            #MFI vifm    - File manager with vi-like commands.
            #MFI detox   - File name clean up.
            #MFI findmnt - Find a filesystem.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Manager Applications Menu"
            DELIMITER="#MFI" #MFI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Manager Applications case statement.
                 1 | [Cc] | [Cc][Ll] | [Cc][Ll][Ee] | [Cc][Ll][Ee][Xx])
                 APP_NAME="clex"
                 f_application_run
                 ;;
                 clex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Ii] | [Dd][Ii][Rr] | [Dd][Ii][Rr][Ee] | [Dd][Ii][Rr][Ee][Dd])
                 APP_NAME="dired"
                 f_application_run
                 ;;
                 dired' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Cc])
                 APP_NAME="mc"
                 f_application_run
                 ;;
                 mc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Rr] | [Rr][Aa] | [Rr][Aa][Nn] | [Rr][Aa][Nn][Gg] | [Rr][Aa][Nn][Gg][Ee] | [Rr][Aa][Nn][Gg][Ee][Rr])
                 APP_NAME="ranger"
                 f_application_run
                 ;;
                 ranger' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc])
                 APP_NAME="smbc"
                 f_application_run
                 ;;
                 smbc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Vv] | [Vv][Ff] | [Vv][Ff][Uu]) 
                 APP_NAME="vfu"
                 f_application_run
                 ;;
                 vfu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Vv] | [Vv][Ii] | [Vv][Ii][Ff] | [Vv][Ii][Ff][Mm])
                 APP_NAME="vifm"
                 f_application_run
                 ;;
                 vifm' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Dd] | [Dd][Ee] | [Dd][Ee][Tt] | [Dd][Ee][Tt][Oo] | [Dd][Ee][Tt][Oo][Xx])
                 APP_NAME="detox"
                 f_application_run
                 ;;
                 detox' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Dd] | [Ff][Ii][Nn][Dd][Mm] | [Ff][Ii][Nn][Dd][Mm][Nn] | [Ff][Ii][Nn][Dd][Mm][Nn][Tt])
                 APP_NAME="findmnt"
                 f_application_run
                 ;;
                 findmnt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac               # End of File Manager Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of File Manager Applications until loop.
} # End of f_menu_app_file_managers
#
# +----------------------------------------+
# |   Function f_menu_app_file_splitters   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_splitters () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Splitter Applications case statement.
                 1 | [Ll] | [Ll][Xx] | [Ll][Xx][Ss] | [Ll][Xx][Ss][Pp] | [Ll][Xx][Ss][Pp][Ll] | [Ll][Xx][Ss][Pp][Ll][Ii] | [Ll][Xx][Ss][Pp][Ll][Ii][Tt])
                 APP_NAME="lxsplit"
                 f_application_run
                 ;;
                 lxsplit' '* | 'sudo lxsplit '* | 'sudo lxsplit')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ss] | [Ss][Pp] | [Ss][Pp][Ll] | [Ss][Pp][Ll][Ii] | [Ss][Pp][Ll][Ii][Tt])
                 APP_NAME="split"
                 f_application_run
                 ;;
                 split' '* | 'sudo split '* | 'sudo split')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_viewers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of File Viewer Applications until loop.
            #MFV jless - File viewer pager.
            #MFV more  - File viewer pager.
            #MFV most  - File viewer pager.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Viewer Applications Menu"
            DELIMITER="#MFV" #MFV This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Viewer Applications case statement.
                 1 | [Jj] | [Jj][Ll] | [Jj][Ll][Ee] | [Jj][Ll][Ee][Ss] | [Jj][Ll][Ee][Ss][Ss])
                 APP_NAME="jless"
                 f_application_run
                 ;;
                 jless' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Mm] | [Mm][Oo] | [Mm][Oo][Rr] | [Mm][Oo][Rr][Ee])
                 APP_NAME="more"
                 f_application_run
                 ;;
                 more' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Ss] | [Mm][Oo][Ss][Tt])
                 APP_NAME="most"
                 f_application_run
                 ;;
                 most' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_deletion () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Deletion Applications case statement.
                 1 | [Ss] | [Ss][Hh] | [Ss][Hh][Rr] | [Ss][Hh][Rr][Ee] | [Ss][Hh][Rr][Ee][Dd])
                 APP_NAME="shred"
                 f_application_run
                 ;;
                 shred' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_file_recover () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Recovery Applications case statement.
                 1 | [Ff] | [Ff][Oo] | [Ff][Oo][Rr] | [Ff][Oo][Rr][Ee] | [Ff][Oo][Rr][Ee][Mm] | [Ff][Oo][Rr][Ee][Mm][Oo] | [Ff][Oo][Rr][Ee][Mm][Oo][Ss] | [Ff][Oo][Rr][Ee][Mm][Oo][Ss][Tt])
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
                 foremost' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Pp] | [Pp][Hh] | [Pp][Hh][Oo] | [Pp][Hh][Oo][Tt] | [Pp][Hh][Oo][Tt][Oo] | [Pp][Hh][Oo][Tt][Oo][Rr] | [Pp][Hh][Oo][Tt][Oo][Rr][Ee] | [Pp][Hh][Oo][Tt][Oo][Rr][Ee][Cc])
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
                 photorec' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Aa] | [Ss][Aa][Ff] | [Ss][Aa][Ff][Ee] | [Ss][Aa][Ff][Ee][Cc] | [Ss][Aa][Ff][Ee][Cc][Oo] | [Ss][Aa][Ff][Ee][Cc][Oo][Pp] | [Ss][Aa][Ff][Ee][Cc][Oo][Pp][Yy])
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
                 safecopy' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Tt] | [Tt][Rr] | [Tt][Rr][Aa] | [Tt][Rr][Aa][Ss] | [Tt][Rr][Aa][Ss][Hh] | [Tt][Rr][Aa][Ss][Hh][-] | [Tt][Rr][Aa][Ss][Hh][-][Cc] | [Tt][Rr][Aa][Ss][Hh][-][Cc][Ll] | [Tt][Rr][Aa][Ss][Hh][-][Cc][Ll][Ii])
                 APP_NAME="trash-cli"
                 f_application_run
                 ;;
                 trash-cli' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
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
            f_quit_subcat_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Game Category case statement.
                 1 | [Aa] | [Aa][Rr] | [Aa][Rr][Cc] | [Aa][Rr][Cc][Aa] | [Aa][Rr][Cc][Aa][Dd] | [Aa][Rr][Cc][Aa][Dd][Ee]) 
                 f_menu_app_games_arcade      # Arcade Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Bb] | [Bb][Oo] | [Bb][Oo][Aa] | [Bb][Oo][Aa][Rr] | [Bb][Oo][Aa][Rr][Dd])
                 f_menu_app_games_board       # Board Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Rr] | [Cc][Aa][Rr][Dd])
                 f_menu_app_games_card        # Card Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Mm] | [Mm][Uu] | [Mm][Uu][Dd])
                 f_menu_app_games_mud         # Mud Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Pp] | [Pp][Uu] | [Pp][Uu][Zz] | [Pp][Uu][Zz][Zz] | [Pp][Uu][Zz][Zz][Ll] | [Pp][Uu][Zz][Zz][Ll][Ee] | [Pp][Uu][Zz][Zz][Ll][Ee][Ss])
                 f_menu_app_games_puzzle      # Puzzle Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Zz])
                 f_menu_app_games_quiz        # Quiz Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Rr] | [Rr][Pp] | [Rr][Pp][Gg])
                 f_menu_app_games_rpg         # Role Playing Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Ss] | [Ss][Ii] | [Ss][Ii][Mm] | [Ss][Ii][Mm][Uu] | [Ss][Ii][Mm][Uu][Ll] | [Ss][Ii][Mm][Uu][Ll][Aa] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii][Oo] | [Ss][Ii][Mm][Uu][Ll][Aa][Tt][Ii][Oo][Nn])
                 f_menu_app_games_simulation  # Simulation Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Ss] | [Ss][Tt] | [Ss][Tt][Rr] | [Ss][Tt][Rr][Aa] | [Ss][Tt][Rr][Aa][Tt] | [Ss][Tt][Rr][Aa][Tt][Ee] | [Ss][Tt][Rr][Aa][Tt][Ee][Gg] | [Ss][Tt][Rr][Aa][Tt][Ee][Gg][Yy])
                 f_menu_app_games_strategy    # Strategy Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 10 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Dd])
                 f_menu_app_games_word        # Word Games Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Game Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Game Category until loop.
} # End of function f_menu_cat_games
#
# +----------------------------------------+
# |    Function f_menu_app_games_arcade    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_arcade () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Arcade Games until loop.
            #MGB asciijump      - Ski jump game.
            #MGB freesweep      - Minesweeper game.
            #MGB moon-buggy     - Drive a moon buggy on the moon.
            #MGB ninvaders      - Space invaders-like game ncurses-based.
            #MGB pacman4console - Pacman-like game ncurses-based.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Arcade Games case statement.
                 1 | [Aa] | [Aa][Ss] | [Aa][Ss][Cc] | [Aa][Ss][Cc][Ii] | [Aa][Ss][Cc][Ii][Ii] | [Aa][Ss][Cc][Ii][Ii][Jj] | [Aa][Ss][Cc][Ii][Ii][Jj][Uu] | [Aa][Ss][Cc][Ii][Ii][Jj][Uu][Mm] | [Aa][Ss][Cc][Ii][Ii][Jj][Uu][Mm][Pp])
                 APP_NAME="asciijump"
                 f_application_run
                 ;;
                 asciijump' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ee] | [Ff][Rr][Ee][Ee][Ss] | [Ff][Rr][Ee][Ee][Ss][Ww] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee][Ee] | [Ff][Rr][Ee][Ee][Ss][Ww][Ee][Ee][Pp])
                 APP_NAME="freesweep"
                 f_application_run
                 ;;
                 freesweep' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Oo] | [Mm][Oo][Oo][Nn] | [Mm][Oo][Oo][Nn][-] | [Mm][Oo][Oo][Nn][-][Bb] | [Mm][Oo][Oo][Nn][-][Bb][Uu] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg][Gg] | [Mm][Oo][Oo][Nn][-][Bb][Uu][Gg][Gg][Yy])
                 APP_NAME="moon-buggy"
                 f_application_run
                 ;;
                 moon-buggy' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Ii] | [Nn][Ii][Nn] | [Nn][Ii][Nn][Vv] | [Nn][Ii][Nn][Vv][Aa] | [Nn][Ii][Nn][Vv][Aa][Dd] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee][Rr] | [Nn][Ii][Nn][Vv][Aa][Dd][Ee][Rr][Ss])
                 APP_NAME="ninvaders"
                 f_how_to_quit_application "q" 
                 f_application_run
                 ;;
                 ninvaders' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Aa] | [Pp][Aa][Cc] | [Pp][Aa][Cc][Mm] | [Pp][Aa][Cc][Mm][Aa] | [Pp][Aa][Cc][Mm][Aa][Nn] | [Pp][Aa][Cc][Mm][Aa][Nn][4] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo][Ll] | [Pp][Aa][Cc][Mm][Aa][Nn][4][Cc][Oo][Nn][Ss][Oo][Ll][Ee])
                 APP_NAME="pacman4console"
                 f_application_run
                 ;;
                 pacman4console' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Rr] | [Rr][Oo] | [Rr][Oo][Bb] | [Rr][Oo][Bb][Oo] | [Rr][Oo][Bb][Oo][Tt] | [Rr][Oo][Bb][Oo][Tt][Ss])
                 APP_NAME="robots"
                 f_application_run
                 ;;
                 robots' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Nn] | [Ss][Nn][Aa] | [Ss][Nn][Aa][Kk] | [Ss][Nn][Aa][Kk][Ee])
                 APP_NAME="snake"
                 f_application_run
                 ;;
                 snake' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Mm])
                 APP_NAME="worm"
                 f_application_run
                 ;;
                 worm' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Arcade Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Arcade Games until loop.
} # End of f_menu_app_games_arcade
#
# +----------------------------------------+
# |     Function f_menu_app_games_board    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Board Games case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Oo] | [Aa][Tt][Oo][Mm] | [Aa][Tt][Oo][Mm][4])
                 APP_NAME="atom4"
                 f_application_run
                 ;;
                 atom4' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Aa] | [Bb][Aa][Cc] | [Bb][Aa][Cc][Kk] | [Bb][Aa][Cc][Kk][Gg] | [Bb][Aa][Cc][Kk][Gg][Aa] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm][Oo] | [Bb][Aa][Cc][Kk][Gg][Aa][Mm][Mm][Oo][Nn])
                 APP_NAME="backgammon"
                 f_application_run
                 ;;
                 backgammon' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Oo] | [Mm][Oo][Nn][Oo][Pp])
                 APP_NAME="monop"
                 f_application_run
                 ;;
                 monop' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Board Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Board Games until loop.
} # End of f_menu_app_games_board
#
# +----------------------------------------+
# |     Function f_menu_app_games_card     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Card Games case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Nn] | [Cc][Aa][Nn][Ff] | [Cc][Aa][Nn][Ff][Ii] | [Cc][Aa][Nn][Ff][Ii][Ee] | [Cc][Aa][Nn][Ff][Ii][Ee][Ll] | [Cc][Aa][Nn][Ff][Ii][Ee][Ll][Dd)
                 APP_NAME="canfield"
                 f_application_run
                 ;;
                 canfield' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Rr] | [Cc][Rr][Ii] | [Cc][Rr][Ii][Bb] | [Cc][Rr][Ii][Bb][Bb] | [Cc][Rr][Ii][Bb][Bb][Aa] | [Cc][Rr][Ii][Bb][Bb][Aa][Gg] | [Cc][Rr][Ii][Bb][Bb][Aa][Gg][Ee])
                 APP_NAME="cribbage"
                 f_application_run
                 ;;
                 cribbage' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Gg] | [Gg][Oo] | [Gg][Oo][-] | [Gg][Oo][-][Ff] | [Gg][Oo][-][Ff][Ii] | [Gg][Oo][-][Ff][Ii][Ss] | [Gg][Oo][-][Ff][Ii][Ss][Hh])
                 APP_NAME="go-fish"
                 f_application_run
                 ;;
                 go-fish' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Card Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Card Games until loop.
} # End of f_menu_app_games_card
#
# +----------------------------------------+	
# |      Function f_menu_app_games_mud     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of MUD Games case statement.
                 1 |[Cc] |[Cc][Rr] |[Cc][Rr][Aa] |[Cc][Rr][Aa][Ww] |[Cc][Rr][Aa][Ww][Ll])
                 APP_NAME="crawl"
                 f_application_run
                 ;;
                 crawl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Tt] | [Tt][Ii] | [Tt][Ii][Nn] | [Tt][Ii][Nn][Tt] | [Tt][Ii][Nn][Tt][Ii] | [Tt][Ii][Nn][Tt][Ii][Nn] | [Tt][Ii][Nn][Tt][Ii][Nn][+] | [Tt][Ii][Nn][Tt][Ii][Nn][+][+])
                 APP_NAME="tintin++"
                 f_application_run
                 ;;
                 tintin++' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of MUD Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of MUD Games until loop.
} # End of f_menu_app_games_mud
#
# +----------------------------------------+
# |    Function f_menu_app_games_puzzle    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Puzzle Games case statement.
                 1 | [Bb] | [Bb][Aa] | [Bb][Aa][Ss] | [Bb][Aa][Ss][Tt] | [Bb][Aa][Ss][Tt][Ee] | [Bb][Aa][Ss][Tt][Ee][Tt])
                 APP_NAME="bastet"
                 f_application_run
                 ;;
                 bastet' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Cc] | [Bb][Cc][Dd])
                 APP_NAME="bcd"
                 f_application_run
                 ;;
                 bcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Aa] | [Dd][Aa][Bb])
                 APP_NAME="dab"
                 f_application_run
                 ;;
                 dab' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Rr] | [Nn][Ee][Tt][Rr][Ii] | [Nn][Ee][Tt][Rr][Ii][Ss])
                 APP_NAME="netris"
                 f_application_run
                 ;;
                 netris' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Ee] | [Pp][Ee][Tt] | [Pp][Ee][Tt][Rr] | [Pp][Ee][Tt][Rr][Ii] | [Pp][Ee][Tt][Rr][Ii][Ss])
                 APP_NAME="petris"
                 f_application_run
                 ;;
                 petris' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Pp] | [Pp][Pp] | [Pp][Pp][Tt])
                 APP_NAME="ppt"
                 f_application_run
                 ;;
                 ppt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Puzzle Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Puzzle Games until loop.
} # End of f_menu_app_games_puzzle
#
# +----------------------------------------+
# |      Function f_menu_app_games_quiz    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Quiz Games case statement.
                 1 |[Aa] |[Aa][Rr] |[Aa][Rr][Ii] |[Aa][Rr][Ii][Tt] |[Aa][Rr][Ii][Tt][Hh] |[Aa][Rr][Ii][Tt][Hh][Mm] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt][Ii] |[Aa][Rr][Ii][Tt][Hh][Mm][Ee][Tt][Ii][Cc])
                 APP_NAME="arithmetic"
                 f_how_to_quit_application "Ctrl-Z"
                 f_application_run
                 ;;
                 arithmetic' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Ee] | [Gg][Ee][Ee] | [Gg][Ee][Ee][Kk] | [Gg][Ee][Ee][Kk][Cc] | [Gg][Ee][Ee][Kk][Cc][Oo] | [Gg][Ee][Ee][Kk][Cc][Oo][Dd] | [Gg][Ee][Ee][Kk][Cc][Oo][Dd][Ee])
                 APP_NAME="geekcode"
                 f_application_run
                 ;;
                 geekcode' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Oo] | [Mm][Oo][Rr] | [Mm][Oo][Rr][Ss] | [Mm][Oo][Rr][Ss][Ee])
                 APP_NAME="morse"
                 f_application_run
                 ;;
                 morse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Zz])
                 APP_NAME="quiz"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 quiz' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Quiz Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Quiz Games until loop.
} # End of f_menu_app_games_quiz
#
# +----------------------------------------+
# |      Function f_menu_app_games_rpg     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of RPG Games case statement.
                 1 | [Aa] | [Aa][Dd] | [Aa][Dd][Vv] | [Aa][Dd][Vv][Ee] | [Aa][Dd][Vv][Ee][Nn] | [Aa][Dd][Vv][Ee][Nn][Tt] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu][Rr] | [Aa][Dd][Vv][Ee][Nn][Tt][Uu][Rr][Ee])
                 APP_NAME="adventure"
                 f_how_to_quit_application "quit"
                 f_application_run
                 ;;
                 adventure' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Aa] | [Bb][Aa][Tt] | [Bb][Aa][Tt][Tt] | [Bb][Aa][Tt][Tt][Ll] | [Bb][Aa][Tt][Tt][Ll][Ee] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt][Aa] | [Bb][Aa][Tt][Tt][Ll][Ee][Ss][Tt][Aa][Rr])
                 APP_NAME="battlestar"
                 f_application_run
                 ;;
                 battlestar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [hH] | [hH][Aa] | [hH][Aa][Cc] | [hH][Aa][Cc][Kk])
                 APP_NAME="hack"
                 f_application_run
                 ;;
                 hack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][hH] | [Nn][Ee][Tt][hH][Aa] | [Nn][Ee][Tt][hH][Aa][Cc] | [Nn][Ee][Tt][hH][Aa][Cc][Kk])
                 APP_NAME="nethack-console"
                 f_application_run
                 ;;
                 nethack' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Hh] | [Pp][Hh][Aa] | [Pp][Hh][Aa][Nn] | [Pp][Hh][Aa][Nn][Tt] | [Pp][Hh][Aa][Nn][Tt][Aa] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss][Ii] | [Pp][Hh][Aa][Nn][Tt][Aa][Ss][Ii][Aa])
                 APP_NAME="phantasia"
                 f_application_run
                 ;;
                 phantasia' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ss] | [Ss][Ll] | [Ss][Ll][Aa] | [Ss][Ll][Aa][Ss] | [Ss][Ll][Aa][Ss][Hh] | [Ss][Ll][Aa][Ss][Hh][Ee] | [Ss][Ll][Aa][Ss][Hh][Ee][Mm])
                 APP_NAME="slashem"
                 f_application_run
                 ;;
                 slashem' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ww] | [Ww][Uu] | [Ww][Uu][Mm] | [Ww][Uu][Mm][Pp])
                 APP_NAME="wump"
                 f_application_run
                 ;;
                 wump' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of RPG Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of RPG Games until loop.
} # End of f_menu_app_games_rpg
#
# +----------------------------------------+
# |  Function f_menu_app_games_simulation  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_games_simulation () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Simulation Games until loop.
            #MGI atc  - Air traffic controller.
            #MGI sail - Command a Man O'War fighting ship.
            #MGI trek - Star Trek blast Klingons.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Simulation Games Menu"
            DELIMITER="#MGI" #MGI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Simulation Games case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Cc])
                 APP_NAME="atc"
                 f_application_run
                 ;;
                 atc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 |[Ss] |[Ss][Aa] |[Ss][Aa][Ii] |[Ss][Aa][Ii][Ll])
                 APP_NAME="sail"
                 f_application_run
                 ;;
                 sail' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Rr] | [Tt][Rr][Ee] | [Tt][Rr][Ee][Kk])
                 APP_NAME="trek"
                 f_how_to_quit_application "at the prompt Command: terminate"
                 f_application_run
                 ;;
                 trek' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Simulation Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Simulation Games until loop.
} # End of f_menu_app_games_simulation
#
# +----------------------------------------+
# |   Function f_menu_app_games_strategy   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Strategy Games case statement.
                 1 | [Gg] | [Gg][Oo] | [Gg][Oo][Mm] | [Gg][Oo][Mm][Oo] | [Gg][Oo][Mm][Oo][Kk] | [Gg][Oo][Mm][Oo][Kk][Uu])
                 APP_NAME="gomoku"
                 f_application_run
                 ;;
                 gomoku' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Uu] | [Hh][Uu][Nn] | [Hh][Uu][Nn][Tt])
                 APP_NAME="hunt"
                 f_application_run
                 ;;
                 hunt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Ii] | [Mm][Ii][Ll] | [Mm][Ii][Ll][Ll] | [Mm][Ii][Ll][Ll][Ee])
                 APP_NAME="mille"
                 f_application_run
                 ;;
                 mille' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ww] | [Ww][Aa] | [Ww][Aa][Rr] | [Ww][Aa][Rr][Gg] | [Ww][Aa][Rr][Gg][Aa] | [Ww][Aa][Rr][Gg][Aa][Mm] | [Ww][Aa][Rr][Gg][Aa][Mm][Ee] | [Ww][Aa][Rr][Gg][Aa][Mm][Ee][Ss])
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
                 wargames' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Strategy Games case statement
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Strategy Games until loop.
} # End of f_menu_app_games_strategy
#
# +----------------------------------------+
# |     Function f_menu_app_games_word     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Word Games case statement.
                 1 | [Bb] | [Bb][Oo] | [Bb][Oo][Gg] | [Bb][Oo][Gg][Gg] | [Bb][Oo][Gg][Gg][Ll] | [Bb][Oo][Gg][Gg][Ll][Ee])
                 APP_NAME="boggle"
                 f_application_run
                 ;;
                 boggle' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Aa] | [Hh][Aa][Nn] | [Hh][Aa][Nn][Gg] | [Hh][Aa][Nn][Gg][Mm] | [Hh][Aa][Nn][Gg][Mm][Aa] | [Hh][Aa][Nn][Gg][Mm][Aa][Nn])
                 APP_NAME="hangman"
                 f_application_run
                 ;;
                 hangman' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Pp] | [Pp][Ii] | [Pp][Ii][Gg])
                 APP_NAME="pig"
                 f_application_run
                 ;;
                 pig' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac # End of Word Games case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Word Games until loop.
} # End of f_menu_app_games_word
#
# +----------------------------------------+
# |       Function f_menu_cat_image        |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_image () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Image Application Category until loop.
            #BIG Tools       - Viewers, ASCII Art, format converters, etc. 
            #BIG ImageMagick - Tools to manipulate images.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Image Application Category Menu"
            DELIMITER="#BIG" #BIG This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Image Application Category case statement.
                 1 | [Tt] | [Tt][Oo] | [Tt][Oo][Oo] | [Tt][Oo][Oo][Ll] | [Tt][Oo][Oo][Ll][Ss])
                 f_menu_app_image_graphics    # Image Graphics Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Ii] | [Ii][Mm] | [Ii][Mm][Aa] | [Ii][Mm][Aa][Gg] | [Ii][Mm][Aa][Gg][Ee] | [Ii][Mm][Aa][Gg][Ee][Mm] | [Ii][Mm][Aa][Gg][Ee][Mm][Aa] | [Ii][Mm][Aa][Gg][Ee][Mm][Aa][Gg] | [Ii][Mm][Aa][Gg][Ee][Mm][Aa][Gg][Ii] | [Ii][Mm][Aa][Gg][Ee][Mm][Aa][Gg][Ii][Cc] | [Ii][Mm][Aa][Gg][Ee][Mm][Aa][Gg][Ii][Cc][Kk]) 
                 f_menu_app_imagemagick       # ImageMagic Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Image Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Image Application Category until loop.
} # End of function f_menu_cat_image
#
# +----------------------------------------+
# |    Function f_menu_app_image_graphics   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_image_graphics () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Image-Graphics Applications until loop.
            #MIG aview      - Image and ascii art image viewer.
            #MIG hasciicam  - ASCII web camera images.
            #MIG caca-utils - Image viewer and converter jpg to ascii images.
            #MIG fbi        - Image viewer PhotoCD, jpeg, ppm, gif, tiff, xwd, bmp, png, etc.
            #MIG fbv        - Image viewer framebuffer console.
            #MIG fim        - Image and ascii art image viewer.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Image-Graphics Applications case statement.
                 1 | [Aa] | [Aa][Vv] | [Aa][Vv][Ii] | [Aa][Vv][Ii][Ee] | [Aa][Vv][Ii][Ee][Ww])
                 APP_NAME="aview"
                 f_application_run
                 ;;
                 aview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Aa] | [Hh][Aa][Ss] | [Hh][Aa][Ss][Cc] | [Hh][Aa][Ss][Cc][Ii] | [Hh][Aa][Ss][Cc][Ii][Ii] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc][Aa] | [Hh][Aa][Ss][Cc][Ii][Ii][Cc][Aa][Mm])
                 APP_NAME="hasciicam"
                 f_application_run
                 ;;
                 hasciicam' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Cc] | [Cc][Aa][Cc][Aa] | [Cc][Aa][Cc][Aa][-] | [Cc][Aa][Cc][Aa][-][Uu] | [Cc][Aa][Cc][Aa][-][Uu][Tt] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii][Ll] | [Cc][Aa][Cc][Aa][-][Uu][Tt][Ii][Ll][Ss])
                 APP_NAME="caca-utils"
                 f_application_run
                 ;;
                 caca-utils' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Bb] | [Ff][Bb][Ii])
                 APP_NAME="fbi"
                 f_application_run
                 ;;
                 fbi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ff] | [Ff][Bb] | [Ff][Bb][Vv])
                 APP_NAME="fbv"
                 f_application_run
                 ;;
                 fbv' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ff] | [Ff][Ii] | [Ff][Ii][Mm)
                 APP_NAME="fim"
                 f_application_run
                 ;;
                 fim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Jj] | [Jj][Ff] | [Jj][Ff][Bb] | [Jj][Ff][Bb][Vv] | [Jj][Ff][Bb][Vv][Ii] | [Jj][Ff][Bb][Vv][Ii][Ee] | [Jj][Ff][Bb][Vv][Ii][Ee][Ww])
                 APP_NAME="jfbview"
                 f_application_run
                 ;;
                 jfbview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Jj] | [Jj][Pp] | [Jj][Pp][2] | [Jj][Pp][2][Aa])
                 APP_NAME="jp2a"
                 f_application_run
                 ;;
                 jp2a' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Uu] | [Ll][Ii][Nn][Uu][Xx] | [Ll][Ii][Nn][Uu][Xx][Ll] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo][Gg] | [Ll][Ii][Nn][Uu][Xx][Ll][Oo][Gg][Oo])
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
                 linuxlogo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Image-Graphics Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Image-Graphics Applications until loop.
} # End of f_menu_app_image_graphics
#
# +----------------------------------------+
# |    Function f_menu_app_imagemagick    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of ImageMagick Applications case statement.
                 5 | [Aa] | [Aa][Nn] | [Aa][Nn][Ii] | [Aa][Nn][Ii][Mm] | [Aa][Nn][Ii][Mm][Aa] | [Aa][Nn][Ii][Mm][Aa][Tt] | [Aa][Nn][Ii][Mm][Aa][Tt][Ee])
                 APP_NAME="animate"
                 f_application_run
                 ;;
                 animate' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Cc] | [Cc][Oo] | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Oo] | [Cc][Oo][Mm][Pp][Oo][Ss] | [Cc][Oo][Mm][Pp][Oo][Ss][Ii] | [Cc][Oo][Mm][Pp][Oo][Ss][Ii][Tt] | [Cc][Oo][Mm][Pp][Oo][Ss][Ii][Tt][Ee])
                 APP_NAME="composite"
                 f_application_run
                 ;;
                 composite' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Cc] | [Cc][Oo] | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Aa] | [Cc][Oo][Mm][Pp][Aa][Rr] | [Cc][Oo][Mm][Pp][Aa][Rr][Ee])
                 APP_NAME="compare"
                 f_application_run
                 ;;
                 compare' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Jj] | [Cc][Oo][Nn][Jj][Uu] | [Cc][Oo][Nn][Jj][Uu][Rr] | [Cc][Oo][Nn][Jj][Uu][Rr][Ee])
                 APP_NAME="conjure"
                 f_application_run
                 ;;
                 conjure' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Vv] | [Cc][Oo][Nn][Vv][Ee] | [Cc][Oo][Nn][Vv][Ee][Rr] | [Cc][Oo][Nn][Vv][Ee][Rr][Tt])
                 APP_NAME="convert"
                 f_application_run
                 ;;
                 convert' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Dd] | [Dd][Ii] | [Dd][Ii][Ss] | [Dd][Ii][Ss][Pp] | [Dd][Ii][Ss][Pp][Ll] | [Dd][Ii][Ss][Pp][Ll][Aa] | [Dd][Ii][Ss][Pp][Ll][Aa][Yy])
                 APP_NAME="display"
                 f_application_run
                 ;;
                 display' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Ii] | [Ii][Dd] | [Ii][Dd][Ee] | [Ii][Dd][Ee][Nn] | [Ii][Dd][Ee][Nn][Tt] | [Ii][Dd][Ee][Nn][Tt][Ii] | [Ii][Dd][Ee][Nn][Tt][Ii][Ff] | [Ii][Dd][Ee][Nn][Tt][Ii][Ff][Yy])
                 APP_NAME="identify"
                 f_application_run
                 ;;
                 identify' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Ii] | [Ii][Mm] | [Ii][Mm][Pp] | [Ii][Mm][Pp][Oo] | [Ii][Mm][Pp][Oo][Rr] | [Ii][Mm][Pp][Oo][Rr][Tt])
                 APP_NAME="import"
                 f_application_run
                 ;;
                 import' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Mm] | [Mm][Oo] | [Mm][Oo][Gg] | [Mm][Oo][Gg][Rr] | [Mm][Oo][Gg][Rr][Ii] | [Mm][Oo][Gg][Rr][Ii][Ff] | [Mm][Oo][Gg][Rr][Ii][Ff][Yy])
                 APP_NAME="mogrify"
                 f_application_run
                 ;;
                 mogrify' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Tt] | [Mm][Oo][Nn][Tt][Aa] | [Mm][Oo][Nn][Tt][Aa][Gg] | [Mm][Oo][Nn][Tt][Aa][Gg][Ee])
                 APP_NAME="montage"
                 f_application_run
                 ;;
                 montage' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 15 | [Ss] | [Ss][Tt] | [Ss][Tt][Rr] | [Ss][Tt][Rr][Ee] | [Ss][Tt][Rr][Ee][Aa] | [Ss][Tt][Rr][Ee][Aa][Mm])
                 APP_NAME="stream"
                 f_application_run
                 ;;
                 stream' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of ImageMagick Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of ImageMagick Applications until loop.
} # End of f_menu_app_imagemagick
#
# +----------------------------------------+
# |      Function f_menu_cat_internet      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_internet () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of Internet Category until loop.
            #BIN Web Browsers      - Internet web  browsers.
            #BIN Bittorrent        - File transfer.
            #BIN Downloaders       - Download files and calculate file checksums. 
            #BIN Email             - Email clients.
            #BIN FAX               - FAX clients.
            #BIN FTP               - FTP clients (File Tranfer Protocol).
            #BIN Instant Messaging - AIM/ICQ, Yahoo!, MSN, IRC, Jabber/XMPP/Google Talk...
            #BIN IRC Clients       - Internet Relay Chat clients.
            #BIN News Readers      - Read USEnet news.
            #BIN LAN Chat          - Local Area Network Chat (not IRC).
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
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Internet Category case statement.
                 1 | [Ww] | [Ww][Ee] | [Ww][Ee][Bb] | [Ww][Ee][Bb]' ' | [Ww][Ee][Bb]' '[Bb] | [Ww][Ee][Bb]' '[Bb][Rr] | [Ww][Ee][Bb]' '[Bb][Rr][Oo] |  [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss][Ee] | [Ww][Ee][Bb]' '[Bb][Rr][Oo][Ww][Ss][Ee][Rr])
                 f_menu_app_web_browsers      # Web Browser Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn][Tt]) 
                 f_menu_app_bittorrent        # Bittorrent Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Dd] | [Dd][Oo] | [Dd][Oo][Ww] | [Dd][Oo][Ww][Nn] | [Dd][Oo][Ww][Nn][Ll] | [Dd][Oo][Ww][Nn][Ll][Oo] |  [Dd][Oo][Ww][Nn][Ll][Oo][Aa] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee][Rr] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd][Ee][Rr][Ss])
                 f_menu_app_downloaders       # Downloaders Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Ee] | [Ee][Mm] | [Ee][Mm][Aa] | [Ee][Mm][Aa][Ii] | [Ee][Mm][Aa][Ii][Ll])
                 f_menu_app_email             # Email Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop. 
                 ;;
                 5 | [Ff] | [Ff][Aa] | [Ff][Aa][Xx])
                 f_menu_app_fax               # FAX Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp])
                 f_menu_app_file_transfer     # File Transfer Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Ii] | [Ii][Nn] | [Ii][Nn][Ss] | [Ii][Nn][Ss][Tt] | [Ii][Nn][Ss][Tt][Aa] | [Ii][Nn][Ss][Tt][Aa][Nn] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' ' | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii][Nn] | [Ii][Nn][Ss][Tt][Aa][Nn][Tt]' '[Mm][Ee][Ss][Ss][Aa][Gg][Ii][Nn][Gg])
                 f_menu_app_instant_messaging #Instant Messaging Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Ii] | [Ii][Rr] | [Ii][Rr][Cc] | [Ii][Rr][Cc]' ' | [Ii][Rr][Cc]' '[Cc] | [Ii][Rr][Cc]' '[Cc][Ll] | [Ii][Rr][Cc]' '[Cc][Ll][Ii] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn][Tt] | [Ii][Rr][Cc]' '[Cc][Ll][Ii][Ee][Nn][Tt][Ss])
                 f_menu_app_irc_clients       # IRC Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Nn] | [Nn][Ee] | [Nn][Ee][Ww] | [Nn][Ee][Ww][Ss] | [Nn][Ee][Ww][Ss]' ' | [Nn][Ee][Ww][Ss]' '[Rr] | [Nn][Ee][Ww][Ss]' '[Rr][Ee] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee][Rr] | [Nn][Ee][Ww][Ss]' '[Rr][Ee][Aa][Dd][Ee][Rr][Ss])
                 f_menu_app_news_readers      # News Readers Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 10 | [Ll] | [Ll][Aa] | [Ll][Aa][Nn] | [Ll][Aa][Nn]' ' | [Ll][Aa][Nn]' '[Cc] | [Ll][Aa][Nn]' '[Cc][Hh] | [Ll][Aa][Nn]' '[Cc][Hh][Aa] | [Ll][Aa][Nn]' '[Cc][Hh][Aa][Tt])
                 f_menu_app_lan_chat          # LAN Chat Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 11 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Cc] | [Pp][Oo][Dd][Cc][Aa] | [Pp][Oo][Dd][Cc][Aa][Tt] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee][Rr] | [Pp][Oo][Dd][Cc][Aa][Tt][Cc][Hh][Ee][Rr][Ss])
                 f_menu_app_podcatchers       # Podcatcher Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 12 | [Rr] | [Rr][Ee] | [Rr][Ee][Mm] | [Rr][Ee][Mm][Oo] | [Rr][Ee][Mm][Oo][Tt] | [Rr][Ee][Mm][Oo][Tt][Ee] | [Rr][Ee][Mm][Oo][Tt][Ee]' ' | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii][Oo] | [Rr][Ee][Mm][Oo][Tt][Ee]' '[Cc][Oo][Nn][Nn][Ee][Cc][Tt][Ii][Oo][Nn])
                 f_menu_app_remote_connection # Remote Connection Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 13 | [Rr] | [Rr][Ss] | [Rr][Ss][Ss] | [Rr][Ss][Ss]' ' | [Rr][Ss][Ss]' '[Ff] | [Rr][Ss][Ss]' '[Ff][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee][Rr] | [Rr][Ss][Ss]' '[Ff][Ee][Ee][Dd][Ee][Rr][Ss])
                 f_menu_app_rssfeeders        # RSS Feeder Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                # End of Internet Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Internet Category until loop.
} # End of function f_menu_cat_internet
#
# +----------------------------------------+
# |    Function f_menu_app_web_browsers    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_web_browsers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Web Browsers Applications until loop.
            #MWB elinks - Web browser, tables, frames, forms support, tabbed browsing.
            #MWB lynx   - Web browser, NLS support.
            #MWB links2 - Web browser, has graphics mode.
            #MWB links  - Web browser, no graphics mode.
            #MWB retawq - Web browser, multi-threaded.
            #MWB w3m    - Web browser, tables, frames support, IPv6 support.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Web Browser Applications Menu"
            DELIMITER="#MWB" #MWB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Web Browser Applications case statement.
                 1 | [Ee] | [Ee][Ll] | [Ee][Ll][Ii] | [Ee][Ll][Ii][Nn] | [Ee][Ll][Ii][Nn][Kk] | [Ee][Ll][Ii][Nn][Kk][Ss] | [Ee][Ll][Ii][Nn][Kk][Ss])
                 APP_NAME="elinks"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 elinks' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 2 | [Ll] | [Ll][Yy] | [Ll][Yy][Nn] | [Ll][Yy][Nn][Xx] | [Ll][Yy][Nn][Xx])
                 APP_NAME="lynx"
                 f_web_site
                 f_application_run
                 ;;
                 lynx' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_application_run
                 ;;
                 3 | [Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss] | [Ll][Ii][Nn][Kk][Ss]) 
                 APP_NAME="links"
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
                 4 |[Ll] | [Ll][Ii] | [Ll][Ii][Nn] | [Ll][Ii][Nn][Kk] | [Ll][Ii][Nn][Kk][Ss] | [Ll][Ii][Nn][Kk][Ss][2] | [Ll][Ii][Nn][Kk][Ss][2])
                 APP_NAME="links2"
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
                 5 | [Rr] | [Rr][Ee] | [Rr][Ee][Tt] | [Rr][Ee][Tt][Aa] | [Rr][Ee][Tt][Aa][Ww] | [Rr][Ee][Tt][Aa][Ww][Qq])
                 APP_NAME="retawq"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 retawq' '*)
                 APP_NAME=$CHOICE_APP
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 6 | [Ww] | [Ww][3] | [Ww][3][Mm] | [Ww][3][Mm])
                 APP_NAME="w3m"
                 f_web_site
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 w3m' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_bittorrent () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Bittorrent Applications until loop.
            #MBT aria2        - Downloader supports BitTorrent/HTTP/HTTPS/FTP/Metalink.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Bittorrent Applications case statement.
                 1 | [Aa] | [Aa][Rr] | [Aa][Rr][Ii] | [Aa][Rr][Ii][Aa] | [Aa][Rr][Ii][Aa][2])
                 APP_NAME="aria2"
                 f_application_run
                 ;;
                 aria2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa][Dd] | [Bb][Ii][Tt][Tt][Oo][Rr][Nn][Aa][Dd][Oo])
                 APP_NAME="bittornado"
                 f_application_run
                 ;;
                 bittornado' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Tt] | [Bb][Ii][Tt][Tt][Oo] | [Bb][Ii][Tt][Tt][Oo][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn] | [Bb][Ii][Tt][Tt][Oo][Rr][Rr][Ee][Nn][Tt])
                 APP_NAME="bittorrent"
                 f_application_run
                 ;;
                 bittorrent' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Cc] | [Cc][Tt] | [Cc][Tt][Oo] | [Cc][Tt][Oo][Rr] | [Cc][Tt][Oo][Rr][Rr] | [Cc][Tt][Oo][Rr][Rr][Ee] | [Cc][Tt][Oo][Rr][Rr][Ee][Nn] | [Cc][Tt][Oo][Rr][Rr][Ee][Nn][Tt])
                 APP_NAME="ctorrent"
                 f_application_run
                 ;;
                 ctorrent' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Dd] | [Dd][Ee] | [Dd][Ee][Ll] | [Dd][Ee][Ll][Uu] | [Dd][Ee][Ll][Uu][Gg] | [Dd][Ee][Ll][Uu][Gg][Ee])
                 APP_NAME="deluge"
                 f_application_run
                 ;;
                 deluge' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Mm] | [Mm][Ll] | [Mm][Ll][Dd] | [Mm][Ll][Dd][Oo] | [Mm][Ll][Dd][Oo][Nn] | [Mm][Ll][Dd][Oo][Nn][Kk] | [Mm][Ll][Dd][Oo][Nn][Kk][Ee] | [Mm][Ll][Dd][Oo][Nn][Kk][Ee][Yy])
                 APP_NAME="mldonkey"
                 f_application_run
                 ;;
                 mldonkey' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Rr] | [Rr][Tt] | [Rr][Tt][Oo] | [Rr][Tt][Oo][Rr] | [Rr][Tt][Oo][Rr][Rr] | [Rr][Tt][Oo][Rr][Rr][Ee] | [Rr][Tt][Oo][Rr][Rr][Ee][Nn] | [Rr][Tt][Oo][Rr][Rr][Ee][Nn][Tt]) 
                 APP_NAME="rtorrent"
                 f_application_run
                 ;;
                 rtorrent' '*) 
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Tt] | [Tt][Rr] | [Tt][Rr][Aa] | [Tt][Rr][Aa][Nn] | [Tt][Rr][Aa][Nn][Ss] | [Tt][Rr][Aa][Nn][Ss][Mm] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii][Ss] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii][Ss][Ss] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii][Ss][Ss][Ii] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii][Ss][Ss][Ii][Oo] | [Tt][Rr][Aa][Nn][Ss][Mm][Ii][Ss][Ss][Ii][Oo][Nn]) 
                 APP_NAME="transmission"
                 f_application_run
                 ;;
                 transmission' '*) 
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_downloaders () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Downloaders Applications until loop.
            #MDL aria2    - Downloader supports HTTP/HTTPS/FTP/BitTorrent/Metalink.
            #MDL md5sum   - Display md5 checksum. Usage: md5sum [OPTION] [FILE]
            #MDL md5pass  - Create a password hash. Usage: md5pass [PASSWORD][SALT]
            #MDL sha1sum  - Display sha1 checksum. Usage: sha1sum [OPTION] [FILE]
            #MDL sha1pass - Create a password hash. Usage: sha1pass [PASSWORD][SALT]
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Downloader-Checksum Applications Menu"
            DELIMITER="#MDL" #MDL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Dowloader Applications case statement.
                 1 | [Aa] | [Aa][Rr] | [Aa][Rr][Ii] | [Aa][Rr][Ii][Aa] | [Aa][Rr][Ii][Aa][2])
                 APP_NAME="aria2"
                 f_application_run
                 ;;
                 aria2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Mm][ | [Mm][Dd] | [Mm][Dd][5] | [Mm][Dd][5][Ss] | [Mm][Dd][5][Ss][Uu] | [Mm][Dd][5][Ss][Uu][Mm])
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
                 md5sum' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Dd] | [Mm][Dd][5] | [Mm][Dd][5][Pp] | [Mm][Dd][5][Pp][Aa] | [Mm][Dd][5][Pp][Aa][Ss] | [Mm][Dd][5][Pp][Aa][Ss][Ss])
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
                 md5pass' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Hh] | [Ss][Hh][Aa] | [Ss][Hh][Aa][1] | [Ss][Hh][Aa][1][Ss] | [Ss][Hh][Aa][1][Ss][Uu] | [Ss][Hh][Aa][1][Ss][Uu][Mm])
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
                 sha1sum' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ss] | [Ss][Hh] | [Ss][Hh][Aa] | [Ss][Hh][Aa][1] | [Ss][Hh][Aa][1][Pp] | [Ss][Hh][Aa][1][Pp][Aa] | [Ss][Hh][Aa][1][Pp][Aa][Ss] | [Ss][Hh][Aa][1][Pp][Aa][Ss][Ss])
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
                 sha1pass' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of E-mail Applications case statement.
                 1 | [Aa] | [Aa][Ll] | [Aa][Ll][Pp] | [Aa][Ll][Pp][Ii] | [Aa][Ll][Pp][Ii][Nn] | [Aa][Ll][Pp][Ii][Nn][Ee])
                 APP_NAME="alpine"
                 f_application_run
                 ;;
                 alpine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Ee])
                 APP_NAME="cone"
                 f_application_run
                 ;;
                 cone' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3  | [Ee] | [Ee][Ll] | [Ee][Ll][Mm] | [Ee][Ll][Mm][Oo])
                 APP_NAME="elmo"
                 f_application_run
                 ;;
                 elmo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Ee] | [Ff][Ee][Tt] | [Ff][Ee][Tt][Cc] | [Ff][Ee][Tt][Cc][Hh] | [Ff][Ee][Tt][Cc][Hh][Yy] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh][Oo] | [Ff][Ee][Tt][Cc][Hh][Yy][Aa][Hh][Oo][Oo])
                 APP_NAME="fetchyahoo"
                 f_application_run
                 ;;
                 fetchyahoo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5  | [Gg]  | [Gg][Nn]  | [Gg][Nn][Uu]  | [Gg][Nn][Uu][Ss])
                 APP_NAME="gnus"
                 f_application_run
                 ;;
                 gnus' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Hh] | [Hh][Ee] | [Hh][Ee][Ii] | [Hh][Ee][Ii][Rr] | [Hh][Ee][Ii][Rr][Ll] | [Hh][Ee][Ii][Rr][Ll][Oo] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-][Mm] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-][Mm][Aa] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-][Mm][Aa][Ii] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-][Mm][Aa][Ii][Ll] | [Hh][Ee][Ii][Rr][Ll][Oo][Oo][Mm][-][Mm][Aa][Ii][Ll][Xx])
                 APP_NAME="heirloom-mailx"
                 f_application_run
                 ;;
                 heirloom-mailx' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Mm] | [Mm][4] | [Mm][Uu][4] | [Mm][Uu][4][Ee])
                 APP_NAME="mu4e"
                 f_application_run
                 ;;
                 mu4e' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Uu] | [Mm][Uu][Tt] | [Mm][Uu][Tt][Tt])
                 APP_NAME="mutt"
                 f_application_run
                 ;;
                 mutt' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Nn] | [Nn][Ee] | [Nn][Ee][Dd] | [Nn][Ee][Dd][Mm] | [Nn][Ee][Dd][Mm][Aa] | [Nn][Ee][Dd][Mm][Aa][Ii] | [Nn][Ee][Dd][Mm][Aa][Ii][Ll])
                 APP_NAME="nedmail"
                 f_application_run
                 ;;
                 nedmail' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Pp] | [Pp][Ii] | [Pp][Ii][Nn] | [Pp][Ii][Nn][Ee])
                 APP_NAME="pine"
                 f_application_run
                 ;;
                 pine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Ss] | [Ss][Uu] | [Ss][Uu][Pp] | [Ss][Uu][Pp][Pp])
                 APP_NAME="supp"
                 f_application_run
                 ;;
                 supp' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of FAX Applications case statement.
                 1  | [Ee] | [Ee][Ff] | [Ee][Ff][Aa] | [Ee][Ff][Aa][Xx])
                 APP_NAME="efax"
                 f_application_run
                 ;;
                 efax' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Yy] | [Hh][Yy][Ll] | [Hh][Yy][Ll][Aa] | [Hh][Yy][Ll][Aa][Ff] | [Hh][Yy][Ll][Aa][Ff][Aa] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee][Nn] | [Hh][Yy][Ll][Aa][Ff][Aa][Xx][-][Cc][Ll][Ii][Ee][Nn][Tt])
                 APP_NAME="hylafax-client"
                 f_application_run
                 ;;
                 hylafax-client' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            #MFT woof   - Woof (Web Offer One File) copies files through the HTTP protocol.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="File Transfer Applications Menu"
            DELIMITER="#MFT" #MFT This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of File Transfer Applications case statement.
                 1 | [Cc] | [Cc][Mm] | [Cc][Mm][Dd] | [Cc][Mm][Dd][Ff] | [Cc][Mm][Dd][Ff][Tt] | [Cc][Mm][Dd][Ff][Tt][Pp])
                 APP_NAME="cmdftp"
                 f_application_run
                 ;;
                 cmdftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Uu]  | [Cc][Uu][Rr] | [Cc][Uu][Rr][Ll])
                 APP_NAME="curl"
                 f_application_run
                 ;;
                 curl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp])
                 APP_NAME="ftp"
                 f_application_run
                 ;;
                 ftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Tt] | [Ff][Tt][Pp] | [Ff][Tt][Pp][Ff] | [Ff][Tt][Pp][Ff][Ss])
                 APP_NAME="ftpfs"
                 f_application_run
                 ;;
                 ftpfs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ll] | [Ll][Ff] | [Ll][Ff][Tt] | [Ll][Ff][Tt][Pp])
                 APP_NAME="lftp"
                 f_application_run
                 ;;
                 lftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6  | [Nn] | [Nn][Cc] | [Nn][Cc][Ff] | [Nn][Cc][Ff][Tt] | [Nn][Cc][Ff][Tt][Pp])
                 APP_NAME="ncftp"
                 f_application_run
                 ;;
                 ncftp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Cc] | [Ss][Cc][Pp])
                 APP_NAME="scp"
                 f_application_run
                 ;;
                 scp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ww] | [WW][Oo] | [Ww][Oo][Oo] | [Ww][Oo][Oo][Ff])
                 APP_NAME="woof"
                 f_application_run
                 ;;
                 woof' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Instant Messaging Applications case statement.
                 1 | [Bb] | [Bb][Aa] | [Bb][Aa][Rr] | [Bb][Aa][Rr][Nn] | [Bb][Aa][Rr][Nn][Oo] | [Bb][Aa][Rr][Nn][Oo][Ww] | [Bb][Aa][Rr][Nn][Oo][Ww][Ll])
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
                 barnowl' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Ii] | [Bb][Ii][Tt] | [Bb][Ii][Tt][Ll] | [Bb][Ii][Tt][Ll][Bb] | [Bb][Ii][Tt][Ll][Bb][Ee] | [Bb][Ii][Tt][Ll][Bb][Ee][Ee])
                 APP_NAME="bitlbee"
                 f_application_run
                 ;;
                 bitlbee' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Cc] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Cc][Qq])
                 APP_NAME="centericq"
                 f_application_run
                 ;;
                 centericq' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Cc] | [Cc][Ee] | [Cc][Ee][Nn] | [Cc][Ee][Nn][Tt] | [Cc][Ee][Nn][Tt][Ee] | [Cc][Ee][Nn][Tt][Ee][Rr] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii] | [Cc][Ee][Nn][Tt][Ee][Rr][Ii][Mm])
                 APP_NAME="centerim"
                 f_application_run
                 ;;
                 centerim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ee][Mm][Aa][Cc][Ss][-][Jj][Aa][Bb][Bb][Ee][Rr])
                 APP_NAME="emacs-jabber"
                 f_application_run
                 ;;
                 emacs-jabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Cc] | [Ff][Ii][Nn][Cc][Hh])
                 APP_NAME="finch"
                 f_application_run
                 ;;
                 finch' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ee] | [Ff][Rr][Ee][Ee][Tt] | [Ff][Rr][Ee][Ee][Tt][Aa] | [Ff][Rr][Ee][Ee][Tt][Aa][Ll] | [Ff][Rr][Ee][Ee][Tt][Aa][Ll][Kk])
                 APP_NAME="freetalk"
                 f_application_run
                 ;;
                 freetalk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Cc] | [Mm][Cc][Aa] | [Mm][Cc][Aa][Bb] | [Mm][Cc][Aa][Bb][Bb] | [Mm][Cc][Aa][Bb][Bb][Ee] | [Mm][Cc][Aa][Bb][Bb][Ee][Rr])
                 APP_NAME="mcabber"
                 f_application_run
                 ;;
                 mcabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Nn] | [Nn][Aa] | [Nn][Aa][Ii] | [Nn][Aa][Ii][Mm])
                 APP_NAME="naim"
                 f_application_run
                 ;;
                 naim' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of IRC Clients Applications case statement.
                 1 | [Ee] | [Ee][Pp] | [Ee][Pp][Ii] | [Ee][Pp][Ii][Cc])
                 APP_NAME="epic"
                 f_application_run
                 ;;
                 epic' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ee] | [Ee][Rr] | [Ee][Rr][Cc])
                 APP_NAME="erc"
                 f_application_run
                 ;;
                 erc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ii] |[Ii][Ii])
                 APP_NAME="ii"
                 f_application_run
                 ;;
                 ii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ii] | [Ii][Rr] | [Ii][Rr][Cc] | [Ii][Rr][Cc][Ii] | [Ii][Rr][Cc][Ii][Ii])
                 APP_NAME="ircii"
                 f_application_run
                 ;;
                 ircii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ii] | [Ii][Rr] | [Ii][Rr][Ss] | [Ii][Rr][Ss][Ss] | [Ii][Rr][Ss][Ss][Ii])
                 APP_NAME="irssi"
                 f_application_run
                 ;;
                 irssi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Pp] | [Pp][Oo] | [Pp][Oo][Rr] | [Pp][Oo][Rr][Kk])
                 APP_NAME="pork"
                 f_application_run
                 ;;
                 pork' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Oo] | [Ss][Cc][Rr][Oo][Ll] | [Ss][Cc][Rr][Oo][Ll][Ll] | [Ss][Cc][Rr][Oo][Ll][Ll][Zz])
                 APP_NAME="scrollz"
                 f_application_run
                 ;;
                 scrollz' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ss] | [Ss][Ii] | [Ss][Ii][Cc])
                 APP_NAME="sic"
                 f_application_run
                 ;;
                 sic' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_news_readers () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of RSS Feeder Applications until loop.
            #MNR gnus - News reader and E-mail client for Emacs..
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of News Reader Applications case statement.
                 1 | [Gg] | [Gg][Nn] | [Gg][Nn][Uu] | [Gg][Nn][Uu][Ss])
                 APP_NAME="gnus"
                 f_application_run
                 ;;
                 gnus' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Nn] | [Nn][Nn]) 
                 APP_NAME="nn"
                 f_application_run
                 ;;
                 nn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Rr] | [Rr][Nn])
                 APP_NAME="rn"
                 f_application_run
                 ;;
                 rn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4  | [Ss] | [Ss][Ll] | [Ss][Ll][Rr] | [Ss][Ll][Rr][Nn]) 
                 APP_NAME="slrn"
                 f_application_run
                 ;;
                 slrn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Tt] | [Tt][Ii] | [Tt][Ii][Nn])
                 APP_NAME="tin"
                 f_application_run
                 ;;
                 tin' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Tt] | [Tt][Rr] | [Tt][Rr][Nn])
                 APP_NAME="trn"
                 f_application_run
                 ;;
                 trn' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of LAN Chat Applications case statement.
                 1 | [Tt] | [Tt][Aa] | [Tt][Aa][Ll] | [Tt][Aa][Ll][Kk])
                 APP_NAME="talk"
                 f_application_run
                 ;;
                 talk' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ww] | [Ww][Ee] | [Ww][Ee][Ee] | [Ww][Ee][Ee][Cc] | [Ww][Ee][Ee][Cc][Hh] | [Ww][Ee][Ee][Cc][Hh][Aa] | [Ww][Ee][Ee][Cc][Hh][Aa][Tt])
                 APP_NAME="weechat"
                 f_application_run
                 ;;
                 weechat' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Yy] | [Yy][Tt] | [Yy][Tt][Aa] | [Yy][Tt][Aa][Ll] | [Yy][Tt][Aa][Ll][Kk])
                 APP_NAME="ytalk"
                 f_application_run
                 ;;
                 ytalk' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Podcatcher Applications case statement.
                 1 | [Bb] | [Bb][Aa]| [Bb][Aa][Ss] | [Bb][Aa][Ss][Hh] | [Bb][Aa][Ss][Hh][Pp] | [Bb][Aa][Ss][Hh][Pp[Oo]  | [Bb][Aa][Ss][Hh][Pp[Oo][Dd] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd][Ee] | [Bb][Aa][Ss][Hh][Pp[Oo][Dd][Dd][Ee][Rr])
                 APP_NAME="bashpodder"
                 f_application_run
                 ;;
                 bashpodder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Oo] | [Gg][Oo][Ll] | [Gg][Oo][Ll][Dd] | [Gg][Oo][Ll][Dd][Ee] | [Gg][Oo][Ll][Dd][Ee][Nn] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp][Oo] | [Gg][Oo][Ll][Dd][Ee][Nn][Pp][Oo][Dd])
                 APP_NAME="goldenpod"
                 f_application_run
                 ;;
                 goldenpod' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Hh] | [Hh][Pp] | [Hh][Pp][Oo] | [Hh][Pp][Oo][Dd] | [Hh][Pp][Oo][Dd][Dd] | [Hh][Pp][Oo][Dd][Dd][Ee] | [Hh][Pp][Oo][Dd][Dd][Ee][Rr])
                 APP_NAME="hpodder"
                 f_application_run
                 ;;
                 hpodder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Gg] | [Pp][Oo][Dd][Gg][Ee] | [Pp][Oo][Dd][Gg][Ee][Tt])
                 APP_NAME="podget"
                 f_application_run
                 ;;
                 podget' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Oo] | [Pp][Oo][Dd] | [Pp][Oo][Dd][Rr] | [Pp][Oo][Dd][Rr][Aa] | [Pp][Oo][Dd][Rr][Aa][Cc] | [Pp][Oo][Dd][Rr][Aa][Cc][Ee] | [Pp][Oo][Dd][Rr][Aa][Cc][Ee][Rr])
                 APP_NAME="podracer"
                 f_application_run
                 ;;
                 podracer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Uu] | [Uu][Rr] | [Uu][Rr][Aa] | [Uu][Rr][Aa][Nn] | [Uu][Rr][Aa][Nn][Ii] | [Uu][Rr][Aa][Nn][Ii][Aa] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa][Ss] | [Uu][Rr][Aa][Nn][Ii][Aa][Cc][Aa][Ss][Tt])
                 APP_NAME="uraniacast"
                 f_application_run
                 ;;
                 uraniacast' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Remote Connection Applications case statement.
                 1 | [Cc] | [Cc][Pp] | [Cc][Pp][Uu])
                 APP_NAME="cpu"
                 f_application_run
                 ;;
                 cpu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Oo] | [Oo][Pp] | [Oo][Pp][Ee] | [Oo][Pp][Ee][Nn] | [Oo][Pp][Ee][Nn][Ss] | [Oo][Pp][Ee][Nn][Ss][Ss] | [Oo][Pp][Ee][Nn][Ss][Ss][Hh])
                 APP_NAME="openssh"
                 f_application_run
                 ;;
                 openssh' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Ss] | [Ss][Ss][Hh])
                 APP_NAME="ssh"
                 f_application_run
                 ;;
                 ssh' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Ss] | [Ss][Ss][Ll] | [Ss][Ss][Ll][Hh])
                 APP_NAME="sslh"
                 f_application_run
                 ;;
                 sslh' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of RSS Feeder Applications case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Nn] | [Cc][Aa][Nn][Tt] | [Cc][Aa][Nn][Tt][Oo])
                 APP_NAME="canto"
                 f_application_run
                 ;;
                 canto' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Nn] | [Nn][Ee] | [Nn][Ee][Ww] | [Nn][Ee][Ww][Ss] | [Nn][Ee][Ww][Ss][Bb] | [Nn][Ee][Ww][Ss][Bb][Ee] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt][Ee] | [Nn][Ee][Ww][Ss][Bb][Ee][Uu][Tt][Ee][Rr])
                 APP_NAME="newsbeuter"
                 f_application_run
                 ;;
                 newsbeuter' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Nn] | [Nn][Rr] | [Nn][Rr][Ss] | [Nn][Rr][Ss][Ss])
                 APP_NAME="nrss"
                 f_application_run
                 ;;
                 nrss' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Oo] | [Oo][Ll] | [Oo][Ll][Ii] | [Oo][Ll][Ii][Vv] | [Oo][Ll][Ii][Vv][Ee])
                 APP_NAME="olive"
                 f_application_run
                 ;;
                 olive' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Rr] | [Rr][Aa] | [Rr][Aa][Gg] | [Rr][Aa][Gg][Gg] | [Rr][Aa][Gg][Gg][Ll] | [Rr][Aa][Gg][Gg][Ll][Ee])
                 APP_NAME="raggle"
                 f_application_run
                 ;;
                 raggle' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Rr] | [Rr][Aa] | [Rr][Aa][Ww] | [Rr][Aa][Ww][Dd] | [Rr][Aa][Ww][Dd][Oo] | [Rr][Aa][Ww][Dd][Oo][Gg])
                 APP_NAME="rawdog"
                 f_application_run
                 ;;
                 rawdog' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Rr] | [Rr][Ss] | [Rr][Ss][Ss]  | [Rr][Ss][Ss][Tt]  | [Rr][Ss][Ss][Tt][Aa]  | [Rr][Ss][Ss][Tt][Aa][Ii]  | [Rr][Ss][Ss][Tt][Aa][Ii][Ll])
                 APP_NAME="rsstail"
                 f_application_run
                 ;;
                 rsstail' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ss] | [Ss][Nn] | [Ss][Nn][Oo] | [Ss][Nn][Oo][Ww] | [Ss][Nn][Oo][Ww][Nn] | [Ss][Nn][Oo][Ww][Nn][Ee] | [Ss][Nn][Oo][Ww][Nn][Ee][Ww] | [Ss][Nn][Oo][Ww][Nn][Ee][Ww][Ss])
                 APP_NAME="snownews"
                 f_application_run
                 ;;
                 snownews' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_network () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of Network Application Category until loop.
            #BNE Firewalls    - Configure firewalls.
            #BNE LAN-WAN      - Test network connectivity, speed, routing.
            #BNE NIC Tools    - Configure wired/wireless cards, scan for wireless networks.
            #BNE Sharing      - Share files on NetWare & Microsoft Windows PCs/networks.
            #BNE Monitors     - LAN monitors, network mappers.
            #BNE Packet Tools - Packet sniffers, packet analyzers.
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
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Network Application Category case statement.
                 1 | [Ff] | [Ff][Ii] | [Ff][Ii][Rr] | [Ff][Ii][Rr][Ee] | [Ff][Ii][Rr][Ee][Ww] | [Ff][Ii][Rr][Ee][Ww][Aa] | [Ff][Ii][Rr][Ee][Ww][Aa][Ll] | [Ff][Ii][Rr][Ee][Ww][Aa][Ll][Ll] | [Ff][Ii][Rr][Ee][Ww][Aa][Ll][Ll][Ss])
                 f_menu_app_firewalls         # Firewall Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Ll] | [Ll][Aa] | [Ll][Aa][Nn] | [Ll][Aa][Nn][-] | [Ll][Aa][Nn][-][Ww] | [Ll][Aa][Nn][-][Ww][Aa] | [Ll][Aa][Nn][-][Ww][Aa][Nn])
                 f_menu_app_lanwan            # LANWAN Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Nn] | [Nn][Ii] | [Nn][Ii][Cc] | [Nn][Ii][Cc]' ' | [Nn][Ii][Cc]' '[Tt] | [Nn][Ii][Cc]' '[Tt][Oo] | [Nn][Ii][Cc]' '[Tt][Oo][Oo] | [Nn][Ii][Cc]' '[Tt][Oo][Oo][Ll] | [Nn][Ii][Cc]' '[Tt][Oo][Oo][Ll][Ss])
                 f_menu_app_nic_tools         # NIC Tools Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Ss] | [Ss][Hh] | [Ss][Hh][Aa] | [Ss][Hh][Aa][Rr] | [Ss][Hh][Aa][Rr][Ii] | [Ss][Hh][Aa][Rr][Ii][Nn] | [Ss][Hh][Aa][Rr][Ii][Nn][Gg])
                 f_menu_app_network_sharing   # Network Sharing Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Ii] | [Mm][Oo][Nn][Ii][Tt] | [Mm][Oo][Nn][Ii][Tt][Oo] | [Mm][Oo][Nn][Ii][Tt][Oo][Rr] | [Mm][Oo][Nn][Ii][Tt][Oo][Rr][Ss])
                 f_menu_app_network_monitors  # Network Monitors Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Pp] | [Pp][Aa] | [Pp][Aa][Cc] | [Pp][Aa][Cc][Kk] | [Pp][Aa][Cc][Kk][Ee] | [Pp][Aa][Cc][Kk][Ee][Tt] | [Pp][Aa][Cc][Kk][Ee][Tt]' ' | [Pp][Aa][Cc][Kk][Ee][Tt]' '[Tt] | [Pp][Aa][Cc][Kk][Ee][Tt]' '[Tt][Oo] | [Pp][Aa][Cc][Kk][Ee][Tt]' '[Tt][Oo][Oo] | [Pp][Aa][Cc][Kk][Ee][Tt]' '[Tt][Oo][Oo][Ll] | [Pp][Aa][Cc][Kk][Ee][Tt]' '[Tt][Oo][Oo][Ll][Ss])
                 f_menu_app_packet_tools      # Packet Tools Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                # End of Network Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Network Application Category until loop.
} # End of function f_menu_cat_network
#
# +----------------------------------------+
# |      Function f_menu_app_firewalls     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_firewalls () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of <Sample Template> Applications until loop.
            #MNF iptables  - Firewall configuration rules for an IP chain.
            #MNF arptables - Firewall configuration rules for an ARP chain.
            #MNF ufw       - Firewall configuration and status.
            #MNF portbunny - Port scanner created by Recurity Labs.
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Firewall Applications Menu"
            DELIMITER="#MNF" #MNF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Firewall Applications case statement.
                 1 | [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Aa] | [Ii][Pp][Tt][Aa][Bb] | [Ii][Pp][Tt][Aa][Bb][Ll] | [Ii][Pp][Tt][Aa][Bb][Ll][Ee] | [Ii][Pp][Tt][Aa][Bb][Ll][Ee][Ss])
                 APP_NAME="iptables --list"
                 clear # Blank the screen.
                 echo "Administration tool for IPv4 packet filtering and NAT."
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
                 iptables' '* | 'sudo iptables '* | 'sudo iptables')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Aa] | [Ii][Pp][Tt][Aa][Bb] | [Ii][Pp][Tt][Aa][Bb][Ll] | [Ii][Pp][Tt][Aa][Bb][Ll][Ee] | [Ii][Pp][Tt][Aa][Bb][Ll][Ee][Ss])
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
                 arptables' '* | 'sudo arptables '* | 'sudo arptables')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Uu] | [Uu][Ff] | [Uu][Ff][Ww])
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
                 ufw' '* | 'sudo ufw '* | 'sudo ufw')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Oo] | [Pp][Oo][Rr] | [Pp][Oo][Rr][Tt] | [Pp][Oo][Rr][Tt][Bb] | [Pp][Oo][Rr][Tt][Bb][Uu] | [Pp][Oo][Rr][Tt][Bb][Uu][Nn] | [Pp][Oo][Rr][Tt][Bb][Uu][Nn][Nn] | [Pp][Oo][Rr][Tt][Bb][Uu][Nn][Nn][Yy])
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
                 portbunny' '* | 'sudo portbunny '* | 'sudo portbunny')
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_lanwan () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of LAN/WAN Applications until loop.
            #MNL ip          - Shows routing, devices, policy routing and tunnels.
            #MNL ip addr     - protocol (IP or IPv6) address on a device.
            #MNL ip link     - Shows network device.
            #MNL ip neighbor - ARP or NDISC cache entry.
            #MNL ip route    - Shows routing.
            #MNL route       - Shows routing table.
            #MNL ping        - Check LAN/WAN connectivity by pinging IP address or hostname.
            #MNL arping      - Check LAN connectivity by pinging MAC, IP address or hostname.
            #MNL speedometer - Check LAN/WAN connectivity speed.
            #MNL mtr         - Traceroute tool, has features of ping and traceroute.
            #MNL traceroute  - Traceroute tool, trace network path to destination. 
            #MNL nslookup    - Query Internet domain servers.
            #MNL ss          - Show sockets, PACKET, TCP, UDP, DCCP, RAW, state filtering.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="LAN/WAN Applications Menu"
            DELIMITER="#MNL" #MNL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of LAN/WAN Applications case statement.
                 1 | [Ii] | [Ii][Pp])
                 APP_NAME="ip"
                 f_application_run
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
                 ip' '* | 'sudo ip '* | 'sudo ip')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Aa] | [Ii][Pp]' '[Aa][Dd] | [Ii][Pp]' '[Aa][Dd][Dd] | [Ii][Pp]' '[Aa][Dd][Dd][Rr])
                 APP_NAME="ip addr"
                 f_application_run
                 ;;
                 'ip addr '* | 'sudo ip addr '* | 'sudo ip addr')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Ll] | [Ii][Pp]' '[Ll][Ii] | [Ii][Pp]' '[Ll][Ii][Nn] | [Ii][Pp]' '[Ll][Ii][Nn][Kk])
                 APP_NAME="ip link"
                 f_application_run
                 ;;
                 'ip link '* | 'sudo ip link '* | 'sudo ip link')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Nn] | [Ii][Pp]' '[Nn][Ee] | [Ii][Pp]' '[Nn][Ee][Ii] | [Ii][Pp]' '[Nn][Ee][Ii][Gg] | [Ii][Pp]' '[Nn][Ee][Ii][Gg][Hh] | [Ii][Pp]' '[Nn][Ee][Ii][Gg][Hh][Bb] | [Ii][Pp]' '[Nn][Ee][Ii][Gg][Hh][Bb][Oo] | [Ii][Pp]' '[Nn][Ee][Ii][Gg][Hh][Bb][Oo][Rr])
                 APP_NAME="ip neighbor"
                 f_application_run
                 ;;
                 'ip neighbor '* | 'sudo ip neighbor '* | 'sudo ip neighbor')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ii] | [Ii][Pp] | [Ii][Pp]' ' | [Ii][Pp]' '[Rr] | [Ii][Pp]' '[Rr][Oo] | [Ii][Pp]' '[Rr][Oo][Uu] | [Ii][Pp]' '[Rr][Oo][Uu][Tt] | [Ii][Pp]' '[Rr][Oo][Uu][Tt][Ee])
                 APP_NAME="ip route"
                 f_application_run
                 ;;
                 'ip route '* | 'sudo ip route '* | 'sudo ip route')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Rr] | [Rr][Oo] | [Rr][Oo][Uu] | [Rr][Oo][Uu][Tt] | [Rr][Oo][Uu][Tt][Ee])
                 APP_NAME="route"
                 f_application_run
                 ;;
                 route' '* | 'sudo route '* | 'sudo route')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Ii] | [Pp][Ii][Nn] | [Pp][Ii][Nn] | [Pp][Ii][Nn][Gg])
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
                 'sudo ping')
                 APP_NAME="sudo ping localhost -c 5"
                 f_application_run
                 ;;
                 ping' '* | 'sudo ping '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Ii] | [Aa][Rr][Pp][Ii][Nn] | [Aa][Rr][Pp][Ii][Nn][Gg])
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
                 echo "Pinging this PC (localhost) for 5 times as an example."
                 echo
                 echo "Now run ping. Usage: ping localhost -c 5"
                 echo
                 echo "Many web sites block pings resulting in a message: '100% packet loss'."
                 f_press_enter_key_to_continue
                 f_application_run
                 ;;
                 'sudo arping')
                 APP_NAME="sudo arping localhost -c 5"
                 f_application_run
                 ;;
                 arping' '* | 'sudo arping '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ss] | [Ss][Pp] | [Ss][Pp][Ee] | [Ss][Pp][Ee][Ee] | [Ss][Pp][Ee][Ee][Dd] | [Ss][Pp][Ee][Ee][Dd][Oo] | [Ss][Pp][Ee][Ee][Dd][Oo][Mm] | [Ss][Pp][Ee][Ee][Dd][Oo][Mm][Ee] | [Ss][Pp][Ee][Ee][Dd][Oo][Mm][Ee][Tt] | [Ss][Pp][Ee][Ee][Dd][Oo][Mm][Ee][Tt][Ee] | [Ss][Pp][Ee][Ee][Dd][Oo][Mm][Ee][Tt][Ee][Rr])
                 APP_NAME="speedometer"
                 f_application_run
                 ;;
                 speedometer' '* | 'sudo speedometer '* | 'sudo speedometer')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Mm] | [Mm][Tt] | [Mm][Tt][Rr])
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
                 mtr' '* | 'sudo mtr '* | 'sudo mtr')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Tt] | [Tt][Rr] | [Tt][Rr][Aa] | [Tt][Rr][Aa][Cc] | [Tt][Rr][Aa][Cc][Ee] | [Tt][Rr][Aa][Cc][Ee][Rr] | [Tt][Rr][Aa][Cc][Ee][Rr][Oo] | [Tt][Rr][Aa][Cc][Ee][Rr][Oo][Uu] | [Tt][Rr][Aa][Cc][Ee][Rr][Oo][Uu][Tt] | [Tt][Rr][Aa][Cc][Ee][Rr][Oo][Uu][Tt][Ee] | [Tt][Rr][Aa][Cc][Ee][Rr][Oo][Uu][Tt][Ee])
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
                 12 | [Nn] | [Nn][Ss] | [Nn][Ss][Ll] | [Nn][Ss][Ll][Oo] | [Nn][Ss][Ll][Oo][Oo] | [Nn][Ss][Ll][Oo][Oo][Kk] | [Nn][Ss][Ll][Oo][Oo][Kk][Uu] | [Nn][Ss][Ll][Oo][Oo][Kk][Uu][Pp])
                 APP_NAME="nslookup"
                 f_web_site
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
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
                 13 | [Ss] | [Ss][Ss])
                 APP_NAME="ss"
                 f_application_run
                 ;;
                 ss' '* | 'sudo ss '* | 'sudo ss')
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_nic_tools () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of <Sample Template> Applications until loop.
            #MNN ifconfig     - NIC configuration.
            #MNN ethtool      - NIC configuration.
            #MNN mii-tool     - NIC configuration of Media Independent Interface Unit.
            #MNN mii-diag     - NIC configuration of network cards.
            #MNN nictools-pci - NIC configuration of specific oem network cards.
            #MNN wicd-curses  - Wireless scan and connect to wired/wireless networks.
            #MNN iwconfig     - Wireless NIC configuration.
            #MNN ifplugstatus - Wireless USB NIC status.
            #MNN iwlist       - Get detailed information from wired/wireless interface.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="NIC Tools Applications Menu"
            DELIMITER="#MNN" #MNN This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of NIC Tools Applications case statement.
                 1 | [Ii] | [Ii][Ff] | [Ii][Ff][Cc] | [Ii][Ff][Cc][Oo] | [Ii][Ff][Cc][Oo][Nn] | [Ii][Ff][Cc][Oo][Nn][Ff] | [Ii][Ff][Cc][Oo][Nn][Ff][Ii] | [Ii][Ff][Cc][Oo][Nn][Ff][Ii][Gg])
                 APP_NAME="ifconfig"
                 f_application_run
                 ;;
                 ifconfig' '* | 'sudo ifconfig '* | 'sudo ifconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ee] | [Ee][Tt] | [Ee][Tt][Hh] | [Ee][Tt][Hh][Tt] | [Ee][Tt][Hh][Tt][Oo] | [Ee][Tt][Hh][Tt][Oo][Oo] | [Ee][Tt][Hh][Tt][Oo][Oo] | [Ee][Tt][Hh][Tt][Oo][Oo][Ll])
                 APP_NAME="ethtool"
                 f_application_run
                 ;;
                 ethtool' '* | 'sudo ethtool '* | 'sudo ethtool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Mm] | [Mm][Ii] | [Mm][Ii][Ii] | [Mm][Ii][Ii][-] | [Mm][Ii][Ii][-][Tt] | [Mm][Ii][Ii][-][Tt][Oo] | [Mm][Ii][Ii][-][Tt][Oo][Oo] | [Mm][Ii][Ii][-][Tt][Oo][Oo][Ll])
                 APP_NAME="mii-tool"
                 f_application_run
                 ;;
                 mii-tool' '* | 'sudo mii-tool '* | 'sudo mii-tool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Mm] | [Mm][Ii] | [Mm][Ii][Ii] | [Mm][Ii][Ii][-] | [Mm][Ii][Ii][-][Dd] | [Mm][Ii][Ii][-][Dd][Ii] | [Mm][Ii][Ii][-][Dd][Ii][Aa] | [Mm][Ii][Ii][-][Dd][Ii][Aa][Gg])
                 APP_NAME="mii-diag"
                 f_application_run
                 ;;
                 mii-diag' '* | 'sudo mii-diag '* | 'sudo mii-diag')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Nn] | [Nn][Ii] | [Nn][Ii][Cc] | [Nn][Ii][Cc][Tt] | [Nn][Ii][Cc][Tt][Oo] | [Nn][Ii][Cc][Tt][Oo][Oo] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll][Ss] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll][Ss][-] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll][Ss][-][Pp] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll][Ss][-][Pp][Cc] | [Nn][Ii][Cc][Tt][Oo][Oo][Ll][Ss][-][Pp][Cc][Ii])
                 APP_NAME="nictools-pci"
                 f_application_run
                 ;;
                 nictools-pci' '* | 'sudo nictools-pci '* | 'sudo nictools-pci')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ww] | [Ww][Ii] | [Ww][Ii][Cc] | [Ww][Ii][Cc][Dd] | [Ww][Ii][Cc][Dd][-] | [Ww][Ii][Cc][Dd][-][Cc] | [Ww][Ii][Cc][Dd][-][Cc][Uu] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss][Ee] | [Ww][Ii][Cc][Dd][-][Cc][Uu][Rr][Ss][Ee][Ss])
                 APP_NAME="wicd-curses"
                 f_application_run
                 ;;
                 wicd-curses' '* | 'sudo wicd-curses '* | 'sudo wicd-curses')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ii] | [Ii][Ww] | [Ii][Ww][Cc] | [Ii][Ww][Cc][Oo] | [Ii][Ww][Cc][Oo][Nn] | [Ii][Ww][Cc][Oo][Nn][Ff] | [Ii][Ww][Cc][Oo][Nn][Ff][Ii] | [Ii][Ww][Cc][Oo][Nn][Ff][Ii][Gg])
                 APP_NAME="iwconfig"
                 f_application_run
                 ;;
                 iwconfig' '* | 'sudo iwconfig '* | 'sudo iwconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ii] | [Ii][Ff] | [Ii][Ff][Pp] | [Ii][Ff][Pp][Ll] | [Ii][Ff][Pp][Ll][Uu] | [Ii][Ff][Pp][Ll][Uu][Gg] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss][Tt] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss][Tt][Aa] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss][Tt][Aa][Tt] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss][Tt][Aa][Tt][Uu] | [Ii][Ff][Pp][Ll][Uu][Gg][Ss][Tt][Aa][Tt][Uu][Ss])
                 APP_NAME="ifplugstatus"
                 f_application_run
                 ;;
                 ifplugstatus' '* | 'sudo ifplugstatus '* | 'sudo ifplugstatus')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ii] | [Ii][Ww] | [Ii][Ww][Ll] | [Ii][Ww][Ll][Ii] | [Ii][Ww][Ll][Ii][Ss] | [Ii][Ww][Ll][Ii][Ss][Tt])
                 APP_NAME="iwlist"
                 f_application_run
                 ;;
                 iwlist' '* | 'sudo iwlist '* | 'sudo iwlist')
                 APP_NAME=$CHOICE_APP
                 f_application_run
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            #MNS woof      - Woof (Web Offer One File) copies files through the HTTP protocol.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Sharing Applications Menu"
            DELIMITER="#MNS" #MNS This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Network Sharing Applications case statement.
                 1 | [Nn] | [Nn][Cc] | [Nn][Cc][Pp] | [Nn][Cc][Pp][Ff] | [Nn][Cc][Pp][Ff][Ss])
                 APP_NAME="ncpfs"
                 f_application_run
                 ;;
                 ncpfs' '* | 'sudo ncpfs '* | 'sudo ncpfs')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc])
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
                 smbc' '* | 'sudo smbc '* | 'sudo smbc')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ss][Mm][Bb] | [Ss][Mm][Bb][Cc] | [Ss][Mm][Bb][Cc][Ll] | [Ss][Mm][Bb][Cc][Ll][Ii] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee][Nn] | [Ss][Mm][Bb][Cc][Ll][Ii][Ee][Nn][Tt])
                 APP_NAME="smbclient"
                 f_application_run
                 ;;
                 smbclient' '* | 'sudo smbclient '* | 'sudo smbclient')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Mm] | [Ss][Mm][Bb] | [Ss][Mm][Bb][Ss] | [Ss][Mm][Bb][Ss][Tt] | [Ss][Mm][Bb][Ss][Tt][Aa] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt][Uu] | [Ss][Mm][Bb][Ss][Tt][Aa][Tt][Uu][Ss])
                 APP_NAME="smbstatus"
                 f_application_run
                 ;;
                 smbstatus' '* | 'sudo smbstatus '* | 'sudo smbstatus')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Tt] | [Tt][Ee] | [Tt][Ee][Ss] | [Tt][Ee][Ss][Tt] | [Tt][Ee][Ss][Tt][Pp] | [Tt][Ee][Ss][Tt][Pp][Aa] | [Tt][Ee][Ss][Tt][Pp][Aa][Rr] | [Tt][Ee][Ss][Tt][Pp][Aa][Rr][Mm])
                 APP_NAME="testparm"
                 f_application_run
                 ;;
                 testparm' '* | 'sudo testparm '* | 'sudo testparm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ww] | [WW][Oo] | [Ww][Oo][Oo] | [Ww][Oo][Oo][Ff])
                 APP_NAME="woof"
                 f_application_run
                 ;;
                 woof' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Network Sharing Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Network Sharing Applications until loop.
} # End of function f_menu_app_network_sharing
#
# +----------------------------------------+
# |Function f_menu_app_network_monitors    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_network_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Network Monitor Applications until loop.
            #MNM bmon    - Bandwidth monitor and rate estimator.
            #MNM cbm     - Color Bandwidth Meter, ncurses based display.
            #MNM ifstat  - Bandwidth statistics. (See also dstat, System Monitors Menu).
            #MNM iftop   - Bandwidth statistics.
            #MNM jnettop - Bandwidth statistics across streams.
            #MNM nethogs - Bandwidth statistics by process.
            #MNM ntop    - Display network usage and status information in a web browser.
            #MNM iptraf  - IP LAN monitor, ncurses based display.
            #MNM pmacct  - Traffic information monitor.
            #MNM vnstat  - Traffic information monitor.
            #MNM nagios3 - IP LAN monitor. Display network hosts, devices, connections.
            #MNM sntop   - IP LAN monitor. Display network hosts and connections.
            #MNM opennms - Network management application. Discovery, reports, statistics.
            #MNM slurm   - Network interface I/O load monitor.
            #MNM nc      - Netcat reads/writes data across network.
            #MNM netstat - Print network connections, routing tables, interface stats, etc.
            #MNM ss      - Show sockets, PACKET, TCP, UDP, DCCP, RAW, state filtering.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Network Monitor Applications Menu"
            DELIMITER="#MNM" #MNM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Network Monitor Applications case statement.
                 1 | [Bb] | [Bb][Mm] | [Bb][Mm][Oo] | [Bb][Mm][Oo][Nn])
                 APP_NAME="bmon"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 bmon' '* | 'sudo bmon '* | 'sudo bmon')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 2 | [Cc] | [Cc][Bb] | [Cc][Bb][Mm])
                 APP_NAME="cbm"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 cbm' '* | 'sudo cbm '* | 'sudo cbm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 3 | [Ii] | [Ii][Ff] | [Ii][Ff][Ss] | [Ii][Ff][Ss][Tt] | [Ii][Ff][Ss][Tt][Aa] | [Ii][Ff][Ss][Tt][Aa][Tt])
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
                 ifstat' '* | 'sudo ifstat '* | 'sudo ifstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ii] | [Ii][Ff] | [Ii][Ff][Tt] | [Ii][Ff][Tt][Oo] | [Ii][Ff][Tt][Oo][Pp])
                 APP_NAME="iftop"
                 f_find_NIC
                 APP_NAME="iftop -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 iftop' '* | 'sudo iftop '* | 'sudo iftop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 5 | [Jj] | [Jj][Nn] | [Jj][Nn][Ee] | [Jj][Nn][Ee][Tt] | [Jj][Nn][Ee][Tt][Tt] | [Jj][Nn][Ee][Tt][Tt][Oo] | [Jj][Nn][Ee][Tt][Tt][Oo][Pp])
                 APP_NAME="jnettop"
                 f_find_NIC
                 APP_NAME="jnettop -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=1 # Do not display "Press 'Enter' key to continue."
                 ;;
                 jnettop' '* | 'sudo jnettop '* | 'sudo jnettop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 6 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Hh] | [Nn][Ee][Tt][Hh][Oo] | [Nn][Ee][Tt][Hh][Oo][Gg] | [Nn][Ee][Tt][Hh][Oo][Gg][Ss])
                 APP_NAME="nethogs"
                 f_application_run
                 ;;
                 nethogs' '* | 'sudo nethogs '* | 'sudo nethogs')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Nn] | [Nn][Tt] | [Nn][Tt][Oo] | [Nn][Tt][Oo][Pp])
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
                 8 | [Ii] | [Ii][Pp] | [Ii][Pp][Tt] | [Ii][Pp][Tt][Rr] | [Ii][Pp][Tt][Rr][Aa] | [Ii][Pp][Tt][Rr][Aa][Ff])
                 APP_NAME="iptraf"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 iptraf' '* | 'sudo iptraf '* | 'sudo iptraf')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 9 | [Pp] | [Pp][Mm] | [Pp][MM][Aa] | [Pp][MM][Aa][Cc] | [Pp][MM][Aa][Cc][Cc] | [Pp][MM][Aa][Cc][Cc][Tt])
                 APP_NAME="pmacct"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 pmacct' '* | 'sudo pmacct '* | 'sudo pmacct')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 10 | [Vv] | [Vv][Nn] | [Vv][Nn][Ss] | [Vv][Nn][Ss][Tt] | [Vv][Nn][Ss][Tt][Aa] | [Vv][Nn][Ss][Tt][Aa][Tt])
                 APP_NAME="vnstat"
                 f_application_run
                 ;;
                 vnstat' '* | 'sudo vnstat '* | 'sudo vnstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Nn] | [Nn][Aa] | [Nn][Aa][Gg] | [Nn][Aa][Gg][Ii] | [Nn][Aa][Gg][Ii][Oo] | [Nn][Aa][Gg][Ii][Oo][Ss] | [Nn][Aa][Gg][Ii][Oo][Ss][3])
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
                 nagios3' '* | 'sudo nagios3 '* | 'sudo nagios3')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Ss] | [Ss][Nn] | [Ss][Nn][Tt] | [Ss][Nn][Tt][Oo] | [Ss][Nn][Tt][Oo][Pp])
                 APP_NAME="sntop --refresh=3"
                 clear # Blank the screen.
                 echo "sntop for every 3 seconds as an example."
                 echo
                 echo "Now run sntop. Usage: sntop --refresh=3"
                 echo
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 sntop' '* | 'sudo sntop '* | 'sudo sntop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 13 | [Oo] | [Oo][Pp] | [Oo][Pp][Ee] | [Oo][Pp][Ee][Nn] | [Oo][Pp][Ee][Nn][Nn] | [Oo][Pp][Ee][Nn][Nn][Mm] | [Oo][Pp][Ee][Nn][Nn][Mm][Ss])
                 APP_NAME="opennms"
                 clear # Blank the screen.
                 echo "OpenNMS is a commercial open source application and is in the menu for"
                 echo "reference only."
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
                 14 | [Ss] | [Ss][Ll] | [Ss][Ll][Uu] | [Ss][Ll][Uu][Rr] | [Ss][Ll][Uu][Rr][Mm])
                 APP_NAME="slurm"
                 f_find_NIC
                 APP_NAME="slurm -i $ANS"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 ;;
                 slurm' '* | 'sudo slurm '* | 'sudo slurm')
                 f_how_to_quit_application "q" "no-clear"
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 15 | [Nn] | [Nn][Cc])
                 APP_NAME="nc"
                 f_application_run
                 ;;
                 nc' '* | 'sudo nc '* | 'sudo nc')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 16 | [Nn] | [Nn][Ee] | [Nn][Ee][Tt] | [Nn][Ee][Tt][Ss] | [Nn][Ee][Tt][Ss][Tt] | [Nn][Ee][Tt][Ss][Tt][Aa] | [Nn][Ee][Tt][Ss][Tt][Aa][Tt])
                 APP_NAME="netstat -l"
                 clear # Blank the screen.
                 echo "netstat - Print network connections, routing tables, interface statistics,"
                 echo "masquerade connections, and multicast memberships."
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
                 echo "traceroute of this PC (localhost) as an example."
                 echo
                 echo "Now run netstat. Usage: netstat -l"
                 f_how_to_quit_application "q" "no-clear"
                 f_application_run
                 ;;
                 netstat' '* | 'sudo netstat '* | 'sudo netstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 17 | [Ss] | [Ss][Ss])
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
                 ss' '* | 'sudo ss '* | 'sudo ss')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Network Monitor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Network Monitor Applications until loop.
} # End of function f_menu_app_network_monitors
#
# +----------------------------------------+
# |    Function f_menu_app_packet_tools    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_packet_tools () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Packet Tools Applications until loop.
            #MNP ngrep     - Network packet analyzer.
            #MNP nmap      - Network Mapper, mapping, auditing, security scanning.
            #MNP kismet    - Wireless network detector, packet sniffer, auditor.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Packet Tools Applications case statement.
                 1 | [Nn] | [Nn][Gg] | [Nn][Gg][Rr] | [Nn][Gg][Rr][Ee] | [Nn][Gg][Rr][Ee][Pp])
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
                 2 | [Nn] | [Nn][Mm] | [Nn][Mm][Aa] | [Nn][Mm][Aa][Pp])
                 APP_NAME="nmap"
                 f_application_run
                 ;;
                 nmap' '* | 'sudo nmap '* | 'sudo nmap')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Kk] | [Kk][Ii] | [Kk][Ii][Ss] | [Kk][Ii][Ss][Mm] | [Kk][Ii][Ss][Mm][Ee] | [Kk][Ii][Ss][Mm][Ee][Tt])
                 APP_NAME="kismet"
                 f_application_run
                 ;;
                 kismet' '* | 'sudo kismet '* | 'sudo kismet')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss]| [Ss][Nn] | [Ss][Nn][Oo] | [Ss][Nn][Oo][Rr] | [Ss][Nn][Oo][Rr][Tt])
                 APP_NAME="snort"
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
                 5 | [Tt] | [Tt][Cc] | [Tt][Cc][Pp] | [Tt][Cc][Pp][Dd] | [Tt][Cc][Pp][Dd][Uu] | [Tt][Cc][Pp][Dd][Uu][Mm] | [Tt][Cc][Pp][Dd][Uu][Mm][Pp])
                 APP_NAME="tcpdump"
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
                 tcpdump' '* | 'sudo tcpdump '* | 'sudo tcpdump')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ww] | [Ww][Ii] | [Ww][Ii][Rr] | [Ww][Ii][Rr][Ee] | [Ww][Ii][Rr][Ee][Ss] | [Ww][Ii][Rr][Ee][Ss][Hh] | [Ww][Ii][Rr][Ee][Ss][Hh][Aa] | [Ww][Ii][Rr][Ee][Ss][Hh][Aa][Rr] | [Ww][Ii][Rr][Ee][Ss][Hh][Aa][Rr][Kk])
                 APP_NAME="wireshark"
                 f_application_run
                 ;;
                 wireshark' '* | 'sudo wireshark '* | 'sudo wireshark')
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_office () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Office Application Category until loop.
            #BOF Accounting   - Accounting (with with double-entry).
            #BOF Calculators  - Simple "pocket" calculators.
            #BOF Calendar     - Calendars.
            #BOF Notebooks    - Write notes in a "notebook".
            #BOF PDF-PS docs  - view, edit, compare, merge pdf and ps documents.
            #BOF Presenters   - Text slideshow presentation.
            #BOF Spreadsheets - Basic spreadsheet.
            #BOF Text         - Create/Edit text files, text format converters, etc.        
            #BOF ToDo         - To-Do lists, alarm clocks.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Office Application Category Menu"
            DELIMITER="#BOF" #BOF This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of Office Application Category case statement.
                 1 | [Aa] | [Aa][Cc] | [Aa][Cc][Cc] | [Aa][Cc][Cc][Oo] | [Aa][Cc][Cc][Oo][Nn] | [Aa][Cc][Cc][Oo][Nn][Tt] | [Aa][Cc][Cc][Oo][Nn][Tt][Ii] | [Aa][Cc][Cc][Oo][Nn][Tt][Ii][Nn] | [Aa][Cc][Cc][Oo][Nn][Tt][Ii][Nn][Gg])
                 f_menu_app_accounting        # Accounting Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Cc] | [Cc][Aa][Ll][Cc][Uu] | [Cc][Aa][Ll][Cc][Uu][Ll] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt][Oo] | [Cc][Aa][Ll][Cc][Uu][Ll][Aa][Tt][Oo][Rr])
                 f_menu_app_calculators       # Calculator Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Ee] | [Cc][Aa][Ll][Ee][Nn] | [Cc][Aa][Ll][Ee][Nn][Dd] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa] | [Cc][Aa][Ll][Ee][Nn][Dd][Aa][Rr])
                 f_menu_app_calendar          # Calendar Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Nn] | [Nn][Oo] | [Nn][Oo][Tt] | [Nn][Oo][Tt][Ee] | [Nn][Oo][Tt][Ee][Bb] | [Nn][Oo][Tt][Ee][Bb][Oo] | [Nn][Oo][Tt][Ee][Bb][Oo][Oo] | [Nn][Oo][Tt][Ee][Bb][Oo][Oo][Kk])
                 f_menu_app_note              # Note Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][-] | [Pp][Dd][Ff][-][Pp] | [Pp][Dd][Ff][-][Pp][Ss] | [Pp][Dd][Ff][-][Pp][Ss]' ' | [Pp][Dd][Ff][-][Pp][Ss]' '[Dd] | [Pp][Dd][Ff][-][Pp][Ss]' '[Dd][Oo] | [Pp][Dd][Ff][-][Pp][Ss]' '[Dd][Oo][Cc] | [Pp][Dd][Ff][-][Pp][Ss]' '[Dd][Oo][Cc][Ss])
                 f_menu_app_pdfps             # PDF-PS Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Pp] | [Pp][Rr] | [Pp][Rr][Ee] | [Pp][Rr][Ee][Nn] | [Pp][Rr][Ee][Nn][Tt] | [Pp][Rr][Ee][Nn][Tt][Ee] | [Pp][Rr][Ee][Nn][Tt][Ee][Rr] | [Pp][Rr][Ee][Nn][Tt][Ee][Rr][Ss])
                 f_menu_app_presentation      # Presentation Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Ss] | [Ss][Pp] | [Ss][Pp][Rr] | [Ss][Pp][Rr][Ee] | [Ss][Pp][Rr][Ee][Aa] | [Ss][Pp][Rr][Ee][Aa][Dd] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee][Ee] | [Ss][Pp][Rr][Ee][Aa][Dd][Ss][Hh][Ee][Ee][Tt])
                 f_menu_app_spreadsheets      # Spreadsheet Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Tt] | [Tt][Ee] | [Tt][Ee][Xx] | [Tt][Ee][Xx][Tt])
                 f_menu_cat_text              # Text Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Tt] | [Tt][Oo] | [Tt][Oo][Dd] | [Tt][Oo][Dd][Oo])
                 f_menu_app_todo
                 CHOICE_SCAT=-1  # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Office Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Office Application Category until loop.
} # End of function f_menu_cat_office
#
# +----------------------------------------+
# |     Function f_menu_app_accounting     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_accounting () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Accounting Applications until loop.
            #MAA ledger        - Ledger using double-entry.
            #MAA hledger       - Same as "ledger" but using the Haskell Programming Language.
            #MAA hledger-chart - hledger pie chart generator.
            #MAA hledger-vty   - hledger n-curses style interface.
            #MAA hledger-web   - hledger web interface.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Accounting Applications Menu"
            DELIMITER="#MAA" #MAA This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calculator Applications case statement.
                 1 | [Ll] | [Ll][Ee] | [Ll][Ee][Dd] | [Ll][Ee][Dd][Gg] | [Ll][Ee][Dd][Gg][Ee] | [Ll][Ee][Dd][Gg][Ee][Rr])
                 APP_NAME="ledger"
                 f_application_run
                 ;;
                 ledger' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr])
                 APP_NAME="hledger"
                 f_application_run
                 ;;
                 hledger' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc][Hh] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc][Hh][Aa] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc][Hh][Aa][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Cc][Hh][Aa][Rr][Tt])
                 APP_NAME="hledger-chart"
                 f_application_run
                 ;;
                 hledger-chart' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Vv] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Vv][Tt] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Vv][Tt][Yy]) 
                 APP_NAME="hledger-vty"
                 f_application_run
                 ;;
                 hledger-vty' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Hh] | [Hh][Ll][Ee] | [Hh][Ll][Ee][Dd] | [Hh][Ll][Ee][Dd][Gg] | [Hh][Ll][Ee][Dd][Gg][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Ww] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Ww][Ee] | [Hh][Ll][Ee][Dd][Gg][Ee][Rr][-][Ww][Ee][Bb]) 
                 APP_NAME="hledger-web"
                 f_application_run
                 ;;
                 hledger-web' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Accounting Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Accounting Applications until loop.
} # End of f_menu_app_accounting
#
# +----------------------------------------+
# |     Function f_menu_app_calculators    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_calculators () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Calculator Applications until loop.
            #MCC bc       - Calculator.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calculator Applications case statement.
                 1 | [Bb] | [Bb][Cc])
                 APP_NAME="bc"
                 f_how_to_quit_application "quit"
                 f_application_run
                 ;;
                 bc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Oo] | [Oo][Rr] | [Oo][Rr][Pp] | [Oo][Rr][Pp][Ii] | [Oo][Rr][Pp][Ii][Ee])
                 APP_NAME="orpie"
                 f_application_run
                 ;;
                 orpie' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Aa] | [Tt][Aa][Pp] | [Tt][Aa][Pp][Ee] | [Tt][Aa][Pp][Ee][Cc] | [Tt][Aa][Pp][Ee][Cc][Aa] | [Tt][Aa][Pp][Ee][Cc][Aa][Ll] | [Tt][Aa][Pp][Ee][Cc][Aa][Ll][Cc])
                 APP_NAME="tapecalc"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 tapecalc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Calculator Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Calculator Applications until loop.
} # End of f_menu_app_calculators
#
# +----------------------------------------+
# |      Function f_menu_app_calendar      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_calendar () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Calendar Applications until loop.
            #MCA cal         - Displays a monthly calendar.
            #MCA ccal        - Calendar color.
            #MCA calcurse    - Calendar ncurses-based.
            #MCA clcal       - Calendar and appointment reminders.
            #MCA emacs-calfw - Displays a calendar view in the Emacs buffer.
            #MCA gcal        - Calendar, almost the same as cal.
            #MCA gcalcli     - Google calendar.
            #MCA mencal      - Calendar to track repeating periodic events every nn days.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Calendar Applications case statement.
                 1 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll])
                 APP_NAME="cal"
                 f_application_run
                 ;;
                 cal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Cc] | [Cc][Cc][Aa] | [Cc][Cc][Aa][Ll])
                 APP_NAME="ccal"
                 f_application_run
                 ;;
                 ccal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Cc] | [Cc][Aa] | [Cc][Aa][Ll] | [Cc][Aa][Ll][Cc] | [Cc][Aa][Ll][Cc][Uu] | [Cc][Aa][Ll][Cc][Uu][Rr] | [Cc][Aa][Ll][Cc][Uu][Rr][Ss] | [Cc][Aa][Ll][Cc][Uu][Rr][Ss][Ee])
                 APP_NAME="calcurse"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 calcurse' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Cc] | [Cc][Ll] | [Cc][Ll][Cc] | [Cc][Ll][Cc][Aa] | [Cc][Ll][Cc][Aa][Ll])
                 APP_NAME="clcal"
                 f_application_run
                 ;;
                 clcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ee][Mm][Aa][Cc][Ss][-][Cc][Aa][Ll][Ff][Ww])
                 APP_NAME="emacs-calfw"
                 f_application_run
                 ;;
                 emacs-calfw' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Gg] | [Gg][Cc] | [Gg][Cc][Aa] | [Gg][Cc][Aa][Ll])
                 APP_NAME="gcal"
                 f_application_run
                 ;;
                 gcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Gg] | [Gg][Cc] | [Gg][Cc][Aa] | [Gg][Cc][Aa][Ll] | [Gg][Cc][Aa][Ll][Cc] | [Gg][Cc][Aa][Ll][Cc][Ll] | [Gg][Cc][Aa][Ll][Cc][Ll][Ii])
                 APP_NAME="gcalcli"
                 f_application_run
                 ;;
                 gcalcli' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Ee] | [Mm][Ee][Nn] | [Mm][Ee][Nn][Cc] | [Mm][Ee][Nn][Cc][Aa] | [Mm][Ee][Nn][Cc][Aa][Ll])
                 APP_NAME="mencal"
                 f_application_run
                 ;;
                 mencal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Pp] | [Pp][Aa] | [Pp][Aa][Ll])
                 APP_NAME="pal"
                 f_application_run
                 ;;
                 pal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Pp] | [Pp][Cc][Aa] | [Pp][Cc][Aa][Ll])
                 APP_NAME="pcal"
                 f_application_run
                 ;;
                 pcal' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Pp] | [Pp][Oo] | [Pp][Oo][Mm])
                 APP_NAME="pom"
                 f_application_run
                 ;;
                 pom' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Rr] | [Rr][Ee] | [Rr][Ee][Mm] | [Rr][Ee][Mm][Ii] | [Rr][Ee][Mm][Ii][Nn] | [Rr][Ee][Mm][Ii][Nn][Dd)
                 APP_NAME="remind"
                 f_application_run
                 ;;
                 remind' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Ww] | [Ww][Hh] | [Ww][Hh][Ee] | [Ww][Hh][Ee][Nn])
                 APP_NAME="when"
                 f_application_run
                 ;;
                 when' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Ww] | [Ww][Yy] | [Ww][Yy][Rr] | [Ww][Yy][Rr][Dd])
                 APP_NAME="wyrd"
                 f_how_to_quit_application "Q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 wyrd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Calendar Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Calendar Applications until loop.
} # End of f_menu_app_calendar
#
# +----------------------------------------+
# |         Function f_menu_app_note       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Note Applications case statement.
                 1 | [Hh] | [Hh][Nn] | [Hh][Nn][Bb])
                 APP_NAME="hnb"
                 f_application_run
                 ;;
                 hnb' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Note Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Note Applications until loop.
} # End of f_menu_app_note
#
# +----------------------------------------+
# |       Function f_menu_app_pdfps       |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_pdfps () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Tool Applications until loop.
            #MPS diffpdf  - Compare pdf files.
            #MPS gs       - GhostScript, PostScript, and PDF viewer.
            #MPS fbgs     - GhostScript, PostScript, and PDF viewer.
            #MPS fbdjvu   - DjVu viewer similar to fbpdf.
            #MPS fbpdf    - Framebuffer PDF viewer based on MuPDF with Vim keybindings.
            #MPS jfbview  - Image viewer and framebuffer PDF viewer based on Imlib2.
            #MPS pdfjam   - Merge pdf files into a single file.
            #MPS pdftex   - Typesetter creates pdf files.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of PDF and PS Applications case statement.
                 1 | [Dd] | [Dd][Ii] | [Dd][Ii][Ff] | [Dd][Ii][Ff][Ff] | [Dd][Ii][Ff][Ff][Pp] | [Dd][Ii][Ff][Ff][Pp][Dd] | [Dd][Ii][Ff][Ff][Pp][Dd][Ff])
                 APP_NAME="diffpdf"
                 f_application_run
                 ;;
                 diffpdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Ss])
                 APP_NAME="gs"
                 f_application_run
                 ;;
                 gs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Bb] | [Ff][Bb][Gg] | [Ff][Bb][Gg][Ss])
                 APP_NAME="fbgs"
                 f_application_run
                 ;;
                 fbgs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ff] | [Ff][Bb] | [Ff][Bb][Dd] | [Ff][Bb][DD][Jj] | [Ff][Bb][DD][Jj][Vv] | [Ff][Bb][DD][Jj][Vv][Uu])
                 APP_NAME="fbdjvu"
                 f_application_run
                 ;;
                 fbdjvu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ff] | [Ff][Bb] | [Ff][Bb][Pp] | [Ff][Bb][Pp][DD] | [Ff][Bb][Pp][DD][Ff])
                 APP_NAME="fbpdf"
                 f_application_run
                 ;;
                 fbpdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Jj] | [Jj][Ff] | [Jj][Ff][Bb] | [Jj][Ff][Bb][Vv] | [Jj][Ff][Bb][Vv][Ii] | [Jj][Ff][Bb][Vv][Ii][Ee] | [Jj][Ff][Bb][Vv][Ii][Ee][Ww])
                 APP_NAME="jfbview"
                 f_application_run
                 ;;
                 jfbview' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Jj] | [Pp][Dd][Ff][Jj][Aa] | [Pp][Dd][Ff][Jj][Aa][Mm])
                 APP_NAME="pdfjam"
                 f_application_run
                 ;;
                 pdfjam' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Tt] | [Pp][Dd][Ff][Tt][Ee] | [Pp][Dd][Ff][Tt][Ee][Xx])
                 APP_NAME="pdftex"
                 f_application_run
                 ;;
                 pdftex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Pp] | [Pp][Dd] | [Pp][Dd][Ff] | [Pp][Dd][Ff][Tt] | [Pp][Dd][Ff][Tt][Oo] | [Pp][Dd][Ff][Tt][Oo][Pp] | [Pp][Dd][Ff][Tt][Oo][Pp][Ss])
                 APP_NAME="pdftops"
                 f_application_run
                 ;;
                 pdftops' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Pp] | [Pp][Ss] | [Pp][Ss][2] | [Pp][Ss][2][Aa] | [Pp][Ss][2][Aa][Ss] | [Pp][Ss][2][Aa][Ss][Cc] | [Pp][Ss][2][Aa][Ss][Cc][Ii] | [Pp][Ss][2][Aa][Ss][Cc][Ii][Ii])
                 APP_NAME="ps2ascii"
                 f_application_run
                 ;;
                 ps2ascii' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Pp] | [Pp][Ss] | [Pp][Ss][2] | [Pp][Ss][2][Pp] | [Pp][Ss][2][Pp][Dd] | [Pp][Ss][2][Pp][Dd][Ff])
                 APP_NAME="ps2pdf"
                 f_application_run
                 ;;
                 ps2pdf' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of PDF and PS Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of pdf-ps Applications until loop.
} # End of f_menu_app_pdfps
#
# +----------------------------------------+
# |    Function f_menu_app_presentation    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_presentation () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Presentation Applications case statement.
                 1 | [Tt] | [Tt][Pp] | [Tt][Pp][Pp])
                 APP_NAME="tpp"
                 f_application_run
                 ;;
                 tpp' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Spreadsheet Applications case statement.
                 1 | [Oo] | [Oo][Ll] | [Oo][Ll][Ee] | [Oo][Ll][Ee][Oo])
                 APP_NAME="oleo"
                 f_application_run
                 ;;
                 oleo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ss] | [Ss][Cc])
                 APP_NAME="sc"
                 f_application_run
                 ;;
                 sc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ss] | [Ss][Ll] | [Ss][Ll][Ss] | [Ss][Ll][Ss][Cc])
                 APP_NAME="slsc"
                 f_application_run
                 ;;
                 slsc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Spreadsheet Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Spreadsheet Applications until loop.} # End of menu_app_spreadsheets
} # End of f_menu_app_spreadsheets
#
# +----------------------------------------+
# |         Function f_menu_cat_text       |
# +----------------------------------------+
#
#  Inputs: None
#    Uses: CHOICE_TCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_TCAT
#
f_menu_cat_text () {
      f_initvars_menu_app
      until [ $CHOICE_TCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
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
            f_quit_tcat_menu
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_TCAT in # Start of Text Application Category case statement.
                 1 | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Aa] | [Cc][Oo][Mm][Pp][Aa][Rr] | [Cc][Oo][Mm][Pp][Aa][Rr][Ee])
                 f_menu_app_text_compare      # Text Compare Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;               
                 2 | [Cc] | [Cc][Oo] | [Cc][Oo][Nn] | [Cc][Oo][Nn][Vv] | [Cc][Oo][Nn][Vv][Ee] | [Cc][Oo][Nn][Vv][Ee][Rr] | [Cc][Oo][Nn][Vv][Ee][Rr][Tt] | [Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee] | [Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee][Rr] | [Cc][Oo][Nn][Vv][Ee][Rr][Tt][Ee][Rr][Ss])
                 f_menu_app_text_converters   # Text Converter Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Ee] | [Ee][Dd] | [Ee][Dd][Ii] | [Ee][Dd][Ii][Tt] | [Ee][Dd][Ii][Tt][Oo] | [Ee][Dd][Ii][Tt][Oo][Rr] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss])
                 f_menu_app_text_editors      # Text Editor Application Menu.
                 CHOICE_TCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Tt] | [Tt][Oo] | [Tt][Oo][Oo] | [Tt][Oo][Oo][Ll] | [Tt][Oo][Oo][Ll][Ss])
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_compare () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Compare Applications until loop.
            #MTC imediff2  - Interactive 2-way file merge.
            #MTC colordiff - Differences between two text files shown in color.
            #MTC diff      - Differences between two text files shown using <> signs.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Compare Applications case statement.
                 1 | [Ii] | [Ii][Mm] | [Ii][Mm][Ee] | [Ii][Mm][Ee][Dd] | [Ii][Mm][Ee][Dd][Ii] | [Ii][Mm][Ee][Dd][Ii][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff] | [Ii][Mm][Ee][Dd][Ii][Ff][Ff][2])
                 APP_NAME="imediff2"
                 f_application_run
                 ;;
                 imediff2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Oo] | [Cc][Oo][Ll] | [Cc][Oo][Ll][Oo] | [Cc][Oo][Ll][Oo][Rr] | [Cc][Oo][Ll][Oo][Rr][Dd] | [Cc][Oo][Ll][Oo][Rr][[Dd][Ii] | [Cc][Oo][Ll][Oo][Rr][Dd][Ii][Ff] | [Cc][Oo][Ll][Oo][Rr][Dd][Ii][Ff][Ff])
                 APP_NAME="colordiff"
                 f_application_run
                 ;;
                 colordiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [[Dd][Ii] | [Dd][Ii][Ff] | [Dd][Ii][Ff][Ff])
                 APP_NAME="diff"
                 f_application_run
                 ;;
                 diff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Vv] | [Vv][Ii] | [Vv][Ii][Mm] | [Vv][Ii][Mm][Dd] | [Vv][Ii][Mm][Dd][Ii] | [Vv][Ii][Mm][Dd][Ii][Ff] | [Vv][Ii][Mm][Dd][Ii][Ff][Ff])
                 APP_NAME="vimdiff"
                 f_application_run
                 ;;
                 vimdiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ww] | [Ww][Dd] | [Ww][Dd][Ii] | [Ww][Dd][Ii][Ff] | [Ww][Dd][Ii][Ff][Ff])
                 APP_NAME="wdiff"
                 f_application_run
                 ;;
                 wdiff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Text Compare Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Text Compare Applications until loop.
} # End of f_menu_app_text_compare
#
# +----------------------------------------+
# |   Function f_menu_app_text_converters  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Converter Applications case statement.
                 1 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Hh] | [Tt][Xx][Tt][2][Hh][Tt] | [Tt][Xx][Tt][2][Hh][Tt][Mm][Ll])
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
                 txt2html' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Mm] | [Tt][Xx][Tt][2][Mm][Aa] | [Tt][Xx][Tt][2][Mm][Aa][Nn])
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
                 txt2man' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Pp] | [Tt][Xx][Tt][2][Pp][Dd] | [Tt][Xx][Tt][2][Pp][Dd][Bb] | [Tt][Xx][Tt][2][Pp][Dd][Bb][Dd] | [Tt][Xx][Tt][2][Pp][Dd][Bb][Dd][Oo] | [Tt][Xx][Tt][2][Pp][Dd][Bb][Dd][Oo][Cc])
                 APP_NAME="man txt2pdbdoc"
                 clear # Blank the screen.
                 echo "txt2pdbdoc - Convert plain text files to (Palm Pilot Database) Doc file *.pdb."
                 echo "for PalmPilots and DocReaders. (Does anyone still have a PalmPilot?)"
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
                 txt2pdbdoc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Rr] | [Tt][Xx][Tt][2][Rr][Ee] | [Tt][Xx][Tt][2][Rr][Ee][Gg] | [Tt][Xx][Tt][2][Rr][Ee][Gg][Ee] | [Tt][Xx][Tt][2][Rr][Ee][Gg][Ee][Xx])
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
                 txt2regex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Tt] | [Tt][Xx] | [Tt][Xx][Tt] | [Tt][Xx][Tt][2] | [Tt][Xx][Tt][2][Tt] | [Tt][Xx][Tt][2][Tt][Aa] | [Tt][Xx][Tt][2][Tt][Aa][Gg] | [Tt][Xx][Tt][2][Tt][Aa][Gg][Ss])
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
                 txt2tags' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Text Converter Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Text Converter Applications until loop.
} # End of f_menu_app_text_converters
#
# +----------------------------------------+
# |     Function f_menu_app_text_editors   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_text_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Text Editor Applications until loop.
            #MTE beav  - Binary editor and viewer.
            #MTE dav   - Text editor.
            #MTE dex - Support for ctags and parsing compiler errors.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Editor Applications case statement.
                 1 | [Bb] | [Bb][Ee] | [Bb][Ee][Aa] | [Bb][Ee][Aa][Vv] | [Bb][Ee][Aa][Vv][Ee])
                 APP_NAME="beav"
                 f_application_run
                 ;;
                 beav' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Aa] | [Dd][Aa][Vv])
                 APP_NAME="dav"
                 f_how_to_quit_application "<F5>"
                 f_application_run
                 ;;
                 dav' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Ee] | [Dd][Ee][Xx])
                 APP_NAME="dex"
                 f_application_run
                 ;;
                 dex' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ee] | [Ee][Dd])
                 APP_NAME="ed"
                 f_application_run
                 ;;
                 ed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ee] | [Ee][Mm] | [Ee][Mm][Aa] | [Ee][Mm][Aa][Cc] | [Ee][Mm][Aa][Cc][Ss])
                 APP_NAME="emacs"
                 f_application_run
                 ;;
                 emacs' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Gg] | [Gg][Rr] | [Gg][Rr][Oo] | [Gg][Rr][Oo][Ff] | [Gg][Rr][Oo][Ff][Ff])
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
                 groff' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Jj] | [Jj][Ee] | [Jj][Ee][Dd])
                 APP_NAME="jed"
                 f_application_run
                 ;;
                 jed' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Jj] | [Jj][Oo] | [Jj][Oo][Ee])
                 APP_NAME="joe"
                 f_how_to_quit_application "Ctrl-k x"
                 f_application_run
                 ;;
                 joe' '*)
                 APP_NAME=$CHOICE_APP
                 f_how_to_quit_application "Ctrl-k x"
                 f_application_run
                 ;;
                 6 | [Nn] | [Nn][Aa] | [Nn][Aa][Nn] | [Nn][Aa][Nn][Oo])
                 APP_NAME="nano"
                 f_application_run
                 ;;
                 nano' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Ii] | [Pp][Ii][Cc] | [Pp][Ii][Cc][Oo])
                 APP_NAME="pico"
                 f_application_run
                 ;;
                 pico' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Vv] | [Vv][Ii])
                 APP_NAME="vi"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 vi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Vv] | [Vv][Ii] | [Vv][Ii][Mm])
                 APP_NAME="vim"
                 f_how_to_quit_application "<esc> + :q!"
                 f_application_run
                 ;;
                 vim' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Zz] | [Zz][Ii] | [Zz][Ii][Ll] | [Zz][Ii][Ll][Ee])
                 APP_NAME="zile"
                 f_application_run
                 ;;
                 zile' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Text Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Text Editor Applications until loop.
} # End of f_menu_app_text_editors
#
# +----------------------------------------+
# |     Function f_menu_app_text_tools     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Text Editor Applications case statement.
                 1 | [Aa] | [Aa][Nn] | [Aa][Nn][Tt] | [Aa][Nn][Tt][Ii] | [Aa][Nn][Tt][Ii][Ww] | [Aa][Nn][Tt][Ii][Ww][Oo] | [Aa][Nn][Tt][Ii][Ww][Oo][Rr] | [Aa][Nn][Tt][Ii][Ww][Oo][Rr][Dd])
                 APP_NAME="antiword"
                 f_application_run
                 ;;
                 antiword' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Oo] | [Dd][Oo][Cc] | [Dd][Oo][Cc][Oo] | [Dd][Oo][Cc][Oo][Nn] | [Dd][Oo][Cc][Oo][Nn][Cc] | [Dd][Oo][Cc][Oo][Nn][Cc][Ee])
                 APP_NAME="doconce"
                 f_application_run
                 ;;
                 doconce' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Text Editor Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Text Tool Applications until loop.
} # End of f_menu_app_text_tools
#
# +----------------------------------------+
# |        Function f_menu_app_todo        |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_todo () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of ToDo Applications until loop.
            #MTD doneyet          - To-Do List.
            #MTD hnb              - To-Do List and note taker, ncurses-based application.
            #MTD todo             - To-Do List hierarchical. Install package 'devtodo'.
            #MTD tudu             - To-Do List hierarchical tasks.
            #MTD yaGTD            - To-Do List based on "Getting Things Done" methodology.
            #MTD yokadi           - Project/task manager which uses SQLite.
            #MTD binary-clock     - Binary numbers 1/0 tells time.
            #MTD cclock           - Digital clock with huge numbers fills entire screen.
            #MTD clockywock       - Analog clock, ncurses-based.
            #MTD grandfatherclock - Clock chimes Big-Ben, Cuckoo, 'Close Encounters'.
            #MTD saytime          - Audio clock.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="To-Do/Clock Applications Menu"
            DELIMITER="#MTD" #MTD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of ToDo Applications case statement.
                 1 | [Dd] | [Dd][Oo] | [Dd][Oo][Nn] | [Dd][Oo][Nn][Ee] | [Dd][Oo][Nn][Ee][Yy] | [Dd][Oo][Nn][Ee][Yy][Ee] | [Dd][Oo][Nn][Ee][Yy][Ee][Tt])
                 APP_NAME="doneyet"
                 f_application_run
                 ;;
                 doneyet' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Hh] | [Hh][Nn] | [Hh][Nn][Bb])
                 APP_NAME="hnb"
                 f_application_run
                 ;;
                 hnb' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Oo] | [Tt][Oo][Dd] | [Tt][Oo][Dd][Oo])
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
                 todo' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Tt] | [Tt][Uu] | [Tt][Uu][Dd] | [Tt][Uu][Dd][Uu])
                 APP_NAME="tudu"
                 f_application_run
                 ;;
                 tudu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Yy] | [Yy][Aa] | [Yy][Aa][Gg] | [Yy][Aa][Gg][Tt] | [Yy][Aa][Gg][Tt][Dd])
                 APP_NAME="yagtd"
                 f_application_run
                 ;;
                 yagtd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Yy] | [Yy][Oo] | [Yy][Oo][Kk] | [Yy][Oo][Kk][Aa] | [Yy][Oo][Kk][Aa][Dd] | [Yy][Oo][Kk][Aa][Dd][Ii])
                 APP_NAME="yokadi"
                 f_application_run
                 ;;
                 yokadi' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Bb] | [Bb][Ii] | [Bb][Ii][Nn] | [Bb][Ii][Nn][Aa] | [Bb][Ii][Nn][Aa][Rr] | [Bb][Ii][Nn][Aa][Rr][Yy] | [Bb][Ii][Nn][Aa][Rr][Yy][-] | [Bb][Ii][Nn][Aa][Rr][Yy][-][Cc] | [Bb][Ii][Nn][Aa][Rr][Yy][-][Cc][Ll] | [Bb][Ii][Nn][Aa][Rr][Yy][-][Cc][Ll][Oo] | [Bb][Ii][Nn][Aa][Rr][Yy][-][Cc][Ll][Oo][Cc] | [Bb][Ii][Nn][Aa][Rr][Yy][-][Cc][Ll][Oo][Cc][Kk])
                 APP_NAME="binary-clock"
                 f_application_run
                 ;;
                 binary-clock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Cc] | [Cc][Cc] | [Cc][Cc][Ll] | [Cc][Cc][Ll][Oo] | [Cc][Cc][Ll][Oo][Cc] | [Cc][Cc][Ll][Oo][Cc][Kk])
                 APP_NAME="cclock"
                 f_application_run
                 ;;
                 cclock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Cc] | [Cc][Ll] | [Cc][Ll][Oo] | [Cc][Ll][Oo][Cc] | [Cc][Ll][Oo][Cc][Kk] | [Cc][Ll][Oo][Cc][Kk][Yy] | [Cc][Ll][Oo][Cc][Kk][Yy][Ww] | [Cc][Ll][Oo][Cc][Kk][Yy][Ww][Oo] | [Cc][Ll][Oo][Cc][Kk][Yy][Ww][Oo][Cc] | [Cc][Ll][Oo][Cc][Kk][Yy][Ww][Oo][Cc][Kk])
                 APP_NAME="clockywock"
                 f_application_run
                 ;;
                 clockywock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Gg] | [Gg][Rr] | [Gg][Rr][Aa] | [Gg][Rr][Aa][Nn] | [Gg][Rr][Aa][Nn][Dd] | [Gg][Rr][Aa][Nn][Dd][Ff] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr][Cc] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr][Cc][Ll] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr][Cc][Ll][Oo] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr][Cc][Ll][Oo][Cc] | [Gg][Rr][Aa][Nn][Dd][Ff][Aa][Tt][Hh][Ee][Rr][Cc][Ll][Oo][Cc][Kk])
                 APP_NAME="grandfatherclock"
                 f_application_run
                 ;;
                 grandfatherclock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Ss] | [Ss][Aa] | [Ss][Aa][Yy] | [Ss][Aa][Yy][Tt] | [Ss][Aa][Yy][Tt][Ii] | [Ss][Aa][Yy][Tt][Ii][Mm] | [Ss][Aa][Yy][Tt][Ii][Mm][Ee])
                 APP_NAME="saytime"
                 f_application_run
                 ;;
                 saytime' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of ToDo Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of ToDo Applications until loop.
} # End of f_menu_app_todo
#
# +----------------------------------------+
# |    Function f_menu_app_screen_savers   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Screen-saver Applications case statement.
                 1 | [Aa] | [Aa][Ss] | [Aa][Ss][Cc] | [Aa][Ss][Cc][Ii] | [Aa][Ss][Cc][Ii][Ii] | [Aa][Ss][Cc][Ii][Ii][Aa] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu][Aa] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu][Aa][Rr] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu][Aa][Rr][Ii] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu][Aa][Rr][Ii][Uu] | [Aa][Ss][Cc][Ii][Ii][Aa][Qq][Uu][Aa][Rr][Ii][Uu][Mm])
                 APP_NAME="asciiaquarium"
                 f_application_run
                 ;;
                 asciiaquarium' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Mm] | [Cc][Mm][Aa] | [Cc][Mm][Aa][Tt] | [Cc][Mm][Aa][Tt][Rr] | [Cc][Mm][Aa][Tt][Rr][Ii] | [Cc][Mm][Aa][Tt][Rr][Ii][Xx])
                 APP_NAME="cmatrix"
                 f_application_run
                 ;;
                 cmatrix' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Rr] | [Rr][Aa] | [Rr][Aa][Ii] | [Rr][Aa][Ii][Nn])
                 APP_NAME="rain"
                 f_application_run
                 ;;
                 rain' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Tt] | [Tt][Tt] | [Tt][Tt][Yy] | [Tt][Tt][Yy][-] | [Tt][Tt][Yy][–][Cc] | [Tt][Tt][Yy][–][Cc][Ll] | [Tt][Tt][Yy][–][Cc][Ll][Oo] | [Tt][Tt][Yy][–][Cc][Ll][Oo][Cc] | [Tt][Tt][Yy][–][Cc][Ll][Oo][Cc][Kk])
                 APP_NAME="tty-clock"
                 f_application_run
                 ;;
                 tty-clock' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ww] | [Ww][Oo] | [Ww][Oo][Rr] | [Ww][Oo][Rr][Mm] | [Ww][Oo][Rr][Mm][Ss])
                 APP_NAME="worms"
                 f_application_run
                 ;;
                 worms' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Screen-saver Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Screen-saver Applications until loop.
} # End of f_menu_app_screen_savers
#
# +----------------------------------------+
# |        Function f_menu_cat_system      |
# +----------------------------------------+
#
#  Inputs: None.
#    Uses: CHOICE_SCAT, MAX
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_system () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ]
      do    # Start of System Category until loop.
            #BSY Backup      - File Backup/archive to CD-ROM or compressed files.
            #BSY Disks       - Disk information.
            #BSY Health      - Anti-virus scanners, root-kit detectors, stress tests etc.
            #BSY Logs        - Log file viewers.
            #BSY Mainboard   - Information on PC mainboard, memory, etc.
            #BSY Monitors    - Resources, and disk I/O monitors.
            #BSY Other       - Screen capture, file compression, DOS Emulators.
            #BSY Peripherals - Information on PC peripherals, PCI devices, hard drives, etc.
            #BSY Process     - System process monitoring, killing.
            #BSY Screens     - Multiple screen sessions.
            #BSY Software    - (Un)Install and manage software packages (programs).
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
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_SCAT in # Start of System Category case statement.
                 1 | [Bb] | [Bb][Aa] | [Bb][Aa][Cc] | [Bb][Aa][Cc][Kk] | [Bb][Aa][Cc][Kk][Uu] | [Bb][Aa][Cc][Kk][Uu][Pp])
                 f_menu_app_sys_backup        # System Backup Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Dd] | [Dd][Ii] | [Dd][Ii][Ss] | [Dd][Ii][Ss][Kk] | [Dd][Ii][Ss][Kk][Ss]) 
                 f_menu_app_sys_disks         # System Disks Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 3 | [Hh] | [Hh][Ee] | [Hh][Ee][Aa] | [Hh][Ee][Aa][Ll] | [Hh][Ee][Aa][Ll][Tt] | [Hh][Ee][Aa][Ll][Tt][Hh])
                 f_menu_app_sys_health        # System Health Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 4 | [Ll] | [Ll][Oo] | [Ll][Oo][Gg] | [Ll][Oo][Gg][Ss]) 
                 f_menu_app_sys_logs          # System Logs Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 5 | [Mm] | [Mm][Aa] | [Mm][Aa][Ii] | [Mm][Aa][Ii][Nn] | [Mm][Aa][Ii][Nn][Bb] | [Mm][Aa][Ii][Nn][Bb][Oo] | [Mm][Aa][Ii][Nn][Bb][Oo][Aa] | [Mm][Aa][Ii][Nn][Bb][Oo][Aa][Rr] | [Mm][Aa][Ii][Nn][Bb][Oo][Aa][Rr][Dd])
                 f_menu_app_sys_mainboard     # System Mainboard Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 6 | [Mm] | [Mm][Oo] | [Mm][Oo][Nn] | [Mm][Oo][Nn][Ii] | [Mm][Oo][Nn][Ii][Tt]] | [Mm][Oo][Nn][Ii][Tt]][Oo] | [Mm][Oo][Nn][Ii][Tt]][Oo][Rr] | [Mm][Oo][Nn][Ii][Tt]][Oo][Rr][Ss])
                 f_menu_app_sys_monitors      # System Monitors Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 7 | [Oo] | [Oo][Tt] | [Oo][Tt][Hh] | [Oo][Tt][Hh][Ee] | [Oo][Tt][Hh][Ee][Rr]) 
                 f_menu_app_sys_other         # System Other Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 8 | [Pp] | [Pp][Ee] | [Pp][Ee][Rr] | [Pp][Ee][Rr][Ii] | [Pp][Ee][Rr][Ii][Pp] | [Pp][Ee][Rr][Ii][Pp][Hh] | [Pp][Ee][Rr][Ii][Pp][Hh][Ee] | [Pp][Ee][Rr][Ii][Pp][Hh][Ee][Rr] | [Pp][Ee][Rr][Ii][Pp][Hh][Ee][Rr][Aa] | [Pp][Ee][Rr][Ii][Pp][Hh][Ee][Rr][Aa][Ll] | [Pp][Ee][Rr][Ii][Pp][Hh][Ee][Rr][Aa][Ll][Ss])
                 f_menu_app_sys_peripherals   # System Peripherals Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 9 | [Pp] | [Pp][Rr] | [Pp][Rr][Oo] | [Pp][Rr][Oo][Cc] | [Pp][Rr][Oo][Cc][Ee] | [Pp][Rr][Oo][Cc][Ee][Ss] | [Pp][Rr][Oo][Cc][Ee][Ss][Ss])
                 f_menu_app_sys_process       # System Process Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 10 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn] | [Ss][Cc][Rr][Ee][Ee][Nn][Ss]) 
                 f_menu_app_sys_screens       # System Screens Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 11 | [Ss] | [Ss][Oo] | [Ss][Oo][Ff] | [Ss][Oo][Ff][Tt] | [Ss][Oo][Ff][Tt][Ww] | [Ss][Oo][Ff][Tt][Ww][Aa] | [Ss][Oo][Ff][Tt][Ww][Aa][Rr] | [Ss][Oo][Ff][Tt][Ww][Aa][Rr][Ee])
                 f_menu_app_sys_software      # System Software Applications Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of System Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of System Category until loop.
} # End of function f_menu_cat_system
#
# +----------------------------------------+
# |     Function f_menu_app_sys_backup     |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_backup () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Backup Applications until loop.
            #MSB atool        - Manages file archives (tar, gzip, zip etc.).
            #MSB rsync        - File backup, mirror, directories and files.
            #MSB tar          - File backup, compress files.
            #MSB p7zip        - File compress, to 7z files, 7z better than zip compression.
            #MSB gzip         - File compress, to zip files.
            #MSB gunzip       - File uncompress zip files.
            #MSB zip          - File compress files to zip files. 
            #MSB unzip        - File uncompress zip files.
            #MSB bashburn     - CD burning.
            #MSB burn         - CD burning.
            #MSB cdrecord     - CD burning.
            #MSB xorriso      - CD burning.
            #MSB mkcd         - CD burning.
            #MSB mybashburn   - CD burning.
            #MSB simpleburner - CD burning.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Backup/Archive Applications Menu"
            DELIMITER="#MSB" #MSB This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Backup Applications case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Oo] | [Aa][Tt][Oo][Oo] | [Aa][Tt][Oo][Oo][Ll])
                 APP_NAME="atool"
                 f_application_run
                 ;;
                 atool' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Rr] | [Rr][Ss] | [Rr][Ss][Yy] | [Rr][Ss][Yy][Nn] | [Rr][Ss][Yy][Nn][Cc])
                 APP_NAME="rsync"
                 f_application_run
                 ;;
                 rsync' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Tt] | [Tt][Aa] | [Tt][Aa][Rr])
                 APP_NAME="tar"
                 f_application_run
                 ;;
                 tar' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][7] | [Pp][7][Zz] | [Pp][7][Zz][Ii] | [Pp][7][Zz][Ii][Pp])
                 APP_NAME="p7zip"
                 f_application_run
                 ;;
                 p7zip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Gg] | [Gg][Zz] | [Gg][Zz][Ii] | [Gg][Zz][Ii][Pp])
                 APP_NAME="gzip"
                 f_application_run
                 ;;
                 gzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Gg] | [Gg][Uu] | [Gg][Uu][Nn] | [Gg][Uu][Nn][Zz] | [Gg][Uu][Nn][Zz][Ii] | [Gg][Uu][Nn][Zz][Ii][Pp])
                 APP_NAME="gunzip"
                 f_application_run
                 ;;
                 gunzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Zz] | [Zz][Ii] | [Zz][Ii][Pp])
                 APP_NAME="zip"
                 f_application_run
                 ;;
                 zip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Uu] | [Uu][Nn] | [Uu][Nn][Zz] | [Uu][Nn][Zz][Ii] | [Uu][Nn][Zz][Ii][Pp])
                 APP_NAME="unzip"
                 f_application_run
                 ;;
                 unzip' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Bb] | [Bb][Aa] | [Bb][Aa][Ss] | [Bb][Aa][Ss][Hh] | [Bb][Aa][Ss][Hh][Bb] | [Bb][Aa][Ss][Hh][Bb][Uu] | [Bb][Aa][Ss][Hh][Bb][Uu][Rr] | [Bb][Aa][Ss][Hh][Bb][Uu][Rr][Nn])
                 APP_NAME="bashburn"
                 f_application_run
                 ;;
                 bashburn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Bb] | [Bb][Uu] | [Bb][Uu][Rr] | [Bb][Uu][Rr][Nn])
                 APP_NAME="burn"
                 f_application_run
                 ;;
                 burn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Cc] | [Cc][Dd] | [Cc][Dd][Rr] | [Cc][Dd][Rr][Ee] | [Cc][Dd][Rr][Ee][Cc] | [Cc][Dd][Rr][Ee][Cc][Oo] | [Cc][Dd][Rr][Ee][Cc][Oo][Rr] | [Cc][Dd][Rr][Ee][Cc][Oo][Rr][Dd])
                 APP_NAME="cdrecord"
                 f_application_run
                 ;;
                 cdrecord' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Xx] | [Xx][Oo] | [Xx][Oo][Rr] | [Xx][Oo][Rr][Rr] | [Xx][Oo][Rr][Rr][Ii] | [Xx][Oo][Rr][Rr][Ii][Ss] | [Xx][Oo][Rr][Rr][Ii][Ss][Oo])
                 APP_NAME="xorriso"
                 f_application_run
                 ;;
                 xorriso' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Mm] | [Mm][Kk] | [Mm][Kk][Cc] | [Mm][Kk][Cc][Dd])
                 APP_NAME="mkcd"
                 f_application_run
                 ;;
                 mkcd' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Mm] | [Mm][Yy] | [Mm][Yy][Bb] | [Mm][Yy][Bb][Aa] | [Mm][Yy][Bb][Aa][Ss] | [Mm][Yy][Bb][Aa][Ss][Hh] | [Mm][Yy][Bb][Aa][Ss][Hh][Bb] | [Mm][Yy][Bb][Aa][Ss][Hh][Bb][Uu] | [Mm][Yy][Bb][Aa][Ss][Hh][Bb][Uu][Rr] | [Mm][Yy][Bb][Aa][Ss][Hh][Bb][Uu][Rr][Nn])
                 APP_NAME="mybashburn"
                 f_application_run
                 ;;
                 mybashburn' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 15 | [Ss] | [Ss][Ii] | [Ss][Ii][Mm] | [Ss][Ii][Mm][Pp] | [Ss][Ii][Mm][Pp][Ll] | [Ss][Ii][Mm][Pp][Ll][Ee] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb][Uu] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb][Uu][Rr] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb][Uu][Rr][Nn] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb][Uu][Rr][Nn][Ee] | [Ss][Ii][Mm][Pp][Ll][Ee][Bb][Uu][Rr][Nn][Ee][Rr])
                 APP_NAME="simpleburner"
                 f_application_run
                 ;;
                 simpleburner' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_disks () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of System Disks Information Applications until loop.
            #MSD df     - Disk usage and mount points, usage: -hT.
            #MSD pydf   - Disk usage df clone written in python.
            #MSD du     - Disk usage monitor by directory.
            #MSD gt5    - A diff-capable du-browser.
            #MSD ncdu   - Disk usage monitor, ncurses-based.
            #MSD uuid   - Use ls -l to show disk uuid number.
            #MSD cfdisk - Disk partition tool.
            #MSD parted - Disk partition tool.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Disks Information Menu"
            DELIMITER="#MSD" #MSD This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Disks Information Applications case statement.
                 1 | [Dd] | [Dd][Ff])
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
                 df' '* | 'sudo df '* | 'sudo df')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Pp] | [Pp][Yy] | [Pp][Yy][Dd] | [Pp][Yy][Dd][Ff])
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
                 pydf' '* | 'sudo pydf '* | 'sudo pydf')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Uu])
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
                 du' '* | 'sudo du '* | 'sudo du')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Gg] | [Gg][Tt] | [Gg][Tt][5])
                 APP_NAME="gt5"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 gt5' '* | 'sudo gt5 '* | 'sudo gt5')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 5 | [Nn] | [Nn][Cc] | [Nn][Cc][Dd] | [Nn][Cc][Dd][Uu])
                 APP_NAME="ncdu"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 ncdu' '* | 'sudo ncdu '* | 'sudo ncdu')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 6 | [Uu] | [Uu][Uu] | [Uu][Uu][Ii] | [Uu][Uu][Ii][Dd])
                 clear # Blank the screen.
                 echo To find the UUID of a disk, type: ls -l /dev/disk/by-uuid.
                 APP_NAME="ls -l /dev/disk/by-uuid"
                 f_application_run             
                 ;;
                 uuid' '* | 'sudo uuid '* | 'sudo uuid')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Cc] | [Cc][Ff] | [Cc][Ff][Dd] | [Cc][Ff][Dd][Ii] | [Cc][Ff][Dd][Ii][Ss] | [Cc][Ff][Dd][Ii][Ss][Kk])
                 APP_NAME="cfdisk"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 cfdisk' '* | 'sudo cfdisk '* | 'sudo cfdisk')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 8 | [Pp] | [Pp][Aa] | [Pp][Aa][Rr] | [Pp][Aa][Rr][Tt] | [Pp][Aa][Rr][Tt][Ee] | [Pp][Aa][Rr][Tt][Ee][Dd])
                 APP_NAME="parted"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 parted' '* | 'sudo parted '* | 'sudo parted')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_health () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of System Health Applications until loop.
            #MSH lynis      - security auditing tool that tests for security holes in a PC.
            #MSH clamscan   - Clam anti-virus program scans for viruses.
            #MSH freshclam  - Clam anti-virus database definition update.
            #MSH chkrootkit - Root Kit detector.
            #MSH rkhunter   - Root Kit detector.
            #MSH tripwire   - Detects/Reports changes in system files.
            #MSH arpon      - ArpON detects/blocks arp poisoning/spoofing attacks.
            #MSH arpalert   - Checks MAC addresses against list of known MACs, runs script.
            #MSH arpwatch   - Detects unknown MAC addresses and IP addresses, like ArpON.
            #MSH arp-scan   - Discover, fingerprint hosts on LAN using MAC addresses.
            #MSH stress     - Stress test can simulate a heavy load on CPU.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Health Applications Menu"
            DELIMITER="#MSH" #MSH This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Health Applications case statement.
                 1 | [Ll] | [Ll][Yy] | [Ll][Yy][Nn] | [Ll][Yy][Nn][Ii] | [Ll][Yy][Nn][Ii][Ss])
                 APP_NAME="lynis"
                 f_application_run
                 ;;
                 lynis' '* | 'sudo lynis '* | 'sudo lynis')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Cc] | [Cc][Ll] | [Cc][Ll][Aa] | [Cc][Ll][Aa][Mm] | [Cc][Ll][Aa][Mm][Ss] | [Cc][Ll][Aa][Mm][Ss][Cc] | [Cc][Ll][Aa][Mm][Ss][Cc][Aa] | [Cc][Ll][Aa][Mm][Ss][Cc][Aa][Nn])
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
                 clamscan' '* | 'sudo clamscan '* | 'sudo clamscan')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 3 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ss] | [Ff][Rr][Ee][Ss][Hh] | [Ff][Rr][Ee][Ss][Hh][Cc] | [Ff][Rr][Ee][Ss][Hh][Cc][Ll] | [Ff][Rr][Ee][Ss][Hh][Cc][Ll][Aa] | [Ff][Rr][Ee][Ss][Hh][Cc][Ll][Aa][Mm])
                 APP_NAME="freshclam"
                 # f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 freshclam' '* | 'sudo freshclam '* | 'sudo freshclam')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=1 # Display "Press 'Enter' key to continue."
                 ;;
                 4 | [Cc] | [Cc][Hh] | [Cc][Hh][Kk | [Cc][Hh][Kk] | [Cc][Hh][Kk][Rr] | [Cc][Hh][Kk][Rr][Oo] | [Cc][Hh][Kk][Rr][Oo][Oo] | [Cc][Hh][Kk][Rr][Oo][Oo][Tt] | [Cc][Hh][Kk][Rr][Oo][Oo][Tt][Kk] | [Cc][Hh][Kk][Rr][Oo][Oo][Tt][Kk][Ii] | [Cc][Hh][Kk][Rr][Oo][Oo][Tt][Kk][Ii][Tt])
                 APP_NAME="chkrootkit"
                 f_application_run
                 ;;
                 chkrootkit' '* | 'sudo chkrootkit '* | 'sudo chkrootkit')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Rr] | [Rr][Kk] | [Rr][Kk][Hh] | [Rr][Kk][Hh][Uu] | [Rr][Kk][Hh][Uu][Nn] | [Rr][Kk][Hh][Uu][Nn][Tt] | [Rr][Kk][Hh][Uu][Nn][Tt][Ee] | [Rr][Kk][Hh][Uu][Nn][Tt][Ee][Rr])
                 APP_NAME="rkhunter"
                 f_application_run
                 ;;
                 rkhunter' '* | 'sudo rkhunter '* | 'sudo rkhunter')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Tt] | [Tt][Rr] | [Tt][Rr][Ii] | [Tt][Rr][Ii][Pp] | [Tt][Rr][Ii][Pp][Ww] | [Tt][Rr][Ii][Pp][Ww][Ii] | [Tt][Rr][Ii][Pp][Ww][Ii][Rr] | [Tt][Rr][Ii][Pp][Ww][Ii][Rr][Ee])
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
                 tripwire' '* | 'sudo tripwire '* | 'sudo tripwire')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Oo] | [Aa][Rr][Pp][Oo][Nn])
                 APP_NAME="arpon"
                 f_application_run
                 ;;
                 arpon' '* | 'sudo arpon '* | 'sudo arpon')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8| [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Aa] | [Aa][Rr][Pp][Aa][Ll] | [Aa][Rr][Pp][Aa][Ll][Ee] | [Aa][Rr][Pp][Aa][Ll][Ee][Rr] | [Aa][Rr][Pp][Aa][Ll][Ee][Rr][Tt])
                 APP_NAME="arpalert"
                 f_application_run
                 ;;
                 arpalert' '* | 'sudo arpalert '* | 'sudo arpalert')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][Ww] | [Aa][Rr][Pp][Ww][Aa] | [Aa][Rr][Pp][Ww][Aa][Tt] | [Aa][Rr][Pp][Ww][Aa][Tt][Cc] | [Aa][Rr][Pp][Ww][Aa][Tt][Cc][Hh])
                 APP_NAME="arpwatch"
                 clear # Blank the screen.
                 echo "arpwatch - keep track of ethernet/ip address pairings"
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
                 arpwatch' '* | 'sudo arpwatch '* | 'sudo arpwatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Aa] | [Aa][Rr] | [Aa][Rr][Pp] | [Aa][Rr][Pp][-] | [Aa][Rr][Pp][-][Ss] | [Aa][Rr][Pp][-][Ss][Cc] | [Aa][Rr][Pp][-][Ss][Cc][Aa] | [Aa][Rr][Pp][-][Ss][Cc][Aa][Nn])
                 APP_NAME="arp-scan"
                 clear # Blank the screen.
                 echo "arp-scan - ARP Scanner."
                 echo "Usage:"
                 echo "arp-scan [options] [hosts...]"
                 echo
                 echo "       --localnet or -l"
                 echo "              Generate addresses from network  interface  configuration.   Use"
                 echo "              the  network  interface  IP address and network mask to generate"
                 echo "              the list of target host addresses.  The list  will  include  the"
                 echo "              network  and  broadcast  addresses,  so  an interface address of"
                 echo "              10.0.0.1 with netmask 255.255.255.0 would  generate  256  target"
                 echo "              hosts  from  10.0.0.0  to 10.0.0.255 inclusive.  If you use this"
                 echo "              option, you cannot specify the --file option or specify any tar‐"
                 echo "              get hosts on the command line.  The interface specifications are"
                 echo "              taken from the interface that arp-scan will use,  which  can  be"
                 echo "              changed with the --interface option."
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
                 arp-scan' '* | 'sudo arp-scan '* | 'sudo arp-scan')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Ss] | [Ss][Tt] | [Ss][Tt][Rr] | [Ss][Tt][Rr][Ee] | [Ss][Tt][Rr][Ee][Ss] | [Ss][Tt][Rr][Ee][Ss][Ss])
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
                 stress' '* | 'sudo stress '* | 'sudo stress')
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_mainboard () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Information until loop.
            #MSI dmidecode   - Main board information.
            #MSI lshw        - Main board information.
            #MSI free        - Memory usage RAM and swap.
            #MSI vmstat      - Memory usage RAM and swap, CPU information.
            #MSI hdparm      - Hard disk drive information.
            #MSI lsb_release - Linux distro and LSB (Linux Standard Base).
            #MSI uname       - Linux kernel information.
            #MSI lsmod       - Linux kernel module information.
            #MSI slabtop     - Kernel slab cache information in real time.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Mainboard Information Menu"
            DELIMITER="#MSI" #MSI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Mainboard System Information case statement.
                 1 | [Dd] | [Dd][Mm] | [Dd][Mm][Ii] | [Dd][Mm][Ii][Dd] | [Dd][Mm][Ii][Dd][Ee] | [Dd][Mm][Ii][Dd][Ee][Cc | [Dd][Mm][Ii][Dd][Ee][Cc][Oo] | [Dd][Mm][Ii][Dd][Ee][Cc][Oo][Dd] | [Dd][Mm][Ii][Dd][Ee][Cc][Oo][Dd][Ee])
                 APP_NAME="dmidecode"
                 f_application_run
                 ;;
                 dmidecode' '* | 'sudo dmidecode '* | 'sudo dmidecode')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ll] | [Ll][Ss] | [Ll][Ss][Hh] | [Ll][Ss][Hh][Ww])
                 clear # Blank the screen.
                 APP_NAME="lshw -short"
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
                 lshw' '* | 'sudo lshw '* | 'sudo lshw')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Rr] | [Ff][Rr][Ee] | [Ff][Rr][Ee][Ee])
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
                 free' '* | 'sudo free '* | 'sudo free')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Vv] | [Vv][Mm] | [Vv][Mm][Ss] | [Vv][Mm][Ss][Tt] | [Vv][Mm][Ss][Tt][Aa] | [Vv][Mm][Ss][Tt][Aa][Tt])
                 APP_NAME="vmstat"
                 f_application_run
                 ;;
                 vmstat' '* | 'sudo vmstat '* | 'sudo vmstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Hh] | [Hh][Dd] | [Hh][Dd][Pp] | [Hh][Dd][Pp][Aa] | [Hh][Dd][Pp][Aa][Rr] | [Hh][Dd][Pp][Aa][Rr][Mm])
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
                 hdparm' '* | 'sudo hdparm '* | 'sudo hdparm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ll] | [Ll][Ss] | [Ll][Ss][Bb] | [Ll][Ss][Bb][_] | [Ll][Ss][Bb][_][Rr] | [Ll][Ss][Bb][_][Rr][Ee] | [Ll][Ss][Bb][_][Rr][Ee][Ll] | [Ll][Ss][Bb][_][Rr][Ee][Ll][Ee] | [Ll][Ss][Bb][_][Rr][Ee][Ll][Ee][Aa] | [Ll][Ss][Bb][_][Rr][Ee][Ll][Ee][Aa][Ss] | [Ll][Ss][Bb][_][Rr][Ee][Ll][Ee][Aa][Ss][Ee])
                 APP_NAME="lsb_release -a"
                 f_application_run
                 ;;
                 lsb_release' '* | 'sudo lsb_release '* | 'sudo lsb_release')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Uu] | [Uu][Nn] | [Uu][Nn][Aa] | [Uu][Nn][Aa][Mm] | [Uu][Nn][Aa][Mm][Ee])
                 APP_NAME="uname -a"
                 f_application_run
                 ;;
                 uname' '* | 'sudo uname '* | 'sudo uname')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ll] | [Ll][Ss] | [Ll][Ss][Mm] | [Ll][Ss][Mm][Oo] | [Ll][Ss][Mm][Oo][Dd])
                 APP_NAME="lsmod "
                 f_application_run
                 ;;
                 lsmod' '* | 'sudo lsmod '* | 'sudo lsmod')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ss] | [Ss][Ll] | [Ss][Ll][Aa] | [Ss][Ll][Aa][Bb] | [Ss][Ll][Aa][Bb][Tt] | [Ss][Ll][Aa][Bb][Tt][Oo] | [Ss][Ll][Aa][Bb][Tt][Oo][Pp])
                 APP_NAME="slabtop"
                 clear # Blank the screen.
                 echo "slabtop - display kernel slab cache information in real time."
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
                 slabtop' '* | 'sudo slabtop '* | 'sudo slabtop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
            esac                # End of Mainboard System Information case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Mainboard System Information until loop.
} # End of f_menu_app_sys_mainboard
#
# +----------------------------------------+
# |   Function f_menu_app_sys_peripherals  |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_peripherals () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of Peripheral System Information until loop.
            #MSL printenv    - Environmental variables.
            #MSL blkid       - Block devices.
            #MSL lsusb       - USB devices.
            #MSL lspci       - PCI buses and connected devices.
            #MSL lspcmcia    - PCMCIA extended debugging information.
            #MSL pccardctl   - PCMCIA card devices.
            #MSL acpitool    - ACPI power/battery settings.
            #MSL lsof        - Display information about open files.
            #MSL uptime      - Display how long PC has been running, # users, load average.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Peripheral System Information Menu"
            DELIMITER="#MSL" #MSL This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Peripheral System Information case statement.
                 1 | [Pp] | [Pp][Rr] | [Pp][Rr][Ii] | [Pp][Rr][Ii][Nn] | [Pp][Rr][Ii][Nn][Tt] | [Pp][Rr][Ii][Nn][Tt][Ee] | [Pp][Rr][Ii][Nn][Tt][Ee][Nn] | [Pp][Rr][Ii][Nn][Tt][Ee][Nn][Vv])
                 APP_NAME="printenv"
                 f_application_run
                 ;;
                 printenv' '* | 'sudo printenv '* | 'sudo printenv')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Bb] | [Bb][Ll] | [Bb][Ll][Kk] | [Bb][Ll][Kk][Ii] | [Bb][Ll][Kk][Ii][Dd])
                 APP_NAME="blkid"
                 clear # Blank the screen.
                 echo "blkid - locate/print block device attributes"
                 echo
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
                 blkid' '* | 'sudo blkid '* | 'sudo blkid')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ll] | [Ll][Ss] | [Ll][Ss][Cc] | [Ll][Ss][Cc][Pp] | [Ll][Ss][Cc][Pp][Uu])
                 APP_NAME="lscpu"
                 f_application_run
                 ;;
                 lscpu' '* | 'sudo lscpu '* | 'sudo lscpu')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ll] | [Ll][Ss] | [Ll][Ss][Uu] | [Ll][Ss][Uu][Ss] | [Ll][Ss][Uu][Ss][Bb])
                 APP_NAME="lsusb"
                 f_application_run
                 ;;
                 lsusb' '* | 'sudo lsusb '* | 'sudo lsusb')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ll] | [Ll][Ss] | [Ll][Ss][Pp] | [Ll][Ss][Pp][Cc] | [Ll][Ss][Pp][Cc][Ii])
                 APP_NAME="lspci"
                 f_application_run
                 ;;
                 lspci' '* | 'sudo lspci '* | 'sudo lspci')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ll][Ss][Pp][Cc][Mm][Cc][Ii][Aa])
                 APP_NAME="lspcmcia"
                 clear # Blank the screen.
                 echo "lspcmcia - display extended PCMCIA debugging information."
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
                 lspcmcia' '* | 'sudo lspcmcia '* | 'sudo lspcmcia')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Cc] | [Pp][Cc][Cc] | [Pp][Cc][Cc][Aa] | [Pp][Cc][Cc][Aa][Rr] | [Pp][Cc][Cc][Aa][Rr][Dd] | [Pp][Cc][Cc][Aa][Rr][Dd][Cc] | [Pp][Cc][Cc][Aa][Rr][Dd][Cc][Tt] | [Pp][Cc][Cc][Aa][Rr][Dd][Cc][Tt][Ll])
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
                 pccardctl' '* | 'sudo pccardctl '* | 'sudo pccardctl')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Aa] | [Aa][Cc] | [Aa][Cc][Pp] | [Aa][Cc][Pp][Ii] | [Aa][Cc][Pp][Ii][Tt] | [Aa][Cc][Pp][Ii][Tt][Oo] | [Aa][Cc][Pp][Ii][Tt][Oo][Oo] | [Aa][Cc][Pp][Ii][Tt][Oo][Oo][Ll])
                 APP_NAME="acpitool"
                 f_application_run
                 ;;
                 acpitool' '* | 'sudo acpitool '* | 'sudo acpitool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ll] | [Ll][Ss] | [Ll][Ss][Oo] | [Ll][Ss][Oo][Ff])
                 APP_NAME="lsof"
                 f_application_run
                 ;;
                 lsof' '* | 'sudo lsof '* | 'sudo lsof')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Uu] | [Uu][Pp] | [Uu][Pp][Tt] | [Uu][Pp][Tt][Ii] | [Uu][Pp][Tt][Ii][Mm] | [Uu][Pp][Tt][Ii][Mm][Ee])
                 APP_NAME="uptime"
                 f_application_run
                 ;;
                 uptime' '* | 'sudo uptime '* | 'sudo uptime')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Peripheral System Information case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Peripheral System Information until loop.
} # End of f_menu_app_sys_peripherals
#
# +----------------------------------------+
# |      Function f_menu_app_sys_logs      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_logs () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Logs until loop.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Logs case statement.
                 1 | [Mm] | [Mm][Uu] | [Mm][Uu][Ll] | [Mm][Uu][Ll][Tt] | [Mm][Uu][Ll][Tt][Ii] | [Mm][Uu][Ll][Tt][Ii][Tt] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa][Ii] | [Mm][Uu][Ll][Tt][Ii][Tt][Aa][Ii][Ll])
                 APP_NAME="multitail"
                 f_application_run
                 ;;
                 multitail' '* | 'sudo multitail '* | 'sudo multitail')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Ss] | [Ss][Ww] | [Ss][Ww][Aa] | [Ss][Ww][Aa][Tt] | [Ss][Ww][Aa][Tt][Cc] | [Ss][Ww][Aa][Tt][Cc][Hh])
                 APP_NAME="swatch"
                 f_application_run
                 ;;
                 swatch' '* | 'sudo swatch '* | 'sudo swatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of System Logs case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of System Logs until loop.
} # End of f_menu_app_sys_logs
#
# +----------------------------------------+
# |    Function f_menu_app_sys_monitors    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_monitors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Monitors until loop.
            #MSM chkconfig - System update/query run-level processes at boot time.
            #MSM glances   - View system processes/resources, CPU/Load/Mem/Swap/Disk/BW.
            #MSM tload     - System load average graphical monitor.
            #MSM mpstat    - CPU microprocessor usage monitor.
            #MSM dstat     - View system resources, replaces vmstat, iostat, ifstat.
            #MSM iostat    - CPU usage and disk I/O process monitor.
            #MSM sar       - CPU usage statistics, user/nice/system/iowait/steal/idle.
            #MSM iotop     - Disk I/O process monitor.
            #MSM nmon      - CPU usage, memory, network, disk usage, processes, resources.
            #MSM saidar    - Monitor system processes, network I/O, disks I/O, free space.
            #MSM yacpi     - ACPI monitor, ncurses-based.
            #MSM last      - Users' login/logout times from /var/log/wtmp.
            #MSM swatch    - Log file viewer with regexp matching, highlighting & hooks.
            #MSM cacti     - Frontend to rrdtool for monitoring systems and services.
            #MSM rrdtool   - The Round Robin Database Tool stores/displays time-series data.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Monitors Menu"
            DELIMITER="#MSM" #MSM This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Monitors case statement.
                 1 | [Cc] | [Cc][Hh] | [Cc][Hh][Kk] | [Cc][Hh][Kk][Cc] | [Cc][Hh][Kk][Cc][Oo] | [Cc][Hh][Kk][Cc][Oo][Nn] | [Cc][Hh][Kk][Cc][Oo][Nn][Ff] | [Cc][Hh][Kk][Cc][Oo][Nn][Ff][Ii] | [Cc][Hh][Kk][Cc][Oo][Nn][Ff][Ii][Gg])
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
                 chkconfig' '* | 'sudo chkconfig '* | 'sudo chkconfig')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Gg] | [Gg][Ll] | [Gg][Ll][Aa] | [Gg][Ll][Aa][Nn] | [Gg][Ll][Aa][Nn][Cc] | [Gg][Ll][Aa][Nn][Cc][Ee] | [Gg][Ll][Aa][Nn][Cc][Ee][Ss])
                 APP_NAME="glances"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 glances' '* | 'sudo glances '* | 'sudo glances')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 3 | [Tt] | [Tt][Ll] | [Tt][Ll][Oo] | [Tt][Ll][Oo][Aa] | [Tt][Ll][Oo][Aa][Dd])
                 APP_NAME="tload"
                 clear # Blank the screen.
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
                 tload' '* | 'sudo tload '* | 'sudo tload')
                 APP_NAME=$CHOICE_APP
                 clear # Blank the screen.
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
                 4 | [Mm] | [Mm][Pp] | [Mm][Pp][Ss] | [Mm][Pp][Ss][Tt] | [Mm][Pp][Ss][Tt][Aa] | [Mm][Pp][Ss][Tt][Aa][Tt])
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
                 mpstat' '* | 'sudo mpstat '* | 'sudo mpstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Dd] | [Dd][Ss] | [Dd][Ss][Tt] | [Dd][Ss][Tt][Aa] | [Dd][Ss][Tt][Aa][Tt])
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
                 dstat' '* | 'sudo dstat '* | 'sudo dstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 6 | [Ii]| [Ii][Oo] | [Ii][Oo][Ss] | [Ii][Oo][Ss][Tt] | [Ii][Oo][Ss][Tt][Aa] | [Ii][Oo][Ss][Tt][Aa][Tt])
                 APP_NAME="iostat"
                 f_application_run
                 ;;
                 iostat' '* | 'sudo iostat '* | 'sudo iostat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Ss] | [Ss][Aa] | [Ss][Aa][Rr])
                 APP_NAME="sar"
                 f_application_run
                 ;;
                 sar' '* | 'sudo sar '* | 'sudo sar')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Ii]| [Ii][Oo] | [Ii][Oo][Tt] | [Ii][Oo][Tt][Oo] | [Ii][Oo][Tt][Oo][Pp])
                 APP_NAME="iotop"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 iotop' '* | 'sudo iotop '* | 'sudo iotop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 9 | [Nn] | [Nn][Mm] | [Nn][Mm][Oo] | [Nn][Mm][Oo][Nn])
                 APP_NAME="nmon"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
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
                 10 | [Ss] | [Ss][Aa] | [Ss][Aa][Ii] | [Ss][Aa][Ii][Dd] | [Ss][Aa][Ii][Dd][Aa] | [Ss][Aa][Ii][Dd][Aa][Rr])
                 APP_NAME="saidar"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 saidar' '* | 'sudo saidar '* | 'sudo saidar')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 11 | [Yy] | [Yy][Aa] | [Yy][Aa][Cc] | [Yy][Aa][Cc][Pp] | [Yy][Aa][Cc][Pp][Ii])
                 APP_NAME="yacpi"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 yacpi' '* | 'sudo yacpi '* | 'sudo yacpi')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 12 | [Ll]| [Ll][Aa] | [Ll][Aa][Ss] | [Ll][Aa][Ss][Tt])
                 APP_NAME="last"
                 f_application_run
                 ;;
                 last' '* | 'sudo last '* | 'sudo last')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Ss] | [Ss][Ww] | [Ss][Ww][Aa] | [Ss][Ww][Aa][Tt] | [Ss][Ww][Aa][Tt][Cc] | [Ss][Ww][Aa][Tt][Cc][Hh])
                 APP_NAME="swatch"
                 f_application_run
                 ;;
                 swatch' '* | 'sudo swatch '* | 'sudo swatch')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Cc] | [Cc][Aa] | [Cc][Aa][Cc] | [Cc][Aa][Cc][Tt] | [Cc][Aa][Cc][Tt][Ii])
                 APP_NAME="cacti"
                 clear # Blank the screen.
                 echo "cacti - Frontend to rrdtool for monitoring systems and services."
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
                 cacti' '* | 'sudo cacti '* | 'sudo cacti')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 15 | [Rr] | [Rr][Rr] | [Rr][Rr][Dd] | [Rr][Rr][Dd][Tt] | [Rr][Rr][Dd][Tt][Oo] | [Rr][Rr][Dd][Tt][Oo][Oo] | [Rr][Rr][Dd][Tt][Oo][Oo][Ll])
                 APP_NAME="rrdtool"
                 echo "rrdtool   - The Round Robin Database Tool stores/displays time-series data."
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
                 rrdtool' '* | 'sudo rrdtool '* | 'sudo rrdtool')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of System Monitors case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of System Monitors until loop.
} # End of f_menu_app_sys_monitors
#
# +----------------------------------------+
# |     Function f_menu_app_sys_other      |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_other () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Other until loop.
            #MSO desmume - Nintendo DS emulator.
            #MSO dosemu  - DOS emulator.
            #MSO dtrx    - Extract tar, zip, deb, rpm, gz, bz2, cab, 7z, lzh, rar, etc.
            #MSO scrot   - Screen capture.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Other System Applications Menu"
            DELIMITER="#MSO" #MSO This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Other System Applications case statement.
                 1 | [Dd] | [Dd][Ee] | [Dd][Ee][Ss] | [Dd][Ee][Ss][Mm] | [Dd][Ee][Ss][Mm][Uu] | [Dd][Ee][Ss][Mm][Uu][Mm] | [Dd][Ee][Ss][Mm][Uu][Mm][Ee])
                 APP_NAME="desmume"
                 f_application_run
                 ;;
                 desmume' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Oo] | [Dd][Oo][Ss] | [Dd][Oo][Ss][Ee] | [Dd][Oo][Ss][Ee][Mm] | [Dd][Oo][Ss][Ee][Mm][Uu])
                 APP_NAME="dosemu"
                 f_application_run
                 ;;
                 dosemu' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Tt] | [Dd][Tt][Rr] | [Dd][Tt][Rr][Xx])
                 APP_NAME="dtrx"
                 f_application_run
                 ;;
                 dtrx' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Oo] | [Ss][Cc][Rr][Oo][Tt])
                 APP_NAME="scrot"
                 f_application_run
                 ;;
                 scrot' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of Other System Applications case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of Other System Applications until loop.
} # End of f_menu_app_sys_other
#
# +----------------------------------------+
# |     Function f_menu_app_sys_process    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_process () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of System Process Applications until loop.
            #MSR atop      - View system processes/resources, CPU/Mem/Swap/Page/Disk/Net.
            #MSR htop      - View system processes/resources; bar graph of CPU/Mem/Swap.
            #MSR pidstat   - View system processes/resources, PID/USR/System/Guest/CPU/Cmd.
            #MSR ps        - View system processes/resources, PID/PGID/SID/TTY/Time/Cmd.
            #MSR pstree    - Tree view system processes/resources, like "ps" command.
            #MSR pswatcher - Execute commands when certain processes are run.
            #MSR pwdx      - Report current working directory of a process.
            #MSR top       - View system PID/User/PR/NI/VERT/RES/SHR/CPU/MEM/Time/Cmd.
            #MSR pgrep     - Search ps output for full/partial name of process.
            #MSR pmap      - View process memory usage.
            #MSR strace    - Trace process system calls and signals.
            #MSR sysctl    - Configure kernel parameters at runtime.
            #MSR killall   - Kill processes based on full-name of process.
            #MSR pkill     - Kill processes based on partial name of process.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Process Applications Menu"
            DELIMITER="#MSR" #MSR This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Process Applications case statement.
                 1 | [Aa] | [Aa][Tt] | [Aa][Tt][Oo] | [Aa][Tt][Oo][Pp])
                 APP_NAME="atop"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 atop' '* | 'sudo atop '* | 'sudo atop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 2 | [Hh] | [Hh][Tt] | [Hh][Tt][Oo] | [Hh][Tt][Oo][Pp])
                 APP_NAME="htop"
                 f_how_to_quit_application "q or <F10>"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 htop' '* | 'sudo htop '* | 'sudo htop')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 3 | [Pp] | [Pp][Ii] | [Pp][Ii][Dd] | [Pp][Ii][Dd][Ss] | [Pp][Ii][Dd][Ss][Tt] | [Pp][Ii][Dd][Ss][Tt][Aa] | [Pp][Ii][Dd][Ss][Tt][Aa][Tt])
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
                 pidstat' '* | 'sudo pidstat '* | 'sudo pidstat')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Pp] | [Pp][Ss])
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
                 ps' '* | 'sudo ps '* | 'sudo ps')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Pp] | [Pp][Ss] | [Pp][Ss][Tt] | [Pp][Ss][Tt][Rr] | [Pp][Ss][Tt][Rr][Ee] | [Pp][Ss][Tt][Rr][Ee][Ee])
                 APP_NAME="pstree"
                 f_application_run
                 ;;
                 pstree' '* | 'sudo pstree '* | 'sudo pstree')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Pp] | [Pp][Ss] | [Pp][Ss][Ww] | [Pp][Ss][Ww][Aa] | [Pp][Ss][Ww][Aa][Tt] | [Pp][Ss][Ww][Aa][Tt][Cc] | [Pp][Ss][Ww][Aa][Tt][Cc][Hh] | [Pp][Ss][Ww][Aa][Tt][Cc][Hh][Ee] | [Pp][Ss][Ww][Aa][Tt][Cc][Hh][Ee][Rr])
                 APP_NAME="pswatcher"
                 clear # Blank the screen.
                 echo "pswatcher - monitoring a system via ps-like commands."
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
                 pswatcher' '* | 'sudo pswatcher '* | 'sudo pswatcher')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Pp] | [Pp][Ww] | [Pp][Ww][Dd] | [Pp][Ww][Dd][Xx])
                 APP_NAME="pwdx"
                 f_application_run
                 ;;
                 pwdx' '* | 'sudo pwdx '* | 'sudo pwdx')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Tt] | [Tt][Oo] | [Tt][Oo][Pp])
                 APP_NAME="top"
                 f_how_to_quit_application "q"
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 top' '* | 'sudo top '* | 'sudo top')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 ;;
                 9 | [Pp] | [Pp][Gg] | [Pp][Gg][Rr] | [Pp][Gg][Rr][Ee] | [Pp][Gg][Rr][Ee][Pp])
                 APP_NAME="pgrep"
                 f_application_run
                 ;;
                 pgrep' '* | 'sudo pgrep '* | 'sudo pgrep')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Pp] | [Pp][Mm] | [Pp][Mm][Aa] | [Pp][Mm][Aa][Pp])
                 APP_NAME="pmap"
                 f_application_run
                 ;;
                 pmap' '* | 'sudo pmap '* | 'sudo pmap')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Ss] | [Ss][Tt] | [Ss][Tt][Rr] | [Ss][Tt][Rr][Aa] | [Ss][Tt][Rr][Aa][Cc] | [Ss][Tt][Rr][Aa][Cc][Ee])
                 APP_NAME="strace"
                 f_application_run
                 ;;
                 strace' '* | 'sudo strace '* | 'sudo strace')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Ss] | [Ss][Yy] | [Ss][Yy][Ss] | [Ss][Yy][Ss][Cc] | [Ss][Yy][Ss][Cc][Tt] | [Ss][Yy][Ss][Cc][Tt][Ll])
                 APP_NAME="sysctl"
                 clear # Blank the screen.
                 echo "sysctl - configure kernel parameters at runtime"
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
                 sysctl' '* | 'sudo sysctl '* | 'sudo sysctl')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 13 | [Kk] | [Kk][Ii] | [Kk][Ii][Ll] | [Kk][Ii][Ll][Ll] | [Kk][Ii][Ll][Ll][Aa] | [Kk][Ii][Ll][Ll][Aa][Ll] | [Kk][Ii][Ll][Ll][Aa][Ll][Ll])
                 APP_NAME="killall"
                 f_application_run
                 ;;
                 killall' '* | 'sudo killall '* | 'sudo killall')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 14 | [Pp] | [Pp][Kk] | [Pp][Kk][Ii] | [Pp][Kk][Ii][Ll] | [Pp][Kk][Ii][Ll][Ll])
                 APP_NAME="pkill"
                 f_application_run
                 ;;
                 pkill' '* | 'sudo pkill '* | 'sudo pkill')
                 APP_NAME=$CHOICE_APP
                 f_application_run
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_screens () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ]
      do    # Start of System Screens until loop.
            #MSC byobu  - Multiple sessions.
            #MSC dtach  - Emulates detach feature of screen.
            #MSC dvtm   - dwm-style (tiling) window manager.
            #MSC screen - Multiple sessions via split or pager screens.
            #MSC tmux   - Multiple sessions with multiplexing.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="System Screens Menu"
            DELIMITER="#MSC" #MSC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of System Screens case statement.
                 1 | [Bb] | [Bb][Yy] | [Bb][Yy][Oo] | [Bb][Yy][Oo][Bb] | [Bb][Yy][Oo][Bb][Uu])
                 APP_NAME="byobu"
                 f_application_run
                 ;;
                 byobu' '* | 'sudo byobu '* | 'sudo byobu')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Dd] | [Dd][Tt] | [Dd][Tt][Aa] | [Dd][Tt][Aa][Cc] | [Dd][Tt][Aa][Cc][Hh])
                 APP_NAME="dtach"
                 f_application_run
                 ;;
                 dtach' '* | 'sudo dtach '* | 'sudo dtach')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Dd] | [Dd][Vv] | [Dd][Vv][Tt] | [Dd][Vv][Tt][Mm])
                 APP_NAME="dvtm"
                 f_application_run
                 ;;
                 dvtm' '* | 'sudo dvtm '* | 'sudo dvtm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Ss] | [Ss][Cc] | [Ss][Cc][Rr] | [Ss][Cc][Rr][Ee] | [Ss][Cc][Rr][Ee][Ee] | [Ss][Cc][Rr][Ee][Ee][Nn])
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
                 screen' '* | 'sudo screen '* | 'sudo screen')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Tt] | [Tt][Mm] | [Tt][Mm][Uu] | [Tt][Mm][Uu][Xx])
                 APP_NAME="tmux"
                 f_application_run
                 ;;
                 tmux' '* | 'sudo tmux '* | 'sudo tmux')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
            esac                # End of System Screens case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_application_bad_menu_choice
            # If application displays information, allow user to read it.
            f_option_press_enter_key
      done # End of System Screens until loop.
} # End of f_menu_app_sys_screens
#
# +----------------------------------------+
# |    Function f_menu_app_sys_software    |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_sys_software () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of System Softare Applications until loop.
            #MSF apt      - Debian package manager.
            #MSF aptoncd  - Make a CD of Debian packages, install via APT package manager.
            #MSF aptitude - Debian package manager.
            #MSF dpkg     - Debian package manager.
            #MSF synaptic - GUI Debian package manager.
            #MSF alien    - Converts rpm to deb packages.
            #MSF rpm      - RPM (Red Hat) package manager.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Synstem Software Applications case statement.
                 1 | [Aa] | [Aa][Pp] | [Aa][Pp][Tt])
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
                 apt' '* | 'apt-'* | 'sudo apt' | 'sudo apt '* | 'sudo apt-'*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Aa] | [Aa][Pp] | [Aa][Pp][Tt] | [Aa][Pp][Tt][Oo] | [Aa][Pp][Tt][Oo][Nn] | [Aa][Pp][Tt][Oo][Nn][Cc] | [Aa][Pp][Tt][Oo][Nn][Cc][Dd])
                 APP_NAME="aptoncd"
                 clear # Blank the screen.
                 echo "APTonCD is a GUI application and is in the menu for reference only."
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
                 3 | [Aa] | [Aa][Pp] | [Aa][Pp][Tt] | [Aa][Pp][Tt][Ii] | [Aa][Pp][Tt][Ii][Tt] | [Aa][Pp][Tt][Ii][Tt][Uu] | [Aa][Pp][Tt][Ii][Tt][Uu][Dd] | [Aa][Pp][Tt][Ii][Tt][Uu][Dd][Ee])
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
                 aptitude' '* | 'sudo aptitude '* | 'sudo aptitude')
                 APP_NAME=$CHOICE_APP
                 PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
                 f_application_run
                 ;;
                 4 | [Dd] | [Dd][Pp] | [Dd][Pp][Kk] | [Dd][Pp][Kk][Gg])
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
                 dpkg' '* | 'dpkg-'* | 'sudo dpkg '* | 'sudo dpkg' | 'sudo dpkg-'*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Ss] | [Ss][Yy] | [Ss][Yy][Nn] | [Ss][Yy][Nn][Aa] | [Ss][Yy][Nn][Aa][Pp] | [Ss][Yy][Nn][Aa][Pp][Tt] | [Ss][Yy][Nn][Aa][Pp][Tt][Ii] | [Ss][Yy][Nn][Aa][Pp][Tt][Ii][Cc])
                 APP_NAME="synaptic"
                 clear # Blank the screen.
                 echo "Synaptic is a GUI package manager and is in the menu for reference only."
                 echo
                 echo "However, like many GUI applications, it can be launched by from the CLI."
                 echo "Synaptic can be launched from the command line with the 'synaptic' command."
                 echo
                 f_press_enter_key_to_continue
                 ;;
                 6 | [Aa] | [Aa][Ll] | [Aa][Ll][Ii] | [Aa][Ll][Ii][Ee] | [Aa][Ll][Ii][Ee][Nn])
                 APP_NAME="alien"
                 f_application_run
                 ;;
                 alien' '* | 'sudo alien '* | 'sudo alien')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Rr] | [Rr][Pp] | [Rr][Pp][Mm])
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
                 rpm' '* | 'sudo rpm '* | 'sudo rpm')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Uu] | [Uu][Rr] | [Uu][Rr][Pp] | [Uu][Rr][Pp][Mm] | [Uu][Rr][Pp][Mm][Ii])
                 APP_NAME="urpmi"
                 f_application_run
                 ;;
                 urpmi' '* |  'sudo urpmi '* | 'sudo urpmi')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Yy] | [Yy][Aa] | [Yy][Aa][Ss] | [Yy][Aa][Ss][Tt])
                 APP_NAME="yast"
                 clear # Blank the screen.
                 echo "YaST is a GUI package manager and is in the menu for reference only."
                 echo
                 echo "However, like many GUI applications, it can be launched by from the CLI."
                 echo "YaST can be launched from the command line with the 'yast' command."
                 echo
                 f_press_enter_key_to_continue
                 ;;
                 10 | [Yy] | [Yy][Uu] | [Yy][Uu][Mm])
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
                 yum' '* | 'sudo yum '* | 'sudo yum')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Zz] | [Zz][Yy] | [Zz][Yy][Pp] | [Zz][Yy][Pp][Pp] | [Zz][Yy][Pp][Pp][Ee] | [Zz][Yy][Pp][Pp][Ee][Rr])
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
                 zypper' '* | 'sudo zypper '* | 'sudo zypper')
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_SCAT
#
f_menu_cat_video () {
      f_initvars_menu_app
      until [ $CHOICE_SCAT -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Video Application Category until loop.
            #BXC Editors - Video editors, transcoders, converters.
            #BXC Players - Video players/downloaders.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Video Application Category Menu"
            DELIMITER="#BXC" #BXC This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_SCAT
            #
            f_quit_subcat_menu
            ERROR=0 # Reset error flag.
            #
            case $CHOICE_SCAT in # Start of Video Application Category case statement.
                 1 | [Ee] | [Ee][Dd] | [Ee][Dd][Ii] | [Ee][Dd][Ii][Tt] | [Ee][Dd][Ii][Tt][Oo] | [Ee][Dd][Ii][Tt][Oo][Rr] | [Ee][Dd][Ii][Tt][Oo][Rr][Ss]) 
                 f_menu_app_video_editors     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
                 2 | [Pp] | [Pp][Ll] | [Pp][Ll][Aa] | [Pp][Ll][Aa][Yy] | [Pp][Ll][Aa][Yy][Ee] | [Pp][Ll][Aa][Yy][Ee][Rr] | [Pp][Ll][Aa][Yy][Ee][Rr][Ss])
                 f_menu_app_video_players     # Application Menu.
                 CHOICE_SCAT=-1               # Legitimate response. Stay in menu loop.
                 ;;
            esac                 # End of Video Application Category case statement.
            #
            # Trap bad menu choices, do not echo Press enter key to continue.
            f_subcat_bad_menu_choice
      done  # End of Video Application Category until loop.
} # End of function f_menu_cat_video
#
# +----------------------------------------+
# |    Function f_menu_app_video_editors   |
# +----------------------------------------+
#
#  Inputs: None. 
#    Uses: CHOICE_APP, MAX.
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_video_editors () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Video Applications until loop.
            #MVI avconv        - Audio/Video converter.
            #MVI avidemux      - Editor for simple cutting, filtering, encoding.
            #MVI ffmpeg        - Multimedia Record, convert, stream and play. 
            #MVI handbrake-cli - Transcoder ideal for batch mkv/x264 ripping.
            #MVI mencoder      - Mplayer's encoder AVI/ASF/OGG/DVD/VCD/VOB/MPG/MOV etc.
            #MVI mjpegtools    - MJPEG video playback, editing, video capture.
            #MVI mpgtx         - Editor splits/joins MPEG1 video/audio files; MPEG2, MP3 tools.
            #
            PRESS_KEY=1 # Display "Press 'Enter' key to continue."
            MENU_TITLE="Video Editor Applications Menu"
            DELIMITER="#MVI" #MVI This 3rd field prevents awk from printing this line into menu options. 
            f_show_menu $MENU_TITLE $DELIMITER 
            #
            read CHOICE_APP
            #
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Video Editor Applications case statement.
                 1 | [Aa] | [Aa][Vv] | [Aa][Vv][Cc] | [Aa][Vv][Cc][Oo] | [Aa][Vv][Cc][Oo][Nn] | [Aa][Vv][Cc][Oo][Nn][Vv])
                 APP_NAME="avconv"
                 f_how_to_quit_application "q"
                 f_application_run
                 ;;
                 avconv' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Aa] | [Aa][Vv] | [Aa][Vv][Ii] | [Aa][Vv][Ii][Dd] | [Aa][Vv][Ii][Dd][Ee] | [Aa][Vv][Ii][Dd][Ee][Mm] | [Aa][Vv][Ii][Dd][Ee][Mm][Uu] | [Aa][Vv][Ii][Dd][Ee][Mm][Uu][Xx])
                 APP_NAME="avidemux"
                 f_application_run
                 ;;
                 avidemux' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Ff] | [Ff][Ff] | [Ff][Ff][Mm] | [Ff][Ff][Mm][Ee] | [Ff][Ff][Mm][Ee][Gg])
                 APP_NAME="ffmpeg"
                 f_application_run
                 ;;
                 ffmpeg' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Hh] | [Hh][Aa] | [Hh][Aa][Nn] | [Hh][Aa][Nn][Dd] | [Hh][Aa][Nn][Dd][Bb] | [Hh][Aa][Nn][Dd][Bb][Rr] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk][Ee] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk][Ee][-] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk][Ee][-][Cc] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk][Ee][-][Cc][Ll] | [Hh][Aa][Nn][Dd][Bb][Rr][Aa][Kk][Ee][-][Cc][Ll][Ii])
                 APP_NAME="handbrake-cli"
                 f_application_run
                 ;;
                 handbrake-cli' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Mm] | [Mm][Ee] | [Mm][Ee][Nn] | [Mm][Ee][Nn][Cc] | [Mm][Ee][Nn][Cc][Oo] | [Mm][Ee][Nn][Cc][Oo][Dd] | [Mm][Ee][Nn][Cc][Oo][Dd][Ee] | [Mm][Ee][Nn][Cc][Oo][Dd][Ee][Rr])
                 APP_NAME="mencoder"
                 f_application_run
                 ;;
                 mencoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Mm] | [Mm][Jj] | [Mm][Jj][Pp] | [Mm][Jj][Pp][Ee] | [Mm][Jj][Pp][Ee][Gg] | [Mm][Jj][Pp][Ee][Gg][Tt] | [Mm][Jj][Pp][Ee][Gg][Tt][Oo] | [Mm][Jj][Pp][Ee][Gg][Tt][Oo][Oo] | [Mm][Jj][Pp][Ee][Gg][Tt][Oo][Oo][Ll] | [Mm][Jj][Pp][Ee][Gg][Tt][Oo][Oo][Ll][Ss])
                 APP_NAME="mjpegtools"
                 f_application_run
                 ;;
                 mjpegtools' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Mm] | [Mm][Pp] | [Mm][Pp][Gg] | [Mm][Pp][Gg][Tt] | [Mm][Pp][Gg][Tt][Xx])
                 APP_NAME="mpgtx"
                 f_application_run
                 ;;
                 mpgtx' '*)
                 APP_NAME=$CHOICE_APP
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
# Outputs: ERROR, MENU_TITLE, DELIMETER, PRESS_KEY, CHOICE_APP
#
f_menu_app_video_players () {
      f_initvars_menu_app
      until [ $CHOICE_APP -eq 0 ] 
            # Only way to exit menu is to enter "0" or "[R]eturn".
      do    # Start of Video Applications until loop.
            #MVI mplayer      - Multimedia player MPEG,AVI, Ogg/OGM, QT/MOV/MP4, ASF/WMA/WMV.
            #MVI mplayer2     - Multimedia player MPEG,AVI, Ogg/OGM, QT/MOV/MP4, ASF/WMA/WMV.
            #MVI xine-console - xine video player AVI, DVD, SVCD, VCD, MPEG, QuickTime.
            #MVI aaxine       - xine video player.
            #MVI cacaxine     - xine video player.
            #MVI fbxine       - xine video player.
            #MVI vlc          - VideoLAN media player MPEG, MOV, WMV, QT, WebM, MP3, etc.
            #MVI mencoder     - Mplayer's encoder AVI/ASF/OGG/DVD/VCD/VOB/MPG/MOV etc.
            #MVI episoder     - Reads "tv.com" and "epguides.com" for new TV episodes.
            #MVI cclive       - Download/Play Youtube videos.
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
            f_quit_app_menu
            f_application_help
            ERROR=0 # Reset error flag.
            APP_NAME="" # Set application name to null value.
            #
            case $CHOICE_APP in # Start of Video Player/Downloader Applications case statement.
                 1 | [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr])
                 APP_NAME="mplayer"
                 f_application_run
                 ;;
                 mplayer' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 2 | [Mm] | [Mm][Pp] | [Mm][Pp][Ll] | [Mm][Pp][Ll][Aa] | [Mm][Pp][Ll][Aa][Yy] | [Mm][Pp][Ll][Aa][Yy][Ee] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr] | [Mm][Pp][Ll][Aa][Yy][Ee][Rr][2])
                 APP_NAME="mplayer2"
                 f_application_run
                 ;;
                 mplayer2' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 3 | [Xx] | [Xx][Ii] | [Xx][Ii][Nn] | [Xx][Ii][Nn][Ee] | [Xx][Ii][Nn][Ee][-] | [Xx][Ii][Nn][Ee][-][Cc] | [Xx][Ii][Nn][Ee][-][Cc][Oo] | [Xx][Ii][Nn][Ee][-][Cc][Oo][Nn] | [Xx][Ii][Nn][Ee][-][Cc][Oo][Nn][Ss] | [Xx][Ii][Nn][Ee][-][Cc][Oo][Nn][Ss][Oo] | [Xx][Ii][Nn][Ee][-][Cc][Oo][Nn][Ss][Oo][Ll] | [Xx][Ii][Nn][Ee][-][Cc][Oo][Nn][Ss][Oo][Ll][Ee])
                 APP_NAME="xine-console"
                 f_application_run
                 ;;
                 xine-console' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 4 | [Aa] | [Aa][Aa] | [Aa][Aa][Xx] | [Aa][Aa][Xx][Ii] | [Aa][Aa][Xx][Ii][Nn] | [Aa][Aa][Xx][Ii][Nn][Ee])
                 APP_NAME="aaxine"
                 f_application_run
                 ;;
                 aaxine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 5 | [Cc] | [Cc][Aa] | [Cc][Aa][Cc] | [Cc][Aa][Cc][Aa] | [Cc][Aa][Cc][Aa][Xx] | [Cc][Aa][Cc][Aa][Xx][Ii] | [Cc][Aa][Cc][Aa][Xx][Ii][Nn] | [Cc][Aa][Cc][Aa][Xx][Ii][Nn][Ee])
                 APP_NAME="cacaxine"
                 f_application_run
                 ;;
                 cacaxine'*')
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 6 | [Ff] | [Ff][Bb] | [Ff][Bb][Xx] | [Ff][Bb][Xx][Ii] | [Ff][Bb][Xx][Ii][Nn] | [Ff][Bb][Xx][Ii][Nn][Ee])
                 APP_NAME="fbxine"
                 f_application_run
                 ;;
                 fbxine' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 7 | [Vv] | [Vv][Ll] | [Vv][Ll][Cc])
                 APP_NAME="vlc"
                 f_application_run
                 ;;
                 vlc' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 8 | [Mm] | [Mm][Ee] | [Mm][Ee][Nn] | [Mm][Ee][Nn][Cc] | [Mm][Ee][Nn][Cc][Oo] | [Mm][Ee][Nn][Cc][Oo][Dd] | [Mm][Ee][Nn][Cc][Oo][Dd][Ee] | [Mm][Ee][Nn][Cc][Oo][Dd][Ee][Rr])
                 APP_NAME="mencoder"
                 f_application_run
                 ;;
                 mencoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 9 | [Ee] | [Ee][Pp] | [Ee][Pp][Ii] | [Ee][Pp][Ii][Ss] | [Ee][Pp][Ii][Ss][Oo] | [Ee][Pp][Ii][Ss][Oo][Dd] | [Ee][Pp][Ii][Ss][Oo][Dd][Ee] | [Ee][Pp][Ii][Ss][Oo][Dd][Ee][Rr])
                 APP_NAME="episoder"
                 f_application_run
                 ;;
                 episoder' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 10 | [Cc] | [Cc][Cc] | [Cc][Cc][Ll] | [Cc][Cc][Ll][Ii] | [Cc][Cc][Ll][Ii][Vv] | [Cc][Cc][Ll][Ii][Vv][Ee])
                 APP_NAME="cclive"
                 f_application_run
                 ;;
                 cclive' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 11 | [Yy] | [Yy][Oo] | [Yy][Oo][Uu] | [Yy][Oo][Uu][Gg] | [Yy][Oo][Uu][Gg][Rr] | [Yy][Oo][Uu][Gg][Rr][Aa] | [Yy][Oo][Uu][Gg][Rr][Aa][Bb] | [Yy][Oo][Uu][Gg][Rr][Aa][Bb][Bb | [Yy][Oo][Uu][Gg][Rr][Aa][Bb][Bb][Ee] | [Yy][Oo][Uu][Gg][Rr][Aa][Bb][Bb][Ee][Rr])
                 APP_NAME="yougrabber"
                 f_application_run
                 ;;
                 yougrabber' '*)
                 APP_NAME=$CHOICE_APP
                 f_application_run
                 ;;
                 12 | [Yy] | [Yy][Oo] | [Yy][Oo][Uu] | [Yy][Oo][Uu][Tt] | [Yy][Oo][Uu][Tt][Uu] | [Yy][Oo][Uu][Tt][Uu][Bb] | [Yy][Oo][Uu][Tt][Uu][Bb][Ee] | [Yy][Oo][Uu][Tt][Uu][Bb][Ee][-] | [Yy][Oo][Uu][Tt][Uu][Bb][Ee][-][Dd] | [Yy][Oo][Uu][Tt][Uu][Bb][Ee][-][Dd] | [Yy][Oo][Uu][Tt][Uu][Bb][Ee][-][Dd][Ll])
                 APP_NAME="youtube-dl"
                 f_application_run
                 ;;
                 youtube-dl' '*)
                 APP_NAME=$CHOICE_APP
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
      #AAA Download            - Download latest released version of this script.
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
           [Ee] | [Ee][Xx] |[Ee][Xx][Ii] | [Ee][Xx][Ii][Tt])
           CHOICE_MAIN=0
           PRESS_KEY=0
           ;;
      esac
      #
      #
      case $CHOICE_MAIN in # Start of CLI Menu case statement.
           1 | [Aa] | [Aa][Pp] | [Aa][Pp][Pp] | [Aa][Pp][Pp][Ll] | [Aa][Pp][Pp][Ll][Ii] | [Aa][Pp][Pp][Ll][Ii][Cc] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn] | [Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn][Ss])
           f_menu_cat_applications
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           ;;
           2 | [Hh] | [Hh][Ee] | [Hh][Ee][Ll] | [Hh][Ee][Ll][Pp] | [Hh][Ee][Ll][Pp]' ' | [Hh][Ee][Ll][Pp]' '[Aa] | [Hh][Ee][Ll][Pp]' '[Aa][Nn] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' ' | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa][Tt] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa][Tt][Uu] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa][Tt][Uu][Rr] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa][Tt][Uu][Rr][Ee] | [Hh][Ee][Ll][Pp]' '[Aa][Nn][Dd]' '[Ff][Ee][Aa][Tt][Uu][Rr][Ee][Ss])
           clear # Blank the screen.
           sed -n 's/^#@//'p $THIS_FILE | more -d
           # display Help Applications (all lines beginning with #@ but
           # substitute "" for "#@" so "#@" is not printed).
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           3 | [Aa][Bb] | [Aa][Bb][Oo] | [Aa][Bb][Oo][Uu] | [Aa][Bb][Oo][Uu][Tt] | [Aa][Bb][Oo][Uu][Tt]' ' | [Aa][Bb][Oo][Uu][Tt]' '[Cc] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' ' | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee][Nn] | [Aa][Bb][Oo][Uu][Tt]' '[Cc][Ll][Ii]' '[Mm][Ee][Nn][Uu])
           clear # Blank the screen.
           echo "CLI Menu version: $REVISION"
           echo "       Edited on: $REVDATE"
           echo "Bash script name: $THIS_FILE"
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           4 | [Dd] | [Dd][Oo] | [Dd][Oo][Cc] | [Dd][Oo][Cc][Uu] | [Dd][Oo][Cc][Uu][Mm] | [Dd][Oo][Cc][Uu][Mm][Ee] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii][Oo] | [Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt][Aa][Tt][Ii][Oo][Nn])
           clear # Blank the screen.
           sed -n 's/^#://'p $THIS_FILE | more -d 
           # display Documentation (all lines beginning with #: but
           # substitute "" for "#:" so "#:" is not printed).
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           5 | [Dd] | [Dd][Oo] | [Dd][Oo][Ww] | [Dd][Oo][Ww][Nn] | [Dd][Oo][Ww][Nn][Ll] | [Dd][Oo][Ww][Nn][Ll][Oo] |  [Dd][Oo][Ww][Nn][Ll][Oo][Aa] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd])
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/cli-app-menu.sh"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/README"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/COPYING"
           wget $WEB_SITE
           WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/master/EDIT_HISTORY"
           wget $WEB_SITE
           echo
           echo "Downloaded files are in the same folder as this script."
           echo "The file names will be appended with a '.1'"
           echo "and you will have to manually copy them to the original names."
           PRESS_KEY=1 # Display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           6 | [Ee] | [Ee][Dd] | [Ee][Dd][Ii] | [Ee][Dd][Ii][Tt] | [Ee][Dd][Ii][Tt]' '[Hh] | [Ee][Dd][Ii][Tt]' '[Hh][Ii] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr] | [Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr][Yy])
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
           7 | [Ll] | [Ll][Ii] | [Ll][Ii][Cc] | [Ll][Ii][Cc][Ee] | [Ll][Ii][Cc][Ee][Nn] | [Ll][Ii][Cc][Ee][Nn][Cc] | [Ll][Ii][Cc][Ee][Nn][Cc][Ee])
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
           8 | [Ll] | [Ll][Ii] | [Ll][Ii][Ss] | [Ll][Ii][Ss][Tt] | [Ll][Ii][Ss][Tt]' ' | [Ll][Ii][Ss][Tt]' '[Oo] | [Ll][Ii][Ss][Tt]' '[Oo][Ff] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' ' | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn] | [Ll][Ii][Ss][Tt]' '[Oo][Ff]' '[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn][Ss])
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
           9 | [Uu] | [Uu][Pp] | [Uu][Pp][Dd] | [Uu][Pp][Dd][Aa] | [Uu][Pp][Dd][Aa][Tt] | [Uu][Pp][Dd][Aa][Tt][Ee] | [Uu][Pp][Dd][Aa][Tt][Ee]' ' | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' ' | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr] | [Uu][Pp][Dd][Aa][Tt][Ee]' '[Ee][Dd][Ii][Tt]' '[Hh][Ii][Ss][Tt][Oo][Rr][Yy])
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
           10 | [Bb] | [Bb][Ll] | [Bb][Ll][Aa] | [Bb][Ll][Aa][Cc] | [Bb][Ll][Aa][Cc][Kk])
           TCOLOR="black"
           f_term_color # Set terminal color.
           PRESS_KEY=0 # Do not display "Press 'Enter' key to continue."
           CHOICE_MAIN=-1 # Legitimate response. Stay in menu loop.
           ;;
           11 | [Ww] | [Ww][Hh] | [Ww][Hh][Ii] | [Ww][Hh][Ii][Tt] | [Ww][Hh][Ii][Tt][Ee])
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
done # End of CLI Menu until loop.
# all dun dun noodles.
