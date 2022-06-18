
function tophat(img)
    % img = imread('lena.jpg');
    %img = imread('F:\DIP\缺陷库\二次氧化铁皮CS1003(小长条,压痕，对比比较大)\BOT48926594.jpg'); 



    if size(img, 3) == 3
        img_in = rgb2gray(img);
    else
        img_in = img;
    end

    img_in = im2double(img_in);

    N = 3; %多尺度的个数
    % 创建多尺度亮top-hat变换：WTHs 用于提取亮细节特征
    % 创建多尺度暗top-hat变换: BTHs 用于提取暗细节特征
    % 尺度由小到大
    SEsSize = [3, 5, 7];
    SEs = cell(1, N);
    for i = 1:N
        SEs{i} = strel('disk', SEsSize(i));
    end

    % WTHs 和 BTHs
    WTHs = cell(1, N);
    BTHs = cell(1, N);
    sum = 0;
    for i = 1:N
        WTHs{i} = img_in - imopen(img_in, SEs{i});  % imtophat(img_in, SEs{i});
        BTHs{i} = imclose(img_in, SEs{i}) - img_in; % imbothat(img_in, SEs{i});
        sum  = sum + i;
    end

    % 尺度相关归一化因子系数： lambda(i) = (N - i + 1) / sum 
    % 细节增强增益控制系数：k 
    k = 0.5; 
    tmp = 1:N; 
    lambda = (N - tmp + 1) / sum; 
    img_out1 = img_in;
    for i = 1:N
        img_out1 = img_out1 + k * lambda(i) * (WTHs{i} - BTHs{i});
    end

    %等比例形态学图像增强
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

    % 等比例控制因子：lambdai = 1 / N
    % 细节增强增益控制系数：k
    k = 0.5; 
    img_out2 = img_in;
    for i = 1:N
        img_out2 = img_out2 + k * ( 1.0 / N * (Dops{i} - Dcls{i}));
    end



    % 基于梯度自适应调整的控制因子: lambda
    % 梯度响应控制参数：sigma 
    sigma = 1.5;
    g = cell(1, N);
    g_max = zeros(1, N);
    g_min = zeros(1, N);
    for i = 1:N
        g{i} = imdilate(img_in, SEs{i}) - imerode(img_in, SEs{i}); % 形态学梯度: 膨胀 - 腐蚀
        g_max(i) = max(max(g{i}));
        g_min(i) = min(min(g{i}));
    end

    lambda = cell(1, N);
    for i = 1:N
        tmp = g{i} - (g_max(i) + g_min(i)) / 2;
        lambda{i} = 1 ./ (1 + exp(-sigma .* tmp));
    end

    % 归一化lambda系数
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

    figure()
    subplot(4,2,1);
    imshow(img, []);
    title('原始图像');
    subplot(4,2,2);
    imhist(img);
    title('原始图像');
    subplot(4,2,3);
    imshow(img_out1, []);
    title('多尺度形态学图像增强结果');
    subplot(4,2,4);
    imhist(img_out1);
    title('多尺度形态学图像增强结果');
    subplot(4,2,5);
    imshow(img_out2, []);
    title('等比例形态学图像增强结果');
    subplot(4,2,6);
    imhist(img_out2);
    title('等比例形态学图像增强结果');
    subplot(4,2,7);
    imshow(img_out3, []);
    title('自适应形态学图像增强');
    subplot(4,2,8);
    imhist(img_out3);
    title('自适应形态学图像增强');

end
