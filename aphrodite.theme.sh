#!/usr/bin/env bash

#======================================================================#
#    _        _                _ _ _         _____ _                   #
#   /_\  _ __| |_  _ _ ___  __| (_) |_ ___  |_   _| |_  ___ _ __  ___  #
#  / _ \| '_ \ ' \| '_/ _ \/ _` | |  _/ -_)   | | | ' \/ -_) '  \/ -_) #
# /_/ \_\ .__/_||_|_| \___/\__,_|_|\__\___|   |_| |_||_\___|_|_|_\___| #
#       |_|                                                            #
#                                                                      #
#                       Aphrodite Terminal Theme                       #
#                 by Sergei Kolesnikov a.k.a. win0err                  #
#                                                                      #
#                        https://kolesnikov.se                         #
#                                                                      #
#======================================================================#


export VIRTUAL_ENV_DISABLE_PROMPT=true


__aphrodite_update_prompt_data() {
	local RETVAL=$?

	__aphrodite_venv=''
	[[ -n "$VIRTUAL_ENV" ]] && __aphrodite_venv=$(basename "$VIRTUAL_ENV")

	# I don't need git status output, i'm already using IDE or $(git status).
	# If i want take some mistake, those prompt con't stopping me.
	# 
	# __aphrodite_git=''
	# __aphrodite_git_color=$(tput setaf 10)  # clean
	# local git_branch=$(git --no-optional-locks branch --show-current 2> /dev/null)
	# if [[ -n "$git_branch" ]]; then
	# 	local git_status=$(git --no-optional-locks status --porcelain 2> /dev/null | tail -n 1)
	# 	[[ -n "$git_status" ]] && __aphrodite_git_color=$(tput setaf 11)  # dirty
	# 	__aphrodite_git="‹${git_branch}›"
	# fi

	__aphrodite_prompt_symbol_color=$(tput sgr0)
	[[ "$RETVAL" -ne 0 ]] && __aphrodite_prompt_symbol_color=$(tput setaf 1)

	__aphrodite_prompt_return_string=""
	[[ "$RETVAL" -ne 0 ]] && __aphrodite_prompt_return_string="[${RETVAL}]"


	return $RETVAL  # to preserve retcode
}


# I don't know what those did, is anyone seted "git_branch" befor bashrc?
# 
# if [[ -n "$git_branch" ]]; then
# 	PROMPT_COMMAND="$PROMPT_COMMAND; __aphrodite_update_prompt_data"
# else
# 	PROMPT_COMMAND="__aphrodite_update_prompt_data"
# fi
# 
# But we still need PROMP_COMMAND, right? i forget this.
PROMPT_COMMAND="__aphrodite_update_prompt_data"

# emm,what? Are these relic? this line added by me.
# remove comments to enable the [time] print.
# APHRODITE_THEME_SHOW_TIME='1'

PS1=''
PS1+='\[$(tput setaf 7)\]$(echo -ne $__aphrodite_venv)\[$(tput sgr0)\]'
PS1+='\[$(tput setaf 6)\]\u'
PS1+='\[$(tput setaf 8)\]@'
PS1+='\[$(tput setaf 12)\]\h'
# Add a space after ':' for easy copying, i love double click.
PS1+='\[$(tput setaf 8)\]: '
PS1+='\[$(tput sgr0)\]\w '

# git state
# PS1+='\[$(echo -ne $__aphrodite_git_color)\]$(echo -ne $__aphrodite_git)\[$(tput sgr0)\] '
# PS1+='\[$(tput sgr0)\]'

# time
PS1+='\[$(tput setaf 8)\]\[$([[ -n "$APHRODITE_THEME_SHOW_TIME" ]] && echo -n "[\t]")\]\[$(tput sgr0)\] '

# error code
PS1+='\[$(echo -ne $__aphrodite_prompt_symbol_color)\]'
# display error code and line feed
PS1+='\[$(echo -ne $__aphrodite_prompt_return_string)\]\n'
# set to normal color
PS1+='\$\[$(tput sgr0)\] '
