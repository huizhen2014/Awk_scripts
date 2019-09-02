##将含有交叉区间的bed文件，分别输出到不同文件

##If the FILENAME in the BEGIN scope, It could not  parse the FILENAME 
BEGIN{split(FILENAME,N,".")
pre=N[1]}
##for the same name interval, print them to separated file with suffix number plus one, interally.
{
    split(FILENAME,N,".")
    pre=N[1]
    if(ID[$1]){
	split(ID[$1],TMP)
	tmp=TMP[4]+1
	print tmp
	output=pre"_output_"tmp
	print $1"\t"$2"\t"$3"\t"tmp >> output
	ID[$1]=$1"\t"$2"\t"$3"\t"tmp
	##关闭打开的文件，只能打开一定数量
	close(output)
    }else{
	ID[$1]=$1"\t"$2"\t"$3"\t"1
	output=pre"_output_1"
	print $1"\t"$2"\t"$3"\t"1 >> output
	##关闭打开的文件，只能打开一定数量文件
	close(output)
    }
}
