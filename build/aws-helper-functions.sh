#!/bin/bash

# login.sh
_aws_sso_login() {
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it and try again."
        return 1
    fi

    # Check if fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo "fzf is not installed. Please install it using your package manager."
        echo "For example, on macOS: brew install fzf"
        return 1
    fi

    # Get a list of all configured profiles
    profiles=$(aws configure list-profiles)

    # Check if profiles are found
    if [ -z "$profiles" ]; then
        echo "No AWS profiles found. Please configure your AWS CLI."
        return 1
    fi

    # Use fzf to select a profile
    selected_profile=$(echo "$profiles" | fzf --height=10 --prompt="Select an AWS profile to log in: " --border)

    # Check if a profile was selected
    if [ -z "$selected_profile" ]; then
        echo "No profile selected."
        return 1
    fi

    echo "You selected profile: $selected_profile"

    # Set the AWS_PROFILE environment variable
    export AWS_PROFILE="$selected_profile"
    echo "AWS_PROFILE set to $AWS_PROFILE"

    # Log in to AWS SSO using the selected profile
    echo "Logging in to AWS SSO using profile: $AWS_PROFILE..."
    aws sso login --profile "$AWS_PROFILE"

    # Check if login was successful
    if [ $? -ne 0 ]; then
        echo "Failed to log in. Please check your profile configuration."
        return 1
    fi

    echo "Successfully logged in to AWS SSO with profile: $AWS_PROFILE"
}
# logout.sh
_aws_sso_logout() {
    if [ -n "$AWS_PROFILE" ]; then
        echo "Logging out of AWS SSO for profile: $AWS_PROFILE..."
        aws sso logout --profile "$AWS_PROFILE"
        unset AWS_PROFILE
        echo "Logged out and unset AWS_PROFILE"
    else
        echo "No AWS_PROFILE set."
    fi
}

awsm() {
    case "$1" in
        login)
            _aws_sso_login
            ;;
        logout)
            _aws_sso_logout
            ;;
        *)
            echo "Usage: awsm {login|logout}"
            return 1
            ;;
    esac
}