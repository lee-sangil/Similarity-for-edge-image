function similarity = calculateSimilarity(refImage, estImage, RefCost, RefMatched, EstMatched)

numOfPixels = sum(sum(refImage | estImage));

unmatchedRefImage = refImage > 0;
unmatchedRefImage(RefMatched) = 0;
unmatchedEstImage = refImage > 0;
unmatchedEstImage(EstMatched) = 0;

unmatchedNumOfPixels = sum(sum(unmatchedRefImage | unmatchedEstImage));

matchedCost = sum(sum(RefCost.*RefMatched));
unmatchedCost = sum(sum(unmatchedNumOfPixels));

similarity = 100 * (1 - (matchedCost+unmatchedCost)/numOfPixels);