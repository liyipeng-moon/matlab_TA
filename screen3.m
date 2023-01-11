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
    
    % 我们想呈现一个视角5度的图片
    pixs=deg2pix(5,13.3,wsize(3),50);
    % 计算这个条件下对应视角在屏幕中的像素数
    
    % 画图
    % 首先加载图片
    cd Screen_tutorial/images/
    files=dir('*tif*');
    for i= 1:length(files)
        image_pool{i}=imread(files(i).name);
    end
    

    trial_interval=2; %试次之间的间隔
    fix_onset=0.5;
    image_onset=1;
    mask_onset=1;
    word_onset=1;
    for i = 1:length(image_pool)
        Screen('FillRect',win,128);  %背景与注视点
        Screen('FillOval', win , color_feature,  [cx-5, cy-5, cx+5, cy+5]);
        time_stamp = Screen('Flip',win,time_stamp+trial_interval); 
    
        % 展示图片
        Screen('FillRect',win,128);
        Image_Index=Screen('MakeTexture', win, image_pool{i});
        Screen('DrawTexture', win, Image_Index,[],[cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
        time_stamp = Screen('Flip',win,time_stamp+fix_onset);
        % 呈现mask
        Screen('FillRect',win,128);
        masks=im2uint8(rand(400));
        Image_Index=Screen('MakeTexture', win, masks);
        Screen('DrawTexture', win, Image_Index,[],[cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
        time_stamp = Screen('Flip',win,time_stamp+image_onset);
        % 呈现指导语
        Screen('FillRect',win,128);
        txt='Animal';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy,255);
        txt='Object';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy-bRect(4),255);
        txt='Scene';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy+bRect(4),255);
        time_stamp = Screen('Flip',win,time_stamp+mask_onset);
        % 要求被试反应
        Screen('FillRect',win,128);
        time_stamp = Screen('Flip',win,time_stamp+word_onset);
    end
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