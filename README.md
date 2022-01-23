# Silence Remover

> Automatically Trims Silent Parts From Your Videos

This Script will use python moviepy library with ffmpeg to automatically trim out silent sections of a video files. Will be helpful on content creation and editing.

## Usage

```shell
$ git clone https://github.com/nushankodikara/Silence-Remover
$ cd Silence-Remover
$ ./removeSilence.sh <THRESH> <DURATION> <WIDTH> <HEIGHT> <INPUT_FILE_1> <INPUT_FILE_2> ...

```

```
options:
THRESH            Minimum Audio threshold in dB
DURATION          Minimum Silence duration in seconds
WIDTH             Width of the output video
HEIGHT            Height of the output video
INPUT_FILE_X      Video Files to be processed
```

Example

```shell
$ ./removeSilence.sh -30 0.5 1920 1080 input1.mp4 input2.mp4 input3.mp4
```

Above code will automatically trim out silent parts of the video files and save the output in the same folder named with a suffix of "\_out.mp4"

### Credits

-   Donald Feury - Original Creator [Support Him On Youtube](https://www.youtube.com/watch?v=ak52RXKfDw8)
-   Zulko - moviepy
-   Nushan Kodikara - Modifications and maintaing the project
