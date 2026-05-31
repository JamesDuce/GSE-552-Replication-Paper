#!/bin/bash
# run_all.sh
# Convenience wrapper around the Makefile.
# Runs the full replication pipeline from scratch.
#
# Usage: bash run_all.sh
#
# Requires: R (4.0+), pdflatex, and replication data in input/
# See input/README.md for data download instructions.

set -e   # Exit immediately if any command fails

echo "======================================================"
echo "GSE 552 Replication: Jones & Marinescu (2022)"
echo "======================================================"
echo ""

# Clean and rebuild everything
make clean
make

echo ""
echo "======================================================"
echo "Done. Final paper is at: paper/paper.pdf"
echo "======================================================"
