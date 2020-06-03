#! /usr/bin/awk -f

BEGIN {
	SCRIPTNAME="script.awk"
	SCRIPTVERSION="1.0.0"
	SCRIPTAUTHOR="peter@forret.com"
	GITHUBURL="https://github.com/pforret/awk-boilerplate"
}


{
	# add line number
	print NR,$0
}



END { 
	if(NR ==0){
		# show usage when no input was received
		print "### " SCRIPTNAME " v" SCRIPTVERSION " ####" > "/dev/stderr"
		print "# Purpose: ___" > "/dev/stderr"
		print "# Usage  : " SCRIPTNAME "-v input=<file> -v output=<file> -v steps=10 " > "/dev/stderr"
		print "# Options:" > "/dev/stderr"
		print "#  -F<char>  : input field separator (default: )" > "/dev/stderr"
		print "#  -v key=val  : set key (default: )" > "/dev/stderr"
	}
}


# some references:
# https://www.gnu.org/software/gawk/manual/html_node/Executable-Scripts.html