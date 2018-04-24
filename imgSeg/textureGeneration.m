%% mask texture generation
% this script was created for generating the texture with the given mask
% for each of the image, generate a folder containing the texture named as
% the masks.

% run feaSeg.m first

maskName = {'BLUE', 'GREEN', 'BLACK', 'WHITE', 'RED', 'YELLOW', 'GREY', 'LIGHT_BLUE', 'PURPLE'};

for i = 1 : length(feaImList)
    % exist the folder ?
    if exist([feaFolder, feaImList{i}.name],'dir') == 7
        status = rmdir([feaFolder, feaImList{i}.name],'s');
        if status == 0
            error(['folder ' feaFolder, feaImList{i}.name])
        end
    end
    status = mkdir([feaFolder, feaImList{i}.name]);
    if status == 0
        error(['folder ' feaFolder, feaImList{i}.name ' created failed']);
    end
    
    
    tmpImg = zeros(feaImList{i}.size(1), feaImList{i}.size(2));
    tmpImg2 = zeros(feaImList{i}.size(1), feaImList{i}.size(2));
    textureImg = zeros(400, 400, 3, 'uint8');
    for j = 1 : length(m_colorMap)
        index1 = feaImList{i}.mask(:, :, 1) == m_colorMap(j,1);
        index2 = feaImList{i}.mask(:, :, 2) == m_colorMap(j,2);
        index3 = feaImList{i}.mask(:, :, 3) == m_colorMap(j,3);
        index = index1 & index2 & index3;
        tmpImg2(index) = 1;
        ind = find(index == 1);
        
        if isempty(ind) == 1
            continue;
        end
        
        indx = rem(ind, feaImList{i}.size(1)) + 1;
        indy = floor((ind - 1) / feaImList{i}.size(1)) + 1;
%         for i1 = 1:length(indx)
%             tmpImg(indx(i1),indy(i1)) = 1;
%         end
%         figure(1)
%         imshow(tmpImg)
%         figure(2)
%         imshow(tmpImg2)
        r = imread([feaFolder feaImList{i}.name '.jpg']);
        count = 1;
        for i1 = 1:size(textureImg,1)
            for j1 = 1:size(textureImg,2)
                textureImg(i1,j1,:) = r(indx(count), indy(count),:);
                count = rem(count, length(indx)) + 1;
%                 if count == 57223
%                     disp('debug')
%                 end
%                 disp([num2str(count) '/' num2str(length(indx))])
            end
        end
        imwrite(textureImg, [feaFolder, feaImList{i}.name '/' maskName{j} '.png']);        
        disp(['imwrite ' feaFolder, feaImList{i}.name '/' maskName{j} '.png done']);
    end    
    
    % output the mask with padding as well as the original image with
    % padding
    
    % padding the image
    % enlarge the image with the ratio of 0.1 on each side
    paddingSize = round(feaImList{i}.size(1:2) * 1.2);
    paddingMask = zeros(paddingSize(1), paddingSize(2), 3, 'uint8');
%     paddingMask(:, :, 1) = paddingMask(:, :, 1) + 180;
%     paddingMask(:, :, 2) = paddingMask(:, :, 2) + 60;
    wRange = round(0.1 * feaImList{i}.size(1)) : round(0.1 * feaImList{i}.size(1)) + feaImList{i}.size(1) -1;
    hRange = round(0.1 * feaImList{i}.size(2)) : round(0.1 * feaImList{i}.size(2)) + feaImList{i}.size(2) -1;
    paddingMask(wRange,hRange,1) = feaImList{i}.mask(:,:,1);
    paddingMask(wRange,hRange,2) = feaImList{i}.mask(:,:,2);
    paddingMask(wRange,hRange,3) = feaImList{i}.mask(:,:,3);
    
    imwrite(paddingMask, [feaFolder, feaImList{i}.name '/mask_padding.png']);
    disp(['imwrite ' feaFolder, feaImList{i}.name '/mask_padding.png done'])
    
    paddingMask = zeros(paddingSize(1), paddingSize(2), 3, 'uint8');
%     paddingMask(:, :, 1) = paddingMask(:, :, 1) + 180;
%     paddingMask(:, :, 2) = paddingMask(:, :, 2) + 60;
    paddingMask(wRange,hRange,1) = r(:,:,1);
    paddingMask(wRange,hRange,2) = r(:,:,2);
    paddingMask(wRange,hRange,3) = r(:,:,3);
    
    imwrite(paddingMask, [feaFolder, feaImList{i}.name '/' feaImList{i}.name '_padding.png']);
    disp(['imwrite ' feaFolder, feaImList{i}.name '/' feaImList{i}.name '_padding.png done'])
end


