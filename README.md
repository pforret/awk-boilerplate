# awk-boilerplate
![AWK CI](https://github.com/pforret/awk-boilerplate/workflows/AWK%20CI/badge.svg)

A starting point for larger AWK scripts

Features:

* define required/optional parameters
* show usage when input is empty

		script.awk v1.0.0 - by peter@forret.com
		<https://github.com/pforret/awk-boilerplate>
		Purpose: Read data file 1 and filter it into data file 2
		Usage  : script.awk -v <option>=<value>
		Options:
			-v input=<source file> (default: )
			-v output=<result file> (default: )
			-v steps=<number of steps> (default: 10)
			-v verbose=<more information on stderr> (default: 0)
			-v silent=<no information on stderr> (default: 0)

* functions for output: `out()` / `debug()` / `progress()`
