clc
clear
right=0;
exten=9;  
database=load('X:\Do_an\code\code_in_report\trained\ARdata01.mat');
test=load('X:\Do_an\code\code_in_report\trained\ARdata14.mat');
data_train=dir('X:\Do_an\code\id8_advance_zorder\train\AR5\*01.mat');
test_train=dir('X:\Do_an\code\id8_advance_zorder\train\AR5\*14.mat');
number=0;
for Wn=20:10:50
%Wn = 10;
for K=3:1:6
Hausdorff_distance=zeros(size(test.output,1),size(database.output,1));
for ii=1:size(test.output,1)
    testname = fullfile('X:\Do_an\code\id8_advance_zorder\train\AR5\',test_train(ii).name);
    testI = load(testname);
    for jj=1:size(database.output,1)
        dataname = fullfile('X:\Do_an\code\id8_advance_zorder\train\AR5\',data_train(jj).name);
        dataI = load(dataname);
        Hausdorff_distance(ii,jj)=MHD_trained_data(testI.descriptors,dataI.descriptors,test.output{ii,1}.descriptors,database.output{jj,1}.descriptors,Wn,K);
    end
end
right=0;
for ii=1:size(test.output,1)
        [Minimum_distance,placejj]=min(Hausdorff_distance(ii,:));
        testname=test.output{ii,1}.name(1:end-exten);
        modelname=database.output{placejj,1}.name(1:end-exten);
        if strcmp(testname,modelname)==1
            right=right+1;
        end
end
percentage=100*right/size(test.output,1);
number=number+1;
result(1,number)=Wn;
result(2,number)=K;
result(3,number)=percentage;
display(number)
end
end