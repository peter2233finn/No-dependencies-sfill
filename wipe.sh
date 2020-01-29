# number of wipes you want it to do
wipeRuns=5
# Name of the file to create
wipeFile="fileee"
# String to fill the file with
wipeStr="ABCDEFG"
# If your having high CPU usage or crashes, set this to a small value like 0.001
rest=0
# blockSize sets the size of the blocks
blockSize=1000
# wipeFolder is the name of the folder the wipe files will be copied to
wipeFolder="folder1"

printf "Starting wipe\n"
ctr=0
offSet=0


while (( ctr != wipeRuns ))
do
	# creates the temporary file
	offCtr=0
	for i in {0..$wipes}
		do

		# do a charecter offset so it doesnt wipe over itself identically
		while (( offSet > offCtr ))
		do
			printf "A" >> $wipeFile
			((offCtr++))
		done

		# create tempoary block
		for i in $(seq 1 $blockSize)
		do
			printf $wipeStr >> tmpFile
		done
	done

	((ctr++))
	offCtr=0
	((offSet++))
	errorCtr=0
  
	# create the folder
	mkdir $wipeFolder
	printf "Folder $wipeFolder created...\n"

	fileCtr=0
	while (( errorCtr < 20 ))
	do
    		# Will copy the file until 20 errors accor (Assumption is that memory is full)
		cp tmpFile $wipeFolder/$wipeFile.$fileCtr || (( errorCtr++))
		((fileCtr++))
		sleep $rest
		printf "Wipe number: $ctr/$wipeRuns file: $fileCtr created\n"
	done
	printf "Not enough memory to create any more files. Will fill up the remaining space/n"
	while true
	do
		printf $wipeStr >> $wipeFolder/$wipeFile || break

	done
	rm $wipeFile
	rm -r $wipeFolder
	rm tmpFile
	printf "completed wipe: $ctr/$wipeRuns \n"
done
printf "All done...\n"
