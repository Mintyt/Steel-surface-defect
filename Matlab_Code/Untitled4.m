% im1=imread('F:\DIP\缺陷库\二次氧化铁皮CS1003(小长条,压痕，对比比较大)\BOT48926594.jpg');
% im2=imread('F:\DIP\缺陷库\划伤HS1002(长的连续细线)\BOT48926244.jpg');
% im3=imread('F:\DIP\缺陷库\压伤(water droplet)\BOT48927162.jpg');
im4=imread('F:\DIP\缺陷库\发花（模糊不清的块）\清楚的杏仁形\TOP48975530.jpg');
% im5=imread('F:\DIP\缺陷库\油斑YB1001（闲散的黑色点或者条）\BOT48926427.jpg');
% im6=imread('F:\DIP\缺陷库\渐变\BOT48926103.jpg');
im7=imread('F:\DIP\缺陷库\滴焦油（带有完整形状的一块黑色）\BOT48979683.jpg');
% im8=imread('F:\DIP\缺陷库\白点\TOP48926184.jpg');
% im9=imread('F:\DIP\缺陷库\缩孔\TOP48979539.jpg');
% im10=imread('F:\DIP\缺陷库\非光整边（灰色锌层）(整个图片都是缺陷)\TOP48926264.jpg');
% im11=imread('F:\DIP\缺陷库\麻点（聚集的点或条）\BOT48975626.jpg');

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
