#!/bin/bash

# Give the user some help
if [ "$1" == "-h" ]; then
	echo "you need to launch this command for each pddl benchmark (ipc2000/blocks ipc2000/logistics ipc1998/gripper ipc2002/depots)"
	echo "this script write a tableau.md file with the results of the benchmarks"
	echo "It uses a .result.txt and .result2.txt file to store the results of the two planners"
	echo "you can find the differents benchmarks in the directory pddl4j/src/test/resources/benchmarks/pddl/"
	echo "Usage: $0 <directory> <HSP_Planner> <MTC_Planner>"
	exit 1
fi

# Define the target directory, the HSP directory and the MTC directory
directory="$1"
HSP="$2"
MTC="$3"

# Loop through files in the target directory
for file in "$directory"/*; do
	if [ -f "$file" ] && [ "${file##*/}" != "domain.pddl" ]; then
		# Let's the user know what's going on and choose the problem to run
		clear
		echo domain : ${directory##*/} problem :${file##*/}, wait some time before killing the process...
		echo "Press 'c' key to pass this file and continu"
                echo "Press any other key to (wait and) save the result"
                read -n 1 -s key
                if [ "$key" == "c" ]; then
                        continue
                fi
		echo "Let's go for a run"
		
		# Run the planners in parallel
		# The last output of the HSP is stored in a .result file
		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP.${HSP##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result)&
		pid1=$! # Store the PID of the first process

		# The last output of the MTC is stored in a .result2 file
		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP2.${MTC##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result2) &
 		pid2=$! # Store the PID of the second process
		
		wait $pid1
		# Get the results of HSP
		result=$(cat .result)

		# If HSP didn't find a plan, we skip the MCT and inform the user
		if [ -z "$result" ]; then
			echo "HSP n'a pas trouvé de plan"
			echo "MCT va être tué (et en passant tout les processus java)"
			kill $(pgrep -f "java")
			echo "|${file##*/}|$HSP_Time|NoPlanFound|timeout|timeout|timeout|timeout|" >> tableau.md	
			sleep 10
			continue
		fi
		
		wait $pid2
		# Get the results of MCT
		result2=$(cat .result2)

		# we cut the results to get the time and the length of the plan
		HSP_Time=$(echo "$result" | cut -d '|' -f 2)
		HSP_Length=$(echo "$result" | cut -d '|' -f 3)
		MCT_Time=$(echo "$result2" | cut -d '|' -f 2)
		MCT_Length=$(echo "$result2" | cut -d '|' -f 3)

		# If both planners found a plan, we calculate the difference between the two plans
		if [ -n "$result" ] && [ -n "$result2" ]; then	
			TimeDifference=$(($HSP_Time - $MCT_Time))

			if [ $HSP_Time -lt $MCT_Time ]; then	
				HSP_Time="**$HSP_Time**"
			elif [ $HSP_Time -gt $MCT_Time ]; then
				MCT_Time="**$MCT_Time**"
			else
				HSP_Time="**$HSP_Time**"
				MCT_Time="**$MCT_Time**"
			fi
			
			LengthDifference=$(($HSP_Length - $MCT_Length))
			
			if [ $HSP_Length -lt $MCT_Length ]; then
				HSP_Length="**$HSP_Length**"
			elif [ $HSP_Length -gt $MCT_Length ]; then
				MCT_Length="**$MCT_Length**"
			else
				HSP_Length="**$HSP_Length**"
				MCT_Length="**$MCT_Length**"
			fi
			# If the time of the MCT is greater than 10 minutes, we consider it as a timeout
			if [ $MCT_Time -gt "600000" ]; then 
				MCT_Time="Timeout"
				MCT_Length="Timeout"
			fi
			echo "|${file##*/}|$HSP_Time|$HSP_Length|$MCT_Time|$MCT_Length|$TimeDifference|$LengthDifference|" >> tableau.md
			continue
		fi	
	fi

	# If the target is a directory, we start a new table in the tableau.md file
	if [ -d "$file" ]; then
		MTC_short=$(echo "${MTC##*/}")
		HSP_short=$(echo "${HSP##*/}")
		echo " " >> tableau.md	
		echo "## Benchmark: $file" >> tableau.md
		echo " " >> tableau.md
		echo "|Problemes|${HSP_short} (ms total)|${HSP_short} (longueur)|${MTC_short} (ms total)|${MTC_short} (longueur)|Time Difference (${HSP_short}-${MTC_short})|Length Difference (${HSP_short}-${MTC_short})|" >> tableau.md
		echo "|:-------:|:------------:|:------------:|:------------:|:------------:|:-----------------------:|:-------------------------:|" >> tableau.md
		
		./script.sh "$file" "$HSP" "$MTC"
	fi
done

