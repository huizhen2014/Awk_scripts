##input xxx.faa from NCBI
BEGIN{
    OFS="\t"
}
/^>/{
    printf "%s\t",substr($0,index($0,"|")+1,11)
    location=substr($0,index($0,"location="))
    printf "%s\t",substr(location,1,index(location,"]")-1)
    locus_tag=substr($0,index($0,"locus_tag="))
    printf "%s\t", substr(locus_tag,11,index(locus_tag,"]")-11)
    if(/protein_id/){
	protein_id=substr($0,index($0,"protein_id="))
	printf "%s\t",substr(protein_id,12,index(protein_id,"]")-12)
	}else{
	    printf "%s\t","NA"
	}
    if(/protein/){
	protein=substr($0,index($0,"protein="))
	printf "%s\n",substr(protein,9,index(protein,"]")-9)
    }else if(/product/){
	product=substr($0,index($0,"product="))
	printf "%s\n",substr(product,9,index(product,"]")-9)
    }else{
	printf "%s\n","NA"
    }
}

