clc
clear
right=0;
exten=7;
tic;
database=load('X:\Do_an\code\code_in_report\trained\BNdata1.mat');
test=load('X:\Do_an\code\code_in_report\trained\BNdata2.mat');
Hausdorff_distance=zeros(length(test.output),length(database.output));
complex = 0;
for ii=1:length(test.output)
    for jj=1:length(database.output)
        [num, Hausdorff_distance(ii,jj)]=MHD(database.output{jj,1}.descriptors,test.output{ii,1}.descriptors);%,5,16);
        complex = complex + num;
        %Hausdorff_distance(ii,jj)=MHD_incR(database.output{jj,1}.descriptors,test.output{ii,1}.descriptors,3,10);
        %Hausdorff_distance(ii,jj)=MHD_divide_local(database.output{jj,1}.descriptors,test.output{ii,1}.descriptors,34);
    end
    fprintf('Dang tinh anh %d \n', ii);
end
for ii=1:length(test.output)
        [Minimum_distance,placejj]=min(Hausdorff_distance(ii,:));
        testname=test.output{ii,1}.name(1:end-exten);
        modelname=database.output{placejj,1}.name(1:end-exten);
        if strcmp(testname,modelname)==1
           right=right+1;
        end
end
percentage=100*right/length(test.output);
toc;