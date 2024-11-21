# Source helper functions
for f in $(dirname "${BASH_SOURCE[0]}")/functions/*.sh; do
    source "$f"
done

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