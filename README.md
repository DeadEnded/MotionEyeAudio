# MotionEye Audio
Script to add Audio recording to MotionEye NVR

## Docker Image
A docker image with the script already added to the `/etc/motioneye/` directory can be found [here](https://hub.docker.com/repository/docker/deadend/motioneye-audio).

## Manual Copy

Currently this has only been tested on continuous recording, but should work on motion events as well.

**Docker script location** - Identify the directory mapped to `/etc/motioneye/` volume for the container.  Copy `motioneye-audio.sh` to the host directory mapped to the containers `/etc/motioneye/` directory.
      
**MotionEyeOS script location** - Copy `motioneye-audio.sh` to the config directory - this is typically `/data/etc/`.

Make the script executable - For Linux, navigate to the directory containing the script and and run:
      
      chmod +x motioneye-audio.sh
      
## Configuration

*Please confirm the ` %t %f '%$'` ordering as this was changed August 2020 when the script was changed back to `camera_id` from `camera_name`.*

In your camera settings, under the `Video Device` section add the following to `Extra Motion Options`:

**Docker**

      on_movie_start /etc/motioneye/motioneye-audio.sh start %t %f '%$'
      
**MotionEyeOS**

      on_movie_start /data/etc/motioneye-audio.sh start %t %f '%$'
      
In your camera settings, under the `File Storage` section enable `Run a Command` and add the following command:

**Docker**

      /etc/motioneye/motioneye-audio.sh stop %t %f '%$'
      
**MotionEyeOS**

      /data/etc/motioneye-audio.sh stop %t %f '%$'

The configuration section will need to be done for each camera that you want to add audio to the recordings.
