# FRMIS: Fast and Robust Microscopic Image Stitching

FRMIS is a fast and robust automatic stitching algorithm to generate a consistent whole-slide image. This algorithm utilizes dominant SURF features from a small part of the overlapping region to achieve pairwise registration and consider the number of matched features in the global alignment.

This repository contains source code. All codes were implemented using Matlab.

FRMIS is designed to stitch 2D images from different image modalities, including bright-field, phase-contrast, and fluorescence. 


## Usage

The scan pattern in the WSI technique reveals the connection order of tiles and was used to sort them next to each other in a predefined pattern. 
Users should enter a path Directory, dataset name, Width, and height, and overlap portion of images.
The pattern of images. 
This information is available in WSI images.
There is an option to select the global alignment method MST or SPT
Select if the user wants to do optimization or not.
Select the modality of images to choose the threshold value. 
You can select a blending option

The output will be the stitched result and .mat file that contains tile positions, and the number of extracted,  matched, and inlier features for all tiles.
Translation parameters.
Graph weights, RMSE value, pairwise registration time, global alignment time,



