# number of wipes you want it to do
wipeRuns=5
# Name of the file to create
wipeFile="fileee"
# String to fill the file with
wipeStr="ABCDEFG"
# If your having high CPU usage or crashes, set this to a small value like 0.001
rest=0

echo "Starting wipe"
ctr=0
offSet=0
while (( ctr != wipeRuns ))
do
	((ctr++))

	# do a charecter offset so it doesnt wipe over itself identically
	offCtr=0
	while (( offSet > offCtr ))
	do
		printf "A" >> $wipeFile
		((offCtr++))
	done
	offCtr=0
	((offSet++))
	errorCtr=0
  
  # Do the wipe
	while (( errCtr != 20 ))
	do
    # Should fail to add onto the file when memory is full
		printf "$wipeStr " >> $wipeFile || (( errorCtr++))
		sleep $rest
	done
	rm $wipeFile
	echo "completed wipe: $ctr/$wipeRuns"
done
