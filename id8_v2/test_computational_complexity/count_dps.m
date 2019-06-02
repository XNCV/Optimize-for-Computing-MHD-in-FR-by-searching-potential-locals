%count the number of dominant points
clc
clear
num_dps = 0;
A=load('X:\Do_an\code\code_in_report\trained\BNdata2.mat');
for i = 1:1:size(A.output,1)
    num_dps = num_dps + size(A.output{i,1}.descriptors,2);
    display(i)
end