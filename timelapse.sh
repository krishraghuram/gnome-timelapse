FRAMERATE=60

clean()
{
    printf "Cleaning captures...\n"
    rm -rf _timelapse*.jpg
}

generate_video()
{
    printf "Generating video...\n"
    ffmpeg -framerate $FRAMERATE -pattern_type glob -i '_timelapse*.jpg' -c:v libx264 $1
}

printf "Gnome Timelapse\n\n"
if [[ "$1" == "capture" ]]; then
    printf "Capturing timelapse...\n"

    cps=${2:-3}
    full=${3:-full}
    output=${4:-out.mp4}

    LC_NUMERIC=C
    waittime=$(awk "BEGIN { printf(\"%.4f\", (1 / $cps)) }")
    
    while [ true ]; do
        trap "break" INT
        sleep $waittime

        filename="_timelapse_$(echo '('`date +"%s.%N"` ' * 1000000)/1' | bc).jpg"
        ./gnome-screenshot/build/src/gnome-screenshot -f $filename
    done

    if [[ "$full" == "full" ]]; then
        generate_video $output

        if [ $? -eq 0 ]; then
            clean
        fi
    fi

    printf "\nDone\n\n"
elif [[ "$1" == "clean" ]]; then
    printf "Cleaning captures...\n"
    rm -rf _timelapse*.jpg
elif [[ "$1" == "video" ]]; then
    output=${2:-out.mp4}
    generate_video $output

    if [ $? -eq 0 ]; then
        clean
    fi
else
    printf "How to use:\n\t ./timelapse.sh COMMAND [parameters]\n\n\tThis will start capturing. Press Ctrl+C to top the capturing and it will generate the final timelapse file.\n\nCommands:\n\t- clean\t\tCleans all the capture files in this directory\n\t- capture\tCaptures the timelapse\n\t\t\t- cps: Captures per second\n\t\t\t- [full|novideo]: 'full' means it will take the captures and then produce a video in the end the 'novideo' will not produce the video and keep the captures\n\t\t\t- filename: Name of the output file\n\t- video\t\tMakes the video of all the captures in the current directory\n\nExample:\nTo capture a timelapse video of 1 frame per second, do:\n\t./timelapse capture 1 full out.mp4\n\n"
fi
