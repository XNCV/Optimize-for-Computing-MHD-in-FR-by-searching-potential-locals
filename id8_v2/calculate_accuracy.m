% calculate the accuracy of the recognition.
tic; 
clc
clear
right=0;
exten=9;   %ex: name1.ssfpm: BN 7; AR 9
database=load('X:\Do_an\code\code_in_report\trained\ARdata01.mat');
test=load('X:\Do_an\code\code_in_report\trained\ARdata14.mat');
data_train=dir('train\AR5\*01.mat');
test_train=dir('train\AR5\*14.mat');
Hausdorff_distance=zeros(size(test.output,1),size(database.output,1));
for ii=1:size(test.output,1)
    testname = fullfile('train\AR5\',test_train(ii).name);
    testI = load(testname);
    for jj=1:size(database.output,1)
        dataname = fullfile('train\AR5\',data_train(jj).name);
        dataI = load(dataname);
        Hausdorff_distance(ii,jj)=MHD_trained_data(testI.descriptors,dataI.descriptors,test.output{ii,1}.descriptors,database.output{jj,1}.descriptors,30,4);
    end
    fprintf('Dang tinh anh %d \n', ii);
end
for ii=1:size(test.output,1)
        [Minimum_distance,placejj]=min(Hausdorff_distance(ii,:));
        testname=test.output{ii,1}.name(1:end-exten);
        modelname=database.output{placejj,1}.name(1:end-exten);
        if strcmp(testname,modelname)==1
            right=right+1;
        end
end
percentage=100*right/size(test.output,1);
toc;