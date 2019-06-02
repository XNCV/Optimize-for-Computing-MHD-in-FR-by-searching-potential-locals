% A=data.descriptors; A1 is the matrix of dominants
function h=MHD_trained_data(A,B,A1,B1,Wn,K)

sumA=0;nAA=0;
for i=1:1:6
    BB{i} = find(B{i});
    AA{i} = find(A{i});
end

%% tinh hAB
for nA=1:1:size(A1,2)
    distA = 0; %control = 5;
    for nmb=5:-1:1
        ri=ceil(A1(1,nA)/2^nmb); ci=ceil(A1(2,nA)/2^nmb);
        loca = (160/2^nmb+4)*(ci+1)+ri+2;
        if(size(find(BB{nmb+1}==loca),1)==0)
            break;
        else
            r=2*ri;c=2*ci; control=nmb-1;
        end
    end
    % add code
    if(control==0)
        C = B{1}(r:1:r+4,c:1:c+4);
        [rowC, columnC]=find(C);
        for i=1:1:size(rowC,1)
            distA(i)=sqrt((r+rowC(i)-3-A1(1,nA))^2+(c+columnC(i)-3-A1(2,nA))^2);
        end
    elseif(nmb==5)
        distA(1)=1;
    else
        C = B{nmb+1}(r:1:r+4,c:1:c+4);
        [rowC, columnC]=find(C);
        for i=1:1:size(rowC,1)
            distA(i)=sqrt((r+rowC(i)-3-ri)^2+(c+columnC(i)-3-ci)^2);
        end
    end
    minA=min(distA);
    if(control~=0)
        minA=minA*2^nmb;
    end
    if(minA<K)
        nAA=nAA+1;
    end
    sumA=sumA+minA;
end
hAB=sumA/nA;
%% tinh hBA
sumB=0;nBB=0;
for nB=1:1:size(B1,2)
    distB = 0; %control = 5;
    for nma=5:-1:1
        ri=ceil(B1(1,nB)/2^nma); ci=ceil(B1(2,nB)/2^nma);
        loca = (160/2^nma+4)*(ci+1)+ri+2;
        if(size(find(AA{nma+1}==loca),1)==0)
            break;
        else
            r=2*ri;c=2*ci; control=nma-1;
        end
    end
    % add code
    if(control==0)
        C = A{1}(r:1:r+4,c:1:c+4);
        [rowC, columnC]=find(C);
        for i=1:1:size(rowC,1)
            distB(i)=sqrt((r+rowC(i)-3-B1(1,nB))^2+(c+columnC(i)-3-B1(2,nB))^2);
        end
    elseif(nma==5)
        distB(1)=1;
    else
        C = A{nma+1}(r:1:r+4,c:1:c+4);
        [rowC, columnC]=find(C);
        for i=1:1:size(rowC,1)
            distB(i)=sqrt((r+rowC(i)-3-ri)^2+(c+columnC(i)-3-ci)^2);
        end
    end
    minB=min(distB);
    if(control~=0)
        minB=minB*2^nma;
    end
    if(minB<K)
        nBB=nBB+1;
    end
    sumB=sumB+minB;
end
hBA=sumB/nB;
%% tinh h
%h=max(hAB, hBA);
hmax=max(hAB,hBA);
Dn=1-0.5*(nAA/nA+nBB/nB);
h=sqrt(hmax^2+Wn^2*Dn^2);
end