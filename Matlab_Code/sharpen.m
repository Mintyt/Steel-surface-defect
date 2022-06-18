function sharpen(img)
    %sobel
    %model=[-1,0,1;-2,0,2;-1,0,1];
    I1=img;
    [m,n]=size(I1);
    I2=double(I1);

    for i=2:m-1
        for j=2:n-1
            I2(i,j)=I1(i+1,j+1)+2*I1(i+1,j)+I1(i+1,j-1)-I1(i-1,j+1)-2*I1(i-1,j)-I1(i-1,j-1);
        end
    end
   
    %robert
    %model=[0,-1;1,0];
    I3=img;
    [m,n]=size(I3);
    I4=double(I3);
    for i=2:m-1
        for j=2:n-1
            I4(i,j)=I3(i+1,j)-I3(i,j+1);
        end
    end
    
    
    %prewitt
    model=[-1,0,1;-1,0,1;-1,0,1];
    I5=img;
    [m,n]=size(I5);
    I6=I5;
    for i=2:m-1
        for j=2:n-1
            tem=I5(i-1:i+1,j-1:j+1);
            tem=double(tem).*model;

            I6(i,j)=sum(sum(tem));
        end
    end
    
    figure()
    subplot(3,3,1);imshow(I1);title('原图');
    subplot(3,3,2);imshow(I2);title('Sobel边缘提取后的图像');
    I2 = I2 + double(I1);
    subplot(3,3,3);imshow(uint8(I2));title('锐化后的图像');
    
    subplot(3,3,4);imshow(I3);title('原图');
    subplot(3,3,5);imshow(I4);title('robert边缘提取后的图像');
    I4 = I4 + double(I3);
    subplot(3,3,6);imshow(uint8(I4));title('锐化后的图像');
    
    subplot(3,3,7);imshow(I5);title('原图');
    subplot(3,3,8);imshow(uint8(I6));title('prewitt边缘提取后的图像');
    I6=I6+I5;
    subplot(3,3,9);imshow(uint8(I6));title('锐化后的图像');
end