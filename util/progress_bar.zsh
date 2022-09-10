#!/bin/bash
# Original insperation to https://github.com/fearside/ProgressBar/

# Prints a progress bar with a message to the terminal.
# $1 : String  : message.
# $2 : integer : current item progress.
# $3 : integer : total item count.
let _message_length=${#1}
let _term_width=$(tput cols)
let _progress="${2}*100/${3}"

# Calculate the templating string length based off how large the xyz%
# number will be.
_template_message="$1 : [] %"
if [ "$_progress" -le "9" ]; then
    let _template_length=${#_template_message}+1
elif [ "$_progress" -le "99" ]; then
    let _template_length=${#_template_message}+2
else
    let _template_length=${#_template_message}+3
fi

# Calculate the bar feature lenghts
let _progress_bar_length="$_term_width - $_template_length"
let _done_count="$_progress_bar_length*$_progress/100"
let _remaining_count="$_progress_bar_length*(100-$_progress)/100"

# Build the bar components
_done_res=$(printf "%${_done_count}s")
_remainine_res=$(printf "%${_remaining_count}s")

# Expected output:
# Some Message : [########################################] 100%
printf "\r${1} : [${_done_res// /#}${_remainine_res// /-}] ${_progress}%%"

# For Debugging.
# echo "_progress             ${_progress}"
# echo "_template_message len ${#_template_message}"
# echo "_template_length      $_template_length"
# echo "_progress_bar_length  $_progress_bar_length"
# echo "_done_count           $_done_count"
# echo "_remaining_count      $_remaining_count"