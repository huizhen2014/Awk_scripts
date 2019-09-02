##input faa seq, print the name and seq, separated by tab
## $(find $(pwd) -name "*_pan.faa")

function iterate(value){
    print value
    do{
	getline
	if(/^>/ && /blaKPC/){
	    iterate($0)
	}else if(/^>/){
	    break
	}
	print $0
    }while($0 !~ />/)
}

/^>/ && /blaKPC/{
    #match(FILENAME,"[0-9]{5}")
    #outfile=substr(FILENAME,RSTART,RLENGTH)
    #print outfile
    #print $0 
    print $0
    do{
	getline 
	if(/^>/ && /blaKPC/){
	    iterate($0)
	    break
	}else if(/^>/){
	    break
	}
	print $0
	}while($0 !~ />/)

}

