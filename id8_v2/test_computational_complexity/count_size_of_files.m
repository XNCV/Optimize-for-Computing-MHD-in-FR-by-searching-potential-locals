% count size of files
% data=dir('X:/Do_an/code/code_in_report/trained/ARdata01.mat');
clc
clear
sum = 0;
data=dir('X:/Do_an/code/id8_v2/test_computational_complexity/data_for_count_size_file/AR/*01.mat');
for i = 1:1:size(data,1)
    sum = sum + data(i).bytes;
end

% save again file
%data=load('X:/Do_an/code/code_in_report/trained/BNdata2.mat');
%for i = 1:1:size(data.output,1)
%    A = data.output{i,1}.descriptors;
%    output = A(1:1:2,:);
%    link = sprintf('X:/Do_an/code/id8_v2/test_computational_complexity/data_for_count_size_file/BN/%s.mat',data.output{i,1}.name(1:end-6));
%    save(link,'output');
%end