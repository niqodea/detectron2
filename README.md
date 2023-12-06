# Densepose magic-animate compatibility hack

## Instructions

1. Build the docker image
2. Run the docker image with name `densepose-magic-animate` and by mounting input and output volumes, mounting them in `/home/appuser/detectron2/projects/DensePose/input` and `/home/appuser/detectron2/projects/DensePose/output` respectively. The docker user should have read access to input and write access to output.
3. For inference, `mv`/`ln` your video in the mounted input directory, then use `sudo docker exec densepose-magic-animate ./convert-video-to-openpose.sh <VIDEO_FILENAME>`. You will find the densepose sequence video with the same file name in the output directory.
