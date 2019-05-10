parallel --timeout 100 \
  --colsep ' ' \
  --files --results results \
  --joblog joblog --resume \
  --progress --bar --eta \
  java -cp $gapt_jar \
  -Xmx1G -Xss40m \
  -XX:ParallelGCThreads=1 -XX:ConcGCThreads=1 \
  gapt.testing.testViper '{1}' '{2}' \
  :::: experiment_list || true

pushd results
  java -Xmx24g -cp $gapt_jar gapt.testing.collectExperimentResults >../results.json
popd
