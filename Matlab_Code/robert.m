function robert(img)
    %robert
    %model=[0,-1;1,0];
    I1=img;
    [m,n]=size(I1);
    I2=double(I1);
    for i=2:m-1
        for j=2:n-1
            I2(i,j)=I1(i+1,j)-I1(i,j+1);
        end
    end
    figure()
    subplot(1,3,1);imshow(I1);title('ԭͼ');
    subplot(1,3,2);imshow(I2);title('robert��Ե��ȡ���ͼ��');
    I2 = I2 + double(I1);
    subplot(1,3,3);imshow(uint8(I2));title('�񻯺��ͼ��');

end