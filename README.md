# FRMIS: Fast and Robust Microscopic Image Stitching

FRMIS is a fast and robust automatic stitching algorithm to generate a consistent whole-slide image. This algorithm utilizes dominant SURF features from a small part of the overlapping region to achieve pairwise registration and consider the number of matched features in the global alignment. It implements global alignment algorithms such as Minimum Spanning Tree (MST) and Shortest Path Spanning Tree (SPT) for aligning the images. FRMIS is designed to stitch 2D microscopic images from different image modalities, including bright-field, phase-contrast, and fluorescence. 

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

## Usage

1. Clone or download the repository to your local machine.

2. Open the MATLAB script `start_stitch.m`.

3. Customize the script by setting the following parameters:

    - `dataset_dir`: Directory containing the images to be stitched.
    
    - `dataset_name`: Name of the dataset.
    
    - `Optimization_option`: Choose between 'False' and 'True' to enable/disable optimization.
    
    - `GlobalRegistration_option`: Choose between 'MST' and 'SPT' for global registration.
    
    - `blend_method_options`: Choose between 'Overlay' and 'Linear' for blending method.
    
    - `alpha`: Alpha value for linear blending.
    
    - Parameters specific to your dataset such as
    - `width`: Width of image grid (number of columns).
    - `height`: Height of image grid (number of rows).
    - , `overlap`, `img_num`, `img_type`, `sort_type`, and `modality`.

4. Run the script in MATLAB.

## Output

The script generates the stitched image and saves it as a JPEG file. It also saves the stitching results as a MAT file.

## Customization

You can customize the script further by adjusting parameters based on your specific dataset. Additionally, you can modify the code to incorporate different optimization, registration, and blending techniques.

## Notes

- Make sure to provide the correct path to the directory containing your dataset.

- Adjust the parameters according to the properties of your dataset for optimal stitching results.

- This script assumes that the images are named in a sequential order and can be sorted accordingly. If your images have a different naming convention, you may need to modify the sorting logic.

- Ensure that the necessary MATLAB toolboxes (such as Image Processing Toolbox) are installed and accessible.


