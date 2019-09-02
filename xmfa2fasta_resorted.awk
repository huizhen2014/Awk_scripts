BEGIN{
    while((getline < ARGV[1])>0){
	if(/^#Sequence[0-9]{,2}File/){
	    gsub("#","",$1)
	    gsub(".*/","",$2)
	    gsub("\.fna|\.fasta|\.fa","",$2)
	    #print $1,$2
	    Seq[++i]=$2
	}
    }
}
!/^#/ && !/^=/{
    if(/^>/){
	i++
	tmp=index($2,":")
	num=substr($2,1,tmp-1)
	name=Seq[num]
	interval=substr($2,tmp+1)
	print ">"name":"interval >>name".xmfa_resorted"
	next
    }
    gsub("-","",$0)
    if($0)print $0 >> name".xmfa_resorted"

}

