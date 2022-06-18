function sobel(img)
    I1=img;
    %sobel
    %model=[-1,0,1;-2,0,2;-1,0,1];
    [m,n]=size(I1);
    I2=double(I1);

    for i=2:m-1
        for j=2:n-1
            I2(i,j)=I1(i+1,j+1)+2*I1(i+1,j)+I1(i+1,j-1)-I1(i-1,j+1)-2*I1(i-1,j)-I1(i-1,j-1);
        end
    end
    figure()
    subplot(1,3,1);imshow(I1);title('原图');
    subplot(1,3,2);imshow(I2);title('Sobel边缘提取后的图像');
    I2 = I2 + double(I1);
    subplot(1,3,3);imshow(uint8(I2));title('锐化后的图像');
    


end