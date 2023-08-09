if status is-interactive
    # Commands to run in interactive sessions can go here
end

# USER CONFIG
set CASE_SENSITIVE true
set ENABLE_CORRECTION true
set COMPLETION_WAITING_DOTS true
set EDITOR code

set -gx GPG_TTY (tty)
set -gx JAVA_HOME "$(/usr/libexec/java_home)"
set -gx JOBS max
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx SSH_KEY_PATH $HOME/.ssh/

# ANDROID SETUP
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx ANDROID_SDK_ROOT $ANDROID_HOME
set -gx ANDROID_AVD_HOME $HOME/.android/avd


# PATH
set -gx PATH $PATH /usr/local/sbin
set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /usr/sbin
set -gx PATH $PATH /usr/bin
set -gx PATH $PATH /sbin
set -gx PATH $PATH /bin
set -gx PATH $PATH /Users/valentin.dealmeida/.local/share/solana/install/active_release/bin
set -gx PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools
set -gx PATH $PATH $HOME/.cargo/bin

# node
set -gx NODE_OPTIONS "--max-old-space-size=7168"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

rbenv init - fish | source
# fnm env --use-on-cd | source
starship init fish | source

# proto
set -gx PROTO_ROOT "$HOME/.proto"
set -gx PATH "$PROTO_ROOT/bin" $PATH

