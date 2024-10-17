#!/bin/bash
# NOMBRE DE APP: Notas Mnemotécnicas
# NOMBRE DE ARCHIVO PRINCIPAL: Notas.sh
# Autor: Sergio S. Juárez Rivera
# Hi, solo para poner que yo solo intento adaptar esta cosilla para que sea un poco mas agradable al vista jsjsjsjsj, MIRE JEFE, ANDO EDITANDO SU PROGRAMA
#Tambien dire que le pondre Emu porque pondre imagenes de Emu uwu, sobre aviso no hay engaño
# Editor 1 (si me nombro asi? xd): Sergio U. Juárez Manjarrez
# Versión: 0.0.1
# Version: 0.0.2 / 29-05-2024
# Variables: 1
# PENDIENTES: 0

#Definir Editor de texto: leafpad, mousepad, gedit
EDITOR=gedit

function edata {
							# Crea respaldo de archivo Notas.txt antes de abrirlo #
							cp /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt /home/$USER/APPSCRIPTS/Notas/Data/Notas.bak
							$EDITOR /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
	}
function ekey {
							cp /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt /home/$USER/APPSCRIPTS/Notas/Data/Keywords.bak
							$EDITOR /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
	}
function new {
							echo "Define una llave mental" | iconv -f utf-8 -t iso-8859-1 #| festival --tts &
							#iconv -f utf-8 -t iso-8859-1 - hace la conversion de los caracteres
							FECHA=`date +%F`
							HORA=`date +%H:%M:%S`
							KEY=`zenity --title "¿ Llave mental (KEYWORD) ?"  --entry --text="Define una llave mental para relacionar esta nota"`
							TXT=`zenity --title "Llave mental definida : : : $KEY : : : "  --entry --text="Escribir Nota :                                                                                                      "`
							echo $KEY >> /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							echo $KEY ::: $FECHA / $HORA ::: $TXT >> /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt 
							notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/OK.png "$KEY" "$TXT" &
							echo "Nota salvada" | iconv -f utf-8 -t iso-8859-1 #| festival --tts &
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
exit
	}
function keyword {
							cat /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt | sort | uniq > /tmp/Keywords.tmp
							cat /tmp/Keywords.tmp > /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							cat /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt | zenity --title "Llaves (KEYWORDS) definidas : " --width=250 --height=350 --text-info
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
}
function contact {
							zenity --info --width=400 --height=60 --title="Sergio S. Juárez Rivera" --text="https://www.linkedin.com/in/sergio-juarez-91524445/"
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
										}
function help {
							cat /home/$USER/APPSCRIPTS/Notas/Docs/help.txt | zenity --title "HELP!" --width=450 --height=550 --text-info
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
}
#function donate{}
#function about {cat home/$USER/APPSCRIPTS/Notas/}
#-------------------------------------------------------------------------------------------------------------------------------
#if [ -z "${Palabra1}" ]; then
PALABRA1=`echo $(($RANDOM%4))`
PALABRA2=`echo $(($RANDOM%3))`
#RANDM2=`$(($RANDOM%4))`

case $PALABRA1 in
     0) echo "precisas"> /tmp/P1.txt  ;;
     1) echo "gustas"> /tmp/P1.txt  ;;
     2) echo "quieres"> /tmp/P1.txt  ;;
     3) echo "necesitas"> /tmp/P1.txt  ;;
esac

case $PALABRA2 in
     0) echo "Supongo"> /tmp/P2.txt  ;;
     1) echo "Creo"> /tmp/P2.txt  ;;
     2) echo "Veo"> /tpm/P2.txt  ;;
     #3) echo
esac

LEER1=$(cat /tmp/P1.txt)
LEER2=$(cat /tmp/P2.txt)

#"1" = "precisas"
#-------------------------------------------------------------------------------------------------------------------------------
notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/EMU.jpg "Hola amigo! soy Emu!" "¿Que $LEER1 buscar?"
#-------------------------------------------------------------------------------------------------------------------------------
#notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/EMU.jpg "Hola amigo! soy Emu!" "¿Que precisas buscar?"
BUSCAR=`zenity --title "Buscar en notas - help! para ayuda" --entry --text="N! nueva nota - Buscar: Palabra, texto, dato o comando :                                 "`

if [ -z "${BUSCAR}" ]; then
#notify-send -i /home/sergiojr24/APPSCRIPTS/Notas/Icons/OK.png "Asumo que quiere salir . . ." "Adios amigo!"
#notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/OK.png "Supongo que quieres salir . . ." "Adios amigooo!"
notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/OK.png "$LEER2 que quieres salir . . ." "Adios amigooo!"
exit 0

else
case $BUSCAR in
		edata!) edata ;;
		EDATA!) edata ;;
		ekey!) ekey ;;
		EKEY!) ekey ;;
		keyword!) keyword ;;
		KEYWORD!) keyword ;;
		key!) keyword ;;
		KEY!) keyword ;;
		n!) new ;;
		N!) new ;;
		contact!) contact ;;
		CONTACT!) contact ;;
		help!) help ;;
		HELP!) help ;;
		donate!) donate ;;
		DONATE!) donate ;;
		about!) about ;;
		ABOUT!) ABOUT ;;
esac

notify-send -i /home/$USER/APPSCRIPTS/Notas/Icons/EMU2.jpg "Buscando . . .  :  $BUSCAR" "Dentro de Notas"
#echo "Aqui esta la informacion" | festival --tts &
mpv /home/sergiojr24/APPSCRIPTS/Notas/Sounds/*.ogg &
cat /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt | grep -i "$BUSCAR" > /tmp/find_data.tmp
cat /tmp/find_data.tmp | zenity --title "Busqueda terminada com : $BUSCAR" --width=1300 --height=550 --text-info
exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
fi
exit
