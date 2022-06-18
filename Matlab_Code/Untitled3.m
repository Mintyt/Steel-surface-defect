% �ο����ף� ��߶�top-hat �任��ȡϸ�ڵĶԱȶ���ǿ�㷨
% ���ߣ� ������ ��־��
% http://www.docin.com/p-1457027092.html
% Author: HSW
% Date: 2018-04-25
%

clc;
close all;
clear all;

% img = imread('lena.jpg');
img = imread('F:\DIP\ȱ�ݿ�\����������ƤCS1003(С����,ѹ�ۣ��ԱȱȽϴ�)\BOT48926594.jpg'); 

figure(1);
imshow(img, []);
title('ԭʼͼ��');

if size(img, 3) == 3
    img_in = rgb2gray(img);
else
    img_in = img;
end

img_in = im2double(img_in);

N = 3; %��߶ȵĸ���
% ������߶���top-hat�任��WTHs ������ȡ��ϸ������
% ������߶Ȱ�top-hat�任: BTHs ������ȡ��ϸ������
% �߶���С����
SEsSize = [3, 5, 7];
SEs = cell(1, N);
for i = 1:N
    SEs{i} = strel('disk', SEsSize(i));
end

% WTHs �� BTHs
WTHs = cell(1, N);
BTHs = cell(1, N);
sum = 0;
for i = 1:N
    WTHs{i} = img_in - imopen(img_in, SEs{i});  % imtophat(img_in, SEs{i});
    BTHs{i} = imclose(img_in, SEs{i}) - img_in; % imbothat(img_in, SEs{i});
    sum  = sum + i;
end

% �߶���ع�һ������ϵ���� lambda(i) = (N - i + 1) / sum 
% ϸ����ǿ�������ϵ����k 
k = 0.5; 
tmp = 1:N; 
lambda = (N - tmp + 1) / sum; 
img_out1 = img_in;
for i = 1:N
    img_out1 = img_out1 + k * lambda(i) * (WTHs{i} - BTHs{i});
end

figure(2);
imshow(img_out1, []);
title('��߶���̬ѧͼ����ǿ���');

% ������̬ѧͼ����ǿ
Dops = cell(1, N);
Dcls = cell(1, N);
for i = 1:N
    if i == 1
        Dops{i} = WTHs{i};
        Dcls{i} = BTHs{i};
    else
        Dops{i} = WTHs{i-1} - WTHs{i};
        Dcls{i} = BTHs{i} - BTHs{i-1};
    end
end

% �ȱ����������ӣ�lambdai = 1 / N
% ϸ����ǿ�������ϵ����k
k = 0.5; 
img_out2 = img_in;
for i = 1:N
    img_out2 = img_out2 + k * ( 1.0 / N * (Dops{i} - Dcls{i}));
end

figure(3);
imshow(img_out2, []);
title('�ȱ�����̬ѧͼ����ǿ���');

% �����ݶ�����Ӧ�����Ŀ�������: lambda
% �ݶ���Ӧ���Ʋ�����sigma 
sigma = 1.5;
g = cell(1, N);
g_max = zeros(1, N);
g_min = zeros(1, N);
for i = 1:N
    g{i} = imdilate(img_in, SEs{i}) - imerode(img_in, SEs{i}); % ��̬ѧ�ݶ�: ���� - ��ʴ
    g_max(i) = max(max(g{i}));
    g_min(i) = min(min(g{i}));
end

lambda = cell(1, N);
for i = 1:N
    tmp = g{i} - (g_max(i) + g_min(i)) / 2;
    lambda{i} = 1 ./ (1 + exp(-sigma .* tmp));
end

% ��һ��lambdaϵ��
lambdaNormal = cell(1,N);
tmp = zeros(size(lambda{i}));
for j = 1:N
    tmp = tmp + lambda{i};
end

for i = 1:N
    lambdaNormal{i} = lambda{i} ./ tmp;
end

img_out3 = img_in;
for i = 1:N
    img_out3 = img_out3 + k * (lambdaNormal{i} .* (Dops{i} - Dcls{i}));
end

figure(4)
imshow(img_out3, []);
title('����Ӧ��̬ѧͼ����ǿ');
figure(5)
subplot(2,2,1);
imhist(img);
title('img');
subplot(2,2,2);
imhist(img_out1);
title('��߶���̬ѧͼ����ǿ���');
subplot(2,2,3);
imhist(img_out2);
title('�ȱ�����̬ѧͼ����ǿ���');
subplot(2,2,4);
imhist(img_out3);
title('����Ӧ��̬ѧͼ����ǿ');