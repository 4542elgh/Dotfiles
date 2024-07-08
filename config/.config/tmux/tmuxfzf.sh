#!/bin/bash

# Function to create a tmux session
create_attach_session() {
    tmux new-session -A -s "$1"
}

# Function to delete a tmux session
delete_session() {
    tmux kill-session -t "$1"
}

# Prompt user to select action: create or delete
action=$(printf "Create / Attach Session\nDelete Session\nRename Session" | fzf --prompt="Tmux action: ")

# Check if action is valid
if [[ "$action" == "Create / Attach Session" ]]; then
    # Prompt user to enter tmux session name
    # Trim leading \n and remove any \
    # session_name=$(echo "$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Enter session name: " --print-query)" | tail -n1)

    session_name=$(echo "$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Enter session name: " --print-query)" | tail -n1)

    # Check if session name is provided
    if [[ -n "$session_name" ]]; then
        create_attach_session "$session_name"
    else
        echo "No session name provided. Exiting."
        exit 1
    fi
elif [[ "$action" == "Delete Session" ]]; then
    # Prompt user to select a tmux session to delete
    session_name=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Select session to delete: ")

    # Check if session name is provided
    if [[ -n "$session_name" ]]; then
        delete_session "$session_name"
    else
        echo "No session selected for deletion."
        exit 1
    fi
elif [[ "$action" == "Rename Session" ]]; then
    # Prompt user to select a tmux session to delete
    session_name=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Select session to rename: ")

    # Check if session name is provided
    if [[ -n "$session_name" ]]; then
        new_session_name=$(echo "$(tmux list-sessions -F "#{session_name}" | fzf --prompt="New session name: " --print-query)" | tr -d '\n' | tr -d '\\')
        if [[ -n "$session_name" ]]; then
            tmux rename-session -t "$session_name" "$new_session_name"
        else
            echo "New session name Invalid. Exiting"
            exit 1
        fi
    else
        echo "No session selected for deletion."
        exit 1
    fi

else
    echo "Invalid action selected. Exiting."
    exit 1
fi
