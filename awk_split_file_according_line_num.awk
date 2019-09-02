BEGIN{
#建立每个输入的分割范围
	num_1=1;num_2=1;line_1=LEN;line_2=LEN
#建立每个输出文本的名字，使用bash $RANDOM 函数创建，本例子创建了5个随机文件名字
	for(i=1;i<=5;i++){
		"echo $RANDOM" | getline name
		Sample_1[i]="sample_R1_" name "_" i ".fastq"
		Sample_2[i]="sample_R2_" name "_" i ".fastq"
		print Sample_1[i]
		print Sample_2[i]
		close("echo $RANDOM")
	}
	print line_1
	print line_2
}
#匹配模式需要和后续执行在同一行，表示作用于后面{}内操作,这里，ARGIND不存在；若在其中使用exit，表示全局推出！！！
FILENAME==ARGV[1]{
#针对每条输入测试当前行号，满足小于line_num时输入到随机命名的文件中
		if((FNR<=line_1) && Sample_1[num_1]){
#打印输出到随机文件
			print $0 >> Sample_1[num_1]
		
		}else{
			line_1=line_1+LEN
			num_1++
			if(Sample_1[num_1]){
#在条件为真时，输入下一行,同时将当前行输入下一文本
				print $0 >> Sample_1[num_1]
			}
		}
}
FILENAME==ARGV[2]{
#针对每条输入测试当前行号，满足小于line_num时输入到随机命名的文件中
		if((FNR<=line_2) && Sample_2[num_2]){
#打印输出到随机文件
			print $0 >> Sample_2[num_2]
		}else{
			line_2=line_2+LEN
			num_2++
			if(Sample_2[num_2]){
#在条件为真时，输入下一行
				print $0 >>Sample_2[num_2]
			}else{
				exit
			}
		}
}
