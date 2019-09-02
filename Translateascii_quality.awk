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
		len=split($0,Qual,"")
		for(n=1;n<=len;n++){
				printf "%d ",(array[Qual[n]]-33)
		}
		printf "\n"
}

