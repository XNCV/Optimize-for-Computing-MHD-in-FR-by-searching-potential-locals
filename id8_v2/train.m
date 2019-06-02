% train
clear
clc
data=load('X:\Do_an\code\code_in_report\trained/ARdata20.mat');
for i=1:1:size(data.output,1)
    descriptors=resize_neighbors(data.output{i,1}.descriptors);
    name=data.output{i,1}.name(1:end-6);
    filename=sprintf('train/AR5/%s.mat',name);
    save(filename,'descriptors');
    display(i)
end