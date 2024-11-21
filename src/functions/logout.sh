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