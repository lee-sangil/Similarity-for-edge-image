function similarity = calculateSimilarity(refImage, estImage, RefCost, RefMatched, EstMatched)

unmatchedRefImage = refImage > 0;
unmatchedRefImage(RefMatched) = 0;
unmatchedEstImage = estImage > 0;
unmatchedEstImage(EstMatched) = 0;

matchedNumOfPixels = sum(sum(RefMatched));
unmatchedNumOfPixels = sum(sum(unmatchedRefImage | unmatchedEstImage));

matchedCost = sum(sum(RefCost.*RefMatched));
unmatchedCost = unmatchedNumOfPixels;

similarity = 100 * (1 - (matchedCost+unmatchedCost)/(unmatchedNumOfPixels+matchedNumOfPixels));