clear all;close all;clc;
warning('off')
dataset_dir = '/home/user1/Downloads/Tak_Dataset-Corrected1/026-01-91-Corrected/'
dataset_name = '026-01-91-Corrected'
     
modality_option = {'BrightField','phase&Fluorescent'};
Optimization_option = {'False','True'};
GlobalRegistration_option = {'MST','SPT'};

% Choose optimization and global registration options
Optimization = Optimization_option{2};
GlobalRegistration = GlobalRegistration_option{1};

%% for Tak dataset
width = 10; height = 10; overlap = 0.25; img_num = 100; img_type = '*.jpg'; sort_type = 1;modality = modality_option{1};
% %% for human colon dataset
% width = 29; height = 21; overlap = 0.03; img_num = 609; img_type = '*.tif'; sort_type = 2;modality = modality_option{1};
% %% for stem cell colony (SCC) dataset: Level3
% width = 23; height = 24; overlap = 0.1; img_num = 552; img_type = '*.tif'; sort_type = 1;modality = modality_option{2};
% %% for stem cell colony (SCC) dataset: Level1, Level2, phase
% width = 10; height = 10; overlap = 0.1; img_num = 100; img_type = '*.tif'; sort_type = 1;modality = modality_option{2};
% %% for stem cell colony (SCC) dataset: small, small_phase
% width = 5; height = 5; overlap = 0.19; img_num = 25; img_type = '*.tif'; sort_type = 1;modality = modality_option{2};
% %% for USAF & ICIAR
%     width = 10; height = 10; overlap = 0.30; img_num = 100; img_type = '*.tif'; sort_type = 1;modality = modality_option{1};


stitching_results = stiching(dataset_dir, width, height, overlap, overlap, img_num, img_type, sort_type, dataset_name, modality,Optimization,GlobalRegistration);
fprintf('\n Stitching %s done', dataset_name);
save(sprintf('%s_stitching_result_Optimization_%s_%s.mat',dataset_name, Optimization, GlobalRegistration));
