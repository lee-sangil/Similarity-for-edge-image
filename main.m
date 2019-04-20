edgeCanny = imread('Canny.png');
edgeSobel = imread('Sobel.png');

similarity = measureCDM(edgeSobel, edgeCanny);

disp(similarity);