## input fsa seq, print the name and seq
## $(find $(pwd) -name "*_pan.faa")
## fasta文件对应名称的序列
##-v指定SEQ为需提取序列名称

##函数应该放到最外面，不在BEGIN，也不再{}内
#function iterate(value){
#   print value
#    do{
#	getline
#	if(!/>/){
#	    print $0
#	}else if(/>/ && /blaKPC/){
#	    iterate($0)
#	}
#   }while(!/>/)
#}
BEGIN{
    if(!SEQ){
    print "Input your wanted seq ID assigned by SEQ"
    exit
    }
}

/^>/&& $0 ~ SEQ{
    print $0
    do{
	    ##getline:遇到文件末尾返回0；遇到错误返回-1；正确读取返回1
	    if((getline seq)== 0)exit

	    if(seq !~ /^>/){
		print seq
	    }else if(seq ~ /^>/ && seq ~ SEQ){
	        print seq 
	    }else if(seq ~ /^>/ && seq !~ SEQ){
	        next
	    }

	}while(seq)

i}

