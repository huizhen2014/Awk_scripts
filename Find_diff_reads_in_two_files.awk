BEGIN{
		while((getline<ARGV[1])>0){
				i++
				if(i=="1"){
						old=i
						sub("@","",$1)
						name1[$1]++
				}else if((i-old)=="4"){
						old=i
						sub("@","",$1)
						name1[$1]++
				}
		}
		while((getline<ARGV[2])>0){
				j++
				if(j=="1"){
						old=j
						sub("@","",$1)
						#print $1
						name2[$1]++
				}else if((j-old)=="4"){
						old=j
						sub("@","",$1)
						#print $1
						name2[$1]++
				}
		}
		for(var in name2){
						if(!name1[var]){
						print var"\t"name2[var]
				}
		}
}
