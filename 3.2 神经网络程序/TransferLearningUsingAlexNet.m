%% Transfer Learning Using AlexNet
% ����˵��ʹ��΢��Ԥѵ���� AlexNet ����������Զ��µ�ͼ�񼯺�ִ�з��ࡣ
% AlexNet �ѻ��ڳ���һ�����ͼ�����ѵ�������Խ�ͼ���Ϊ 1000 ���������������̡����ȱ���Ǧ�ʺͶ��ֶ����
%�������ѻ��ڴ���ͼ��ѧϰ�˷ḻ��������ʾ��������ͼ����Ϊ���룬Ȼ�����ͼ���ж���ı�ǩ�Լ�ÿ���������ĸ��ʡ�
% ���ѧϰӦ���г����õ�Ǩ��ѧϰ������Ԥѵ�������磬������ѧϰ������
%��ʹ�������ʼ����Ȩ�ش�ͷѵ��������ȣ�ͨ��Ǩ��ѧϰ΢������Ҫ������򵥡�����ʹ�ý���������ѵ��ͼ����ٵؽ���ѧϰ������Ǩ�Ƶ�������

%% *��������*
% ���Ƚ�Դ�����е���ģͼ��ת��ΪjpgȻ������ٴ������е��ܰͽ�ת�Ƶ���������Ϊ�����ļ��У�Ȼ���ѹ������ͼ����Ϊͼ�����ݴ洢��
%|imageDatastore|�����ļ��������Զ����ͼ�񣬲������ݴ洢Ϊ|ImageDatastore|����
%ͨ��ͼ�����ݴ洢���Դ洢��ͼ�����ݣ������޷������ڴ�����ݣ����ھ���������ѵ�������и�Ч������ȡͼ��

imds = imageDatastore('BQuanBuShuJuYanMo', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%% 
% �����ݻ���Ϊѵ�����ݼ�����֤���ݼ����� 70% ��ͼ������ѵ����30% ��ͼ��������֤��|splitEachLabel| �� |images|���ݴ洢���Ϊ�����µ����ݴ洢
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
%% 
% ��ʾһЩʾ��ͼ��
numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsTrain,idx(i));
    imshow(I)
end
%% *����Ԥѵ������*
% ����Ԥѵ���� AlexNet �����硣���δ��װ Deep Learning Toolbox? Model_for AlexNet Network_����������ṩ�������ӡ�AlexNet 
% �ѻ��ڳ���һ�����ͼ�����ѵ�������Խ�ͼ���Ϊ 1000 ���������������̡���ꡢǦ�ʺͶ��ֶ������ˣ���ģ���ѻ��ڴ���ͼ��ѧϰ�˷ḻ��������ʾ

net = alexnet;
%% 
% ʹ��|analyzeNetwork|���Խ������ӷ�ʽ��������ܹ��Լ��й���������ϸ��Ϣ��

analyzeNetwork(net)
%% 
% ��һ�㣨ͼ������㣩��Ҫ��СΪ 227��227��3 ������ͼ������ 3 ����ɫͨ������

inputSize = net.Layers(1).InputSize
%% *�滻���ղ�*
% Ԥѵ������|net|������������ 1000 ����������á���������·�������΢���������㡣��Ԥѵ����������ȡ���������֮������в�

layersTransfer = net.Layers(1:end-3);
%% 
% ͨ������������滻Ϊȫ���Ӳ㡢softmax ��ͷ�������㣬����Ǩ�Ƶ��·�������
%����������ָ���µ�ȫ���Ӳ��ѡ���ȫ���Ӳ�����Ϊ��С���������е�������ͬ

numClasses = numel(categories(imdsTrain.Labels))
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
%% *ѵ������*
% ����Ҫ������ͼ��Ĵ�СΪ 227��227��3����ͼ�����ݴ洢�е�ͼ����в�ͬ��С��ʹ����ǿ��ͼ�����ݴ洢���Զ�����ѵ��ͼ��Ĵ�С��

pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
%% 
% Ҫ�ڲ�ִ�н�һ��������ǿ��������Զ�������֤ͼ��Ĵ�С��ʹ����ǿ��ͼ�����ݴ洢������ָ���κ�����Ԥ���������

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);
%% 
% ָ��ѵ��ѡ�����Ǩ��ѧϰ������Ԥѵ������Ľ�ǳ���е�������Ǩ�ƵĲ�Ȩ�أ���
%����һ���У�������ȫ���Ӳ��ѧϰ�����ӣ��Լӿ��µ����ղ��е�ѧϰ�ٶȡ�����ѧϰ���������ֻ��ӿ��²��е�ѧϰ�ٶȣ�����������������ѧϰ�ٶȡ�
%ִ��Ǩ��ѧϰʱ�������ѵ��������Խ��١�һ��ѵ���Ƕ�����ѵ�����ݼ���һ������ѵ�����ڡ�ָ��С������С����֤���ݡ�
%�����ѵ��������ÿ|ValidationFrequency|�ε�����֤һ�����硣

options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');
%% 
% ѵ����Ǩ�Ʋ���²���ɵ����硣
%Ĭ������£������ GPU ���ã�|trainNetwork|�ͻ�ʹ�� GPU����Ҫ Parallel Computing Toolbox? �;��� 3.0 ����߼���������֧�� CUDA? �� GPU����
%���򣬽�ʹ�� CPU��
%������ʹ��|trainingOptions| �� |'ExecutionEnvironment'|����-ֵ�������ָ��ִ�л���

netTransfer = trainNetwork(augimdsTrain,layers,options);
%% *����֤ͼ����з���*
% ʹ�þ���΢�����������֤ͼ����з��ࡣ

[YPred,scores] = classify(netTransfer,augimdsValidation);
%% 
% ʹ�þ���΢�����������֤ͼ����з��ࡣ

idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end
%% 
% ���������֤���ķ���׼ȷ�ȡ�׼ȷ��������Ԥ����ȷ�ı�ǩ�ı���

YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)
