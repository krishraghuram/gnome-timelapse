# Making a timelapse in Ubuntu with Gnome on Wayland

It seems there's no ready-to-use tool that just makes a screen timelapse in Ubuntu (more specifically a x86_64 version running Gnome on Wayland). So this is a guide to make it happen. 

## Instructions

Install dependencies:

```shell
sudo apt install gnome-screenshot ffmpeg
```

Clone this repository:

```shell
git clone git@github.com:CrociDB/gnome-timelapse && cd gnome-timelapse
```

Now run it with the following parameters:

```shell
./timelapse.sh capture .5 full timelapse.mp4
```

This will capture `.5` screens per second (aka one screen every two seconds) and will remaing capturing until you cancel it by pressing **Ctrl+C**, then it will generate the video file.

## How to use

```shell
$ /timelapse.sh

Gnome Timelapse v0.1

How to use:
         ./timelapse.sh COMMAND [parameters]

        This will start capturing. Press Ctrl+C to top the capturing and it will generate the final timelapse file.

Commands:
        - clean         Cleans all the capture files in this directory
        - capture       Captures the timelapse
                 - cps: Captures per second
                 - [full|novideo]: 'full' means it will take the captures and then produce a video in the end the 'novideo' will not produce the video and keep the captures
                 - filename:    Name of the output file
         - video        Makes the video of all the captures in the current directory

Example:
To capture a timelapse video of 1 frame per second, do:30
        ./timelapse capture 1 full out.mp4
```

## Explanation

This script uses `gnome-screenshot` to take screenshots and then uses `ffmpeg` to assemble a video file with the captures. The reason there's a custom version of `gnome-screenshot` is that in the original version of that software, you get a screen flash and a shutter sound on every capture, and it would be very annoying, so I edited that out of the source and rebuilt.