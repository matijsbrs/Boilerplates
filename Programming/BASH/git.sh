#!/bin/bash
#
# Most of my python projects I link the version and date of that version in the 
# code. This script does that and is able to change the variables. 
# also the way I use tags is some what automated.
# The variables it changes are: _version and _date it is changed using 'sed'
# 
AUTHOR="M. Behrens"
DATE="31-1-2023"
VERSION="v0.0.2"
# 
# when authentication is needed I recommend using the credential helper.
# $ git config credential.helper store
# $ git config credential.helper 'cache --timeout 43200'
# $ git push 
#
# You now can work the rest of the day without typing your credentials. ;-)
#
# Version 0.0.2 added support for upgrade 

FILE=""
GIT_TAG_VERSION=`git tag | tail -n 1`
NEW_TAG=GIT_TAG_VERSION
MESSAGE=""

update_version_field () {
    echo "Sync version field in '$1' with git_tag '$2'."
    sed -i 's/_version.*=.*/_version = "'$2'"/g' $1
    sed -i 's/_date.*=.*/_date = "'`date  +%d%m%Y`'"/g' $1
}



while getopts 'f:vpc:hi:m:u' opt; do
  case "$opt" in
    u)
        curl "https://raw.githubusercontent.com/matijsbrs/Boilerplates/main/Programming/BASH/git.sh" -o "git.sh.new"
        SUM_NEW=`md5sum git.sh.new | awk {'print $1'}`
        SUM_NOW=`md5sum git.sh | awk {'print $1'}` 
        echo "sum new" $SUM_NEW
        echo "sum now" $SUM_NOW
        
        if [ $SUM_NEW != $SUM_NOW ] 
            then
            VER_NEW=`cat git.sh.new | grep "^VERSION="`
            VER_NOW=`cat git.sh | grep "^VERSION="`
            echo "Online version is different"
            echo "Online version: " $VER_NEW
            echo "Local  version: " $VER_NOW
            read -p "upgrade? (y/n)" yn
            case $yn in
                [yY] )
                    echo "ok, proceed"
                    echo "local version is stored as git.sh.old"
                    mv git.sh git.sh.old
                    mv git.sh.new git.sh
                    ;;
                [nN] ) 
                    echo "stopping"
                    exit
                    ;;
                * )
                    echo "no input, stopping"
                    exit
                    ;;      
            esac       
        fi
        ;;
    f)
        FILE=$OPTARG
        ;;
    v)
      update_version_field $FILE $NEW_TAG
      ;;

    p)
      if [ $NEW_TAG != $GIT_TAG_VERSION ] 
        then
          echo "Push code"
          git push
          echo "Push tag: " $NEW_TAG
          git push origin $NEW_TAG
        fi
      ;;
    m)
        MESSAGE=$OPTARG
        ;;
    i)
      NEW_TAG=$GIT_TAG_VERSION
      case "$OPTARG" in
        M | major)
            echo "Increase major counter"
            NEW_TAG=`echo $GIT_TAG_VERSION | sed s/v//g | awk -F . {'print "v"$1+1"."$2"."$3'}`
            ;;
        m | minor)
            echo "Increase minor counter"
            NEW_TAG=`echo $GIT_TAG_VERSION | sed s/v//g | awk -F . {'print "v"$1"."$2+1"."$3'}`
            ;;
        b | build) 
            echo "Increase build counter"
            NEW_TAG=`echo $GIT_TAG_VERSION | sed s/v//g | awk -F . {'print "v"$1"."$2"."$3+1'}`
            ;;
        -- )
            echo "unknown option"
            break
            ;;
      esac
      if [ $NEW_TAG == $GIT_TAG_VERSION ] 
        then
            echo "Version not changed" $NEW_TAG
      else 
          if [ "$MESSAGE" == "" ]
            then
                echo "Please use -m 'message' before -i argument. "
            else  
                echo "New tag: " $NEW_TAG
                echo git tag -a $NEW_TAG -m $MESSAGE
            fi
      fi
      ;;
    i)
      arg="$OPTARG"
      echo "increatement '${OPTARG}' argument"
      ;;
   
    ?|h)
      echo "Git support script by $AUTHOR $VERSION $DATE"
      echo "Usage: $(basename $0) [-f 'file.py'] [-v] [-p] [-c] [-m 'message'] [-i '']"
      echo ""
      echo " -f               Filename to sync the version to (used python variables)"
      echo " -v               Sync version '$GIT_TAG_VERSION' to '$FILE'"
      echo " -p               Push to git (include tag if -i is used)"
      echo " -c               Commit "
      echo " -h               Help, shows this information "
      echo " -m               Message (for command and / or tag annotation) "
      echo " -i 'M' | 'major' Increment the major counter with 1"
      echo " -i 'm' | 'minor' Increment the minor counter with 1"
      echo " -i 'b' | 'build' Increment the build counter with 1"
      echo " -u               Upgrade to the latested version of git.sh"
      echo ""
      echo " Example: ./git.sh -m \"New minor with improvements\" -i m -v -c -p" 
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"