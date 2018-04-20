%% feaSegmentation
clear
clc

feaFolder = '../data/summit/';
feaList = dir(feaFolder);

feaImList = {};
counter = 1;
%% filter the layer0_1.mat file and load in the data
for i = 1:length(feaList)
    if feaList(i).isdir == 1
        continue;
    else
        if strcmp(feaList(i).name(end - 11 : end),'layer0_1.mat') == 1
            load([feaFolder feaList(i).name]);
            feaImList{counter}.im = im;
            feaImList{counter}.size = size(im);
            feaImList{counter}.len = feaImList{counter}.size(1) * feaImList{counter}.size(2);
            feaImList{counter}.mask = zeros(feaImList{counter}.size(1), feaImList{counter}.size(2),3,'uint8');
            counter = counter + 1;  
            clear im
        end
    end
    
end

%% kmeans for segmentation and show the segmentation result
num_k = 2;

fea = [];
for i = 1 : length(feaImList)
    tmpfea = reshape(feaImList{i}.im, feaImList{i}.size(1) * feaImList{i}.size(2), feaImList{i}.size(3));
    fea = cat(1,fea,tmpfea);
end

idx = kmeans(fea,2);

%% show the segmentations for each image
m_colorMap = ceil(jet(num_k) * 255);
% for each cluster
for i = 1 : num_k
    % for each image
    maskIdx = idx == i;
    for j = 1 : length(feaImList)
        tmpMask = zeros(feaImList{j}.size(1), feaImList{j}.size(2), 'uint8');
        tmpMask(maskIdx(1:feaImList{j}.len)) = m_colorMap(i,1);
        feaImList{j}.mask(:,:,1) = feaImList{j}.mask(:,:,1) + tmpMask;
        % clear and set the second channel
        tmpMask = tmpMask .* 0;
        tmpMask(maskIdx(1:feaImList{j}.len)) = m_colorMap(i,2);
        feaImList{j}.mask(:,:,2) = feaImList{j}.mask(:,:,2) + tmpMask;
        % clear and set the third channel
        tmpMask = tmpMask .* 0;
        tmpMask(maskIdx(1:feaImList{j}.len)) = m_colorMap(i,3);
        feaImList{j}.mask(:,:,3) = feaImList{j}.mask(:,:,3) + tmpMask;
        maskIdx = maskIdx(feaImList{j}.len + 1 : end);
    end
end

%% show the figure

for i = 1 : length(feaImList)
    figure(i)
    imshow(feaImList{i}.mask)
end