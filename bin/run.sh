#!/bin/bash

dotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
} 

if [ $# -eq 0 ] ; then
  echo "param: config-server discovery-server api-gateway admin-server consumer customers-service vets-service visits-service (-b)"
  echo "  -b for build"
  echo ""
  exit
fi

dotenv

mkdir -p logs

BUILD_MODE=false
if [[ "$*" == *"-b"* ]] ; then
    BUILD_MODE=true
fi

CMD1="mvn clean package -DskipTests"
CMD2="java -jar target/*.jar"
CMD3="mvn spring-boot:run"
CMD0=

HOSTNAME=`hostname`

OPT1="--eureka.instance.hostname=$HOSTNAME --eureka.instance.ip-address=127.0.0.1 --eureka.instance.prefer-ip-address=true"
OPT2="-Dspring.profiles.active=native"
OPT3="-Dspring.profiles.active=mysql"
OPT4="--spring.profiles.active=native"
OPT5="--spring.profiles.active=mysql"
OPT0=

if $BUILD_MODE ; then
  CMD0=$CMD1
else
	CMD0=$CMD2
fi

for var in "$@"
do

    case $var in
    config-server)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1 $OPT4"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    discovery-server)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    api-gateway)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    admin-server)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    consumer)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1 $OPT5"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    customers-service)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1 $OPT5"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    vets-service)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1 $OPT5"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
    visits-service)
			cd "spring-petclinic-$var"
	    echo "running $var>>"
	    if ! $BUILD_MODE ; then
	    	CMD="$CMD0 $OPT1 $OPT5"
	    	CMD="nohup $CMD > ../logs/$var.log 2>&1 &"
	    else
	    	CMD="$CMD0"
	    fi
	    echo $CMD
	    eval $CMD
	    ;;
		*)
	    # ignore
	    continue
	    ;;
	esac

	cd ..

done


