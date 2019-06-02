function [num, h] = MHD(A,B)%,K,Wn)
num = 0;
sumA=0;
sumB=0;
%nA=0; 
%% tính hAB
for i=1:size(A,2)
    for j=1:size(B,2)
        num=num+1;
	    distA(j)=sqrt((A(1,i)-B(1,j))^2 + (A(2,i)-B(2,j))^2);
    end
    %if(min(distA)<K)
    %    nA=nA+1;
    %end
	sumA = sumA+min(distA);
end
h_AB=sumA/size(A,2);
%% tinh hBA
%nB=0;
for i=1:size(B,2)
    for j=1:size(A,2)
        num=num+1;
	    distB(j)=sqrt((B(1,i)-A(1,j))^2 + (B(2,i)-A(2,j))^2);
    end
    %if(min(distB)<K)
    %    nB=nB+1;
    %end
	sumB = sumB+min(distB);
end
h_BA=sumB/size(B,2);
h=max(h_AB,h_BA);
%hmax=max(h_AB,h_BA);
%Dn = 1-0.5*(nA/size(A,2)+nB/size(B,2));
%h=sqrt(hmax^2+Wn^2*Dn^2);
end