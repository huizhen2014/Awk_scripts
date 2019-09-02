## combine the separated interval files to a aggregated interval file without intersection
##REF file wile be the first output file for the split_the_interval.awk, and the command input file will be the second output file from split_the_interval.awk
## Combined all the output files from split_the_interval.awk , we will get the aggregated interval file

## asorti permitted to run with gawk 3.1.2 and later edition
BEGIN{
    while((getline < REF)>0){
	F[$1]=$1"\t"$2"\t"$3
    }
}
{
    if(F[$1]){
	split((F[$1]),TMP,"\t")
	if($2<=TMP[2] && $3>= TMP[2] && $3 <= TMP[3]){
	    F[$1]=$1"\t"$2"\t"TMP[3]
	}else if($2>=TMP[2] && $2 <= TMP[3] && $3 >=TMP[3]){
	    F[$1]=$1"\t"TMP[2]"\t"$3
	}else if($2 <=TMP[2] && $3>= TMP[3]){
	    F[$1]=$1"\t"$2"\t"$3
	}else if($2>=TMP[2] && $3 <= TMP[3]){
	    F[$1]=$1"\t"TMP[2]"\t"TMP[3]
	}else if($2>TMP[3] || $3<TMP[2]){
	    S[$1]=$1"\t"$2"\t"$3
	}
    }
}
END{
    num=asorti(F,F_index)
    for(n=1;n<=num;n++){
	print F[F_index[n]]
	if(S[F_index[n]]){
	    print S[F_index[n]]
	}
    }
}


