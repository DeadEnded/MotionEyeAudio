# Set variables
operation=$1
camera_id=$2
file_path=$3
motion_config_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
motion_camera_conf="${motion_config_dir}/camera-${camera_id}.conf"
netcam="$(if grep -q 'netcam_highres' ${motion_camera_conf};then echo 'netcam_highres'; else echo 'netcam_url'; fi)"
extension="$(echo ${file_path} | sed 's/^/./' | rev | cut -d. -f1  | rev)"

case ${operation} in
    start)
        credentials="$(grep netcam_userpass ${motion_camera_conf} | sed -e 's/netcam_userpass.//')"
        stream="$(grep ${netcam} ${motion_camera_conf} | sed -e "s/${netcam}.//")"
        full_stream="$(echo ${stream} | sed -e "s/\/\//\/\/${credentials}@/")"
        ffmpeg -y -i "${full_stream}" -c:a aac ${file_path}.aac 2>&1 1>/dev/null &
        ffmpeg_pid=$!
        echo ${ffmpeg_pid} > /tmp/motion-audio-ffmpeg-camera-${camera_id}
        ;;

    stop)
        # Kill the ffmpeg audio recording for the clip
        kill $(cat /tmp/motion-audio-ffmpeg-camera-${camera_id})
        rm -rf $(cat /tmp/motion-audio-ffmpeg-camera-${camera_id})

        # Merge the video and audio to a single file, and replace the original video file
        ffmpeg -y -i ${file_path} -i ${file_path}.aac -c:v copy -c:a copy ${file_path}.temp.${extension};
        mv -f ${file_path}.temp.${extension} ${file_path};

        # Remove audio file after merging
        rm -f ${file_path}.aac;
        ;;

    *)
        echo "Usage ./motioneye-audio.sh start <camera-id> <full-path-to-moviefile>"
        exit 1
esac
