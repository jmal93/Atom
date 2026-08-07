# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/development/p2e-database/webscraper/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "p2e"; then

  new_window "p2e"
  split_v 10
  run_cmd "source .venv/bin/activate.fish"

  select_pane 1
  run_cmd "source .venv/bin/activate.fish"
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
