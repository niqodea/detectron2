# Densepose magic-animate compatibility hack

## Instructions

1. Build the docker image
   ```sh
   docker build . -t densepose-magic-animate:latest
   ```
2. Set up input and output directories for the docker container. The docker user should have read access to input and write access to output.
   ```sh
   mkdir /path/to/input
   mkdir /path/to/output

   # If our user is different from 1000, the docker user will see these mounted directories as not owned
   # In that case, we need to make the output directory writable by anyone
   chmod 777 /path/to/output
   ```
2. Run the docker image and by mounting input and output volumes. Also specify the GPU device you want to use.
   ```sh
   docker run \
       -v /path/to/input:/home/app/user/detectron2/projects/DensePose/input \
       -v /path/to/output:/home/app/user/detectron2/projects/DensePose/output \
       --gpus device=1 \
       --name densepose-magic-animate densepose-magic-animate
   ```
3. For inference, `mv`/`ln` your video in the mounted input directory, then run the `convert-video-to-openpose.sh` script by specifying the video file name as argument. You will find the densepose sequence video in the output directory.
   ```sh
   ln /path/to/my-video.mp4 /path/to/input
   docker exec densepose-magic-animate ./convert-video-to-openpose my-video.mp4
   mv /path/to/output/my-video.mp4 /somewhere/else
   ```

## TODO

- - Return empty violet background image for frames with undetected poses instead of a black and white source frame
