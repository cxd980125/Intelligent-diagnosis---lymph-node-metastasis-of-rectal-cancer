clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\shiliPNG\1034';%����ȡ�ļ��Ĵ��Ŀ¼�������Լ���Ҫ�������ã�
fileSavePath='C:\Users\15545\Desktop\baocun1\1034';%�ļ�����Ŀ¼�������Լ���Ҫ�������ã�
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
    
[Iout,intensity,fitness,time]=segmentation(ImgSrc(:,:,2),10,'pso');

[m,n]=size(Iout);

for i=1:m
    for j=1:n
        if Iout(i,j)~=intensity(5)& Iout(i,j)~=intensity(6)
            J(i,j)=0;
        else
            J(i,j)=1;%Iout(i,0000000000000000000000000000000000000000000000000000000 j);
        end
    end
end
 
 %���洦�����ļ�
savePathName=sprintf('%s%s%s%s',fileSavePath,'\',noSuffixName,srcsuffixSave);
        imwrite(J,savePathName);
end