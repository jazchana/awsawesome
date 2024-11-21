# AWS SSO Helper

A command-line tool that simplifies AWS SSO login by providing an interactive profile selector.

## Features

- Interactive AWS profile selection using fzf
- Easy SSO login/logout commands
- Shell completion for commands
- Supports both Bash and Zsh

## Requirements

- AWS CLI v2
- fzf
- AWS SSO configured profiles
- Bash or Zsh shell

## Installation

Clone the repository:
```bash
git clone https://github.com/yourusername/aws-helpers.git
cd aws-helpers
```

Install:
```bash
make install
```

## Usage

### Login

Start interactive profile selection and login

```bash
awsm login
```

This will:

1. Allow you to select an AWS SSO profile from a list
2. Open a browser to the AWS SSO login page
3. Save the profile to your environment variable $AWS_PROFILE


### Logout

```bash
awsm logout
```

This will:
1. Log you out of the current AWS SSO session
2. Unset the AWS_PROFILE environment variable

## Shell Completion

### Zsh Users
The tool automatically sets up Zsh completion during installation. If you want to customize the completion system, you can add these lines manually to your `.zshrc` before installing:

```ini
Initialize completion system
autoload -Uz compinit
compinit
```


### Bash Users
Bash completion is automatically configured during installation.

## Configuration

AWS profiles should be configured in `~/.aws/config`. Example:

```ini
[profile dev]
sso_start_url = https://my-sso-portal.awsapps.com/start
sso_region = us-east-1
sso_account_id = 123456789012
sso_role_name = Developer

[profile prod]
sso_start_url = https://my-sso-portal.awsapps.com/start
sso_region = us-east-1
sso_account_id = 987654321098
sso_role_name = Administrator
```

## Uninstallation
```bash
make uninstall
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](LICENSE)