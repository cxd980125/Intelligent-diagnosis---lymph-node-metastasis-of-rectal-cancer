clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\baocun2\1034';%被读取文件的存放目录（根据自己需要更改设置）
fileSavePath='C:\Users\15545\Desktop\qiegelaoshi\1034';%文件保存目录（根据自己需要更改设置）
srcsuffixSave='.png';%保存文件名后缀（根据自己需要更改设置）
src=srcFace;
srcsuffix='.png';%被读取的文件名后缀（根据被读取文件的实际文件类型设置）
files = dir(fullfile(src, strcat('*', srcsuffix)));
geshu=length(files);  %geshu保存文件个数
for file_i= 1 : geshu
    disp(file_i);%显示当前处理的文件序号
    srcName = files(file_i).name;
    noSuffixName = srcName(1:end-4);
    pathImgName=sprintf('%s%s%s',src,'\',srcName);
    ImgSrc=imread(pathImgName);%读入图像
    %获取图像灰度矩阵特征
    stats1 =graycoprops(ImgSrc);    %Contrast对比度,Correlation互相关Energy能量Homogeneity齐次性(同质性)
    %获取图像特征
    means=mean2(ImgSrc);             %图像的平均偏差
    std2s=std2(ImgSrc);              %标准差
    
    ent=entropy(ImgSrc);             %灰度图像熵
    stats = regionprops('table',ImgSrc,'all'); 
    areas=sum(stats.EquivDiameter);    %面积
   
    eccentricity=sum(stats.Eccentricity);
    T(file_i,:)= table(stats1.Contrast,stats1.Correlation ,stats1.Energy ,stats1.Homogeneity,means,std2s,areas,eccentricity,ent);
    T.Properties.RowNames{file_i} = srcName;
    %根据有无肿瘤的特征进行选择
    if(areas >= 21.4 && areas <= 29.7 && stats1.Contrast >= 2970 && stats1.Contrast <= 4454.7)
        ImgSrc = ImgSrc ;    
    else
        ImgSrc = im2bw(ImgSrc,1);
        
    end
              
    savePathName=sprintf('%s%s%s%s',fileSavePath,'\',noSuffixName,srcsuffixSave);
        imwrite(ImgSrc,savePathName);
end
    T.Properties.VariableNames{'Var1'} = 'Contrast';
    T.Properties.VariableNames{'Var2'} = 'Correlation';
    T.Properties.VariableNames{'Var3'} = 'Energy';
    T.Properties.VariableNames{'Var4'} = 'Homogeneity';
    T.Properties.VariableNames{'Var5'} = 'means';
    T.Properties.VariableNames{'Var6'} = 'std2s';
    T.Properties.VariableNames{'Var7'} = 'areas'
    T.Properties.VariableNames{'Var8'} = 'eccentricity'; 
    T.Properties.VariableNames{'Var9'} = 'entropy'; 
    
    %writetable(T,'E:\Desktop\mask\1034\tezheng.txt');      %写出表tezheng.txt');      %写出表
    

