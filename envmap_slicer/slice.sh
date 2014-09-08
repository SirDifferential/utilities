#!/bin/bash

# if making envmaps from blender to unity, the ordering is the following:
#
# right, back, left
# bottom, top, front

image_data=$1
slice_size_x=$2
slice_size_y=$3

convert $image_data -crop ${slice_size_x}x${slice_size_y} +repage +adjoin output_%02d.png
mv output_00.png right.png
mv output_01.png back.png
mv output_02.png left.png
mv output_03.png bottom.png
mv output_04.png top.png
mv output_05.png front.png

