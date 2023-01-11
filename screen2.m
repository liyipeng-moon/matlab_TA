global screens screenNumber win wsize flipIntv slack cx cy time_stamp
% 什么是全局变量？

try % 为什么要try 跟着catch？

    HideCursor; % 隐藏鼠标
    InitializeMatlabOpenGL;
    Screen('Preference', 'SkipSyncTests',1); % 跳过刷新率检测（硬件问题）
    screens=Screen('Screens'); 
    screenNumber=max(screens);  % 第一个屏幕就是0
    [win,wsize]=Screen('OpenWindow',screenNumber);%打开窗口并返回两个重要变量
    cx = wsize(3)/2; cy = wsize(4)/2;  % 中央，Screen中像素的布局
    flipIntv=Screen('GetFlipInterval', win);  % 获取屏幕刷新率，单位是s
    
    Screen('FillRect',win,128);  % 一个中性灰色的背景
    time_stamp = Screen('Flip',win); % time_stamp是屏幕翻转的时间，单位是秒
    
    % 我们想呈现一个视角5度的刺激，不管是什么刺激
    pixs=deg2pix(5,13.3,wsize(3),50);
    % 计算这个条件下对应视角在屏幕中的像素数
    
    color_feature=[140,30,30];
    
    Screen('FillRect',win,128); 
    Screen('DrawLine', win, color_feature, cx-pixs, cy, cx+pixs, cy,1);
    time_stamp = Screen('Flip',win,time_stamp+2);
    % Screen(‘DrawLine’, windowPtr [,color], fromH, fromV, toH, toV [,penWidth]);
    
    % 一个变粗的线条
    for width_now = 1:7
        Screen('FillRect',win,128); 
        Screen('DrawLine', win, color_feature, cx-pixs, cy, cx+pixs, cy,width_now);
        time_stamp = Screen('Flip',win,time_stamp+1);
    end
    
    % 一个小方块
    Screen('FillRect',win,128);  % 一个大方块
    Screen( 'FillRect', win ,color_feature, [cx-pixs, cy-pixs, cx+pixs, cy+pixs])
    %Screen( 'FillRect', windowPtr [,color] [,rect] ); 小方块
    time_stamp = Screen('Flip',win,time_stamp+2);
    
    % 一个空心方块
    Screen('FillRect',win,128);  % 一个大方块
    Screen( 'FrameRect', win ,color_feature, [cx-pixs, cy-pixs, cx+pixs, cy+pixs])
    time_stamp = Screen('Flip',win,time_stamp+2);
    % Screen(%FrameRect , windowPtr [,color] [,rect] [,penWidth]);
    % 空心和实心的语法差异不大，基本就是 Fill 和 Frame 的差异，see doc
    
    % 画圆形
    Screen('FillRect',win,128);  % 一个大方块
    Screen('FillOval', win , color_feature,  [cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
    % Screen(‘FillOval’, windowPtr [,color] [,rect] [,perfectUpToMaxDiameter]);
    time_stamp = Screen('Flip',win,time_stamp+2);

    % 写字 指导语
    txt='Welcome to MATLAB Tutorial by LiYipeng...';
    bRect= Screen('TextBounds',win,txt); % 返还写这么多字需要多大的位置
    % [normBoundsRect, offsetBoundsRect, textHeight, xAdvance] = Screen(‘TextBounds’, windowPtr, text [,x] [,y] [,yPositionIsBaseline] [,swapTextDirection]);
    Screen('DrawText',win,txt,cx-bRect(3)/2,cy-bRect(4)/2,255);
    % [newX, newY, textHeight]=Screen(‘DrawText’, windowPtr, text [,x] [,y] [,color] [,backgroundColor] [,yPositionIsBaseline] [,swapTextDirection]);
    time_stamp = Screen('Flip',win,time_stamp+2);


    % 画图
    % 首先加载图片
    cd Screen_tutorial/images/
    files=dir('*tif*');
    image_loaded=imread(files(1).name);
    imshow(image_loaded);

    Image_Index=Screen('MakeTexture', win, image_loaded);
    % textureIndex=Screen(‘MakeTexture’, WindowIndex, imageMatrix [, optimizeForDrawAngle=0] [, specialFlags=0] [, floatprecision] [, textureOrientation=0] [, textureShader=0]);
    Screen('DrawTexture', win, Image_Index,[],[cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
    %Screen(%DrawTexture’, windowPointer, texturePointer [,sourceRect] [,destinationRect] [,rotationAngle] [, filterMode] [, globalAlpha] [, modulateColor] [, textureShader] [, specialFlags] [, auxParameters]);
    time_stamp = Screen('Flip',win,time_stamp+2);
    
    time_stamp = Screen('Flip',win,time_stamp+3);
    Screen('CloseAll');%sca;
catch
    sca;
end

function pixs=deg2pix(degree,inch,pwidth,vdist) 
    screenWidth = inch*2.54/sqrt(1+9/16); 
    pix=screenWidth/pwidth; 
    pixs = round(2*tan((degree/2)*pi/180) * vdist / pix); 
end