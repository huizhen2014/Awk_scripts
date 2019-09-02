{
		#从1开始对每个read信息计数，第一行记录为数组name
		n++
		name[n]=$0
		#print Name[n]
    #读入下一行序列信息，命名为seq
		getline seq
		#等号赋值时从左往右依次进行，所以当m=n++时，m从0，n从1递增；建立数组记录序列的位置信息，序列信息及重复次数
		Seq[n]=seq
		#++Count[seq]
		SEQ[Seq[n]]=++Count[seq]
		#printf "%s\t%d\n",Seq[n],SEQ[Seq[n]]
		#print seq,SEQ[n,seq]
		getline
    #读入第四行质量信息，记录为数组qual
		getline qual[n]
		#print n,qual[n]
}
END{
		sub(".fastq","_deduplicated.fastq_new",FILENAME)
		output=FILENAME
		for(m=1;m<=n;m++){
				if(SEQ[Seq[m]] == "1"){
						printf "%d\t%s\n", m,name[m] >> output
						printf "%d\t%s\n",m,Seq[m] >> output
						printf "%d\t%s\n",m,"+" >> output
						printf "%d\t%s\n",m,qual[m] >> output
				}else{
						if(Seq[m] in Dupl){
								continue
						}else{
								Dupl[Seq[m]]=SEQ[Seq[m]]
						    printf "%d\t%s\t%d\n", m,Seq[m],SEQ[Seq[m]] >> "Duplicated.text_new"
						}
				}
		}
}
