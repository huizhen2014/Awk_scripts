##diamond blastx 
##diamond blastx --query-gencode 11 -d ../sprot.dmnd -q trinity_out_dir/kp_21_trinity_unique.fasta -f 6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore qcovhsp evalue btop qseq > kp_21_trinity_prokka.results
##diamond blastx qseq为query fasta sequence，if(start < end):substr($seq,start,end-start+1);if(start >end):substr($seq,end,start-end+1)

##blastx
##blastx -db ../Bacteria/sprot -evalue 1e-5 -query_gencode 11 -query trinity_out_dir/kp_21_trinity_unique.fasta -outfmt "6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore qcovs evalue btop qseq" > kp_21_trinity_prokka_blast.results

##extact the mapping interval from contig fasta files, if(start < end):substr($seq,start,end-start+1); if(start > end):revcomp(substr($seq,end,start-end+1)) equal to the Protein sequences

##querycov filter > 60 query interval sequence mapping at least 60% of the target sequence

##Filter the search result with the criteria:If the collected interval would intersect with the next interval, the script would selcet the one with the higher bitscore
BEGIN{
    FS="\t"
    OFS="\t"
}
(sqrt(($3-$4)^2)+1) / ((sqrt(($7-$8)^2)+1)*3) >= 0.6{
    if($1 in Contig){
	Tmp[$1]=0
	for(var in Annot){
	    split(Annot[var],T,"\t")
	    if(T[1] == $1){
		S[1]=$3;S[2]=$4;S[3]=T[3];S[4]=T[4]
		asort(S)
		if( ((S[1]==$3) && (S[2]==$4)) || ((S[1]==$4) && (S[2]==$3)) || ((S[1]==T[3]) && (S[2]==T[4])) || ((S[1]==T[4]) && (S[2]==T[3])) ){
		    Tmp[$1]=Tmp[$1]+1
		}else{
		    if($13 > T[13]){
			#print Annot[var] > "Omitted_results_by_filter.txt"
			delete Annot[var]
			Annot[$0]=$0
			next
		    }else{
			#print $0 > "Omitted_results_by_filter.txt"
			next
		    }
		}
	    }
	}
	    if(Tmp[$1]==Contig[$1]){
		    Annot[$0]=$0
		    Contig[$1]=Contig[$1]+1
		    next
	    }
	
    }else{
	Contig[$1]=Contig[$1]+1
	Annot[$0]=$0
    }
}


END{
    for(var in Annot){
	print Annot[var]
    }
}
