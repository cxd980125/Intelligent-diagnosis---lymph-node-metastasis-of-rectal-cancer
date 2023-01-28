clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\baocun2\1034';%����ȡ�ļ��Ĵ��Ŀ¼�������Լ���Ҫ�������ã�
fileSavePath='C:\Users\15545\Desktop\qiegelaoshi\1034';%�ļ�����Ŀ¼�������Լ���Ҫ�������ã�
srcsuffixSave='.png';%�����ļ�����׺�������Լ���Ҫ�������ã�
src=srcFace;
srcsuffix='.png';%����ȡ���ļ�����׺�����ݱ���ȡ�ļ���ʵ���ļ��������ã�
files = dir(fullfile(src, strcat('*', srcsuffix)));
geshu=length(files);  %geshu�����ļ�����
for file_i= 1 : geshu
    disp(file_i);%��ʾ��ǰ������ļ����
    srcName = files(file_i).name;
    noSuffixName = srcName(1:end-4);
    pathImgName=sprintf('%s%s%s',src,'\',srcName);
    ImgSrc=imread(pathImgName);%����ͼ��
    %��ȡͼ��ҶȾ�������
    stats1 =graycoprops(ImgSrc);    %Contrast�Աȶ�,Correlation�����Energy����Homogeneity�����(ͬ����)
    %��ȡͼ������
    means=mean2(ImgSrc);             %ͼ���ƽ��ƫ��
    std2s=std2(ImgSrc);              %��׼��
    
    ent=entropy(ImgSrc);             %�Ҷ�ͼ����
    stats = regionprops('table',ImgSrc,'all'); 
    areas=sum(stats.EquivDiameter);    %���
   
    eccentricity=sum(stats.Eccentricity);
    T(file_i,:)= table(stats1.Contrast,stats1.Correlation ,stats1.Energy ,stats1.Homogeneity,means,std2s,areas,eccentricity,ent);
    T.Properties.RowNames{file_i} = srcName;
    %����������������������ѡ��
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
    
    %writetable(T,'E:\Desktop\mask\1034\tezheng.txt');      %д����tezheng.txt');      %д����
    

