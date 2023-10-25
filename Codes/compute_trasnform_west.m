function [Y2, X2, index_ImMatch2, pointsPreviousNumb2, pointsNumb2, matchedNumb2, inlierNumb2, status] = compute_trasnform_west( I1, I2, index_matrix, M, N, X_pixel, OvX, Threshold_metric)

pointsPrevious = detectSURFFeatures(I1, 'ROI',[1 1 X_pixel M],'MetricThreshold', Threshold_metric);
points = detectSURFFeatures(I2, 'ROI',[round(N*(1-OvX)) 1 X_pixel M],'MetricThreshold', Threshold_metric);

[featuresPrevious, pointsPrevious] = extractFeatures(I1, pointsPrevious);
[features, points] = extractFeatures(I2, points);

pointsPreviousNumb2 = length(pointsPrevious);
pointsNumb2 = length(points);
% Find correspondences between I(n) and I(n-1).
indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
matchedPoints = points(indexPairs(:,1), :);
matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);
matchedNumb2 = length(matchedPoints);

if matchedNumb2 == 0
    inlierNumb2 = NaN;
    index_ImMatch2 = NaN;
    matchedNumb2 = NaN;
    status = 1;
    X2 = NaN;
    Y2 = NaN;
else
    [tforms2,inlierIndex, status] =  estimateGeometricTransform2D_customized(matchedPointsPrev, matchedPoints,'rigid', 'Confidence', 99.99, 'MaxNumTrials', 2000);
    if status == 0
        index_ImMatch2 = index_matrix;
        inlierNumb2 = sum(inlierIndex);
        X2 = (tforms2.Translation(1));
        Y2 = (tforms2.Translation(2 ));
    else
        inlierNumb2 = NaN;
        index_ImMatch2 = NaN;
        X2 = NaN;
        Y2 = NaN;
    end

end
end