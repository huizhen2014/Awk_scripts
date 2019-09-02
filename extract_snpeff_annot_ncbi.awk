##读取NCBIgff3格式文件
##读取snpEff根据gff3注释的vcf文件，提取对应信息
BEGIN{
    FS="\t"
    OFS="\t"
    while((getline <ARGV[1])>0){
	if(!/^#/){
	    if($3 == "gene"){
		split($9,N,";")
		for(i=1;i<=length(N);i++){
		    if(N[i] ~ /^Name/){
			#print N[i]
			gsub("Name=","",N[i])
			Name[$1,$4]=N[i]
			#print Name[$1,$4]
		    }
		}
	    }else{
		if(Name[$1,$4]){
		    split($9,M,";")
		    for(i=1;i<=length(M);i++)if(M[i] ~ /^product/)Gene[Name[$1,$4]]=M[i]
		}
	    }
	}
    }
    ##打印表头文件
    print "Chrom\tRef\tAlt\tFilter\tGene_ID\tGene_Name\tAnnotation\tPutative_Impact\tTranscript_Biotype\tRank_Total\tHGVS.c\tHGVS.p\tcDNA_Position\tCDS_Position\tProtein_Position"
}
!/^#/ && FILENAME == ARGV[2]{
    start=index($8,"ANN")
    annot=substr($8,start)
    split(annot,P,"|")
    print $1,$4,$5,$7,P[4],Gene[P[4]],P[2],P[3],P[8],P[9],P[10],P[11],P[12],P[13],P[14]
}

