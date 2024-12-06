#!/bin/bash

# Give the user some help
if [ "$1" == "-h" ]; then
	echo "you need to launch this command for each pddl benchmark (ipc2000/blocks ipc2000/logistics ipc1998/gripper ipc2002/depots)"
	echo "this script write a tableauSAT.md file with the results of the benchmarks"
	echo "It uses a .result.txt and .result2.txt file to store the results of the two planners"
	echo "you can find the differents benchmarks in the directory pddl4j/src/test/resources/benchmarks/pddl/"
	echo "Usage: $0 <directory> <HSP_Planner> <SAT_Planner> <NbProblem>"
	echo "$1 $2 $3 $4"
	exit 1
fi

# Define the target directory, the HSP directory and the SAT directory
directory="$1"
HSP="$2"
SAT="$3"
NbProblem="$4"
tableau="tableauSAT.md"
scoreLength=0
scoreTime=0
timeout=10

if [ -z "$NbProblem" ]; then
	NbProblem=5
fi

# Loop through files in the target directory
for file in "$directory"/*; do
	if [ -f "$file" ] && [ "${file##*/}" != "domain.pddl" ]; then
		if [ $NbProblem -eq "0" ]; then
			exit
		fi
		NbProblem=$(($NbProblem - 1))

		# Let's the user know what's going on and choose the problem to run
		clear
		echo domain : ${directory##*/} problem :${file##*/}, wait ${timeout}s before killing the process...
		echo "Let's go for a run"
		
		# Run the planners in parallel
		# The last output of the HSP is stored in a .result file
		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP.${HSP##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result)&

		# The last output of the SAT is stored in a .result2 file
		$(java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/classes/" "TP3.${SAT##*/}" "$directory/domain.pddl" "$file" | grep -oE "\|[0-9]+\|[0-9]+\|" > .result2) &
		
		sleep $timeout
		# Get the results of HSP
		result=$(cat .result)
		result2=$(cat .result2)
		
		# we cut the results to get the time and the length of the plan
    	HSP_Time=$(echo "$result" | cut -d '|' -f 2)
    	HSP_Length=$(echo "$result" | cut -d '|' -f 3)
    	SAT_Time=$(echo "$result2" | cut -d '|' -f 2)
    	SAT_Length=$(echo "$result2" | cut -d '|' -f 3)

		# If HSP or SAT did not finish, we kill them
		if [ -z "$result" ] && [ -z "$result2" ]; then
			kill $(pgrep -f "java")
			echo "|${file##*/}|timeout|timeout|timeout|timeout|$scoreTime|$scoreLength|" >> $tableau
			timeout=$(($timeout + 10))
			continue
		elif [ -z "$result" ]; then

			kill $(pgrep -f "java")
		
			TimeDifference=$(($SAT_Time))
			LengthDifference=$(($SAT_Length))
			scoreTime=$(($TimeDifference + $scoreTime))
			scoreLength=$(($LengthDifference + $scoreLength))
		
			echo "|${file##*/}|timeout|timeout|**$SAT_Time**|**$SAT_Length**|$scoreTime|$scoreLength|" >> $tableau     
			timeout=$(($timeout + 10))
			continue
		elif [ -z "$result2" ]; then
		
			kill $(pgrep -f "java")
		
			TimeDifference=$((-$HSP_Time))
			LengthDifference=$((-$HSP_Length))
			scoreTime=$(($TimeDifference + $scoreTime))
			scoreLength=$(($LengthDifference + $scoreLength))
		
			echo "|${file##*/}|**$HSP_Time**|**$HSP_Length**|timeout|timeout|$scoreTime|$scoreLength|" >> $tableau
			timeout=$(($timeout + 10))
			continue
		fi
		
		timeout=$(($timeout - 1))
		# If both planners found a plan, we calculate the difference between the two plans
		if [ -n "$result" ] && [ -n "$result2" ]; then	
			TimeDifference=$(($HSP_Time - $SAT_Time))
			scoreTime=$(($TimeDifference + $scoreTime))
			if [ $HSP_Time -lt $SAT_Time ]; then
				HSP_Time="**$HSP_Time**"
			elif [ $HSP_Time -gt $SAT_Time ]; then
				SAT_Time="**$SAT_Time**"
			else
				HSP_Time="**$HSP_Time**"
				SAT_Time="**$SAT_Time**"
			fi
			
			LengthDifference=$(($HSP_Length - $SAT_Length))
			scoreLength=$(($LengthDifference + $scoreLength))
			if [ $HSP_Length -lt $SAT_Length ]; then
				HSP_Length="**$HSP_Length**"
			elif [ $HSP_Length -gt $SAT_Length ]; then
				SAT_Length="**$SAT_Length**"
			else
				HSP_Length="**$HSP_Length**"
				SAT_Length="**$SAT_Length**"
			fi
			echo "|${file##*/}|$HSP_Time|$HSP_Length|$SAT_Time|$SAT_Length|$scoreTime|$scoreLength|" >> $tableau
			continue
		fi	
	fi

	# If the target is a directory, we start a new table in the tableau.md file
	if [ -d "$file" ]; then
		SAT_short=$(echo "${SAT##*/}")
		HSP_short=$(echo "${HSP##*/}")
		echo " " >> $tableau
		echo "## Benchmark: $file" >> $tableau
		echo " " >> $tableau
		echo "|Problemes|${HSP_short} (ms total)|${HSP_short} (longueur)|${SAT_short} (ms total)|${SAT_short} (longueur)|Difference Time ${HSP_short} - ${SAT_short}|Score Difference Length ${HSP_short} - ${SAT_short}|" >> $tableau
		echo "|:-------:|:------------:|:------------:|:------------:|:------------:|:-------------------------:|:------------------------------|" >> $tableau
		
		./scriptSAT.sh "$file" "$HSP" "$SAT" "$NbProblem"
	fi
done

