#!/usr/bin/env bash

if [ ! -d "$1" ]; then
  echo "Usage: ./do_analysis.sh YYYY-MM-DD"
  exit 1
fi

set -x
cd "$1"

sed '
  s@file = \\".*\\"@file = \\"results.json.xz\\"@;
  s@previous_filename = \\".*\\"@previous_filename = \\"../2015-03-15/CutIntroDataLog.txt\\"@;
' ../viper.ipynb >viper.ipynb
jupyter nbconvert --ExecutePreprocessor.timeout=600 --inplace --execute --to notebook viper.ipynb
