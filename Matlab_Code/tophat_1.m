function I=tophat_1(img)
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
    I=(img_out1);
end