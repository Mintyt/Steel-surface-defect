% im1=imread('F:\DIP\ȱ�ݿ�\����������ƤCS1003(С����,ѹ�ۣ��ԱȱȽϴ�)\BOT48926594.jpg');
% im2=imread('F:\DIP\ȱ�ݿ�\����HS1002(��������ϸ��)\BOT48926244.jpg');
% im3=imread('F:\DIP\ȱ�ݿ�\ѹ��(water droplet)\BOT48927162.jpg');
im4=imread('F:\DIP\ȱ�ݿ�\������ģ������Ŀ飩\�����������\TOP48975530.jpg');
% im5=imread('F:\DIP\ȱ�ݿ�\�Ͱ�YB1001����ɢ�ĺ�ɫ���������\BOT48926427.jpg');
% im6=imread('F:\DIP\ȱ�ݿ�\����\BOT48926103.jpg');
im7=imread('F:\DIP\ȱ�ݿ�\�ν��ͣ�����������״��һ���ɫ��\BOT48979683.jpg');
% im8=imread('F:\DIP\ȱ�ݿ�\�׵�\TOP48926184.jpg');
% im9=imread('F:\DIP\ȱ�ݿ�\����\TOP48979539.jpg');
% im10=imread('F:\DIP\ȱ�ݿ�\�ǹ����ߣ���ɫп�㣩(����ͼƬ����ȱ��)\TOP48926264.jpg');
% im11=imread('F:\DIP\ȱ�ݿ�\��㣨�ۼ��ĵ������\BOT48975626.jpg');

% sharpen(im1);
% sharpen(im2);
% sharpen(im3);
% sharpen(im4);
% sharpen(im5);
% sharpen(im6);
% sharpen(im7);
% sharpen(im8);
% sharpen(im9);
% sharpen(im10);
% sharpen(im11);

I1=tophat_1(im4);
prewitt(I1);
% I2=tophat_1(im7);
% prewitt(I2);
