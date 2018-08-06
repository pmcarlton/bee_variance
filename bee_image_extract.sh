# Extract the target images from the supplemental data PDF file and equalize the image sizes:

pdfimages -j $HOME/aar4975_Howard_SM.pdf $HOME/imgdir/bees
cd imgdir
mkdir targets
for i in $(seq -w 13 4 396 );
	do mv bees-$i targets/;
	done
mv bees-010.jpg targets/
cd targets
for i in bees*jpg;
	do convert -resize 113x113\! $i rescaled$i;
	done # make all 113x113, the most common size
	
