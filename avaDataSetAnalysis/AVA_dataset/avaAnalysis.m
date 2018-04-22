clear
clc

score = load('AVA.txt');
imgIdx = load('image.list');
sc = score(:,3:12);
mysc = zeros(size(sc,1), 1);
for i = 1 : size(sc,2)
    mysc = mysc + sc(:,i) * i;
end

% sc = mean(sc,2);

[scSorted, index] = sort(mysc,'descend');

top10Idx = index(1 : round(length(index) * 0.01));
bottom10Idx = index(end - round(length(index) * 0.01) : end);

if exist('../../data/avaDataset/goodPhotos','dir') == 7
    status = rmdir('../../data/avaDataset/goodPhotos','s');
    if status == 0
        error('folder deleted failed: ../../data/avaDataset/goodPhotos');
    end
end

if exist('../../data/avaDataset/badPhotos','dir') == 7
    status = rmdir('../../data/avaDataset/badPhotos','s');
    if status == 0
        error('folder deleted failed: ../../data/avaDataset/badPhotos');
    end
end

status = mkdir('../../data/avaDataset/goodPhotos');
if status == 0
    error('folder created failed: ../../data/avaDataset/goodPhotos');
end
   
status = mkdir('../../data/avaDataset/badPhotos');
if status == 0
    error('folder created failed: ../../data/avaDataset/badPhotos');
end

%% copy the photos
sourceFolder = '../../data/avaDataset/images';

%% copy the good photos into the given folder
destFolder = '../../data/avaDataset/goodPhotos';
for i = 1 : length(top10Idx)
    if exist([sourceFolder, '/' num2str(top10Idx(i)) '.jpg'],'file') == 0
        continue;
    end
    copyfile([sourceFolder, '/' num2str(top10Idx(i)) '.jpg'],[destFolder, '/' num2str(top10Idx(i)) '.jpg']);
    disp([sourceFolder, '/' num2str(top10Idx(i)) '.jpg'])
end
disp(['copy good photos done'])

%% copy the bad photos into the given folder
destFolder = '../../data/avaDataset/badPhotos';
for i = 1 : length(bottom10Idx)
    if exist([sourceFolder, '/' num2str(bottom10Idx(i)) '.jpg'],'file') == 0
        continue;
    end
    copyfile([sourceFolder, '/' num2str(bottom10Idx(i)) '.jpg'],[destFolder, '/' num2str(bottom10Idx(i)) '.jpg']);
    disp([sourceFolder, '/' num2str(bottom10Idx(i)) '.jpg'])
end
disp(['copy bad photos done'])
