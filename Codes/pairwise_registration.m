function  [Tx_west, Ty_west, Tx_north, Ty_north, index_ImMatch_west,index_ImMatch_north, pointsPreviousNumb_west,pointsPreviousNumb_north,...
    pointsNumb_west,pointsNumb_north,matchedNumb_west,matchedNumb_north,inliersNumb_west,inliersNumb_north,Level1,Level2,weight_north,weight_west,time_pairwise,valid_translations_west,valid_translations_north] = pairwise_registration(source_directory, img_name_grid,index_matrix,...
    nb_vert_tiles,nb_horz_tiles,M, N, OvX,  OvY,channel,percent_overlap_error,modality,Optimization,time)
t = tic;

Level1 = NaN(nb_vert_tiles,nb_horz_tiles);
Level2 = NaN(nb_vert_tiles,nb_horz_tiles);

Ty_north = NaN(nb_vert_tiles,nb_horz_tiles);
Tx_north = NaN(nb_vert_tiles,nb_horz_tiles);

matchedNumb_north = NaN(nb_vert_tiles,nb_horz_tiles);

Ty_west = NaN(nb_vert_tiles,nb_horz_tiles);
Tx_west = NaN(nb_vert_tiles,nb_horz_tiles);

matchedNumb_west = NaN(nb_vert_tiles,nb_horz_tiles);

weight_north = NaN(nb_vert_tiles,nb_horz_tiles);
weight_west = NaN(nb_vert_tiles,nb_horz_tiles);

index_ImMatch_north = NaN(nb_vert_tiles,nb_horz_tiles);
index_ImMatch_west = NaN(nb_vert_tiles,nb_horz_tiles);

pointsNumb_north = NaN(nb_vert_tiles,nb_horz_tiles);
pointsPreviousNumb_north = NaN(nb_vert_tiles,nb_horz_tiles);

pointsNumb_west = NaN(nb_vert_tiles,nb_horz_tiles);
pointsPreviousNumb_west = NaN(nb_vert_tiles,nb_horz_tiles);

inliersNumb_north = NaN(nb_vert_tiles,nb_horz_tiles);
inliersNumb_west = NaN(nb_vert_tiles,nb_horz_tiles);

if OvY > 0.05
    OverlapY = 0.05;
    Y_pixel = round(M*OverlapY);

else
    OverlapY = OvY;
    Y_pixel = round(M*OverlapY);
end

if OvX > 0.05
    OverlapX = 0.05;
    X_pixel = round(N*OverlapX);

else
    OverlapX = OvX;
    X_pixel = round(N*OverlapX);
end

switch modality
    case 'BrightField'
        Threshold_metric = 1000;
    case 'phase&Fluorescent'
        Threshold_metric = 1;
end
for j = 1:nb_horz_tiles
    %     fprintf('  col: %d  / %d\n', j ,nb_horz_tiles);
    fprintf('.');
    for i = 1:nb_vert_tiles

        %     read image from disk

        if channel == 3
            I1 = im2double(rgb2gray(imread([source_directory img_name_grid{i,j}])));
        else
            I1 = im2double(imread([source_directory img_name_grid{i,j}]));

        end

        if i > 1
            %       compute translation north


            if channel == 3
                I2 = im2double(rgb2gray(imread([source_directory img_name_grid{i-1,j}])));
            else
                I2 = im2double(imread([source_directory img_name_grid{i-1,j}]));
            end

            [Ty_north(i,j), Tx_north(i,j),index_ImMatch_north(i,j),pointsPreviousNumb_north(i,j),pointsNumb_north(i,j),matchedNumb_north(i,j),inliersNumb_north(i,j),status] = compute_trasnform_north( I1, I2,index_matrix(i,j), M,N, Y_pixel, OvY, Threshold_metric);
            if status == 0
                Level1(i,j) = 1;
            elseif status ~= 0 && OverlapY ~= OvY;

                [Ty_north(i,j), Tx_north(i,j),index_ImMatch_north(i,j),pointsPreviousNumb_north(i,j),pointsNumb_north(i,j),matchedNumb_north(i,j),inliersNumb_north(i,j),status] = compute_trasnform_north( I1, I2,index_matrix(i,j), M,N, round(M*OvY), OvY, Threshold_metric);
                if status == 0
                    Level1(i,j) = 2;
                end
            end
            %
        end
        if j > 1
            %       compute translation west

            if channel == 3
                I2 = im2double(rgb2gray(imread([source_directory img_name_grid{i,j-1}])));
            else
                I2 = im2double(imread([source_directory img_name_grid{i,j-1}]));
            end

            [Ty_west(i,j), Tx_west(i,j),index_ImMatch_west(i,j),pointsPreviousNumb_west(i,j),pointsNumb_west(i,j),matchedNumb_west(i,j),inliersNumb_west(i,j),status] = compute_trasnform_west( I1, I2,index_matrix(i,j), M,N, X_pixel, OvX, Threshold_metric);
            if status == 0
                Level2(i,j) = 1;
            elseif status ~= 0 && OverlapX ~= OvX;

                [Ty_west(i,j), Tx_west(i,j),index_ImMatch_west(i,j),pointsPreviousNumb_west(i,j),pointsNumb_west(i,j),matchedNumb_west(i,j),inliersNumb_west(i,j),status] = compute_trasnform_west( I1, I2,index_matrix(i,j), M,N, round(N*OvX), OvX, Threshold_metric);

                if status == 0
                    Level2(i,j) = 2;
                end
            end
        end
    end
end
[Tx_west, Ty_west, Tx_north, Ty_north,matchedNumb_west,matchedNumb_north,valid_translations_west,valid_translations_north] = filter_overlap(Tx_west, Ty_west, Tx_north, Ty_north,matchedNumb_west,matchedNumb_north,nb_vert_tiles,nb_horz_tiles,M, N, OvX,  OvY,percent_overlap_error);

N1 = 1./matchedNumb_north;
N2 = 1./matchedNumb_west;
maxN = max(max(N1(:)),max(N2(:)));
weight_north = (N1./ maxN);
weight_west =  (N2./ maxN);

for n = 2:nb_vert_tiles
    idx = isnan(Tx_north(n,:));
    if any(idx) && nnz(idx) == numel(idx)
        Tx_north(n,idx) = round(mean(Tx_north(~isnan(Tx_north))));
        Ty_north(n,idx) = round(mean(Ty_north(~isnan(Ty_north))));

    elseif any(idx) && nnz(idx) ~= numel(idx)
        Tx_north(n,idx) = floor(mean(Tx_north(n,(~idx)))+0.5);
        Ty_north(n,idx) = floor(mean(Ty_north(n,(~idx)))+0.5);

    end
end
weight_north (isnan(weight_north)) = max(weight_north(~isnan(weight_north) ))+.1;
weight_north(1,:)= NaN;

for n = 2:nb_horz_tiles
    idx = isnan(Tx_west(:,n));
    if any(idx) && nnz(idx) == numel(idx)
        Tx_west(idx,n) = round(mean(Tx_west(~isnan(Tx_west))));
        Ty_west(idx,n) = round(mean(Ty_west(~isnan(Ty_west))));

    elseif any(idx) && nnz(idx) ~= numel(idx)
        Tx_west(idx,n) = floor(mean(Tx_west((~idx),n))+0.5);
        Ty_west(idx,n) = floor(mean(Ty_west((~idx),n))+0.5);

    end
end
weight_west (isnan(weight_west)) = max(weight_west(~isnan(weight_west) ))+.1;
weight_west(:,1) = NaN;

time_pairwise = toc(t) +time;