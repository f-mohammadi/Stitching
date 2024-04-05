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
    
    Parameters specific to your dataset, available in Whole-Slide Imaging (WSI) technique, such as:
    - `width`: Width of image grid (number of columns).
    - `height`: Height of image grid (number of rows).
    - `overlap`: Overlap percent between adjacent tiles.
    - `img_num`: Total number of tiles.
    - `img_type`: Image file type.
    - `sort_type`: Sorting type indicates patern of grid (order of the tiles).
    - `modality`: Imaging modality to adjust the SURF's threshold value.

4. Run the script in MATLAB.

## Output

The script generates the stitched image and saves it as a JPG file. It also saves the stitching results as a MAT file.

- `img_name_grid`: Grid containing the names of image files.
- `Tx_west`: Horizontal translations for the west direction.
- `Ty_west`: Vertical translations for the west direction.
- `Tx_north`: Horizontal translations for the north direction.
- `Ty_north`: Vertical translations for the north direction.
- `index_ImMatch_west`: Index of image matches in the west direction.
- `index_ImMatch_north`: Index of image matches in the north direction.
- `pointsPreviousNumb_west`: Number of extracted feature points in the previous frame for the west direction.
- `pointsPreviousNumb_north`: Number of feature points in the previous frame for the north direction.
- `pointsNumb_west`: Total number of feature points for the west direction.
- `pointsNumb_north`: Total number of feature points for the north direction.
- `matchedNumb_west`: Number of matched feature points for the west direction.
- `matchedNumb_north`: Number of matched feature points for the north direction.
- `inliersNumb_west`: Number of inliers for the west direction.
- `inliersNumb_north`: Number of inliers for the north direction.
- `Level1`: Level of feature extraction for the west direction.
- `Level2`: Level of feature extraction for the north direction.
- `weight_north`: Weight for the north direction.
- `weight_west`: Weight for the west direction.
- `time_pairwise`: Time taken for pairwise alignment.
- `valid_translations_west`: Valid translations for the west direction.
- `valid_translations_north`: Valid translations for the north direction.


## Customization

You can customize the script further by adjusting parameters based on your specific dataset. Additionally, you can modify the code to incorporate different optimization, registration, and blending techniques.

## Notes

- Make sure to provide the correct path to the directory containing your dataset.

- Adjust the parameters according to the properties of your dataset for optimal stitching results.

- This script assumes that the images are named in a sequential order and can be sorted accordingly. If your images have a different naming convention, you may need to modify the sorting logic.

- Ensure that the necessary MATLAB toolboxes (such as Image Processing Toolbox) are installed and accessible.


