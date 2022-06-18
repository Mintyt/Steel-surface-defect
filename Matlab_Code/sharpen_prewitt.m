function I=sharpen_prewitt(img)
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
    I=I2;
end