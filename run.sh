#!/usr/bin/env bash

FILES="/Users/nils/Documents/Imported/*"
#SET_DATE_TO="2020-03-06 10:45:00 PM +0000"

COUNT_FILES=$(($(ls -1q $FILES | wc -l)))
echo "$COUNT_FILES" files found.

LOOP_COUNT=0
for f in $FILES
do
  itemContentCreationDateRow=$(mdls -name kMDItemContentCreationDate "$f")
  itemContentCreationDateString=$(echo "$itemContentCreationDateRow" | cut -c30-57)

  if [[ ${SET_DATE_TO} !=  "" ]]
    then
      itemContentCreationDateString=$SET_DATE_TO
  fi

  itemContentCreationDateTimestamp=$(date -j -f '%Y-%m-%d %H:%M:%S %p %z' "$itemContentCreationDateString" "+%s")

  if [[ ${itemContentCreationDateString} !=  "" ]]
  then
    itemContentCreationDateExport=$(date -r "$itemContentCreationDateTimestamp" "+%m/%d/%Y %H:%M:%S")
    SetFile -d "$itemContentCreationDateExport" "$f"
  else
    echo Error getting export time for file: "$f"
  fi

  LOOP_COUNT=$((LOOP_COUNT+1))
  if ! ((LOOP_COUNT % 100)); then
    echo "$LOOP_COUNT" changed.
  fi
done

echo Setting new creation date done. "$LOOP_COUNT" changed.

