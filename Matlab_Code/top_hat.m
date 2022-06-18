clc;
clear all;
close all;
%Top-Hat����ͼ��
I=im2double(imread('F:\DIP\ȱ�ݿ�\����������ƤCS1003(С����,ѹ�ۣ��ԱȱȽϴ�)\BOT48926594.jpg'));
    
%=========================�Ҷ�Top-Hat����==================================        
%�뾶Ϊ40�Ĵ��̣�disk���ṹԪ�� 
r=40;
B=ones(2*r-1,2*r-1);
%���������40�ĵ�����
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
 
%-------------------------------�Ҷȿ�����---------------------------------
J_Opening=zeros(M,N);
%��ʴ����
J_Erosion=zeros(M,N);
for i=1:M
    for j=1:N
        %���ͼ���ӿ�����
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %ɾ��0ֵ������4��ͨ��ֵ
        C=C(:);
        C(ind)=[];
        J_Erosion(i,j)=min(C);
    end
end
%�Ը�ʴͼ�������չ
J_Erosion_pad=padarray(J_Erosion,[n_l,n_l],'symmetric');
%����ͼ��
for i=1:M
    for j=1:N
        %���ͼ���ӿ�����
        Block=J_Erosion_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %ɾ��0ֵ������4��ͨ��ֵ
        C=C(:);
        C(ind)=[];
        J_Opening(i,j)=max(C);
    end
end
J_HotHat=I-J_Opening;
% subplot(111)
% imshow(I)
% subplot(122)
%�ô��ɷ���ͼ���ֵ��
J_Otsu=Otsu(J_HotHat);
imshow(J_Otsu)