#! /bin/bash
#
# Script git_admin.sh
#
# File naming convention for archiving:
# $THIS_FILE_<YYYY-MM-DD_HHMM>.sh
#
# +----------------------------------------+
# |    Revision number and Revision Date   |
# +----------------------------------------+
#
# After each edit made, update Edit History and version (date stamp string) of
# script.
#
# Calculate revision number by counting all lines starting with "## 2013".
# grep ^ (carot sign) means grep any lines beginning with "##2013".
# grep -c means count the lines that match the pattern.
#
THIS_FILE="git_admin.sh"
REVISION=$(grep ^"## 2013" -c $THIS_FILE) ; REVISION="2013.$REVISION"
REVDATE="August-06-2013 11:35"
#
# +----------------------------------------+
# |              Edit History              |
# +----------------------------------------+
#
## 2013-08-06 *Compare option enhanced to diff project files in any directory.
##
## 2013-07-30 *List option changed to print out filenames with no limit on spaces.
##
## 2013-07-29 *Copy option enhanced to copy lib files if exist to any directory.
##            *Update option message cleaned up to show file Date/Time cleanly.
##
## 2013-07-12 *About option added with revision, revision date information.
##            *Edit History added.
##
## 2013-07-11 *Download option edited to give choice between downloading from
##             "Stable" or "Testing" git repositories.
#
# +----------------------------------------+
# |          Initialize Variables          |
# +----------------------------------------+
#
MENU_TITLE="--- Git Project File Manager ---"
TARGETDIR=""
HOMEDIR=""
#
TARGETDIR="/home/robert/"
if [ -d $TARGETDIR ] ; then
   HOMEDIR=$TARGETDIR
else
   TARGETDIR="/home/bchin/"
   if [ -d $TARGETDIR ] ; then
      HOMEDIR=$TARGETDIR
   fi
fi
#
TARGETDIR="/home/robert/Dropbox/linux/cli-app-menu_git-project/"
if [ -d $TARGETDIR ] ; then
   DIR=$TARGETDIR
else
   TARGETDIR="/home/stuff/Dropbox/linux/cli-app-menu_git-project/"
   if [ -d $TARGETDIR ] ; then
      DIR=$TARGETDIR
   fi
fi
#
if [ $DIR = "" ] ; then
   TARGETDIR = ""
   echo
   echo "The git directory was not found."
   exit 1
fi
#
if [ $HOMEDIR = "" ] ; then
   TARGETDIR = ""
   echo
   echo "The home directory was not found."
   exit 1
fi
#
# +----------------------------------------+
# |            Function f_copy             |
# +----------------------------------------+
#
#  Inputs: $DIR, $TARGETDIR, $TARGET
#    Uses: None
# Outputs: None

f_copy () {
           if [ -r $DIR$TARGET ] ; then
              cp -p $DIR$TARGET $TARGETDIR
           else
              echo
              echo "The file $TARGET is either missing or cannot be read."
              echo
              echo -n "Press 'Enter' key to continue."
              read X

           fi
} #End of f_copy
#
# +----------------------------------------+
# |            Function f_diff             |
# +----------------------------------------+
#
#  Inputs: $DIR, $TARGETDIR, $TARGET
#    Uses: None
# Outputs: None

