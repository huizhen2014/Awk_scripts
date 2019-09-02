BEGIN{
		printf "Enter your file:"
		getline file < "-"
		while((getline name < file)>0){
				chr[++i]=name
		}
		for(n=1;n<=i;n++){
				print chr[n]
				sub(">","",chr[n])
				chr[n]=chr[n]".fa"
				while((getline seq < chr[n])>0){
						print seq >> "hg19.fa"
				}
		}
}

