#Count the read number in each chromsome,for the chromosome Y, the location is from 0~2x10^6,10x10^6~13x10^6,23x10^6~The end!
/^[^@]/&& $2 !~ "4"{
    #将字符串转换成数字；使用sprintf
		location=$4*1
		if($3 == "chrY"){
				if(location <= sprintf("%d","2000000") || (location >= sprintf("%d","10000000") && location <= sprintf("%d","13000000")) || location >= sprintf("%d","23000000")){
						Count[$3]++
				    Count_bak[$3]++
						#result=23000000-$4
						#print $3,$4,result
		}
		next
		}else{
	      Count[$3]++
				Count_bak[$3]++
		}
}
END{
	  #len=asort(Count,Count_sorted)
		#for(i=1;i<=len;i++){
		#    for(var in Count)
		#				    if(Count[var]==Count_sorted[i]){
		#						    print var"\t"Count_sorted[i]
		#						    delete Count[var]
		#				}
		#}
		for(i=1;i<=22;i++){
				Chr="chr"i
				printf "%s\t%d\n",Chr,Count_bak[Chr]
		}
		printf "%s\t%d\n","chrX",Count_bak["chrX"]
		printf "%s\t%d\n","chrY",Count_bak["chrY"]
}
