BEGIN{
    while((getline < "set_difference_common_set")>0){
	## 由于getline不存在NR, 所有这里能使用NR
	ID[++j]=$1
	for(i=2;i<=NF;i++){
	    GENE[$1]=GENE[$1]"\t"$i
	}
	#print j,ID[j]
	#print GENE[ID[j]]
    }

    for(m=1;m<=j;m++){
	len=split(GENE[ID[m]],TMP)
	N=0
	P=0
	for(n=1;n<=len;n++){
            ##TMP[n]匹配"xxx"即可, 即TMP[n] 包含于"xxx"
            ##另外，～匹配不能用||符号表示或；除非if(/aaa/||/bbb/)
	    ##gawk的可采用分开匹配，使用小括号限定隔开
            ##if 判断后, 输出采用打括号扩起来，避免命令处于if选择范围外
	    if(TMP[n] ~ /42474_accessory/){P++}
	    if(TMP[n] ~ /42277_accessory/){P++}
	    if(TMP[n] ~ /40847_accessory/){P++}
	    if(TMP[n] ~ /40702_accessory/){P++}
	    if(TMP[n] ~ /38218_accessory/){P++}
	    if(TMP[n] ~ /36472_accessory/){P++}
	    if(TMP[n] ~ /36170_accessory/){P++}
	    if(TMP[n] ~ /36013_accessory/){P++}
	    if(TMP[n] ~ /34978_accessory/){P++}
	    if(TMP[n] ~ /42395_accessory/){N++}
	    if(TMP[n] ~ /38533_accessory/){N++}
	    if(TMP[n] ~ /38377_accessory/){N++}
	}
	#print P,N
	if(P==9 && N==2){
	    print ID[m],GENE[ID[m]]
	}
    }
}

##以下方式可行
######################################################################
##if((TMP[n] ~ /42474_accessory/) || (TMP[n] ~ /42277_accessory/) ||(TMP[n] ~  /40847_accessory/))P++
#{
##if(/42474_accessory/ && /42277_accessory/ && /40847_accessory/ && /40702_accessory/ && /38218_accessory/)print $0
#}
##/42474_accessory/ && /42277_accessory/ && /40847_accessory/ && /40702_accessory/ && /38218_accessory/{print $0}
