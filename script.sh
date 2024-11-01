#!/bin/bash

if [ "$1" == "-h" ]; then
	echo "you need to launch this command for each pddl benchmark (ipc2000/blocks ipc2000/logistics ipc1998/gripper ipc2002/depots)"
	echo "this script write a tableau.md file with the results of the benchmarks"
	echo "It uses a .result.txt and .result2.txt file to store the results of the two planners"
	echo "you can find the differents benchmarks in the directory pddl4j/src/test/resources/benchmarks/pddl/"
	echo "Usage: $0 <directory> <HSP_Planner> <MTC_Planner>"
	exit 1
fi

# Define the target directory
directory="$1"
HSP="$2"
MTC="$3"

# Loop through files in the target directory
for file in "$directory"/*; do
	if [ -f "$file" ] && [ "${file##*/}" != "domain.pddl" ]; then
		clear
		echo domain : ${directory##*/} problem :${file##*/}, wait some time before killing the process...
		echo "Press 'c' key to pass this file and continu"
                echo "Press any other key to (wait and) save the result"
                read -n 1 -s key
                if [ "$key" == "c" ]; then
                        continue
                fi
		
		echo "Let's go for a run"
		
		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP.${HSP##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result.txt)&
		pid1=$!

		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP2.${MTC##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result2.txt) &
 		pid2=$!

		wait $pid1
		result=$(cat .result.txt)

		echo "HSP result : $result"		
		
		if [ -z "$result" ]; then
			echo "HSP n'a pas trouvé de plan"
			echo "MCT quitte automatiquement après 10 minutes ou si vous fermez le script"
			echo "|${file##*/}|$HSP_Time|NoPlanFound|timeout|timeout|timeout|timeout|" >> tableau.md	
			sleep 10
			continue
		fi
		
		wait $pid2
		result2=$(cat .result2.txt)

		HSP_Time=$(echo "$result" | cut -d '|' -f 2)
		HSP_Length=$(echo "$result" | cut -d '|' -f 3)
		MCT_Time=$(echo "$result2" | cut -d '|' -f 2)
		MCT_Length=$(echo "$result2" | cut -d '|' -f 3)

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
			echo "|${file##*/}|$HSP_Time|$HSP_Length|$MCT_Time|$MCT_Length|$TimeDifference|$LengthDifference|" >> tableau.md
			continue
		fi	
	fi
	if [ -d "$file" ]; then
		echo " " >> tableau.md	
		echo "## Benchmark: $directory" >> tableau.md
		echo " " >> tableau.md
		echo "|Problemes|HSP (ms total)|HSP (longueur)|MTC (ms total)|MTC (longueur)|Time Difference (HSP-MCT)|Length Difference (HSP-MCT)|" >> tableau.md
		echo "|:-------:|:------------:|:------------:|:------------:|:------------:|:-----------------------:|:-------------------------:|" >> tableau.md
		
		./script.sh "$file" "$HSP" "$MTC"
	fi
done

