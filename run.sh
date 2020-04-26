#!/usr/bin/env bash

FILES="/Users/nils/Documents/Imported/*"
  for f in $FILES
  do
    itemContentCreationDateRow=$(mdls -name kMDItemContentCreationDate "$f")
    itemContentCreationDateString=$(echo "$itemContentCreationDateRow" | cut -c30-57)
    itemContentCreationDateTimestamp=$(date -j -f '%Y-%m-%d %H:%M:%S %p %z' "$itemContentCreationDateString" "+%s")

    if [[ ${itemContentCreationDateString} !=  "" ]]
    then
      itemContentCreationDateExport=$(date -r "$itemContentCreationDateTimestamp" "+%d/%m/%Y %H:%M:%S")
    else
      echo "Error getting export time"
    fi
  done

