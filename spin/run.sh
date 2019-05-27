#!/usr/bin/env bash
set -ex

tip_files=`readlink -f Problems`
if [ ! -d $tip_files ]; then
  echo $tip_files must be a directory containing the TIP problems.
  exit 1
fi

setup_experiments=`readlink -f .setup_experiments.sh`
do_experiments=`readlink -f .do_experiments.sh`

current_date=`date +%Y-%m-%d`

mkdir $current_date
log_dir=`readlink -f $current_date`

[ -d gapt ] || git clone -b structural_induction https://github.com/gapt/gapt

pushd gapt

  git clean -fdx
  git pull
  git show --summary >$log_dir/revision.txt

  sbt testing/assembly
  gapt_jar=`readlink -f testing/target/scala-*/gapt-testing-assembly*.jar`

  mkdir experiments
  pushd experiments
    proof_dir=proofs
    mkdir $proof_dir
    . $setup_experiments
    . $do_experiments
  popd

popd

. ./.finish.sh
