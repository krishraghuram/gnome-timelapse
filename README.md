# Making a timelapse in Ubuntu with Gnome on Wayland

It seems there's no ready-to-use tool that just makes a screen timelapse in Ubuntu (more specifically a x86_64 version running Gnome on Wayland). So this is a guide to make it happen. 

## Instructions

Install dependencies:

```shell
sudo apt install gnome-screenshot ffmpeg sl
```

Clone this repository:

```shell
git clone git@github.com:CrociDB/gnome-timelapse && cd gnome-timelapse
```

Now run it with the following parameters:

```shell
./gnome-timelapse.sh 30
```


## Explanation
