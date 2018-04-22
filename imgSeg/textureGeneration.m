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
    
    % output the mask
    imwrite(feaImList{i}.mask, [feaFolder, feaImList{i}.name '/mask.png']);
    disp(['imwrite ' feaFolder, feaImList{i}.name '/mask.png done'])
end




