##gk -f separate_combine_core_for_rgi.awk $(find $(pwd) -name "*rgi_result.txt")
##这里打印出来的core genes 没有区分突变
BEGIN{
    FS="\t"
}
{
    match(FILENAME,"[0-9]{5}")
    name=substr(FILENAME,RSTART,RLENGTH)
    Name[name]=1
    if(FNR==1)printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n","name","contig","start","stop","best_hit_ARO","Best_Identities","SNPs_in_Best_Hit_ARO","Other_SNPs","Percentage Length of Reference Sequence" > name"_mutation.txt"
	if(($13 != "SNPs_in_Best_Hit_ARO") || ($14 != "Other_SNPs")){
	    Gene[$9]=1
	    Sample[name,$9]=name"\t"$2"\t"$3"\t"$4"\t"$9"\t"$10"\t"$13"\t"$14"\t"$21
	    if(($13 != "n/a") || ($14 != "n/a")){
		    print name"\t"$2"\t"$3"\t"$4"\t"$9"\t"$10"\t"$13"\t"$14"\t"$21 > name"_mutation.txt"
	    }
	}
}
END{
    for(gene in Gene){
	tmp=0
	for(file in Name){
	    if(Sample[file,gene])tmp++
	}
	if(tmp==length(Name)){
	    Core[gene]=1
	    print gene > "rgi_core_gene.txt"
	}
    }
    for(file in Name){
	printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n","name","contig","start","stop","best_hit_ARO","Best_Identities","SNPs_in_Best_Hit_ARO","Other_SNPs","Percentage Length of Reference Sequence" > file"_accessory.txt"
	for(gene in Gene){
	    if(Sample[file,gene] &&(!Core[gene])){
		print Sample[file,gene] > file"_accessory.txt"
	    }
	}
    }
}
		
