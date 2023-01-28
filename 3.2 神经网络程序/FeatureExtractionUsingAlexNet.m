%% Feature Extraction Using AlexNet
% �˴���˵����δ�Ԥѵ���ľ������������ȡ��ѧϰ��ͼ����������ʹ����Щ������ѵ��ͼ���������
%������ȡ��ʹ��Ԥѵ���������ı���������������ݵķ�ʽ��
%% *��������*
% ���Ƚ�Դ�����е���ģͼ��ת��ΪjpgȻ������ٴ������е��ܰͽ�ת�Ƶ���������Ϊ�����ļ��С�
%Ȼ���ѹ��������ͼ����Ϊͼ�����ݴ洢.|imageDatastore|�����ļ��������Զ����ͼ�񣬲������ݴ洢Ϊ|ImageDatastore|����
%ͨ��ͼ�����ݴ洢���Դ洢��ͼ�����ݣ������޷������ڴ������.�����ݲ�֣�����70%����ѵ�����ݣ�30%�����������ݡ�

unzip('BQuanBuShuJuYanMo.zip');
imds = imageDatastore('BQuanBuShuJuYanMo', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

[imdsTrain,imdsTest] = splitEachLabel(imds,0.7,'randomized');
%% 
% ��������ݼ��У�.��ʾһЩʾ��ͼ��.

numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end
%% *����Ԥѵ������*
% ����Ԥѵ����AlexNet����.���δ��װ���ѧϰ������ģ��_ΪAlexNet����_֧�ְ�����������ṩ�������ӡ�
%AlexNet�ѻ��ڳ���һ�����ͼ�����ѵ�������Խ�ͼ���Ϊ1000���������.���磬���̡���ꡢǦ�ʺͶ��ֶ��
%��ˣ���ģ���ѻ��ڴ���ͼ��ѧϰ�˷ḻ��������ʾ��

net = alexnet;
%% 
% ��ʾ����ܹ�.���������������������ȫ���Ӳ�

net.Layers
%% 
% ��һ��(ͼ�������)��Ҫ��СΪ227��227��3������ͼ������3����ɫͨ����

inputSize = net.Layers(1).InputSize
%% *��ȡͼ������*
% ���繹������ͼ��ķֲ��ʾ.�����������߼������������Щ����ʹ�ý�ǳ��Ľϵͼ�����������.
% 
% ����Ҫ������ͼ��Ĵ�СΪ227��227��3����ͼ�����ݴ洢�е�ͼ����в�ͬ��С��
%Ҫ�ڽ�ѵ��ͼ��Ͳ���ͼ�����뵽����֮ǰ�Զ��������ǵĴ�С��������ǿ��ͼ�����ݴ洢��ָ�������ͼ���С��������Щ���ݴ洢����|activations|���������.

augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);

layer = 'fc7';
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');
%% 
% ��ѵ�����ݺͲ�����������ȡ���ǩ.

YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;
%% *���ͼ�������*
% ʹ�ô�ѵ��ͼ������ȡ��������ΪԤ���������ʹ��|fitcecoc|(ͳ�ƺͻ���ѧϰ������)��϶���֧��������(֧��������)

classifier = fitcecoc(featuresTrain,YTrain);
%% *�Բ���ͼ����з���*
% ʹ�þ���ѵ����֧��������ģ�ͺʹӲ���ͼ������ȡ�������Բ���ͼ����з���.

YPred = predict(classifier,featuresTest);
%% 
% ��ʾ�ĸ�ʾ������ͼ��Ԥ��ı�ǩ..

idx = [1 5 10 15];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    I = readimage(imdsTest,idx(i));
    label = YPred(idx(i));
    imshow(I)
    title(char(label))
end
%% 
% ������Բ��Լ��ķ���׼ȷ��.׼ȷ��������Ԥ����ȷ�ı�ǩ�ı���.

accuracy = mean(YPred == YTest)
