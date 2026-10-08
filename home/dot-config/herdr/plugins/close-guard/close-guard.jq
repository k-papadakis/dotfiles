# Definitions shared by summary.jq, close.sh and the tests.

def shells:
  "bash", "zsh", "fish", "sh", "dash", "ash", "ksh", "mksh", "yash", "nu", "pwsh", "elvish", "tcsh", "csh";

def process_name:
  (.name // .argv0 // "unknown") | split("/")[-1] | sub("^-"; "");

# Emits the name of the process keeping a pane busy, or nothing for an idle
# shell. Input is a `herdr pane process-info` result. A pane is busy when a
# non-shell process is in the foreground, or when the foreground process group
# is not the shell's own (a shell running a script, `sh -c`, a nested shell).
# The name is Herdr's detected agent when set, otherwise the foreground process
# group leader, otherwise the first non-shell process. Missing or empty process
# information emits "unknown" so callers fail closed.
def busy_process($agent):
  .result.process_info as $info
  | $info.foreground_processes as $processes
  | if ($processes | type) != "array" or ($processes | length) == 0 then
      "unknown"
    else
      [$processes[] | select(process_name | ascii_downcase | IN(shells) | not)] as $busy
      | ($info.shell_pid != null and $info.foreground_process_group_id != null
         and $info.shell_pid != $info.foreground_process_group_id) as $foreground_job
      | if ($busy | length) == 0 and ($foreground_job | not) then
          empty
        elif ($agent // "") != "" then
          $agent
        else
          first(
            ($busy[] | select(.pid == $info.foreground_process_group_id)),
            $busy[],
            ($processes[] | select(.pid == $info.foreground_process_group_id)),
            $processes[0]
          ) | process_name
        end
    end;

# The panes that closing the target would kill, in snapshot order. Input is a
# `herdr api snapshot` result. A pane is still checked when it is missing from
# the snapshot.
def target_panes($scope; $target):
  [.result.snapshot.panes[]? | select(.[$scope + "_id"] == $target)]
  | if length == 0 and $scope == "pane" then [{pane_id: $target}] else . end;
