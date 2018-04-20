%% parse deepfeature
%% this script was created for deep feature analysis
clear
clc
%% load the features
fcolor = '../data/summit/Google_0010';
fname = [fcolor '.fea'];

%{
sample input format:

layer 0
1 466 700 64 % dim_n dim_w dim_h dim_m
dim_n 0
dim_m 0
[] % the array with the shape of 466 X 700

%}

fid = fopen(fname, 'r');
layer = {};
while 1

    tline = fgetl(fid);
    if tline == -1
        break;
    end
%     ind = ind + 1;
    % separate the layer
    layer = split(tline);
    layerNum = str2double(layer{2});
    tline = fgetl(fid);
    dims = strtrim(tline);
    dims = strread(dims);
    
    mydata = zeros(dims);
    for ndim = 1 : dims(1)
        for mdim = 1 : dims(4)
            for wdim = 1 : dims(2)
                tline = fgetl(fid);
                tline = strtrim(tline);
%                 [ndim mdim wdim]
                tlineData = strread(tline);
                mydata(ndim, wdim, :, mdim) = tlineData;
            end
            tline = fgetl(fid);
        end
        % save as image
        im = mydata(ndim, :, :, :);
        im = reshape(im, size(im,2), size(im,3), size(im,4));
%         feaImg = [fcolor layer{1} layer{2} '_' num2str(ndim) '_' num2str(mdim) '.png']; 
%         imwrite(im, feaImg);
        feaName = [fcolor '_' layer{1} layer{2} '_' num2str(ndim) '.mat'];
        save(feaName, 'im');
        
        [layerNum ndim mdim]
    end  
    % load data into this layer
%     layer{layerNum + 1} =mydata;
    
end

disp('done')
