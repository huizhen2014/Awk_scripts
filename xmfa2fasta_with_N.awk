BEGIN{
    while((getline < ARGV[1])>0){
	if(/^#Sequence[0-9]{,2}File/){
	    gsub("#","",$1)
	    gsub(".*/","",$2)
	    gsub("\.fna|\.fasta|\.fa","",$2)
	    Seq[++i]=$2
	}
    }
}
!/^#/{
    if(/^>/){
	tmp=index($2,":")
	num=substr($2,1,tmp-1)
	name=Seq[num]
	interval=substr($2,tmp+1)
	print ">"name":"interval >>name".xmfa"
	Inc[name]=1
	next
    }else if(!/^>/ && !/^=$/){
	gsub("-","N",$0)
	print $0 >> name".xmfa"
	len_total+=length($0)

    }else if(/^=$/){
	
	len=len_total/length(Inc)
	for(k=1;k<=len;k++){
	   str=str sprintf("%s","N")
	}
	
	for(j=1;j<=length(Seq);j++){
	    if(!Inc[Seq[j]]){
		##gsub("-","N",str)
		print str >>Seq[j]".xmfa"
	    }
	    delete Inc[Seq[j]]
	    }
	
	len_total=0
	str=""
    }
}

