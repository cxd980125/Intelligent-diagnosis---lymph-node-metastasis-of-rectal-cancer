clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\baocun1\1034';%被读取文件的存放目录（根据自己需要更改设置）
fileSavePath='C:\Users\15545\Desktop\baocun2\1034';%文件保存目录（根据自己需要更改设置）
src=srcFace;
srcsuffix='.png';%被读取的文件名后缀（根据被读取文件的实际文件类型设置）
srcsuffixSave='.png';%保存文件名后缀（根据自己需要更改设置）
files = dir(fullfile(src, strcat('*', srcsuffix)));
geshu=length(files);  %geshu保存文件个数
for file_i= 1 : length(files)
    disp(file_i);%显示当前处理的文件序号
    srcName = files(file_i).name;
    noSuffixName = srcName(1:end-4);
    srcName1=files(file_i).name;
    pathImgName=sprintf('%s%s%s',src,'\',srcName1);
    ImgSrc=imread(pathImgName);%读入图像
    
 %进行区域生长法处理 
Img1 = im2uint8(ImgSrc); [row,col] = size(Img1);
Img2 = zeros(row,col,'uint8');
bwinitpoint=[2.457336448598131e+02,3.137984293193717e+02];%起始点
Img2 = Img2 + im2uint8(regiongrow(Img1,bwinitpoint));
      %保存处理后的文件
        savePathName=sprintf('%s%s%s%s',fileSavePath,'\',noSuffixName,srcsuffixSave);
        imwrite(Img2,savePathName);
end