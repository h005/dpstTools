%% feaSegmentation
clear
clc
load /home/hejw005/Documents/learning/dpst/tools/data/summit/Google_0010_layer0_1.mat
im1.im = im;
im1.size = size(im);
im1.len = im1.size(1) * im1.size(2);
im1.mask = zeros(im1.size(1), im1.size(2), 3, 'uint8');
load /home/hejw005/Documents/learning/dpst/tools/data/summit/Google_0011_layer0_1.mat
im2.im = im;
im2.size = size(im);
im2.len = im2.size(2) * im2.size(2);
im2.mask = zeros(im2.size(1), im2.size(2), 3, 'uint8');
clear im

fea1 = reshape(im1.im, im1.size(1) * im1.size(2), im1.size(3));
fea2 = reshape(im2.im, im2.size(1) * im2.size(2), im2.size(3));

fea = cat(1,fea1,fea2);
idx = kmeans(fea,2);

idx1 = idx(1:im1.len);
index = idx1 == 1;
im1.mask(index) = 255;
im1.mask(index) = 0;
im1.mask(index) = 0;
index = idx1 == 2;
im1.mask(index) = 0;
im1.mask(index) = 0;
im1.mask(index) = 255;
imshow(im1.mask)

idx2 = idx(im1.len + 1: end);
index = idx1 == 1;
im2.mask(index) = 255;
im2.mask(index) = 0;
im2.mask(index) = 0;
index = idx2 == 2;
im2.mask(index) = 0;
im2.mask(index) = 0;
im2.mask(index) = 255;
figure
imshow(im2.mask)