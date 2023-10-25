function [Tx_west, Ty_west, Tx_north, Ty_north,matchedNumb_west,matchedNumb_north,valid_translations_west,valid_translations_north] = filter_overlap(Tx_west,...
    Ty_west, Tx_north, Ty_north,matchedNumb_west,matchedNumb_north, nb_vert_tiles, nb_horz_tiles, M, N, OvX, OvY, percent_overlap_error)


nb_rows = M;
nb_cols = N;

% percent_overlap_error = 5;
overlap = OvY*100;

valid_translations_index1 = zeros(nb_vert_tiles,nb_horz_tiles);
valid_translations_index1(isnan(Ty_north)) = NaN;

ty_min = nb_rows - (overlap + percent_overlap_error)*nb_rows/100;
ty_max = nb_rows - (overlap - percent_overlap_error)*nb_rows/100;

% the valid translations are within the range bounds
valid_translations_index1(Ty_north>=ty_min & Ty_north<=ty_max) = 1;


overlap = 0;

valid_translations_index2 = zeros(nb_vert_tiles,nb_horz_tiles);
valid_translations_index2(isnan(Tx_north)) = NaN;

tx_min = (overlap - percent_overlap_error)*nb_cols/100;
tx_max = (overlap + percent_overlap_error)*nb_cols/100;
valid_translations_index2(Tx_north>=tx_min & Tx_north<=tx_max) = 1;

valid_translations_north = ones(nb_vert_tiles,nb_horz_tiles);
valid_translations_north(isnan(Tx_north)) = NaN;
valid_translations_north((valid_translations_index1 == 0  | valid_translations_index2 == 0 ))= NaN;
invalid_idx_north = isnan(valid_translations_north);
Tx_north(invalid_idx_north) = NaN;
Ty_north( invalid_idx_north) = NaN;
matchedNumb_north( invalid_idx_north) = NaN;


overlap = OvX*100;

valid_translations_index1 = zeros(nb_vert_tiles,nb_horz_tiles);
valid_translations_index1(isnan(Tx_west)) = NaN;

tx_min = nb_cols - (overlap + percent_overlap_error)*nb_cols/100;
tx_max = nb_cols - (overlap - percent_overlap_error)*nb_cols/100;

% the valid translations are within the range bounds
valid_translations_index1(Tx_west>=tx_min & Tx_west<=tx_max) = 1;

overlap = 0;

valid_translations_index2 = zeros(nb_vert_tiles,nb_horz_tiles);
valid_translations_index2(isnan(Ty_west)) = NaN;

ty_min = (overlap - percent_overlap_error)*nb_rows/100;
ty_max = (overlap + percent_overlap_error)*nb_rows/100;
valid_translations_index2(Ty_west>=ty_min & Ty_west<=ty_max) = 1;

valid_translations_west = ones(nb_vert_tiles,nb_horz_tiles);
valid_translations_west(isnan(Tx_west)) = NaN;
valid_translations_west((valid_translations_index1 == 0  | valid_translations_index2 == 0 ))= NaN;

invalid_idx_west = isnan(valid_translations_west);
Tx_west(invalid_idx_west) = NaN;
Ty_west( invalid_idx_west) = NaN;
matchedNumb_west( invalid_idx_west) = NaN;

end