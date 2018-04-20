%% this script was created for deep feature analysis

folder = '/home/hejw005/Documents/learning/dpst/tools/data/summit';
fileList = dir(folder);

for i = 1 : length(fileList)
    if fileList(i).isdir == 1
        continue
    else
        if strcmp(fileList(i).name(end - 3 : end),'.fea') == 1
            %% extract the features and save as mat
            feaAnalysisExtractor(folder, fileList(i).name);
        end
    end
end
