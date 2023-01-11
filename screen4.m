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

    flipIntv=Screen('GetFlipInterval', win);  % 获取屏幕刷新一次所用的时间，单位是s

    Screen('FillRect',win,128);  % 一个中性灰色的背景
    time_stamp = Screen('Flip',win); % time_stamp是屏幕翻转的时间，单位是秒
    
    % 我们想呈现一个视角5度的图片
    pixs=deg2pix(5,13.3,wsize(3),50);
    % 计算这个条件下对应视角在屏幕中的像素数
    
    % 画图
    % 首先加载图片
    cd /Users/lll/Desktop/Screen_tutorial/images
    files=dir('*tif*');
    for i= 1:length(files)
        Image_pool{i}=imread(files(i).name);
    end
    
    % 一共有多少条件？如果【一一进行组合】...
    % 设定SOA条件
    SOA_pool=[16.7:16.7:66.8000]/1000; SOA_pool=time2frame(flipIntv,SOA_pool);
    MASK_pool=1:2;

    % 这种设计是最懒但是最完备的设计，因为每一种条件都可以做
    Total_trial=length(Image_pool)*length(SOA_pool)*length(MASK_pool); 
    % 一共有这么多试次 遍历所有条件

    % 分配图像在这么多试次的分布
    Image_order=mod(randperm(Total_trial),length(Image_pool))+1;
    % number indicate which image to be shown
    SOA_order=mod(randperm(Total_trial),length(SOA_pool))+1;
    % number indicate which SOA we use
    Mask_order=randi(2,[1,Total_trial])-1;
    % 01 insicate whether mash is shown

    trial_interval=1; %试次之间的间隔 单位是s
    trial_interval=time2frame(flipIntv,trial_interval); % 单位是帧

    fix_onset=0.5; fix_onset=time2frame(flipIntv,fix_onset);
    mask_onset=0.5; mask_onset=time2frame(flipIntv,mask_onset);
    word_onset=3; word_onset=time2frame(flipIntv,word_onset);
    for i = 1:Total_trial
        
        Screen('FillRect',win,128);  %背景与注视点
        Screen('FillOval', win , 255,  [cx-5, cy-5, cx+5, cy+5]);
        time_stamp = Screen('Flip',win,time_stamp+(trial_interval-0.5)*flipIntv); 
        % 展示图片
        Screen('FillRect',win,128);
        Image_Index=Screen('MakeTexture', win, Image_pool{Image_order(i)});
        Screen('DrawTexture', win, Image_Index,[],[cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
        time_stamp = Screen('Flip',win,time_stamp+(fix_onset-0.5)*flipIntv); %达到呈现注释点0.5s的效果

        if(Mask_order(i))
            % 呈现mask
            Screen('FillRect',win,128);
            masks=im2uint8(rand(50));
            Image_Index=Screen('MakeTexture', win, masks);
            Screen('DrawTexture', win, Image_Index,[],[cx-pixs, cy-pixs, cx+pixs, cy+pixs]);
            time_stamp = Screen('Flip',win,time_stamp+(SOA_pool(SOA_order(i))-0.5)*flipIntv);
        else
            % 不呈现Mask
            Screen('FillRect',win,128);
            time_stamp = Screen('Flip',win,time_stamp+(SOA_pool(SOA_order(i))-0.5)*flipIntv);
        end

        % 呈现指导语
        Screen('FillRect',win,128);
        txt='2 Animal';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy,255);
        txt='1 Object';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy-bRect(4),255);
        txt='3 Scene';
        bRect= Screen('TextBounds',win,txt);
        Screen('DrawText',win,txt,cx-bRect(3)/2,cy+bRect(4),255);
        time_stamp = Screen('Flip',win,time_stamp+(mask_onset-0.5)*flipIntv);

        % 要求【被试反应】，下节课的重点！
        Screen('FillRect',win,128);
        time_stamp = Screen('Flip',win,time_stamp+(word_onset-0.5)*flipIntv);

    end

    time_stamp = Screen('Flip',win,time_stamp+1);

    stats.subinfo={'LYP','Male','22yrs'}; % 你也可以用cell记录
    stats.trial_num=Total_trial;
    stats.Image_order=Image_order;
    stats.image_shown=Image_pool;
    stats.SOAs=SOA_pool(SOA_order);
    stats.Masks=MASK_pool(Mask_order+1);
    stats.response=[]; % 这个是下节课的重点！
    stats.docs='Masks = 1 is unmask,Masks = 2 is masked';
    save mask_result.mat stats

    Screen('CloseAll');%sca;
catch

    sca;
end

function pixs=deg2pix(degree,inch,pwidth,vdist) 
    screenWidth = inch*2.54/sqrt(1+9/16); 
    pix=screenWidth/pwidth; 
    pixs = round(2*tan((degree/2)*pi/180) * vdist / pix); 
end

function nframe = time2frame(flipIntv,duration)
    nframe=round(duration/flipIntv);
end