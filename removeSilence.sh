#!/usr/bin/env sh

IN=$1
OUT=$2
THRESH=$3
DURATION=$4
WIDTH=$5
HEIGHT=$6

ffmpeg -hide_banner -vn -i "$IN" -af "silencedetect=n=${THRESH}dB:d=${DURATION}" -f null - 2>&1 | grep "silence_end" | awk '{print $5 " " $8}' > silence.txt

python removeSilence.py "$IN" output.tmp.mp4 silence.txt

ffmpeg -i output.tmp.mp4 -vf scale=$WIDTH:$HEIGHT -preset slow -crf 18 "$OUT"

rm output.tmp.mp4