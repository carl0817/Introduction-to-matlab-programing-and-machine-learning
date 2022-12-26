%전체 코드에서 사용될 변수들을 global로 지정한다.
global x_st;
global y_st;
global h_p;
global aviobj;
global key;
global Answer;
global thisisans;
global order;
global Result_value;

%coherence 비율들을 총 110개 만든다.
coherence=[];
for i=1:10
    coherence = [coherence -100 -80 -60 -40 -20 0 20 40 60 80 100];
end
%coherence 비율을 랜덤하게 섞는다.
order= randperm(110);
order= coherence(order);

%점을 움직이는 동영상을 만들기 위한 figure을 설정한다.
h_fg= figure;
h_ax= axes(h_fg);

%starting point 점을 찍는다.
for i=1:100
    a = randi(100,1,1);
    b= randi(100,1,1);
    k = rand(1);
    l= rand(1);
    if k >=0.5
        x_st(i)=a;
    else
        x_st(i)= a*(-1);
    end
    if l> 0.5
        y_st(i) = b;
    else
        y_st(i) = b*(-1);
    end
    h_p(i)= plot(h_ax,x_st(i),y_st(i),'k.');
hold(h_ax,'on');
end
hold(h_ax,'off');

%figure의 가로와 세로의 특성과 점의 크기를 설정한다.
set(h_ax,'XLim',[-100 100]);
set(h_ax, 'YLim', [-100 100]);
set(h_p(:), {'MarkerSize'},{30});

%movie를 만들 기본 설정들이다.
aviobj = VideoWriter('coherencetest.avi');
aviobj.FrameRate = 10;
aviobj.Quality = 100;
open(aviobj);

%점을 움직이는 function을 통해 각각의 움직여진 frame을 만든다.
for i=1:110
movedots(order(i),x_st,y_st,h_p);
end

close(aviobj);

%psychtoolbox에서 movie를 실행하면서 반응을 받는데 필요한 변수들이다.
key=[];
[Answer(1:110).answer]=deal({});
thisisans(1:110)=deal(NaN);

%psychtoolbox에서 movie를 실행하며 반응을 얻는 function이다.
playMovie();

%반응을 처리하는 과정이다.
for i=1:110
    if isequal(Answer(i).answer,{})==1
        thisisans(i)= NaN;
    else
        len = length(Answer(i).answer{1});
        if len==1
        if Answer(i).answer{1}=='r' | Answer(i).answer{1}=='l'
            thisisans(i)=Answer(i).answer{1};
        end
    elseif len >=2
        for j=1:len
            an= Answer(i).answer{1}(1);
            if Answer(i).answer{1}(j)==an
                flag= 0;
            else
                flag=1;
                break;
            end
        end
        if (flag==0) & (an=='r' | an=='l')
            thisisans(i)=an;
        end
    end
    end
end

%결과를 그래프로 그래는데 필요한 변수이다.
[Result_value(1:11).answers]= deal([]);
[Result_value.percentage]=deal([]);

%그래프를 그리는 function이다.
mkgraph();