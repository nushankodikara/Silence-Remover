#!/usr/bin/env python

import sys
import subprocess
import os
import shutil
from moviepy.editor import VideoFileClip, concatenate_videoclips

# Input file path
file_in = sys.argv[1]
# Output file path
file_out = sys.argv[2]
# Silence timestamps
silence_file = sys.argv[3]
# Width of the video
width = int(sys.argv[4])
# Height of the video
height = int(sys.argv[5])

# Ease in duration between cuts
try:
    ease = float(sys.argv[4])
except IndexError:
    ease = 0.0

minimum_duration = 1.0


def main():
    # number of clips generated
    count = 0
    # start of next clip
    last = 0

    in_handle = open(silence_file, "r", errors='replace')
    video = VideoFileClip(file_in)
    full_duration = video.duration
    clips = []
    while True:
        line = in_handle.readline()

        if not line:
            break

        end, duration = line.strip().split()

        to = float(end) - float(duration)

        start = float(last)
        clip_duration = float(to) - start
        # Clips less than one seconds don't seem to work
        # print("Clip Duration: {} seconds".format(clip_duration))

        # if clip_duration < minimum_duration:
        #     continue

        if full_duration - to < minimum_duration:
            continue

        if start > ease:
            start -= ease

        # print("Clip {} (Start: {}, End: {})".format(count, start, to))
        clip = video.subclip(start, to)
        clips.append(clip)
        last = end
        count += 1

    if full_duration - float(last) > minimum_duration:
        # print("Clip {} (Start: {}, End: {})".format(count, last, 'EOF'))
        clips.append(video.subclip(float(last)-ease))

    processed_video = concatenate_videoclips(
        clips, method="compose")
    processed_video.resize((width, height)).write_videofile(
        file_out,
        fps=30,
        preset='ultrafast',
        codec='libx264',
        audio_codec='aac',
        threads=2,
        verbose=False
    )

    in_handle.close()
    video.close()


main()
