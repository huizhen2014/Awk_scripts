BEGIN{
		while((getline < "Agilent_V5_Region_simplified.bed")>0){
				#建立分解值，为下面拆分做准备
				BED[++i]=$0
				}
		for(i=1;i<=22;i++){
				CHR[i]=i
		}
		CHR[23]="X";CHR[24]="Y"
		RS=">"
		#使用while getline "file",只能读取一次文件
		while((getline<"hs37d5.fa")>0){
        #每行60个字符长度
				for(j=1;j<=24;j++){
						if($0 ~ "GRCh37:"CHR[j]":"){
								t=0
								for(k=4;k<=NF;k++){
										SEQ[CHR[j],++t]=$k
									  #print CHR[j],t,SEQ[CHR[j],t]
								}
						}
				}
		}
		for(n=1;n<=length(BED);n++){
				split(BED[n],tmp)
					 for(s=1;s<=24;s++){
							if(tmp[1] == CHR[s]){
									seq=""
									start=end=len=start_num=start_re=end_num=end_re=0
									#bed 文件从0计数
									start=tmp[2]+1;end=tmp[3];len=tmp[3]-tmp[2]
									start_num=int(start/60)
									start_re=start%60
                  #判断起点是否整除
									start_num=(start_re==0)?start_num:start_num+1
									start_re=(start_re==0)?60:start_re
									#获取interval起点序列
									seq=seq substr(SEQ[CHR[s],start_num],start_re)
                  #获得interval中间序列
									for(m=start_num+1;m<=int(end/60);m++){
											seq=seq SEQ[CHR[s],m]
									}
                  #获得interval尾部序列
									end_num=int(end/60)
									end_re=end%60
                  #判断尾部是否整除
									if(end_re==0){
										 print BED[n],len,length(seq),seq
									}else if(end_re >0){
										 seq=seq substr(SEQ[CHR[s],end_num+1],1,end_re)
										 print BED[n],len,length(seq),seq
									}
								}
						}
		  }
}
