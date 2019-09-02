BEGIN{
		array[1]=5;array[2]=3;array[3]=9;array[4]=1;array[5]=7
		
		#Increasing sorting!
		#for(i=2;i<=5;i++){
		#		for(j=i;(j-1) in array && array[j-1]>array[j];j--){
		#				tmp=array[j]
		#				array[j]=array[j-1]
		#				array[j-1]=tmp
		#		}
		#}
    #Descresing sorting!

		for(i=4;i>0;i--){
				for(j=i;(j+1) in array && array[j]<array[j+1];j++){
						tmp=array[j+1]
						array[j+1]=array[j]
						array[j]=tmp
				}
		}

		for(n=1;n<=5;n++){
				print n "->" array[n]
		}
}
							
