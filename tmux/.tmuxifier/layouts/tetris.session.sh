# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/tetris"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
session_root "~/development/tetris"
if initialize_session "tetris"; then

  new_window "tetris"
  split_h 20
  select_pane 1
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
