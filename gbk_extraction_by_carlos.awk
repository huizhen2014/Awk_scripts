##extract the info from ncbi genbak format file to plain txt file
##Notice: customized value, /serotype|/serovar
##
function interval(value){
    result=sprintf("%s",substr(value,1))
    do{
	if((getline seq) == 0)next
	if(seq ~ "\""){
	    gsub("[\" ]","",seq)
	    result=sprintf("%s%s",result,seq)
	    return result
	    next
	}else{
	    gsub("[ ]","",seq)
	    result=sprintf("%s%s",result,seq)
	}
    }while(seq)
}

BEGIN{
    OFS="\t"
    title=sprintf("%s\t%s\t%s\t%s\t%s\t%s\t%s","Locus","Length","Organism","Sero","Interval","Gene","Product")
}
{
    sub("\\..*","",FILENAME)
    out=FILENAME
	if($0 ~ "^LOCUS"){
	    locus=$2
	    len=$3
            ##custromized value
	    sero=""
	}else if ($0 ~ "/organism"){
	    tmp=substr($0,index($0,"\"")+1)
	    organism=substr(tmp,1,index(tmp,"\"")-1)
	}else if($0 ~ "/serovar|/serotype"){
	    tmp=substr($0,index($0,"\"")+1)
	    sero=substr(tmp,1,index(tmp,"\"")-1)
	}else if ($0 ~ "CDS"){
	    gsub("[a-zA-Z() ]","",$0)
	    cds=$0
	}else if($0 ~ "/gene"){
	    tmp=substr($0,index($0,"\"")+1)
	    gene=substr(tmp,1,index(tmp,"\"")-1)
	}else if($0 ~ "/product"){
	    tmp=substr($0,index($0,"\"")+1)
	    if(tmp ~ "\""){
		product=substr(tmp,1,index(tmp,"\"")-1)
	    }else{
		product=interval(tmp)
	    }
	}else if($0 ~ "/protein_id"){
	    tmp=substr($0,index($0,"\"")+1)
	    protein_id=substr(tmp,1,index(tmp,"\"")-1)
	}else if($0 ~ "/translation"){
	    
	    if(title){print title >> out"_summary.txt";title=""}
	    
	    sero=sero?sero:locus
	    print locus,len,organism,sero,cds,gene,product >> out"_summary.txt"
	    
	    tmp=substr($0,index($0,"\"")+1)
	    if(tmp ~ "\""){
		translation=substr(tmp,1,index(tmp,"\"")-1)
	    }else{
		translation=interval(tmp)
	    }
	    
	    print sprintf(">%s_%s_%s_%s_%s",locus,organism,sero,cds,gene) >>out"_protein.faa"
	    print translation >> out"_protein.faa"

	}else if($0 ~ "^ORIGIN"){
	    do{
		if((getline seq) == 0)next
		    if(seq ~ "^//"){
			
			print sprintf(">%s_%s_%s_%s",locus,organism,sero,len) >> out"_cds.fa"
			print dna >> out"_cds.fa"
	                cds="";gene="";product="";dna=""
			next
			
			}else{
			    gsub("[0-9 ]","",seq)
			    dna=sprintf("%s%s",dna,seq)
			}
	    }while(seq)
	}
	    
}
