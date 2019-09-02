##根据注释文件gff的基因名称/基因产物等对应关系，先录入其关系
##然后提取snpeff注释后文件需要信息
##含有多个注释信息时，仅提取第一个注释信息

BEGIN{
    #判断命令行参数，ARGC-1 = length(ARGV), ARGV[0] = gk/awk
    if(ARGC-1 != 2){
	print "Enter your gff annotation file and snpEff annotated file"
	exit
	}
    #根据输入，设定限定符
    FS="\t"
    OFS="\t"
    while((getline < ARGV[1])>0){
	gsub("ID=fig\\|","",$NF)
	split($NF,M,";")
	NAME[M[1]]=M[2]
	#print M[1],M[2]
    }
    ##打印表头文件
    print "Chrom\tRef\tAlt\tFilter\tGene_ID\tGene_Name\tAnnotation\tPutative_Impact\tTranscript_Biotype\tRank_Total\tHGVS.c\tHGVS.p\tcDNA_Position\tCDS_Position\tProtein_Position"
}
!/^#/ && FILENAME == ARGV[2]{
    start=index($8,"ANN")
    annot=substr($8,start)
    split(annot,N,"|")
    print $1,$4,$5,$7,N[5],NAME[N[5]],N[2],N[3],N[11],N[12],N[13],N[14],N[15],N[16],N[17]
    #print $1,$4,$5,$7,length(N)
}



