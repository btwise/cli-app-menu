CLI-app-menu
============

CLI Menu of Applications

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
