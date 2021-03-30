#!/bin/bash

echo "id,type,name,category,sponsored,availability,rent,price,modified,created,address,latitude,longitude,size,full_name,keywords,reduced"
curl -s "https://completelyretail.co.uk/shops-to-rent/Birmingham" \
| xmllint 2>/dev/null --html --xpath '//script[@id="__NEXT_DATA__"]/text()' - \
| sed 's/<!\[CDATA\[//g' \
| sed 's/\]\]>//g' \
| jq '.props.pageProps.initialState.searchData."LOCATION_PROPERTY_ALL_Birmingham".data | to_entries[] | .value '  \
| jq "" --slurp \
| jq -r 'map(.id), map(.type), map(.name), map(.category), map(.sponsored), map(.availability), map(.rent), map(.price), map(.modified), map(.created), map(.address), map(.latitude), map(.longitude), map(.size), map(.full_name), map(.keywords), map(.reduced) | @csv ' \
| csvtool transpose -
