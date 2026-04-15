#Splash
python3 ~/terminalCustomSplash/randomSplash.py
var=$(cat ~/terminalCustomSplash/risultati.txt)
figlet -cl $var | lolcat

#Meteo
#curl wttr.in?0

#Tux
cowsay -f tux " " | sed '1,2d' | lolcat