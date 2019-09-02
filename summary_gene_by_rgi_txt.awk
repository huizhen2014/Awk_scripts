##这里打印出来的core gene没有区分突变
##输入文件，先为阳性后为阴性
BEGIN{
    FS="\t"
    OFS="\t"
    while((getline file < "all_rgi_results.txt")>0){
	#print file
	match(file,"[0-9]{5}")
	name=substr(file,RSTART,RLENGTH)
	num=0
	File[++i]=name
	while((getline < file)>0){
	    num++
	    if(num>1){
		#print name
		Gene[$9]=1
		#print $9
		Product[$9]=$15"\t"$16"\t"$17
		#print Product[$9]
		Sample[name,$9]=1
	    }
	}
    }

    printf "%s\t%s\t%s\t%s\t%s\n","Atrribution","Gene","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Core_genes.txt"
    printf "%s\t%s\t%s\t%s\t%s\n","Atrribution","Gene","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Positive_all_genes_exclude_core.txt"
    printf "%s\t%s\t%s\t%s\t%s\n","Atrribution","Gene","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Negative_all_genes_exclude_core.txt"    
    printf "%s\t%s\t%s\t%s\t%s\n","Atrribution","Gene","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Positive_unique_genes.txt"
    printf "%s\t%s\t%s\t%s\t%s\n","Atrribution","Gene","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Negative_unique_genes.txt"

    len=asorti(Gene)
    for(m=1;m<=len;m++){
	#print Gene[m]
	tmp_p=0
	tmp_n=0
	for(n=1;n<=5;n++){
	    if(Sample[File[n],Gene[m]])tmp_p++
	}
	for(n=6;n<=8;n++){
	    if(Sample[File[n],Gene[m]])tmp_n++
	}

	if(tmp_p==5 && tmp_n==3){
	    print "Core genes",Gene[m],Product[Gene[m]] > "Core_genes.txt"
	    #print Gene[m]
	    Total_cor[++cor]=Gene[m]
	}else if(tmp_p==5 && tmp_n !=3){
	    #print Gene[m]
	    print "Positive genes",Gene[m],Product[Gene[m]] > "Positive_all_genes_exclude_core.txt"
	    Total_pos[++pos]=Gene[m]
	}else if(tmp_p!=5 && tmp_n==3){
	    #print Gene[m]
	    print "Negative genes",Gene[m],Product[Gene[m]] > "Negative_all_genes_exclude_core.txt"
	    Total_neg[++neg]=Gene[m]
	}else{
	    #print Gene[m]
	    Total_las[++las]=Gene[m]
	}

	if(tmp_p==5 && tmp_n==0)print Gene[m],Product[Gene[m]] > "Positive_unique_genes.txt"
	if(tmp_p==0 && tmp_n==3)print Gene[m],Product[Gene[m]] > "Negative_unique_genes.txt"
    }
    close("Core_genes.txt")
    close("Positive_all_genes_exclude_core.txt")
    close("Negative_all_genes_exclude_core.txt")
    close("Positive_unique_genes.txt")
    close("Negative_unique_genes.txt")

    ##sort the gene by distribution
    for(k=1;k<=length(Total_cor);k++){
	if(Total_cor[k])Total_sort[++count]=Total_cor[k]
    }
    for(k=1;k<=length(Total_pos);k++){
	if(Total_pos[k])Total_sort[++count]=Total_pos[k]
    }
    for(k=1;k<=length(Total_neg);k++){
	if(Total_neg[k])Total_sort[++count]=Total_neg[k]
    }
    for(k=1;k<=length(Total_las);k++){
	if(Total_las[k])Total_sort[++count]=Total_las[k]
    }
    ##print the resuts
    printf "%s\t", "Genes" > "Distribution_by_samples_on_row_ignore_mutation.txt"
    for(n=1;n<=length(File);n++){
	printf "%s\t",File[n] > "Distribution_by_samples_on_row_ignore_mutation.txt"
    }
    printf "%s\t%s\t%s\n","Drug_Class","Resistance Mechanism","AMR Gene Family" > "Distribution_by_samples_on_row_ignore_mutation.txt"
    #for(var in Total_sort)print var,Total_sort[var]


    for(n=1;n<=length(Total_sort);n++){
	printf "%s\t",Total_sort[n] > "Distribution_by_samples_on_row_ignore_mutation.txt"
	for(m=1;m<=length(File);m++){
	    if(Sample[File[m],Total_sort[n]]){
		printf "%d\t",1 > "Distribution_by_samples_on_row_ignore_mutation.txt"
	    }else{
		printf "%d\t",0 > "Distribution_by_samples_on_row_ignore_mutation.txt"
	    }
	}
	printf "%s\n",Product[Total_sort[n]] > "Distribution_by_samples_on_row_ignore_mutation.txt"
	#print "" > "Distribution_by_samples_on_row_ignore_mutation.txt"
    }
    close("Distribution_by_samples_on_row_ignore_mutation.txt")
}
