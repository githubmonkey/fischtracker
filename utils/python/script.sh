#!/bin/bash -e

## ./script.sh --old gco6iNXVPKfuARe0h1r1CQ4vURq2 --new newuser --collections 'cats,entries,jobs'
## ./script.sh --old gzKiQax8SmPw4S96w7bHsXQ6gxB3 --new newuser --collections 'cats,entries,jobs'
## ./script.sh --old oXL25xfe7RfZ3tI9KgzAfYdqKiz2 --new newuser --collections 'cats,entries,jobs'
## ./script.sh --old wTF2IgdVJTc0izPU856TkqWc5lm1 --new newuser --collections 'cats,entries,jobs'

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --old) old_userid="$2"; shift ;;
        --new) new_userid="$2"; shift ;;
        --collections) collections="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ -z "$old_userid" ] || [ -z "$new_userid" ] || [ -z "$collections" ]; then
    echo "Usage: $0 --old <old_userid> --new <new_userid> --collections <collections>"
    echo "Example: $0 --old user1 --new user2 --collections 'cats,entries,jobs'"
    exit 1
fi

echo "Processing data for old userid: $old_userid"
echo "Will be migrated to new userid: $new_userid"
echo "Collections to process: $collections"

# create a directory called ${old_userid}_out if it doesn't exist yet
olddir="dump/${old_userid}"
newdir="dump/${new_userid}"
mkdir -p "$olddir"
mkdir -p "$newdir"


## Split the comma-separated string into an array by replacing commas with spaces
col_array=(${collections//,/ })


for col in "${col_array[@]}"
do
  echo "Exporting '$col'..."
  python ./firestore_to_json.py "users/${old_userid}/${col}" "${olddir}/${col}.json"
done

## in each output file, replace each occurance of old_userid with new_userid and save the result in @newdir
for col in "${col_array[@]}"
do
  echo "Updating '$col'..."
  # change this to process the file in olddir but save the result in newdir
  sed  "s/${old_userid}/${new_userid}/g" "${olddir}/${col}.json"  >| "${newdir}/${col}.json"

  # upload modified user   
  python ./json_to_firebase.py "$newdir/$col.json" "users/${new_userid}/${col}"
done



