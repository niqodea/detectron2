#!/bin/sh

set -eu

root="$(dirname $0)"
video_filename="$1"

input_video_path="$root/input/$video_filename"
output_video_path="$root/output/$video_filename"

input_frames_path="$root/input-frames/$video_filename"
output_frames_path="$root/output-frames/$video_filename"
mkdir -p "$input_frames_path/"
mkdir -p "$output_frames_path/"
ffmpeg -i "$input_video_path" -vf 'fps=24' "$input_frames_path/%06d.png"
python "$root/apply_net.py" show "$root/configs/densepose_rcnn_R_50_FPN_s1x.yaml" "checkpoints/densepose_rcnn_R_50_FPN_s1x.pkl" "$input_frames_path/" dp_segm --output "$output_frames_path/frame.png"

# The densepose script saves outputs by prepending an integer to .png
ffmpeg -framerate 24 -pattern_type glob -i "$output_frames_path/frame.*.png" "$output_video_path"
