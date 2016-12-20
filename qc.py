#!/usr/bin/env python

import sys
import argparse
import os
import subprocess
import glob

# Get a array of fastq file paths in provided directory
# Exits if none are found
def getFastqFiles(dir_path):
	# Get array of files to quality control
	fasta_files = glob.glob(
		os.path.join(dir_path, "*.fastq.gz"))

	if len(fasta_files) == 0:
		print "No fasta.gz files in directory"
		sys.exit(2)
	# print fasta_files
	return fasta_files


# Argument parser
parser = argparse.ArgumentParser(
	description="""
		Performs quality control of fastq.gz files using the program fastq.
		Creates reports in QC folder in provided directory.
		""")

parser.add_argument(
	"dir",  # positional argument
	help="Root data directory. Defaults to invoked working directory.",
	default=os.getcwd(),  # parent working dir
	nargs="?")  # optional number of arguments

args = parser.parse_args()

# Make QC folder
qc_dir = os.path.join(args.dir, "QC")
if not os.path.exists(qc_dir):
	os.mkdir(qc_dir)


fasta_files = getFastqFiles(args.dir)

# Execute fastqc quality control
try:
	cmd = ["fastqc"] + fasta_files + [
		"-t", "8",  # threads
		"-o", qc_dir]
	print cmd
	# blocking system execution
	subprocess.call(cmd)
except OSError as e:
	print e
	print "fastqc may not be installed"
	sys.exit(2)

