BEGIN{IGNORECASE=1;
print "Chrom\tTotal_base\tA_count\tT_count\tC_count\tG_count\tN_count\tGC_percent\tN_percent"}
#将$0split到数组，分别计算ATCGN
function COUNT(input){
		len=split(input,array,"")
		for(m=1;m<=len;m++){
				if(array[m] == "a"){
						count_A++
						count_a++
				}else if(array[m] == "t"){
						count_T++
						count_t++
						}else if(array[m] == "c"){
								count_C++
								count_c++
								}else if(array[m] == "g"){
										count_G++
										count_g++
								}else if(array[m] == "n"){
										count_N++
										count_n++
								}
		}
}
#根据fasta文件>开头规律，当满足>开头时读入$0到数组name[i]，getline读入下一行,使用函数COUNT计算ATCGN,存入数组Chrom[name[i]]；当再次遇到>开头时，将其读入数组name[i]，再次计算ATCGN...
!/contig/&&/^>/{
		#print $0
		do{
				if(/\<contig\>/){
						next
				}else if(/^>/ && !/contig/){
		    if(name[i]){
		    printf ("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%.3f\t%.3f\n",name[i],(count_A+count_T+count_C+count_G+count_N),count_A,count_T,count_C,count_G,count_N,((count_C+count_G)/(count_A+count_T+count_C+count_G+count_N)),count_N/(count_A+count_T+count_C+count_G+count_N))
								    }
						        match($0,"Homo sapiens.*,")
										name[++i]=substr($0,RSTART,RLENGTH-1)
				            #print name[i]
				            count_A=count_T=count_C=count_G=count_N=0
						        }else{
				                COUNT($0)
										}
		} while(getline >0)
}
END{
	  #由于最后一次>时，没有下一个>使循环进去if($0 ~ /^>/)，所以手动输出，此时i也是最后一个值！
		printf("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%.3f\t%.3f\n",name[i],(count_A+count_T+count_C+count_G+count_N),count_A,count_T,count_C,count_G,count_N,((count_A+count_G)/(count_A+count_T+count_C+count_G+count_N)),count_N/(count_A+count_T+count_C+count_G+count_N))
		printf "#Total basea\t%d\n",(count_a+count_t+count_c+count_g+count_n)
		printf "#GC%%\t%.3f\n",(count_c+count_g)/(count_a+count_t+count_c+count_g+count_n)
		printf "#N%%\t%.3f\n",(count_n)/(count_a+count_t+count_c+count_g+count_n)
}
