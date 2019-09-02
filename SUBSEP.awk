BEGIN{
    ##works well
    M["a","b"]=1
    M["c","d"]=2
    for(var in M){
	split(var,N,SUBSEP)
	print var,N[1],N[2]
    }
    ##cant work
    Q["a"]["b"]=1
    Q["c"]["d"]=2
    for(var in Q){
	split(var,R,SUBSEP)
	print var,R[1],R[2]
    }
}
