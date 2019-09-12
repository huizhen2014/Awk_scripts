##diamond blastx 
##diamond blastx --query-gencode 11 --query-cover 60 -d ../sprot.dmnd -q trinity_out_dir/kp_21_trinity_unique.fasta -f 6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore evalue btop > kp_21_trinity_prokka.results

##blastx
##blastx -db ../Bacteria/sprot -evalue 1e-3 -qcov_hsp_perc 60 -query trinity_out_dir/kp_21_trinity_unique.fasta -outfmt "6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore evalue btop" -query_gencode 11 > kp_21_trinity_prokka_blast.results

##Filter the search result with the criteria:If the collected interval would intersect with the next interval, the script would selcet the one with the higher bitscore
BEGIN{
    FS="\t"
    OFS="\t"
}
{
    if($1 in Contig){
	Tmp[$1]=0
	for(var in Annot){
#	    print "length Annot",length(Annot)
	    split(Annot[var],T,"\t")
	    if(T[1] == $1){
		S[1]=$3;S[2]=$4;S[3]=T[3];S[4]=T[4]
#		print "before",S[1],S[2],S[3],S[4]
		asort(S)
		if( ((S[1]==$3) && (S[2]==$4)) || ((S[1]==$4) && (S[2]==$3)) || ((S[1]==T[3]) && (S[2]==T[4])) || ((S[1]==T[4]) && (S[2]==T[3])) ){
		    Tmp[$1]=Tmp[$1]+1
#		    print "alfter",S[1],S[2],S[3],S[4]
#		    print Tmp[$1],Contig[$1]
		}else{
#		    print "$13",$13,T[13]
		    if($13 > T[13]){
#			print Annot[var]
			print Annot[var] > "tmp"
			delete Annot[var]
			Annot[$0]=$0
			Tmp[$1]=0
			next
		    }else{
#			print Annot[var]
			print $0 > "tmp"
			Tmp[$1]=0
			next
		    }
		}
	    }
	}
#	print Tmp[$1],Contig[$1],$1
	    if(Tmp[$1]==Contig[$1]){
		    Annot[$0]=$0
		    Contig[$1]=Contig[$1]+1
#		    print "length",length(Annot)
		    next
	    }
	
    }else{
	Contig[$1]=Contig[$1]+1
#	print "Contig[$1]",Contig[$1]
	Annot[$0]=$0
    }
}


END{
    for(var in Annot){
	print Annot[var]
    }
}