f_diff () {
              # echo Project=$DIR$TARGET
              # echo TARGETDIR=$TARGETDIR
              # echo TARGET=$TARGET
           if [ -r $DIR$TARGET ] ; then
              echo "Comparing $DIR$TARGET"
              echo "     with $TARGETDIR$TARGET"
              echo
              echo -n "Press 'Enter' key to continue."
              read X
              colordiff $DIR$TARGET $TARGETDIR$TARGET | more
              echo
           else
              echo
              echo "The file $TARGET is either missing or cannot be read."
              echo
           fi
} #End of f_diff
#
# +----------------------------------------+
# |                Main Menu               |
# +----------------------------------------+
#
until [ $ANS -eq 0 ]
do
      clear
      echo $MENU_TITLE
      echo
      echo "0. Quit."
      echo "1. About."
      echo "2. Edit History."
      echo "3. Update this script with newer version if available."
      echo "4. Compare 'cli-app-menu.sh' 'cli-app menu.sh.1' files in current directory."
      echo "5. Copy Git project files from Dropbox to any directory."
      echo "6. Download Git project files from github.com"
      echo "7. Delete 'Conflicted Copy' files in Git directory."
      echo "8. Find/view 'Conflicted Copy' files in Git directory."
      echo "9. List files in current directory."
      echo
      echo -n "Enter choice: "
      read ANS
      case $ANS in
           0 | [Qq] | [Qq][Uu] | [Qq][Uu][Ii] | [Qq][Uu][Ii][Tt])
           ANS=0
           ;;
           1 | [Aa] | [Aa][Bb]*)
           clear # Blank the screen.
           echo "         Version: $REVISION"
           echo "       Edited on: $REVDATE"
           echo "Bash script name: $THIS_FILE"
           echo
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=1
           ;;
           2 | [Ee] | [Ee][Dd]*)
           clear # Blank the screen.
              # display Edit History (all lines beginning with ## but
              # substitute "" for "##" so "##" is not printed).
              sed -n 's/^##//'p $THIS_FILE | more -d
           echo
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=2
           ;;
           3 | [Uu] | [Uu][Pp] | [Uu][Pp][Dd] | [Uu][Pp][Dd][Aa] | [Uu][Pp][Dd][Aa][Tt] | [Uu][Pp][Dd][Aa][Tt][Ee])
           echo "Testing if this file $THIS_FILE is older than:"
           echo "$DIR$THIS_FILE."
           echo "Update if needed."       
           echo
           echo "Date/Time of $THIS_FILE in directory:"
           echo "$(pwd)"
           ls -l --time-style=long-iso $THIS_FILE | awk '{print $6" "$7}'
           echo
           echo "Date/Time of $THIS_FILE in directory:"
           echo "$DIR"
           ls -l --time-style=long-iso $DIR$THIS_FILE | awk '{print $6" "$7}'
           if [ $THIS_FILE -ot $DIR$THIS_FILE ] ; then
               echo
               echo -n "Press 'Ctrl-C' now to abort or press 'Enter' key to update this script."
               read X
               cp -p $DIR$THIS_FILE .
               echo
               echo "Script $THIS_FILE has been updated."
           else
               echo
               echo "Script $THIS_FILE is at the latest version, no update is necessary."
           fi
           echo
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=3
           ;;
           4 | [Cc] | [Cc][Oo] | [Cc][Oo][Mm] | [Cc][Oo][Mm][Pp] | [Cc][Oo][Mm][Pp][Aa] | [Cc][Oo][Mm][Pp][Aa][Rr] | [Cc][Oo][Mm][Pp][Aa][Rr][Ee])
           echo -n "Enter target directory to be compared (default: Current directory): "
           read TARGETDIR
           case $TARGETDIR in
                "")
                ;;
                */)
                ;;
                *)
                TARGETDIR=$TARGETDIR'/'
                ;;
           esac
           if [ "$TARGETDIR" = "" ] ; then
              TARGETDIR="Current directory"
           fi
           if [ "$TARGETDIR" = "Current directory" ] ; then
              TARGETDIR=""
           fi
           TARGET="EDIT_HISTORY"
           f_diff
           TARGET="COPYING"
           f_diff
           TARGET="README"
           f_diff
           TARGET="cli-app-menu.sh"
           f_diff
           TARGET="lib_cli-common.lib"
           f_diff
           TARGET="lib_cli-menu-apps.lib"
           f_diff
           TARGET="lib_cli-menu-cat.lib"
           f_diff
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=4
           ;;
           5 | [Cc] | [Cc][Oo] | [Cc][Oo][Pp] | [Cc][Oo][Pp][Yy])
           echo -n "Enter target directory to copy to (default: Current directory): "
           read TARGETDIR
           if [ "$TARGETDIR" = "" ] ; then
              TARGETDIR="Current directory"
           fi
           echo "Copying cli-app-menu project files"
           echo "   from directory:"
           echo $DIR
           echo "   to directory:"
           echo $TARGETDIR
           echo -n " Press 'Ctrl-C' now to abort or press 'Enter' key to copy files."
           read X
           if [ "$TARGETDIR" = "Current directory" ] ; then
              TARGETDIR="."
           fi
           cp -p $DIR'cli-app-menu.sh' $DIR'EDIT_HISTORY' $DIR'COPYING' $DIR'README' $TARGETDIR
           TARGET="lib_cli-common.lib"
           f_copy
           TARGET="lib_cli-menu-apps.lib"
           f_copy
           TARGET="lib_cli-menu-cat.lib"
           f_copy
           ANS=5
           ;;
           6 | [Dd] | [Dd][Oo] | [Dd][Oo][Ww] | [Dd][Oo][Ww][Nn] | [Dd][Oo][Ww][Nn][Ll] | [Dd][Oo][Ww][Nn][Ll][Oo] |  [Dd][Oo][Ww][Nn][Ll][Oo][Aa] | [Dd][Oo][Ww][Nn][Ll][Oo][Aa][Dd])
           echo -n "Download from which branch? (TESTING/stable): "
           read X
           case $X in
                "" | [Tt] | [Tt][Ee] | [Tt][Ee][Ss]| [Tt][Ee][Ss][Tt]*)
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
                X="TESTING"
                ;;                  
                [Ss] | [Ss][Tt] | [Ss][Tt][Aa] | [Ss][Tt][Aa][Bb]*)  
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/cli-app-menu.sh"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/README"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/COPYING"
                wget $WEB_SITE
                WEB_SITE="https://raw.github.com/rdchin/CLI-app-menu/stable/EDIT_HISTORY"
                wget $WEB_SITE
                X="STABLE"
                ;;
           esac
           echo "Downloaded files from github $X branch." 
           echo "Downloaded files are in the same folder as this script."
           echo "The file names will be appended with a '.1'"
           echo "and you will have to manually copy them to the original names."
           echo
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=6
           ;;
           7 | [Dd] | [Dd][Ee] | [Dd][Ee][Ll] | [Dd][Ee][Ll][Ee] | [Dd][Ee][Ll][Ee][Tt] | [Dd][Ee][Ll][Ee][Tt][Ee]) 
           echo "Deleting files matching *'conflicted copy'* from directory $DIR."
           echo
           echo -n " Press 'Ctrl-C' now to abort or press 'Enter' key to delete files."
           read X
           find $DIR -iname *"conflicted copy"* -exec rm '{}' +
           ANS=7
           ;;
           8 | [Ff] | [Ff][Ii] | [Ff][Ii][Nn] | [Ff][Ii][Nn][Dd])
           echo "Finding files matching *'conflicted copy'* from directory $DIR."
           echo -n " Use 'Ctrl-C' now to abort or click 'Enter' key to find files."
           read ANS
           find $DIR -iname *"conflicted copy"* -print
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=8
           ;;
           9 | [Ll] | [Ll][Ii] | [Ll][Ii][Ss] | [Ll][Ii][Ss][Tt])
           # ls -Gg --time-style=long-iso | awk '{print $4,$5,$6,$7,$8,$9,$10}' | more -d # print fields when filenames contain spaces.
           find . -maxdepth 1 -type f -printf %TY'-'%Tm'-'%Td' '%TH':'%TM' '%f'\n' | more -d #print filenames even with spaces in them.
           # find -type (f files only), -printf (formatted YYYY-MM-DD 24:59 <filename> <lfcr>)
           echo
           echo -n "Press 'Enter' key to continue."
           read X
           ANS=9
           ;;
      esac
done
