##文件排序，先为阳性后为阴性
BEGIN{
    FS="\t"
    OFS="\t"
    ##read all the input tsv files
    while((getline file < "all_gene.tsv")>0){
	match(file,"[0-9]{5}")
	name=substr(file,RSTART,RLENGTH)
	#print name
	num=0
	File[++i]=name
	while((getline < file)>0){
	    num++
	    if(($7 != "hypothetical protein") && (num>1)){
		#if(!$4){
		#    Rna[name,line]=$2"\t"$7
		#}
		if($4){
		    Gene[name,$4]=1
		    Total[$4]=1
		    Product[$4]=$7
		    #print $4,Product[$4]
		}
	    }
	}
    }
      printf "%s\t%s\t%s\n","Attribution","Gene","Product" > "Core_genes.txt"
      printf "%s\t%s\t%s\n","Attribution","Gene","Product" > "Positive_all_genes_exclude_core.txt"
      printf "%s\t%s\t%s\n","Attribution","Gene","Product" > "Negative_all_genes_exclude_core.txt"
      printf "%s\t%s\t%s\n","Attribution","Gene","Product" > "Positive_unique_genes.txt"
      printf "%s\t%s\t%s\n","Attribution","Gene","Product" > "Negative_unique_genes.txt"
      #for(var in File)print var,File[var]
       len=asorti(Total)
       #print Total[length(Total)]
       for(m=1;m<=len;m++){
	   tmp_p=0
	   tmp_n=0
	   for(n=1;n<=9;n++){
	       if(Gene[File[n],Total[m]])tmp_p++
	   }
	   for(j=10;j<=12;j++){
	       if(Gene[File[j],Total[m]])tmp_n++
	   }
	   ##print the genes to separated files
	   if(tmp_p==9 && tmp_n==3){ ##the core genes
	       print "Core genes",Total[m],Product[Total[m]] > "Core_genes.txt"
	       Total_cor[++cor]=Total[m] 
	   }else if(tmp_p==9 && tmp_n!=3){ ##the genes all positive posssess
	       print "Positive genes",Total[m],Product[Total[m]] > "Positive_all_genes_exclude_core.txt"
	       Total_pos[++pos]=Total[m]
	   }else if(tmp_p!=9 && tmp_n==3){ ##the genes all negetive possess
	       print "Negative genes",Total[m],Product[Total[m]] > "Negative_all_genes_exclude_core.txt"
	       Total_neg[++neg]=Total[m]
	   }else{
	       Total_las[++non]=Total[m]
	   }
	   ##print the unique genes
	   if(tmp_p==9 && tmp_n==0)print "Positive_unique",Total[m],Product[Total[m]] > "Positive_unique_genes.txt"
	   if(tmp_p==0 && tmp_n==3)print "Negative_unique",Total[m],Product[Total[m]] > "Negative_unique_genes.txt"

       }
       close("Core_genes.txt")
       close("Positive_all_genes_exclude_core.txt")
       close("Negative_all_genes_exclude_core.txt")
       close("Positive_unique_genes.txt")
       close("Negative_unique_genes.txt")
       #print length(Total_cor),length(Total_pos),length(Total_neg),length(Total_las)
       
       ##sort the gene by distribution
       for(k=1;k<=length(Total_cor);k++){
	   Total_sort[++count]=Total_cor[k]
       }
       #print count,"core"
       for(k=1;k<=length(Total_pos);k++){
	   Total_sort[++count]=Total_pos[k]
       }
       #print count,"positive"
       for(k=1;k<=length(Total_neg);k++){
	   Total_sort[++count]=Total_neg[k]
       }
       #print count,"negative"
       for(k=1;k<=length(Total_las);k++){
	   Total_sort[++count]=Total_las[k]
       }

       ##print the sorted genes names
       printf "%s\t","Sample" > "Distribution_by_genes_on_row.txt"
       for(x=1;x<=length(Total_sort);x++){
	   printf "%s\t",Total_sort[x] > "Distribution_by_genes_on_row.txt"
       }
       print "" > "Distribution_by_genes_on_row.txt"
       ##print the samples' distribution by genes, sample in the row, genes in the column
       for(s=1;s<=length(File);s++){
	   printf "%s\t",File[s] > "Distribution_by_genes_on_row.txt" 
	   for(t=1;t<=length(Total_sort);t++){
	       if(Gene[File[s],Total_sort[t]]){
		   printf "%d\t",1 > "Distribution_by_genes_on_row.txt"
	       }else{
		   printf "%d\t",0 > "Distribution_by_genes_on_row.txt"
	       }
	   }
	   print "",Product[Total_sort[s]] > "Distribution_by_genes_on_row.txt" ##打印空行, 输入"", 避免打印最后一行$0
       }

      ##print the samples' distribution by genes, genes in the column, samples in the row
      printf "%s\t","Genes" > "Distribution_by_samples_on_row.txt"
      for(x=1;x<=length(File);x++){
	  printf "%s\t",File[x] > "Distribution_by_samples_on_row.txt"
      }
      printf "%s\n","Product" > "Distribution_by_samples_on_row.txt" ##打印产物行
      
      for(s=1;s<=length(Total_sort);s++){
	  printf "%s\t",Total_sort[s] > "Distribution_by_samples_on_row.txt"
	  for(t=1;t<=length(File);t++){
	      if(Gene[File[t],Total_sort[s]]){
		  printf "%d\t",1 > "Distribution_by_samples_on_row.txt"
	      }else{
		  printf "%d\t",0 > "Distribution_by_samples_on_row.txt"
	      }
	  }
	  printf "%s\n",Product[Total_sort[s]] > "Distribution_by_samples_on_row.txt"  ##打印产物行
	  }
}
