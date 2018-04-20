clear
clc

score = load('AVA.txt');
imgIdx = load('image.list');
sc = score(:,3:12);
sc = mean(sc,2);

[scSorted, index] = sort(sc,'descend');

top10Idx = index(1 : round(length(index) * 0.01));
bottom10Idx = index(end - round(length(index) * 0.01) : end);

