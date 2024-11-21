## Requirements

### Zsh Users
This tool requires zsh completion system to be initialized. The installer will automatically add the necessary configuration if it's missing, but you might want to customize it. The basic setup includes:

zsh
Initialize completion system
autoload -Uz compinit
compinit


If you want to customize the completion system (e.g., add caching or modify load behavior), you can add these lines manually to your `.zshrc` before installing.