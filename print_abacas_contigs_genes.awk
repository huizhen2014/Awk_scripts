###输出abacas拼接输出序列注释信息
##CONTIG="xxx.crunch" from abacas
##GFF="xxx.gff" from prokka
###再使用sort对脚本输出文件排序即可

BEGIN{
    ##读取abacas输出crunch文件，对应定序后的contigs顺序
    while((getline < CONTIG)>0){
	Contig[$5]=++i
	
	##对应拼接后文件累加位置坐标
	split($5,N,"_")
	j++
	Pos[j]=N[4] + Pos[j-1]
	#print i,j,Pos[j]
    }
    
    ##读取prokka输出gff文件，输出相应信息
    FS="\t"
    while((getline < GFF)>0){
	if(/^NODE/){
	    split($9,Att,";")
	    tmp=""
	    for(i=1;i<=length(Att);i++){
                ##记录累加内容信息
		if(Att[i] ~ "dbxref")tmp=Att[i]
		if(Att[i] ~ "gene")tmp=tmp?Att[i]"\t"tmp:Att[i]
		if(Att[i] ~ "HAMAP")tmp=tmp?tmp"\t"substr(Att[i],index(Att[i],"HAMAP")):substr(Att[i],index(Att[i],"HAMAP"))
		if(Att[i] ~ "UniProtKB")tmp=tmp?tmp"\t"substr(Att[i],index(Att[i],"UniProtKB")):substr(Att[i],index(Att[i],"UniProtKB"))
		if(Att[i] ~ "product")tmp=tmp?tmp"\t"Att[i]:Att[i]
	    }
            ##假如contig存在于crush文件，对应输出其内容及拼接后累加坐标位置
	    if(Contig[$1])print "Pos" "\t" Contig[$1] "\t"  Pos[Contig[$1]-1]+$4 "\t" Pos[Contig[$1]-1]+$5 "\t" $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $7 "\t" tmp
	}
    }

}
