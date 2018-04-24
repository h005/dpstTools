img.path = '/home/hejw005/Documents/learning/dpst/tools/data/in_moutain.png';

% laplace kernel 1
lap.k1 = [0,1,0; 1, -4, 1; 0,1,0];
lap.k2 = -lap.k1;
lap.k3 = [1,1,1;1,-8,1;1,1,1];
lap.k4 = -lap.k3;

img.im = imread(img.path);
img.im = double(img.im);
img.filter = zeros(size(img.im));

filteredImg = imfilter(img.im(:,:,1), lap.k1, 'same');
img.filter(:,:,1) = filteredImg;

filteredImg = imfilter(img.im(:,:,2), lap.k1, 'same');
img.filter(:,:,2) = filteredImg;

filteredImg = imfilter(img.im(:,:,3), lap.k1, 'same');
img.filter(:,:,3) = filteredImg;

%% enhancement
img.im = img.im - img.filter;
img.im = uint8(img.im);

figure
imshow(img.im)
