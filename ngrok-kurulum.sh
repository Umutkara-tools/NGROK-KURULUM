#!/bin/bash

# WGET  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/wget ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m WGET PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install wget -y
fi

# SCRİPTS CONTROLS

if [[ ! -a files/update.sh ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m GEREKLİ SCRİPTLER KURULUYOR.."
	echo
	echo
	echo
	# UPDATE.SH ( GÜNCELLEME SCRİPTİ )

	wget -O files/update.sh  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/update.sh

	# BOT_UMUTKARATOOLS ( BİLDİRİM SCRİPTİ )

	#wget -O $PREFIX/bin/bot_umutkaratools  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/bot_umutkaratools

	# LİNK-CREATE ( LİNK OLUŞTURMA SCRİPTİ )

	#wget -O $PREFIX/bin/link-create https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/link-create

	#chmod 777 $PREFIX/bin/*
fi

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi

if [[ ! -a $PREFIX/bin/unzip ]];then
	echo
	echo
	echo
	printf "\e[32m[*]\e[97m UNZİP PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install unzip -y
fi
if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[*]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi
if [[ ! -a $PREFIX/bin/php ]];then
	echo
	echo
	echo
	printf "\e[32m[*]\e[97m PHP PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install php -y
fi
_delete() {
if [[ -a $PREFIX/bin/ngrok ]];then
	rm $PREFIX/bin/ngrok
fi
}
_test() {
killall ngrok
killall php
sleep 2
port="4988"
php -S 127.0.0.1:$port & ngrok http $port > /dev/null &
clear
echo
echo
echo
printf "\e[33m
        +-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+

                  \e[97mNGROK TEST EDİLİYOR..

	          LÜTFEN BEKLEYİNİZ...\e[33m


	+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+\e[97m"
echo
echo
close(){
control=$(ngrok version |wc -l)
if [[ $control == 1 ]];then
	version="true"
else
	version="false"
fi
}
end=$((SECONDS+20))
while [ $SECONDS -lt $end ];
do
	url=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[^,]\*.ngrok.io\" |wc -l)
done
killall ngrok
killall php
clear
echo
echo
echo
echo
echo
echo
if [[ $url == 1 ]];then
	printf "\e[33m
	+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+

	          NGROK TEST EDİLDİ..
	
 	         \e[97mSONUÇ : \e[32m[✓] BAŞARILI\e[33m

	+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+\e[97m"
	exit
else
	printf "\e[33m
	+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+

	          NGROK TEST EDİLDİ..
	
 	         \e[97mSONUÇ : \e[31m[!] BAŞARISIZ\e[33m

	+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+\e[97m"
fi
echo
echo
echo
echo
echo
echo
}
_banner() {
printf "\e[32m

  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+\e[1;33m

    $(cat ngrok-versions |wc -l)\e[1;97m ADET NGROK VERSİYONU

    TEK TEK OTOMATİK OLARAK KURULACAK VE

    \e[32mBAŞARILI \e[1;97mOLANA KADAR TEST EDİLECEKTİR...\e[1;32m

  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+\e[1;97m
 "
echo
echo
echo
echo
echo
sleep 5
}
clear
cd files
bash update.sh
if [[ -a ../updates_infos ]];then
	rm ../updates_infos
	exit
fi
bash banner.sh
if [[ $1 == --all ]];then
	mv ngrok-versions .ngrok-versions
	curl -s https://dl.equinox.io/ngrok/ngrok/stable/archive |grep linux-arm64.zip > ngrok-versions
fi
_banner
_versions() {
	total=$(cat ngrok-versions |grep -o \"[^,]\*\" |tr -d '"' |awk '{print $1}'|wc -l)
	for version in `seq 1 $total`;do
		ngrok_versions=$(cat ngrok-versions |grep -o \"[^,]\*\" |tr -d '"' |awk '{print $1}'|sed -n $version\p)
		ngrok_version_no=$(cat ngrok-versions |grep -o \"[^,]\*\" |tr -d '"' |awk '{print $1}' |sed -n $version\p |grep -o ngrok-[0-9.]\*-linux |tr -d "ngrok-linux-")
		ngrok_zip_name=$(cat ngrok-versions |grep -o \"[^,]\*\" |tr -d '"' |awk '{print $1}' |sed -n $version\p |grep -o ngrok-[^,]\*zip)
		_delete
		wget $ngrok_versions
		unzip $ngrok_zip_name
		rm $ngrok_zip_name
		mv ngrok $PREFIX/bin/ngrok
		chmod 777 $PREFIX/bin/ngrok
		echo
		echo
		echo
		printf "\e[32m[✓]\e[1;97m NGROK \e[33mVERSİON $ngrok_version_no\e[97m KURULUM TANAMLANDI"
		echo
		echo
		echo
		sleep 2
		_test
	done
}
_versions
