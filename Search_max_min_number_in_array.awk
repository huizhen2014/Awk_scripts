BEGIN{
    #Count the max or min number in a array
		a[1]=10;a[2]=9;a[3]=6;a[4]=11;a[5]=7;a[6]=13
		#max=a[1]
		#for(i in a){
		#		if(a[i]>max){
		#				max=a[i]
		#		}
		#		continue
		#}
		#print max
		min=a[1]
		for(i in a){
				if(a[i]<min){
						min=a[i]
				}
				continue
		}
		print min
    for(x in a){
				if(a[x] == min){
						end=x
						print end
				}
		}
}
