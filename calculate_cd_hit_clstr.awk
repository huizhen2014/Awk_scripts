###打印cd-hit输出.clstr文件中没有匹配到的代表性序列名称(即，仅含*结尾序列的cluster)
{
    if(/^>/){
	gsub(">","",$0)
	gsub(" ","_",$0)
	name=$0
	Name[++k]=name
    }else{
	if(/*$/){
	    match($0,"\\|.*\*")
	    ref=substr($0, RSTART+1,RLENGTH-6)
	    Cls_ref[name]=ref
	}else{
	    match($0,"\\|.*at")
	    tar=substr($0,RSTART+1,RLENGTH-7)
	    Cls_tar[name]=Cls_tar[name]?Cls_tar[name]"\t"tar:tar
	}
    }
}
END{
    for(i=1;i<=k;i++){
	if(!Cls_tar[Name[i]]){
	    print Cls_ref[Name[i]] > "total_unique"
	    }
        }
}

