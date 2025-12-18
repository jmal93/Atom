# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/development/GameLib"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "gamelib"; then
    new_window "gamelib"
    run_cmd "docker start sql_server"
    split_v 50
    run_cmd "cd frontend/"
    run_cmd "npm run dev"
    select_pane 1
    run_cmd "cd backend/game_library_backend/"
    run_cmd "dotnet run"
    new_window "git"
    select_window "gamelib"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
