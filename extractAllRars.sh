#!/bin/bash

helpFunction(){
   echo ""
   echo "Usage: $0 -d directory "
   echo -e "\t-d Directory which include logs as rar. Each log must be a RAR file."
   exit 1 # Exit script after printing help
}

while getopts "d:" opt
do
   case "$opt" in
      d ) directory="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$directory" ]
then
   echo "Please give a directory!!";
   helpFunction
fi

mkdir extracted_rars

for rar in ./"$directory"/*.rar; do
    rar_extension_removed=${rar::-4} #remove .rar
    onlyRarName=$(echo $rar_extension_removed | cut -d "/" -f3-) #remove ..../ part.
    mkdir extracted_rars/"$onlyRarName"

    echo "[+] extracted_rars/ $onlyRarName created!"
    echo "[!] extraction started..."

    unrar x "$rar" extracted_rars/"$onlyRarName"
    echo ""
    echo "[+] File opened to extracted_rars/$onlyRarName !!!"
    echo ""
    echo "----------------------------------------------------"
    done;
echo ""
echo "Extraction done."
