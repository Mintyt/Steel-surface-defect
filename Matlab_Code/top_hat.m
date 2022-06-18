clc;
clear all;
close all;
%Top-Hat测试图像
I=im2double(imread('F:\DIP\缺陷库\二次氧化铁皮CS1003(小长条,压痕，对比比较大)\BOT48926594.jpg'));
    
%=========================灰度Top-Hat操作==================================        
%半径为40的磁盘（disk）结构元素 
r=40;
B=ones(2*r-1,2*r-1);
%将距离大于40的点置零
for i=1:2*r-1
    for j=1:2*r-1
        d=sqrt((i-r)^2+(j-r)^2);
        if d>r
            B(i,j)=0;
        end
    end
end
n=2*r-1;
ind=find(B==0);
n_l=r-1;
I_pad=padarray(I,[n_l,n_l],'symmetric');
[M,N]=size(I);
 
%-------------------------------灰度开操作---------------------------------
J_Opening=zeros(M,N);
%腐蚀操作
J_Erosion=zeros(M,N);
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Erosion(i,j)=min(C);
    end
end
%对腐蚀图像进行扩展
J_Erosion_pad=padarray(J_Erosion,[n_l,n_l],'symmetric');
%膨胀图像
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=J_Erosion_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Opening(i,j)=max(C);
    end
end
J_HotHat=I-J_Opening;
% subplot(111)
% imshow(I)
% subplot(122)
%用大律法将图像二值化
J_Otsu=Otsu(J_HotHat);
imshow(J_Otsu)