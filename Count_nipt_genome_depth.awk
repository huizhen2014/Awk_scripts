#函数出现在脚本中模式搜索规则可以出现的任何地方：/XXXXX/{statement}，BEGIN和END中不行
function Sort_array(array,LEN){
		for(i=2;i<=LEN;i++){
				for(j=i;(j-i) in array && array[j-1]>array[j];j--){
						temp=array[j]
						array[j]=array[j-1]
						array[j-1]=temp
				}
		}
		return
}

BEGIN{
		if(system("mkdir ./Tmp")!=0){
				print "Cant make the Tmp fold"
				exit
		}
}

#第一次读入时记录需要输出和统计的染色体
/^@/{
		if($1=="@SQ"){		
				sub("SN:","",$2)
				#++i,先加1,在给数组Name赋值，否则接下来的打印永远打印是上一把数值值
				sub("LN:","",$3)
				Name[++k]=$2
				next
		}
}

#第二次读入，根据染色体名字，将其分配到临时文件夹/tmp内
/^[^@]/{
		print >> "./Tmp/"$3
}

END{
		for(n=1;n<=length(Name);n++){
				#直接使用getline<Split[n],无法读取变量;如果使用system直接输出，无法传递给getline一行一行读出;使用“”|管道操作；同时一个循环中的ij不能在其他循环中实现其值,仅在当前循环有效
				chr=Name[n]
				Loc_name="./Tmp/"Name[n]
				while(("cat " Loc_name|getline)>0){
						end=($4+length($10)-1)
						for(m=$4;m<=end;m++){
								Count[m]++
								#if(Count[m]=="1")Location[++g]=m
						}
				}
				close("cat " Loc_name)
				for(var in Count){
						print chr,var,Count[var] | "sort -b -nk1.4,1.5 -nk2 "
						delete Count[var]
				}
				
				#asort针对values排序，使用数值规则；asorti对indics排序，使用文本排序
				#Len=asorti(Count,Count_sorted)
				#for(j=1;j<=Len;j++){
				#		print chr,Count_sorted[j],Count[Count_sorted[j]]
				#		delete Count[Count_sorted[j]]
				#		delete Count_sorted[j]
				#}
		}
		system("rm -rf " "./Tmp")
}
