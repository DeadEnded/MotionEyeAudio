# MotionEye Audio
Script to add Audio recording to MotionEye NVR

Currently this has only been tested on continuous recording, but should work on motion events as well.

1)  Copy `motioneye-audio.sh` to `/etc/motioneye` - for containers, copy the file to the host directory mapped to the containers `/etc/motioneye' directory.
2)  Make the script executable - For Linux, navigate to the `/etc/motioneye` directory (or host mapped directory as above) and run:
      ```
      chmod +x motioneye-audio.sh
      ```
3)  In your camera settings, under the `Video Device` section add the following to `Extra Motion Options`:
      ```
      on_movie_start /etc/motioneye/motioneye-audio.sh start %t %f
      ```
4)  In your camera settings, under the `File Storage` section enable `Run a Command` and add the following command:
      ```
      /etc/motioneye/motioneye-audio.sh stop %t %f
      ```

This setup (steps 2 and 3) will need to be done for each camera that you want to add audio to the recordings.

***NOTE: If you are using a container, `/etc/motioneye/` directory may be mapped to a different directory on the host.  Identify where your `motion.conf`, `motioneye.conf`, `camera-1.conf` etc. files are and store this stript there.  Then update ONLY STEPS 1 and 2 with this path  (steps 3 and 4 are within the container and so should use `/etc/motioneye`).  If you are not using a container, identify the host directory path for config files and update all 4 steps with the correct path***
