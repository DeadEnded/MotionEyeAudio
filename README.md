# MotionEye Audio
Script to add Audio recording to MotionEye NVR

Currently this has only been tested on continuous recording, but should work on motion events as well.

1)  Copy `motioneye-audio.sh` to `/etc/motioneye` and make sure it is executable
2)  In your camera settings, under the `Video Device` section add the following to `Extra Motion Options`:
      ```
      on_movie_start /etc/motioneye/motioneye-audio.sh start %t %f
      ```
3)  In your camera settings, under the `File Storage` section enable `Run a Command` and add the following command:
      ```
      /etc/motioneye/motioneye-audio.sh stop %t %f
      ```

This setup (steps 2 and 3) will need to be done for each camera that you want to add audio to the recordings.

***NOTE: If your system does not have an `/etc/motioneye/` directory, identify where your `motion.conf`, `motioneye.conf`, `camera-1.conf` etc. files are and store it there.  Then update the above paths accordingly.***
