# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# Functions
#
# (f)ind by (n)ame
# usage: fn foo
# to find all files containing 'foo' in the name
function fn() {
  fd $1 | fpp
}

alias yt='noglob yt'
function yt() {
  youtube-dl -f 'bestvideo[ext=mp4][height <=? 720]+bestaudio[ext=m4a]/mp4' $1 -o '~/Movies/youtube/%(uploader)s - %(title)s.%(ext)s' &>/dev/null &
}

alias ytlist='noglob ytlist'
function ytlist() {
  youtube-dl --yes-playlist --ignore-errors -f 'bestvideo[ext=mp4][height <=? 720]+bestaudio[ext=m4a]/mp4' $1 -o '~/Movies/youtube/%(playlist)s/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s'
}

alias ytaudio='noglob ytaudio'
function ytaudio() {
  youtube-dl -f 'bestaudio[ext=m4a]'  $1 -o '~/Music/youtubemusic/%(title)s.%(ext)s' &>/dev/null &
}

alias ytaudiolist='noglob ytaudiolist'
function ytaudiolist() {
  youtube-dl --yes-playlist --ignore-errors -f 'bestaudio[ext=m4a]' $1 -o '~/Movies/youtube/%(playlist)s/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s'
}

function gif() {
  gifify -r 30@2 -p 215:447 $1
}

function fix_mosh_server() {
  local fw='/usr/libexec/ApplicationFirewall/socketfilterfw'
  local mosh_sym="$(which mosh-server)"
  local mosh_abs="$(greadlink -f $mosh_sym)"

  sudo "$fw" --setglobalstate off
  sudo "$fw" --add "$mosh_sym"
  sudo "$fw" --unblockapp "$mosh_sym"
  sudo "$fw" --add "$mosh_abs"
  sudo "$fw" --unblockapp "$mosh_abs"
  sudo "$fw" --setglobalstate on
}
