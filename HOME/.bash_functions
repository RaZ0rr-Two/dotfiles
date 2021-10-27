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
