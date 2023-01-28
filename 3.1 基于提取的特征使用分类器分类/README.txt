1.提取到的特征。BQuanBuShuJuTeZheng.txt是所给的B题全部数据中arterial phase的掩模图像特征。
BShiLiTeZheng.txt是所给B题示例数据中arterial phase的特征。
在matlab中使用readtable函数即可读取。例如，"T1=readtable('BQuanBuShuJuTeZheng.txt');"。就可以将txt内容保存到matlab工作空间中。

2. FineKNN.m是使用FineKNN算法对提取到的特征进行分类。
BaggedTrees8.m是使用Bagged Trees算法对提取到的特征进行分类。
对加载到matlab空间的表格直接使用程序调用即可。例如，"T1=readtable('BQuanBuShuJuTeZheng.txt'); 	FineKNN(T1);"即可使用FineKNN分类器对全部数据提取得到的特征进行分类。