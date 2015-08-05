original_dir=`pwd`

rm -r output
#set data directories here (absolute paths)
mutect_dir="/scratch/git/impact/mutect"
varscan_dir="/scratch/git/impact/varscan"

mkdir output
mkdir output/mutect_chopped
mkdir output/varscan_chopped

cd $mutect_dir

	#chop off everything past column 120, then chop off headers
	
	echo Cutting off mutect headers and unnecessary columns...

	for i in * ;
		do cut -f1-102,104-121 $i | tail -n +32 > $original_dir/output/mutect_chopped/$i ;
	done

	cd $original_dir/output/mutect_chopped

	echo Replacing mutect barcodes with correct patient ID\'s...
		#Replace all patient ids 
		for i in * ;
			do j=`grep --only-matching -E "(COM|IMP)-[0-9]{5,5}" <<< $i | head -1`;
			awk -v j="$j" '{$16=j; $17=j; print}' FS='\t' OFS='\t' $i;
		done > ../mutect_final.txt 

cd $varscan_dir
	
	echo Cutting off varscan headers and unnecessary columns...
	#chop off everything past column 120, then chop off headers
	for i in * ;
		do cut -f1-120 $i | tail -n +6 | awk -F"\t" '$17 != "NORMAL"' > $original_dir/output/varscan_chopped/$i ; 
	done

	cd $original_dir/output/varscan_chopped

	echo Replacing varscan barcodes with correct patient ID\'s...

		#Replace all patient ids 
		for i in * ;
			do j=`grep --only-matching -E "(COM|IMP)-[0-9]{5,5}" <<< $i | head -1`;
			awk -v j="$j" '{$16=j; $17=j; print}' FS='\t' OFS='\t' $i;
		done > ../varscan_final.txt

	cd ..
echo Appending data files...
cat mutect_final.txt varscan_final.txt > temp.txt

echo Appending headers...
cat ../mutation_data_header.txt temp.txt > data_mutations_extended.txt

echo Removing temporary directories...
rm temp.txt mutect_final.txt varscan_final.txt
rm -r mutect_chopped
rm -r varscan_chopped

cd ..

#command to grab all unique patient ids in tab delim form
#cut -f16 output/data_mutations_extended.txt | sort | uniq | tr "\n" "\t"