global screens screenNumber win wsize flipIntv slack cx cy time_stamp
% 什么是全局变量？

try % 为什么要try 跟着catch？
    Screen('Flip?') % Screen帮助的使用
    Screen('Version') % Screen版本
    % online document - http://psychtoolbox.org/docs/Screen

    HideCursor; % 隐藏鼠标
    InitializeMatlabOpenGL;
    Screen('Preference', 'SkipSyncTests',1); % 跳过刷新率检测（硬件问题）

    screens=Screen('Screens'); 
    screenNumber=max(screens);  % 第一个屏幕就是0

    [win,wsize]=Screen('OpenWindow',screenNumber);%打开窗口并返回两个重要变量

    cx = wsize(3)/2; cy = wsize(4)/2;  % 中央，Screen中像素的布局
    
    flipIntv=Screen('GetFlipInterval', win);  % 获取屏幕刷新率，单位是s
    slack=flipIntv/2; % 为什么要除以二？
    
    Screen('FillRect？')
    Screen('FillRect',win,128); 
    % 画一个覆盖全屏幕的长方形（也可以指定位置大小，下一节会讲）
    % 其颜色是128
    %what if ... 换个颜色
    Screen('FillRect',win,[100,20,40]); 
    
    txt='Welcome to MATLAB Tutorial by LiYipeng...';
    bRect= Screen('TextBounds',win,txt);
    Screen('DrawText',win,txt,cx-bRect(3)/2,cy-bRect(4)/2,255);

    % 指导语
    time_stamp = Screen('Flip',win);

    WaitSecs(2)
    
    Screen('CloseAll');%sca;
catch
    sca;
end