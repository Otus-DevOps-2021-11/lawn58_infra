# lawn58_infra
lawn58 Infra repository

###ДЗ №3 Знакомство с облачной инфраструктурой и облачными сервисами###

##Самостоятельное задание по подключению к someinternalhost  с локальной машины.##

На локальной машине запускаем:

someinternalhost=IP && ssh -tt -i appuser -A appuser@IP "ssh -tt $someinternalhost"
  
  
##Организация VPN сервера на базе Pritunl.##
  
Настроен домен 62.84.124.168.sslip.io.

Данные для подключения к bastion и someinternalhost:  
bastion_IP = 62.84.126.237  
someinternalhost_IP = 10.128.0.23  


###ДЗ №4 Основные сервисы Yandex Cloud###

install_mongodb.sh   # скрипт устанавливает mongodb  
install_ruby.sh      # скрипт устанавливает ruby  
deploy.sh            # скрипт скачивает и разворачивает web-приложение  
startup.sh           # скрипт создает машину в облаке, создает окружение, разворачивает web-приложение. необходимо предварительно создать ssh-ключи  

testapp_IP = 51.250.14.175
testapp_port = 9292
  
