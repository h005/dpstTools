%% vlfeat superpixel segmentation

in.imgName = '../data/in_moutain.png';
out.imgName = '../data/oMountainSpMask.png';
im = imread(in.imgName);

% ratio = 0.5;
% kernelsize = 2;
% Iseg = vl_quickseg(I, ratio, kernelsize, maxdist);

regionSize = 300;
regularizer = 200;
I = single(im);
imlab = vl_xyz2lab(vl_rgb2xyz(I));
segments = vl_slic(I, regionSize, regularizer);

vl_slic_show(im, segments);

m_colorMap = ceil(jet(double(max(max(segments))) + 1) * 255);

segImg = zeros(size(segments,1),size(segments,2),3, 'uint8');
for i = 1:size(segments,1)
    for j = 1:size(segments,2)
        segImg(i,j,:) = m_colorMap(segments(i,j) + 1,:);
    end
end

imshow(segImg)
imwrite(segImg, out.imgName);