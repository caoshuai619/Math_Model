clc,clear
sj0=load('sa.txt');
x=sj0(:,1:2:8);x=x(:); 
y=sj0(:,2:2:8);y=y(:); 
sj=[x y]; d1=[70,40]; 
sj=[d1;sj;d1]; sj=sj*pi/180; 
d=zeros(102); %������� d 
for i=1:101 
 for j=i+1:102 
 temp=cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2)); 
 d(i,j)=6370*acos(temp); 
 end 
end 
d=d+d'; 
path=[];lenth=inf;
%�������ؿ��巨��ñȽϺõĳ�ʼ·��
rand('state',sum(clock)); 
for j=1:1000 
 path0=[1 1+randperm(100),102]; 
 temp=0;
 for i=1:101
temp=temp+d(path0(i),path0(i+1));
end
if temp<lenth
path=path0;lenth=temp;
end
end
e=0.1^30;L=20000;at=0.999;T=1;
%�˻����
for k=1:L
%�����½�
c=2+floor(100*rand(1,2));
c=sort(c);
c1=c(1);c2=c(2);
%������ۺ���ֵ
df=d(path(c1-1),path(c2))+d(path(c1),path(c2+1))-d(path(c1-1),path(c1))-d(path(c2),path(c2+1));
%����׼��
if df<0
path=[path(1:c1-1),path(c2:-1:c1),path(c2+1:102)];
lenth=lenth+df;
elseif exp(-df/T)>rand(1)
path=[path(1:c1-1),path(c2:-1:c1),path(c2+1:102)];
lenth=lenth+df;
end
T=T*at;
if T<e
break;
end
end
% ���Ѳ��·����·������
path;
lenth;
sj = sj * 180/pi;
xx = sj(path,1);
yy = sj(path,2);
plot(xx,yy,'-*')