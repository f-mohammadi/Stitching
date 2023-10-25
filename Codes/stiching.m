function  main = stiching(source_directory, nb_horz_tiles, nb_vert_tiles, OverlapX, OverlapY, End, img_type, sort_type, dataset_name, modality,Optimization,GlobalRegistration)
tic;


files= dir(fullfile(source_directory,img_type));
files = natsortfiles({files.name});
Start =1;
hop = 1;
% End = img_num;
file = files(Start:hop:End);
num_Im = numel(file);

index_matrix = 1:nb_vert_tiles*nb_horz_tiles;

t = nb_vert_tiles;
nb_vert_tiles = nb_horz_tiles;
nb_horz_tiles = t;

if sort_type == 1 % % % for Tak & MIST dataset & ICIAR & USAF
    main.img_name_grid = reshape(file, nb_vert_tiles, nb_horz_tiles)';
    index_matrix = (reshape(index_matrix, nb_vert_tiles, nb_horz_tiles))';
else % % for ashlar dataset
    main.img_name_grid = reshape(file, nb_vert_tiles, nb_horz_tiles)';
    index_matrix = (reshape(index_matrix, nb_vert_tiles, nb_horz_tiles))';
    
    main.img_name_grid  = main.img_name_grid (sort(1:size(main.img_name_grid ,1),'descend'),:);
    index_matrix = index_matrix(sort(1:size(index_matrix,1),'descend'),:);
end

[nb_vert_tiles, nb_horz_tiles] = size(main.img_name_grid);

percent_overlap_error = 2;

[M N channel] = size(imread([source_directory main.img_name_grid{1,1}]));

time= toc;
[main.Tx_west, main.Ty_west, main.Tx_north, main.Ty_north, main.index_ImMatch_west, main.index_ImMatch_north,  main.pointsPreviousNumb_west, main.pointsPreviousNumb_north,...
    main.pointsNumb_west, main.pointsNumb_north, main.matchedNumb_west, main.matchedNumb_north, main.inliersNumb_west, main.inliersNumb_north,main.Level1,main.Level2,...
    main.weight_north,main.weight_west,main.time_pairwise,main.valid_translations_west,main.valid_translations_north] = pairwise_registration(source_directory,...
    main.img_name_grid,index_matrix,nb_vert_tiles,nb_horz_tiles,M, N, OverlapX, OverlapY,channel,percent_overlap_error,modality,Optimization,time);

switch Optimization
    case 'False'

        eval(sprintf('main.%s = global_registration_%s(main.Tx_west, main.Ty_west, main.Tx_north, main.Ty_north,main.weight_north,main.weight_west, nb_vert_tiles,nb_horz_tiles,source_directory, main.img_name_grid, channel, Optimization,dataset_name,main.time_pairwise);',GlobalRegistration,GlobalRegistration));

    case 'True'
        
        [main.Tx_west_optimized, main.Ty_west_optimized, main.Tx_north_optimized, main.Ty_north_optimized,main.time_pairwise_with_Optimization] = optimize_registrations(source_directory, main.img_name_grid,...
            main.Tx_west, main.Ty_west,main.Tx_north, main.Ty_north,nb_vert_tiles,nb_horz_tiles,main.valid_translations_west,main.valid_translations_north,main.time_pairwise);

        eval(sprintf('main.%s_optimized = global_registration_%s(main.Tx_west_optimized, main.Ty_west_optimized, main.Tx_north_optimized, main.Ty_north_optimized,main.weight_north,main.weight_west, nb_vert_tiles,nb_horz_tiles,source_directory, main.img_name_grid, channel, Optimization,dataset_name,main.time_pairwise_with_Optimization);',GlobalRegistration,GlobalRegistration));
end