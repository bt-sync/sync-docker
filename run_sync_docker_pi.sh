#!/bin/bash

DOHELP() {

    echo ""
    echo "Usage: $0 -t [path] (-n [hostname])"
    echo ""
    echo -e "\t-t: Path to base directory of resilio sync storage"
    echo -e "\t-n: Specify a hostname to be used [Optional]"
    echo -e "\t-h: This dialog"
    echo ""
    echo ""

}

TARGDIR=""
HNAME="$(hostname).sync"

if [ $# -lt 1 ]; then
    DOHELP    
    exit 0
fi

while getopts "t:n:" OPTION
do
    case "${OPTION}" in
        t)
            TARGDIR="${OPTARG}"
            ;;
        n)
            HNAME="${OPTARG}"
           ;;
        *)
            DOHELP
            exit
    esac
done

echo "Running Resilo Sync via Docker"
echo "Base Dir: ${TARGDIR}"
echo "Hostname: ${HNAME}"
echo ""
echo "[Press any key to continue]"
read -r


docker run -d -h "${HNAME}" -p 8888:8888 -p 55555 -v "${TARGDIR}":/mnt/sync wardf/sync:arm
