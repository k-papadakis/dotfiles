# Summarises what closing the target would kill. Input is a `herdr api snapshot`
# result followed by one `herdr pane process-info` result per target pane, in
# `target_panes` order; `$n` is how many panes close.sh inspected. Emits nothing
# when every pane is an idle shell, otherwise the confirmation heading, a context
# line and one "name<sep>title" row per busy pane. Anything that does not add up
# becomes an "unknown" row so the caller asks instead of closing.
include "close-guard";

def clean:
  . // "" | tostring | gsub("[[:cntrl:]]"; " ");

def plural($n; $word):
  "\($n) \($word)\(if $n == 1 then "" else "s" end)";

# The tab or workspace with this ID in the snapshot, or null.
def find($snapshot; $kind; $id):
  first($snapshot.result.snapshot[$kind + "s"][]? | select(.[$kind + "_id"] == $id)) // null;

# The label of a tab or workspace in the snapshot, or "".
def label_of($snapshot; $kind; $id):
  find($snapshot; $kind; $id) | .label // "" | clean;

input as $snapshot
| [inputs] as $infos
| ($snapshot | target_panes($scope; $target)) as $panes
| (if ($panes | length) == 0 then
     [["unknown", "could not list panes"]]
   elif ($panes | length) != $n or ($infos | length) != $n then
     [["unknown", "could not inspect panes"]]
   else
     [range($n) as $i
      | $panes[$i] as $pane
      | $infos[$i]
      | busy_process($pane.agent)
      | [clean, ($pane | .terminal_title_stripped // .terminal_title | clean)]]
   end) as $rows
| (if $scope == "pane" then null else find($snapshot; $scope; $target).pane_count end) as $expected
| ($rows
   + if ($panes | length) > 0 and $expected != null and $expected != ($panes | length) then
       [["unknown", "\(plural($expected; "pane")) expected, \($panes | length) listed"]]
     else
       []
     end) as $rows
| select($rows | length > 0)
| (label_of($snapshot; "tab"; $panes[0].tab_id)) as $tab
| (label_of($snapshot; "workspace"; $panes[0].workspace_id)) as $workspace
| ($target | clean) as $id
| if $scope == "pane" then
    "Close pane?",
    ([if $tab != "" then "tab \($tab)" else empty end, if $workspace != "" then $workspace else empty end] | join(" · "))
  elif $scope == "tab" then
    "Close tab \(label_of($snapshot; "tab"; $target) | if . == "" then $id else . end)?",
    $workspace
  else
    "Close workspace \(label_of($snapshot; "workspace"; $target) | if . == "" then $id else . end)?",
    (if ($panes | length) == 0 then "" else
       "\(plural($panes | map(.tab_id) | unique | length; "tab")) · \(plural($panes | length; "pane"))"
     end)
  end,
  ($rows[] | join($sep))
