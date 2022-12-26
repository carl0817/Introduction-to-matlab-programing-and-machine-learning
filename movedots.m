%function movedots.m

function result= movedots(ch,x_st,y_st,h_p);

%이 function에서 사용되는 global 변수들이다.
global x_st;
global y_st;
global h_p;
global aviobj;

%점의 x값이 증가하는 방향 혹은 감소하는 방향으로 향할 것인지 결정한다.
dx_r=[1:5:11, -10:5:0];
dx_r= repmat(dx_r,[1 3]);
dx_l=[0:-5:-10, 11:-5:1];
dx_l= repmat(dx_l, [1 3]);

%각 점이 움직일 기울기를 랜덤하게 하기 위한 변수이다.
for i=1:100
theta(i)=rand(1)*2*pi;
end 

%coherence 비율이 0일 때의 점들의 다음 좌표들을 계산한다.
if ch==0
    for ii=1: length(dx_r)
    for j=1:100
        value1= rand(1);
        if value1<=0.5
            x_new(j)= x_st(j)+dx_r(ii);
        else
            x_new(j)= x_st(j)+dx_l(ii);
        end
        y_new(j)= tan(theta(j))*x_new(j);
    end    
%각 좌표에 점을 그린다.
set(h_p(:), {'XData'},{x_new(:)},{'YData'},{y_new(:)});
pause(0.4);
%바뀐 좌표의 점들의 figure을 frame으로 갖는다.
F = getframe(gcf);
writeVideo(aviobj, F);
end
else
%랜덤 방향으로 움직이는 점들의 개수를 계산하기 위해 coherence 비율에
%절댓값을 씌운다.
Y = abs(ch);
%랜덤하게 움직일 점들을 랜덤하게 뽑기 위해 필요한 변수이다.
choice= randperm(100);

%각 coherence 비율에 따라 오른쪽 혹은 왼쪽으로 일정하게 움직이는 점들과
%무작위로 움직이는 점들의 다음 좌표를 계산한다.
for ii=1: length(dx_r)
    for s=1:Y
        j= choice(s);
        if ch>0
            x_new(j)= x_st(j)+dx_r(ii);
        else
            x_new(j)= x_st(j)+dx_l(ii);
        end
        y_new(j)=y_st(j);
    end
    for s=Y+1:100
        j= choice(s);
        value1= rand(1);
        if value1<=0.5
            x_new(j)= x_st(j)+dx_r(ii);
        else
            x_new(j)= x_st(j)+dx_l(ii);
        end
        y_new(j)= tan(theta(j))*x_new(j);
    end    
    
set(h_p(:), {'XData'},{x_new(:)},{'YData'},{y_new(:)});
pause(0.4);
F = getframe(gcf);
writeVideo(aviobj, F);
end
end

%각 실행 사이를 구분하기 위해 검정색 화면을 삽입한다.
p= patch([-100 100 100 -100], [-100 -100 100 100],'k');
F = getframe(gcf);
writeVideo(aviobj, F);

%검정색 화면을 7frame 동안 지속한다.
delete(p);
for i=1:7
F = getframe(gcf);
writeVideo(aviobj, F);
end

end