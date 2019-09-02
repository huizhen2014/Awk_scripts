BEGIN{
		#忽略大小写
		IGNORECASE=1;
		#建立ascii与十进制数值数组
		for(i=33;i<=126;i++){
				as=sprintf("%c",i)
				array[as]=i
		}
}
{
    #读取第二行，sequence;同时统计read数目
		getline sequence
    Read_num++
    #将sequence列项为数组
		#print sequence
		len=split(sequence,seq,"")
    #统计每个位置碱基的数量，每统计一个碱基位置移到下一位（i++），递增累加;统计每条read的长度
		count_gc=0
		Len[len]++
		for(n=1;n<=len;n++){
				base=seq[n]
				array_seq[n,base]++
    #统计ATCGN
				if(base=="a"){
						count_a++
				}else if(base=="t"){
						count_t++
				}else if(base=="c"){
						count_c++
				}else if(base=="g"){
						count_g++
				}else if(base=="n"){
						count_n++
				}
				if(base == "g" || base == "c"){
						count_gc++
				}
				}
				seq_gc=sprintf ("%.2f",(count_gc/len))
				#print seq_gc
				Seq_GC[seq_gc]++
		getline 
    #j=1，从第一个cycle位置开始统计；同时统计整条序列的平均质量值
		Seq_qual=0
		#读入第四行，quality
		getline quality
		#print quality
		len=split(quality,qual,"")
    #针对每个位置，统计其质量值的数目，使用二维数组，递增累加，限定质量值范围0-41;统计碱基的质量分布
		for(m=1;m<=len;m++){
				Q=array[qual[m]]-33
				Seq_qual=Seq_qual+Q
				#print Q
				Qual[Q]++
				array_qual[m,Q]++
		}
		mean_qual=sprintf ("%.1f",(Seq_qual/len))
		#print mean_qual
		Mean_qual[mean_qual]++
		next
}
END{
    #统计Q值数目
    for(var in Qual){
				if(var >= 10){
						Count_q10=Count_q10+Qual[var]
				}
				if(var >= 20){
						Count_q20=Count_q20+Qual[var]
				}
				if(var >= 30){
						Count_q30=Count_q30+Qual[var]
				}
		}

		#打印read数目及碱基Q值统计
		printf "#Total read number\t%d\n",Read_num
		printf "#Q10\t%.2f\n",((Count_q10)/(count_a+count_t+count_c+count_g+count_n))*100
		printf "#Q20\t%.2f\n",((Count_q20)/(count_a+count_t+count_c+count_g+count_n))*100
		printf "#Q30\t%.2f\n",((Count_q30)/(count_a+count_t+count_c+count_g+count_n))*100

		#打印整体碱基数及GC含量
		#printf "#The input file:%s\n",FILENAME
		printf "#Total bases\t%d\n",(count_a+count_t+count_c+count_g+count_n)
		printf "#A:%d\tC:%d\tG:%d\tT:%d\tN:%d\n",count_a,count_c,count_g,count_t,count_n
		printf "#GC%%\t%.4f\n",((count_g+count_c)/(count_a+count_t+count_c+count_g+count_n))*100
		printf "#N%%\t%.4f\n",((count_n)/(count_a+count_t+count_c+count_g+count_n))*100
		#打印行名称ACGTN
		printf "#Pos\tA\tC\tG\tT\tN\t"
		#打印质量值统计0-41
		for(l=0;l<=41;l++){
				printf "%d\t",l
		}
		printf "\n"
    #打印LEN个循环每个循环的ACGTN数目
		for(k=1;k<=LEN;k++){
				printf "%s\t%d\t%d\t%d\t%d\t%d\t",k,array_seq[k,"A"],array_seq[k,"C"],array_seq[k,"G"],array_seq[k,"T"],array_seq[k,"N"]
    #打印35个循环每个循环的质量统计值0-41
				for(p=0;p<=41;p++){
						printf "%d\t",array_qual[k,p]
				}
				printf "\n"
		}
		printf "#The read mean_GC distribution\n"
		printf "Percentage\tNumber\n"
		for(x=0;x<=1;x+=0.01){
				#将x转换为保留2位小数值，很重要
				x=sprintf("%.2f",x)
				printf "%.2f\t%d\n",x,Seq_GC[x]
		}
    printf "#The read mean_Qual distribution\n"
    printf "Mean_Quality\tNumber\n"
		for(y=0;y<=41;y+=0.1){
        #将y转换为保留2为小数值，很重要
				y=sprintf("%.1f",y)
				printf "%.1f\t%d\n",y,Mean_qual[y]
		}
		printf "#The seq length distribution\n"
		for(z=1;z<=LEN;z++){
				printf "%d\t",z
		}
		printf "\n"
		for(z=1;z<=LEN;z++){
				printf "%d\t",Len[z]
		}
		printf "\n"
}
