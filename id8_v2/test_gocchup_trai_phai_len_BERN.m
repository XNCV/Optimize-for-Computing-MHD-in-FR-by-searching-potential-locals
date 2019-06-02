%BERN_test dieu kien goc chup thay doi
%nhin sang phai, hinh 3+4 ( 51.6667%); nhin sang trai, hinh 5+6 ( 53.33%); nhin len tren, hinh
%7+8 ( 53.33%)  nhin xuong 9+10 (%)
clc
clear
right=0;
exten=7;
tic;
database=load('X:\Do_an\code\code_in_report\trained\BNdata1.mat');
test1=load('X:\Do_an\code\code_in_report\trained\BNdata5.mat');
test2=load('X:\Do_an\code\code_in_report\trained\BNdata6.mat');

data_train=dir('train\BN5\*1.mat');
test1_train=dir('train\BN5\*5.mat');
test2_train=dir('train\BN5\*6.mat');
Hausdorff_distance=zeros(size(test1.output,1)+size(test2.output,1),size(database.output,1));
for ii=1:(size(test1.output,1)+size(test2.output,1))
    if(ii<=size(test1.output,1))
        testname = fullfile('train\BN5\',test1_train(ii).name);
        testI = load(testname);
        for jj=1:size(database.output,1)
            dataname = fullfile('train\BN5\',data_train(jj).name);
            dataI = load(dataname);
            Hausdorff_distance(ii,jj)=MHD_trained_data(testI.descriptors,dataI.descriptors,test1.output{ii,1}.descriptors,database.output{jj,1}.descriptors,30,4);
        end
    else
        testname = fullfile('train\BN5\',test2_train(ii-size(test1.output,1)).name);
        testI = load(testname);
        for jj=1:size(database.output,1)
            dataname = fullfile('train\BN5\',data_train(jj).name);
            dataI = load(dataname);
            Hausdorff_distance(ii,jj)=MHD_trained_data(testI.descriptors,dataI.descriptors,test2.output{ii-size(test1.output,1),1}.descriptors,database.output{jj,1}.descriptors,30,4);
        end
    end
    fprintf('Dang tinh anh %d \n', ii);
end
for ii=1:(size(test1.output,1)+size(test2.output,1))
        [Minimum_distance,placejj]=min(Hausdorff_distance(ii,:));
        if(ii<=size(test1.output,1))
            testname=test1.output{ii,1}.name((1:end-exten));
        else
            testname=test2.output{ii-size(test1.output,1),1}.name((1:end-exten));
        end
        modelname=database.output{placejj,1}.name(1:end-exten);
        if strcmp(testname,modelname)==1
           right=right+1;
        end
end
percentage=100*right/(size(test1.output,1)+size(test2.output,1));
toc;