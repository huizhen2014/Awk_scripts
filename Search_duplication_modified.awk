{
		#从1开始对每个read信息计数，第一行记录为数组name
		n++
		name[n]=$0
		#print Name[n]
    #读入下一行序列信息，命名为seq
		getline seq
		#等号赋值时从左往右依次进行，所以当m=n++时，m从0，n从1递增；建立数组记录序列的位置信息，序列信息及重复次数
		if(seq in Iterm){
				N=Iterm[seq]
				Dup_seq[N]=seq
				DUP_SEQ[seq]=++Count[seq]
				#print Iterm[seq],seq,DUP_SEQ[seq]
		}else{
		    Seq[n]=seq
		    #建立数组，确定duplication read出现的第一个位置
				Iterm[seq]=n
				#++Count[seq]
		    SEQ[Seq[n]]=++Count[seq]
		    #printf "%s\t%d\n",Seq[n],SEQ[Seq[n]]
		    #print seq,SEQ[n,seq]
		}
		getline
    #读入第四行质量信息，记录为数组qual
		getline qual[n]
		#print n,qual[n]
}
END{
		sub(".fastq","_deduplicated.fastq",FILENAME)
		output=FILENAME
		sub("_deduplicated.fastq","_duplication.report",FILENAME)
		dul_report=FILENAME
		#print dul_report
		for(m=1;m<=n;m++){
        #awk均以string来对待,duplication均以出现的第一次来标记输出
				if(SEQ[Seq[m]]){
						printf "%d\t%s\n", m,name[m] >> output
						printf "%d\t%s\n",m,Seq[m] >> output
						printf "%d\t%s\n",m,"+" >> output
						printf "%d\t%s\n",m,qual[m] >> output
						if(Dup_seq[m])printf "%d\t%s\t%d\n",m,Dup_seq[m],DUP_SEQ[Dup_seq[m]] >> dul_report
				}
		}
}
