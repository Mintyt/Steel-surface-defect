clc
clear
clear all
path = 'F:\DIP2\������ģ������Ŀ飩\�����������';
sudir = dir(path);
for i=1:length(sudir)
    subdir = fullfile(path,sudir(i).name);
    cd(subdir);
    d = dir(['*.jpg']);
    for j=1:length(d)
        I = imread(d(j).name);
        I1 = sharpen_prewitt(I);
        imwrite(I1,d(j).name);
    end
end