clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\baocun1\1034';%����ȡ�ļ��Ĵ��Ŀ¼�������Լ���Ҫ�������ã�
fileSavePath='C:\Users\15545\Desktop\baocun2\1034';%�ļ�����Ŀ¼�������Լ���Ҫ�������ã�
src=srcFace;
srcsuffix='.png';%����ȡ���ļ�����׺�����ݱ���ȡ�ļ���ʵ���ļ��������ã�
srcsuffixSave='.png';%�����ļ�����׺�������Լ���Ҫ�������ã�
files = dir(fullfile(src, strcat('*', srcsuffix)));
geshu=length(files);  %geshu�����ļ�����
for file_i= 1 : length(files)
    disp(file_i);%��ʾ��ǰ������ļ����
    srcName = files(file_i).name;
    noSuffixName = srcName(1:end-4);
    srcName1=files(file_i).name;
    pathImgName=sprintf('%s%s%s',src,'\',srcName1);
    ImgSrc=imread(pathImgName);%����ͼ��
    
 %������������������ 
Img1 = im2uint8(ImgSrc); [row,col] = size(Img1);
Img2 = zeros(row,col,'uint8');
bwinitpoint=[2.457336448598131e+02,3.137984293193717e+02];%��ʼ��
Img2 = Img2 + im2uint8(regiongrow(Img1,bwinitpoint));
      %���洦�����ļ�
        savePathName=sprintf('%s%s%s%s',fileSavePath,'\',noSuffixName,srcsuffixSave);
        imwrite(Img2,savePathName);
end