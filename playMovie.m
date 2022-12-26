function playMovie

%이 function에서 사용되는 global 변수들이다.
global key;
global Answer;

%psychtoolbox에서 movie를 실행하기 위한 변수들이다.
toTime= inf;
soundvolume= 1;
pMovie= [pwd '\coherencetest.avi'];
Screen('Preference', 'SkipSyncTests', 1);
[wPtr, rect] = Screen('OpenWindow', max(Screen('screens')), 0, [0 0 1080 768]);
[movie, dur, fps, width, height] = Screen('OpenMovie', wPtr, pMovie);
Screen('PlayMovie', movie, 1, 0, soundvolume);
t= GetSecs();

%피실험자에게서 얻는 반응을 받을 변수이다.
key=[];
[Answer(1:110).answer]=deal({});
now=[];
t_curr= GetSecs();
in = [0:2.6: 286]; %2.6*110=286

%movie를 실행하는 infinite while loop이다.
while t < toTime
    
    %눌려진 키를 받는다.
    t_curr= GetSecs();
    [keyIsDown, pressedSecs, keyCode] = KbCheck(-1);
    if keyIsDown~=0
    pressedKey = KbName(find(keyCode))
    key = pressedKey;
    now = [now; key];
    
    %키가 눌려진 시간에 따라 몇 번째 실행인지를 계산하여 변수에 저장한다.
     for i=1:110
        if t_curr>t+in(i) & t_curr<=t+in(i+1)
            Answer(i).answer={[cell2mat(Answer(i).answer), key]};
            break;
        end
    end
    end
    
    %movie를 실행한다.
    tex= Screen('GetMovieImage', wPtr, movie);
    if tex<=0
        break;
    end
    Screen('DrawTexture', wPtr, tex);
    Screen('Flip', wPtr);
    Screen('Close', tex);
end
Screen('PlayMovie', movie, 0);
Screen('CloseMovie', movie);
sca;
end