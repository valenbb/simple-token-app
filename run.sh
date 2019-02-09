#!/bin/bash
# A SIMPLE FLASK APP REQUIRING A TOKEN TO RETURN A PING STATUS
#
set -eou pipefail

main () {
    #########################
    # START / STOP / STATUS #
    #########################
    case "$1" in
            start)
                detect_os
                check_python
                pip install -r requirements.txt
                echo "Browse to http://127.0.0.1:5000"
                python main.py
                ;;
            stop)
                kill "$(pgrep -f 'python main.py')"
                ;;
            status)
                if [ -z "$(pgrep -f 'python main.py')" ]; then
                    echo "Status: Stopped"
                else
                    echo "Status: Started"
                fi
                ;;
            *)
                echo $"Usage: $0 {start|stop|status}"
                exit 1
    
    esac

}

####################
# DETECT OS/DISTRO #
####################
def detect_os () {
    ## UBUNTU/DEBIAN ##
    if [ $(command -v apt) ]; then
        distro = "ubuntu"
    ## CENTOS/RHEL ##
    elif [ $(command -v yum) ]; then
        distro = "el"
    ## MACOS ##
    elif [ $(command -v brew) ]; then
        distro = "macos"
    ## UNDETECTABLE OS/DISTRO ##
    else
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "${RED}Package Manager yum, apt, or brew not found. Please contribute to https://github.com/infamousjoeg/simple-token-app for your OS or distribution of choice.${NC}"
        exit 1
    fi

########################################
# DETECTING PRE-REQUISITE APPLICATIONS #
########################################
def check_python () {
    ## NEGATIVE CHECK FOR PYTHON ##
    if [ -z $(command -v python) ]; then
        ## INSTALL PYTHON BASED ON OS/DISTRO ##
        case $distro in
            ubuntu)
                sudo apt -qq update && sudo apt -qq install -y python python-pip
                ;;
            el)
                sudo yum install -y -q epel-release
                sudo yum install -y -q python python-pip
                ;;
            macos)
                brew install python
                ;;
        esac
    fi
}

main "$@"
