function mkgraph

%이 function에서 사용되는 global 변수들이다.
global thisisans;
global key;
global order;
global Result_value;

%피실험자들의 지정 방향을 선택한 확률을 계산한다.
for i=1:11
        k=100-20*(i-1);
        Result_value(i).answers= thisisans(find(order==k));
        count= find(Result_value(i).answers=='r');
        count=length(count);
        Result_value(i).percentage= count/10;
end

%계산된 값을 figure에 점으로 찍는다.
figure(2)
x_value =[];
y_value= [];
for i = 1:11
    x_value = [x_value 100-20*(i-1)];
    y_value = [y_value Result_value(i).percentage];
    plot(x_value,y_value,'ko');
    hold on
end

%figure의 설정이다.
xlim([-100 100]);
ylim([0 1]);

%spline을 이용하여 곡선형태로 점을 잇는다.
x1=-100:0.1:100;
y1=spline(x_value,y_value,x1);
plot(x1,y1);
end