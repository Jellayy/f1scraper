#!/bin/bash

# This script will print the final or current standings of every F1 Drivers Championship since 1950 all the way to 2021.
# The output of this script can be redirected to a file if need be

# Format is POSTION DRIVER COUNTRY POINTS

# Suprisingly the f1 website only seems to ratelimit you a minor amount towards the end, currently this script makes about 284 requests


for ((j = 1950; j <= 2021; j++)); do
    pos=($(curl -s "https://www.formula1.com/en/results.html/$j/drivers.html" | grep '<td class="dark">' | cut -d ">" -f2 | cut -d "<" -f1))
    drivers=($(curl -s "https://www.formula1.com/en/results.html/$j/drivers.html" | grep '<span class="hide-for-mobile">' | cut -d ">" -f2 | cut -d "<" -f1))
    nations=($(curl -s "https://www.formula1.com/en/results.html/$j/drivers.html" | grep '<td class="dark semi-bold uppercase">' | cut -d ">" -f2 | cut -d "<" -f1))
    pts=($(curl -s "https://www.formula1.com/en/results.html/$j/drivers.html" | grep '<td class="dark bold">' | cut -d ">" -f2 | cut -d "<" -f1))

    echo
    echo $j
    for ((i = 0; i < ${#pos[@]}; i++)); do
        printf "%s %s %s %s\n" "${pos[$i]}" "${drivers[$i]}" "${nations[$i]}" "${pts[$i]}"
    done
done