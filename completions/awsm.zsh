#compdef awsm

_awsm() {
    local -a commands
    commands=(
        'login:Login to AWS SSO'
        'logout:Logout from AWS SSO'
    )

    _describe 'command' commands
}

_awsm "$@"