nvmk() { mkdir -p "$(dirname "$1")" && ${EDITOR:-vim} "$1" ; }

packF(){
	if [ -x "$(command -v apt)" ]
  then
		apt list --installed 2> /dev/null | grep -i "$1" | fzf-tmux
	elif [[ -x "$(command -v pacman)" ]]
	then
		pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
  else
    echo "apt or pacman not found"
  fi
}

packN(){
	if [ -x "$(command -v apt)" ]
  then
	apt list --installed 2> /dev/null | grep -i "$1" | wc -l
	elif [[ -x "$(command -v pacman)" ]]
	then
		pacman -Qq | wc -l	
  else
    echo "apt or pacman not found"
  fi
}

packls(){
	apt list --installed 2> /dev/null | grep -i "$1"
}
#apt list --installed 2> /dev/null | grep -i "$1" | cut -d/ -f1

packrm() {
	pak=$(apt list --installed 2>/dev/null | grep -i "$1" | sed 1d | fzf-tmux -m)
	[ -z "$pak" ] || ( sudo apt remove `echo $pak | cut -d/ -f1 | tr '\n' ' '` && \
		echo "Packages removed" )
}

packpr() {
	pak=$(apt list --installed 2>/dev/null | grep -i "$1" | sed 1d | fzf --preview "apt show \$(echo {} |  cut -d/ -f1) 2>/dev/null" --height 100%)
	[ -z "$pak" ] || ( sudo apt purge `echo $pak | cut -d/ -f1 | tr '\n' ' '` && \
		echo -n "want to autoremove?" && read -qs && sudo apt autoremove -y )
}

# fkill - kill process
fkill() {
  local pid

  pid="$(
    ps -ef \
      | sed 1d \
      | fzf -m \
      | awk '{print $2}'
  )" || return

  kill -"${1:-9}" "$pid"
}

opcl() {

    "$@" & disown 
    exit
}

oclbw() {

    lbw & disown 
    exit

}

# Alias for herbstclient if herbstluftwm is Installed
hc() {
  if ! [ -x "$(command -v herbstclient)" ]
  then
    echo 'Error: herbstluftwm is not installed.' >&2
    exit 1
  else
    herbstclient "$@"
  fi
}
