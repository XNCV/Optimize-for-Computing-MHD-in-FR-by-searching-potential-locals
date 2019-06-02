% trau gia thich gam co non, tre con thich choi do co
% A is a matrix of dominants
function output=resize_neighbors(A)
B=zeros(160,160);
for i=1:1:size(A,2)
    B(A(1,i),A(2,i))=1;
end
C1 = zeros(160+4,160+4);
C1(3:end-2,3:end-2)=B;
output{1}=C1;
sizeim_after=160;
C=0;i=0;
while(1)
    i=i+1;
    sizeim_before=sizeim_after;
    sizeim_after=sizeim_before/2;
    if(i==1)
        D=B;
    else
        D=C;
    end
    C=zeros(sizeim_after,sizeim_after);
    for row=1:1:sizeim_after
        for column=1:1:sizeim_after
            for rr=-2:1:2  %size of local
            for cc=-2:1:2  %size of local
                r=row*2+rr; c=column*2+cc;
                if((r>0)&&(c>0)&&(r<sizeim_before)&&(c<sizeim_before))
                if(D(r,c)==1)
                    C(row,column)=1;
                end
                end
            end
            end
        end
    end
    C1 = zeros(sizeim_after+4,sizeim_after+4);
    C1(3:end-2,3:end-2)=C;
    output{end+1}=C1;
    if(mod(sizeim_after,2)==1)
        break;
    end
end
end