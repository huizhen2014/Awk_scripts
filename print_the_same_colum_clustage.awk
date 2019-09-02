##首先根据需求将*_subelements.csv的行进行排序(分组)，以便后续累加计算
##然后根据排序后每组的数目，对应输出满足条件的列
##gawk also can asort/asorti the associated array
##input the ClustAGE.pl ouput file, out_subelements.csv
BEGIN{
    FS=","
}
NR==1{
    for(k=3;k<=NF;k++)Name[k]=$k
}
NR>1{
    ## 建立数组，索引genome
    IF[++j]=$1
    ## 建立二元数组，同时包含genome和bin数据
    for(i=3;i<=NF;i++){
	if($i==1){
    ## 每一个值为1的bin包含进入二元数组
	    ID[$1,i]=1
	}
    }
}
END{
    #print j
    for(m=3;m<=NF;m++){
	## 设定每一个循环的tmp值为0
	tmp_p=0
	tmp_n=0
        ## 针对排序后第一组的bin判断其是否存在
	for(n=1;n<=1;n++){
        ## 累加为真的数组值,可以根据建立对应值的数组，然后挑选对应值的列
	    if(ID[IF[n],m])tmp_p++
	}
        ## 针对排序后第二组的bin判断其是否存在
	for(n=4;n<=j;n++){
	    if(ID[IF[n],m])tmp_n++
	}
        ## 假如累加后tmp值为genome数组个数，那么表明该bin都为1
	if(tmp_p==1 && tmp_n<1){
	    #print NAME[m],m
	    printf "The bin name: %s\n",Name[m]
	    #printf "The same column: %s\n",m
	}
    }
}
