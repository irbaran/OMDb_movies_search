########################################################
# Unit tests for movies.cpp program using linux bash
########################################################

# Defines
RUNSTS_ERROR=0      # Run status error
RUNSTS_OK=1         # Run status ok

#Variables
count_run_sucess=0  # Counter of tests with success
count_run_error=0   # Counter of tests with error
count_runs=0        # Counter of tests runs
start_time=0        # Start test time
end_time=0          # End test time
elapsed=0           # Elapsed test time

# Function to counter results
# First parameter $1 indicates expected result "OK" or "ERROR"
# Second parameter $2 indicates run function result
UnitTest_counter_results()
{
	#Count expect OK results as successess 
	if [ $1 = "OK" ]; then
		if [ $2 -eq $RUNSTS_OK ]; then
			count_run_sucess=$((count_run_sucess+1))
		else
			count_run_error=$((count_run_error+1))
		fi
	fi

	#Count expect error results as successess
	if [ $1 = "ERROR" ]; then
		if [ $2 -eq $RUNSTS_ERROR ]; then
			count_run_sucess=$((count_run_sucess+1))
		else
			count_run_error=$((count_run_error+1))
		fi
	fi
	
	count_runs=$((count_runs+1))
	echo "---- Test run = $count_runs ----"
}

start_time="$(date -u +%s)"

echo
echo "--------------------------------------------------"
echo "Unit tests for movies.cpp program using linux bash."
echo "--------------------------------------------------"
echo

echo
echo "--------------------------------------------------"
echo "Testing help argument of for movies.cpp."
echo

./movies_cygwin.exe -h 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -h -h  
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -h -h  -h
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -h -s house
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -h -s house -t series 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -h -t episode 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -t movie -h
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -h -s Guardians -t series 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians -h -t episode 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians -t movie -h
UnitTest_counter_results "OK" "$?"

echo
echo "--------------------------------------------------"
echo "Testing title argument of for movies.cpp."
echo

./movies_cygwin.exe -s Guardians of the Galaxy Vol	
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy	
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians of the	
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians of
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardian
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardia
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardi
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guard
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guar
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Gua
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Gu
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s G
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s 
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s The Exterminator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s he Exterminator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s e Exterminator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Exterminator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s xterminator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s terminator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s erminator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s rminator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s minator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s inator
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s nator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s ator
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s tor
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s or
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s r
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -s hour
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians -s hour
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians -s hour -s flower 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guardians -s hour -s flower -s test 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s -s -s 
UnitTest_counter_results "ERROR" "$?"

echo
echo "--------------------------------------------------"
echo "Testing title and type arguments of for movies.cpp."
echo

#type movie test
./movies_cygwin.exe -s Guardians of the Galaxy Vol -t movie
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guar -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t series
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t movies
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t serie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episodes
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t mov
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t ser
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episo
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t movie -t series
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s Guar -t movie -t series
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t series -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episode -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t movies -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t serie -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episodes -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t mov -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t ser -t movie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s Guardians of the Galaxy Vol -t episo -t movie
UnitTest_counter_results "ERROR" "$?"

#type series test 
./movies_cygwin.exe -s house -t series
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t series
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -t series -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t series -t movies
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -t serie
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s nada -t seri
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s house -t ser -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s nada -t s -t movies
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s house -t episode -t series
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t movie -t series 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t movies -t series 
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s house -t series -t episode -t movies
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -t series -t movies -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t series -t movies -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s nada -t series -t episode -t movies
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s house -t serie -t series -t episode -t movies
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s house -t serie -t series -t movies -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s nada -t serie -t series -t movies -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s nada -t serie -t series -t episode -t movies
UnitTest_counter_results "ERROR" "$?"

##type series episode 
./movies_cygwin.exe -s insane -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s pilot -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s insane -t episode -t series 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s pilot -t episode -t movies
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s insane -t episod
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s pilot -t episod
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s insane -t episo -t series 
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s pilot -t episo-t movies
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s insane -t episod -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s pilot -t episode -t episod 
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s insane -t episode -t series -t episode -t movies
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s pilot -t episode -t series -t movies -t episode
UnitTest_counter_results "OK" "$?"

./movies_cygwin.exe -s insane -t epi -t series -t series -t movies -t episode
UnitTest_counter_results "ERROR" "$?"

./movies_cygwin.exe -s pilot -t serie -t series -t episode -t movies
UnitTest_counter_results "ERROR" "$?"


end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
echo
echo "--------------------------------------------------"
echo "Unit Test Results:"
echo "--------------------------------------------------"
echo "Number of tests                       : $count_runs"
echo "Number of tests successfully executed : $count_run_sucess "
echo "Number of tests executed with errors  : $count_run_error"
echo "Unit Test elapsed $elapsed seconds."

