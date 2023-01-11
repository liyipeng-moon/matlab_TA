cd images/

images_nm = dir(['*.tiff']);
for one_image = 1:length(images_nm)
    img_nm=images_nm(one_image).name;
    image_pool{one_image}=imread(img_nm);
    imshow(image_pool{one_image});
    pause(0.5);
end
cd ..

figure(1)
temp_image=image_pool{2};
subplot(1,4,1);
    imshow(temp_image)
    size(temp_image) % 三个通道分别代表什么？
% 第一个纬度
    subplot(1,4,2)
    imshow(temp_image(1:200,:,:))
% 第二个纬度
    subplot(1,4,3)
    imshow(temp_image(:,1:200,:))
% 第三个纬度 - RGB 三个通道
    subplot(1,4,4)
    temp_image(:,:,1)=1;
    temp_image(:,:,2)=1;
    imshow(temp_image)

figure(2)
temp_image=image_pool{6};
subplot(1,5,1);
imshow(temp_image); % 缩放的图片，注意'method'
small_img=imresize(temp_image,[20,20]);
subplot(1,5,2)
imshow(small_img);
subplot(1,5,3) % 缩放的图片，如果比例不一样？
small_img=imresize(temp_image,[200,100]);
imshow(small_img);
subplot(1,5,4); % 裁剪的图片
croped_img=imcrop(temp_image,[50,50,50+50,50+50]);
imshow(croped_img);
subplot(1,5,5); % 旋转的图片
rorared_img=imrotate(temp_image,90);
imshow(rorared_img);


% method of imresize
figure(3)
im_orig=[zeros(5);ones(5)];
subplot(1,3,1)
imshow(im_orig)
subplot(1,3,2)
im_default=imresize(im_orig,[400,400]);
imshow(im_default)
subplot(1,3,3)
im_box=imresize(im_orig,[400,400],'Method','box');
imshow(im_box)

% 生成白噪音
imshow(rand(200))

figure(3)
% 两种色彩空间的转换
temp_image=image_pool{6};
temp_image(126,126,1);
subplot(1,2,1)
imshow(temp_image);
whos
double_image=im2double(temp_image);
subplot(1,2,2);
imshow(double_image);

% 生成正弦光栅
[x,y]=meshgrid(1:400,1:400);
gratings=(sin(x/10)+1)/2;
imshow(gratings)
% 生成高斯窗口
sigma=50;
cx=200;
cy=200;
gaussian=exp(-1/(2*sigma^2)*((x-cx).^2+(y-cy).^2));
imshow(gaussian)
% 生成gabor
imshow(gaussian.*gratings)