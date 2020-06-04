#! /usr/bin/awk -f
# STEP 1: give a good name to your script and change all the data in intialize_script()
# STEP 2: define required/optional parameters in load_options()
# STEP 3: write code after the 2nd XXXXXX line
function set_program_data(){
	SCRIPTNAME="script.awk"
	SCRIPTVERSION="1.0.0"
	SCRIPTAUTHOR="peter@forret.com"
	SCRIPTPURPOSE="Read data file 1 and filter it into data file 2"
	SCRIPTURL="https://github.com/pforret/awk-boilerplate"
}
function load_options(){
	# OPTIONS[i]="<name of option>|<description>|<default value>"
	OPTIONS[1]="input|source file|"
	OPTIONS[2]="output|result file|"
	OPTIONS[3]="steps|number of steps|10"
	OPTIONS[9]="verbose|more information on stderr|0"
	OPTIONS[10]="silent|no information on stderr|0"
}
# don't edit between the XXXX lines
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
function intialize_script(){
	set_program_data()
	load_options()
	set_option_defaults()
	printlevel=1
	if(get_option("silent",silent)   > 0)	printlevel=0
	if(get_option("verbose",verbose) > 0)	printlevel=2
}
function set_option_defaults(){
	for ( OPTION in OPTIONS ) {
		split(OPTIONS[OPTION],a,"|")
		key=a[1]
		val=a[2]
		def=a[3]
		DEFAULTS[key]=def
	}
}
function get_option(name,value){
	if(value==""){
		if(DEFAULTS[name] != ""){
			value=DEFAULTS[name]
		}
	}
	debug(name " = " value)
	return value
}
function print_usage(){
	out(sprintf("# %s v%s - by %s", SCRIPTNAME, SCRIPTVERSION, SCRIPTAUTHOR ))
	out("# " SCRIPTURL)
	out("# Purpose: " SCRIPTPURPOSE)
	out("# Usage  : " SCRIPTNAME " -v <option>=<value>")
	if(isarray(OPTIONS)){
		out("# Options:")
		for ( OPTION in OPTIONS ) {
			split(OPTIONS[OPTION],a,"|")
			key=a[1]
			val=a[2]
			def=a[3]
			out(sprintf("#  -v %s=<%s> (default: %s)", key, val, def ))
		}
	}
}
function out(text){
	if(printlevel > 0){
		print "\033[34m" text "\033[0m" > "/dev/stderr"
	}
}
function progress(text){
	if(printlevel > 0){
		printf text "     \r" > "/dev/stderr"
	}
}
function debug(text){
	if(printlevel > 1){
		t=strftime("%H:%M:%S")
		printf "\033[35m|%s|\033[0m %s\n",t,text > "/dev/stderr"
	}
}
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
### ------------------- EXECUTED BEFORE ANY INPUT PROCESSING STARTS

BEGIN {
	debug("---- START  " SCRIPTNAME " [BEGIN]")
	intialize_script()
	debug("---- FINISH " SCRIPTNAME " [BEGIN]")
}

### ================================================================
### ------------------- EXECUTED FOR EACH LINE


/^[\w]/ {
	# add line number
	print NR,$0
}

### ================================================================
### ------------------- EXECUTED AFTER ALL INPUT IS RECEIVED

END { 
	debug("---- START  " SCRIPTNAME " [END]")
	# if no input given - output usage
	if(NR == 0)	print_usage()
	debug("---- FINISH " SCRIPTNAME " [BEGIN]")
}


# some references:
# https://www.gnu.org/software/gawk/manual/html_node/Executable-Scripts.html