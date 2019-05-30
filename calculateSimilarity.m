function similarity = calculateSimilarity(refImage, estImage, RefCost, RefMatched, EstMatched)

NumOfPixels = sum(sum(refImage | estImage));

unmatchedRefImage = refImage > 0;
unmatchedRefImage(RefMatched) = 0;
unmatchedEstImage = estImage > 0;
unmatchedEstImage(EstMatched) = 0;

matchedNumOfPixels = sum(sum(RefMatched));
unmatchedNumOfPixels = sum(sum(unmatchedRefImage | unmatchedEstImage));

matchedCost = sum(sum(RefCost.*RefMatched));
unmatchedCost = unmatchedNumOfPixels;

similarity = 100 * (1 - (matchedCost+unmatchedCost)/NumOfPixels);
% similarity = 100 * (1 - (matchedCost+unmatchedCost)/(unmatchedNumOfPixels+matchedNumOfPixels));

% red = unmatchedRefImage;
% green = RefMatched | EstMatched;
% blue = unmatchedEstImage;
% img = cat(3, red,green,blue);
% 
% figure;imshow(refImage);
% figure;imshow(double(img));
% figure;imshow(estImage);