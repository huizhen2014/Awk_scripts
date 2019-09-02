##首先根据需求将*_subelements.csv的行进行排序(分组)，以便后续累加计算
##然后根据排序后每组的数目，对应输出满足条件的列
##gawk also can asort/asorti the associated array
##input the ClustAGE.pl ouput file, out_subelements.csv
BEGIN{
    if(ARGC != 3){
	print "Enter your *_subelements.csv and *_subelements.annotations.txt"
	print "Change the line number interval for selectinon"
	exit
    }
    
    ## 读取*_subelements.csv文件，使用1和0分别表达subelement存在与否
    FS=","
    while((getline < ARGV[1])>0){
	if(/^genome/){
	    for(k=3;k<=NF;k++)Name[k]=$k
	}else{
	    ## 注意j++和++j的区别,++j为先加后赋值!
	    IF[++j]=$1
	    #print IF[j]
	    for(i=3;i<=NF;i++){
		if($i==1){
		    ID[$1,i]=1
		}
	    }
	}
    }
    close(ARGV[1])
    
    ## 读取*_subelements.annotations.txt文件，记录对应bin的注释信息
    FS="\t"
    while((getline < ARGV[2])>0){
	if(!/^subelement/){
	    Annot[$1]=$2
	}
    }
    close(ARGV[2])

    ## 根据需要筛选的样本行信息，设定参数n区间值
    ## 根据*_subelements.csv文件，计算bin总长,继而计算目的bin及相应注释信息
    len=length(Name)+2
    #print j,len
    for(m=3;m<=len;m++){
        ## 设定每一个循环的tmp值为0
	tmp_p=0
	tmp_n=0
        ## 针对排序后第一组的bin判断其是否存在
	for(n=1;n<=2;n++){
        ## 累加为真的数组值,可以根据建立对应值的数组，然后挑选对应值的列
	    if(ID[IF[n],m])tmp_p++
	}
        ## 针对排序后第二组的bin判断其是否存在
	for(n=3;n<=j;n++){
	    if(ID[IF[n],m])tmp_n++
	}
	## 假如累加后tmp值为genome数组个数，那么表明该bin都为1
	if((tmp_p==2) && (tmp_n<1)){
	    ##打印出bin名称及对应注释信息
	    #print Name[m],Annot[Name[m]]
	    split(Annot[Name[m]],Prot,"\",")
	    #print length(Prot)
	    for(i=1;i<=length(Prot);i++){
		gsub("\""," ",Prot[i])
		printf "%s\t%s\n",Name[m],Prot[i]
	    }
	}
    }
}
