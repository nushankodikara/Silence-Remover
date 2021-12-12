# Silence-Remover

This Script will use python moviepy library with ffmpeg to automatically trim out silent sections of a video files. Will be helpful on content creation.

## Usage

```shell
removeSilence.sh <input-file> <output-file> <cutoff-decible> <ease> <width> <height>
```

### Input File

This can be any video file.

### Output File

Add the path and file name to export the vide.

### Cutoff Decible

Here you can add the threshold for marking the clip as silent. All the parts below this limit will be eleminated ( reccomended -30)

### Ease

Ease out the cutting, here add a value greater than 0.1

### Width

Video Output Width

### Height

Video Output Height

### Credits

-   Donald Feury - Original Creator [Support Him On Youtube](https://www.youtube.com/watch?v=ak52RXKfDw8)
-   Zulko - moviepy
-   Nushan Kodikara - Modifications and maintaing the project
