#-v FS -v RS, after separate the FS or RS, the corresponding separate element is elimiated, So, the same delimiter cant be used twice.

#sed 's/>/#>/g' 10_L2_combined_contigs.fasta | awk  -v RS="#" -v FS=">" '{if(NR==2)print $2}' | le

#for i in $(ls);do sed 's/>/#>/' $i | awk -v RS="#" -v FS=">" '{if(NR==2)print ">"$2}'>>collection.fasta; done
