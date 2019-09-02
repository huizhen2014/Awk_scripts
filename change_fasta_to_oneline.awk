##changet the fasta seq into one line

awk '/^>/ && NR>1{print ""}{printf "%s",/^>/?$0"\t":$0}' YourFile

##count the length of transfered fasta file

awk '/^>/ && NR>1{print ""}{printf "%s",/^>/?$0"\t":$0}' YourFile | awk '{print length($2)}'


