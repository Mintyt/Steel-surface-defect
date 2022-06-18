function prewitt(img)
    %prewitt
    model=[-1,0,1;-1,0,1;-1,0,1];
    I1=img;
    [m,n]=size(I1);
    I2=I1;
    for i=2:m-1
        for j=2:n-1
            tem=I1(i-1:i+1,j-1:j+1);
            tem=double(tem).*model;

            I2(i,j)=sum(sum(tem));
        end
    end
    figure()
    subplot(1,3,1);imshow(I1);title('原图');
    subplot(1,3,2);imshow(uint8(I2));title('prewitt边缘提取后的图像');
    I2=I2+I1;
    subplot(1,3,3);imshow(uint8(I2));title('锐化后的图像');

end