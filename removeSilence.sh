#!/bin/bash
clear
figlet SilenceRemover

THRESH=$1
DURATION=$2
WIDTH=$3
HEIGHT=$4

START=$(date +%s)

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

directory=$(dirname "$0")

C=0
M=4
T=0
TC=0

for I in $*
do
    if (( $TC < $M ))
    then
        TC=$((TC+1))
    else
        T=$((T+1))
    fi
done

for IN in $*
do
    if (($C < $M))
    then
        C=$((C+1))
        continue
    else
        echo "${green}> Converting Video: $(($C+1-$M))/$T${reset}"
        TIME=$(date +%s) 
        ffmpeg -hide_banner -vn -i "$IN" -af "silencedetect=n=${THRESH}dB:d=${DURATION}" -f null - 2>&1 | grep "silence_end" | awk '{print $5 " " $8}' > "${directory}/${TIME}.txt" 
        python "${directory}/removeSilence.py" "$IN" "${IN}_out.mp4" "${directory}/${TIME}.txt" "$WIDTH" "$HEIGHT" 
        rm "${directory}/${TIME}.txt" 
        C=$((C+1))
        echo "${green}> Successfully Processed: $(($C-$M))/$T${reset}"
        sleep 2
    fi
done

# display horizontal line
echo "----------------------------------------------------"
# display spent time
END=$(date +%s)
echo "${green}> Time spent:         $(($END-$START)) second(s)${reset}"
# display processed files
echo "${green}> Processed files:    $T file(s)${reset}"
# display horizontal line
echo "----------------------------------------------------"
echo "${red}> Removing temporary files...${reset}"
# delete leftover files
rm ${directory}/*.txt
rm ${directory}/*.mp4
echo "${green}> All Clear!${reset}"



while getopts ":h" option; do
    case $option in
      h) # display Help
        echo "This script removes silence from a video."
        echo
        echo "usage: removeSilence.sh <THRESH> <DURATION> <WIDTH> <HEIGHT> <INPUT_FILE_1> <INPUT_FILE_2> ..."
        echo
        echo "options:"
        echo "THRESH            Minimum Audio threshold in dB"
        echo "DURATION          Minimum Silence duration in seconds"
        echo "WIDTH             Width of the output video"
        echo "HEIGHT            Height of the output video"
        echo "INPUT_FILE_X      Video Files to be processed"
        echo
        exit;;
    esac
done