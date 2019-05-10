modes="analytic_sequential analytic_independent treegrammar spind"

test -f experiment_list || (
  for problem in $tip_files/*/*; do
    (set +x; echo "$problem")
  done

  find -L $proof_dir -not -type d
) | perl -ne '@m=split/ /,"'"$modes"'";/(.*)/;print"$1 $_\n" for @m' | shuf >experiment_list
