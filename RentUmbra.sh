#!/bin/bash
# shellcheck enable=require-variable-braces
# shellcheck disable=SC2034,2002,2004,2154,SC1073
## DO NOT REMOVE THESE!
## This is to prevent shellcheck from complaining about false positive issues like unused variables.
shopt -s extglob

###############
## VARIABLES ##
###############

## File/Field Seperator Reference
OldIFS=${IFS}

## Define 4-bit Color Table
Tpurple="\e[35;40m"
TBpurple="\e[95;40m"
Tgreen="\e[32;40m"
TBgreen="\e[92;40m"
White="\e[0;40m"
TBred="\e[91;40m"
Tred="\e[31;40m"
TByellow="\e[93;40m"
Tyellow="\e[33;40m"
Tcyan="\e[36;40m"
TBcyan="\e[96;40m"

## Define 8-bit (256_color) Table
blue="\e[38;5;20m"
Bblue="\e[38;5;21m"
Red="\e[38;5;160m"
Bred="\e[38;5;196m"
Purple="\e[38;5;91m"
Bpurple="\e[38;5;129m"
Magenta="\e[38;5;165m"
Bmagenta="\e[38;5;177m"
Pink="\e[38;5;201m"
Bpink="\e[38;5;213m"
Yellow="\e[38;5;226m"
Byellow="\e[38;5;228m"
Orange="\e[38;5;215m"
Borange="\e[38;5;220m"
Green="\e[38;5;40m"
Bgreen="\e[38;5;47m"
Teal="\e[38;5;43m"
Bteal="\e[38;5;122m"
Cyan="\e[38;5;51m"
Bcyan="\e[38;5;123m"
Grey="\e[38;5;248m"

## Black Magic Colors
Gwhite="\e[38;5;231;48;5;238m"

#shellcheck disable=SC1117
SuccessSymbol="${Bgreen}✔${White}"
ErrorSymbol="${Bred}❗${White}"
WarningSymbol="${Byellow}⚠${White}"
KilledSymbol="${Bred}‼${White}"
OptionSymbol="${Bpurple}--${White}"
HelpNoteSymbol="✨${White}"
CircleSymbol="${Cyan}💠${White}"

## SALT
KRABBY_PATTY_SECRET_RECIPE="M@g1c@3M@ch1n@3"

RentUmbra() {
    ###################################################################################################
    ##    RENT UMBRA - Shadow Broker [Credit: Justin Keller(https://github.com/nodesocket/cryptr)]   ##
    ###################################################################################################
    ## Misc Shit
    local OPENSSL_CIPHER_TYPE="aes-256-cbc"
    ## Some Versioning and utility functions
    local VERSION="1.0.1"
    ## Controller Case Statement
    case ${1} in 
        "h"|"H"|"help"|"HELP")
            echo -e "\n
            RentUmbra | Shadow Broker Help Menu:\n
            ${CircleSymbol} Syntax: ${Bteal}RentUmbra${White} <${Magenta}Command${White}> <${Green}Command Arguements${White}>\n
            Valid Options:\n
                ${Cyan}${OptionSymbol} [ ${Magenta}H${White} ] - ${Green}Help${White}\n
                    EXAMPLE: RentUmbra H\n
                ${Cyan}${OptionSymbol} [ ${Magenta}I ] - ${Green}Application Information${White}\n
                ${Cyan}${OptionSymbol} [ ${Magenta}EF ] - ${Green}Encrypt File${White}\n
                ${Cyan}${OptionSymbol} [ ${Magenta}DF ]  - ${Green}Decrypt File${White} ${HelpNoteSymbol}\n
                ${Cyan}${OptionSymbol} [ ${Magenta}ES ] - ${Green}Encrypt String${White} ${HelpNoteSymbol}\n
                ${Cyan}${OptionSymbol} [ ${Magenta}DS ] - ${Green}Decrypt String${White} ${HelpNoteSymbol}\n
            "
        ;;
        "i"|"I"|"INFO"|"info")
            echo -e "
            RentUmbra | Shadow Broker Information:\n
                ${CircleSymbol} Shadow Broker Author: ${Teal}Christopher Nichols (Globbin)${White}\n
                ${CircleSymbol} Shadow Broker Version: ${Green}${VERSION}${White}\n
                ${CircleSymbol} Shadow Broker Encryption: ${Borange}${OPENSSL_CIPHER_TYPE}${White}\n"
        ;;
        "ef"|"EF"|"ENCRYPT-FILE"|"encrypt-file")
            local _file="${2}"
            [ ! -f "${_file}" ] && \
            echo -e "\n[${Bred}ERROR${White}] ${Yellow}File not found, Find it.${White}" && return 1
            ## Using Krabby Patty Secret Recipe For Decryption
            [ -n "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            openssl ${OPENSSL_CIPHER_TYPE} -salt -e -a -in "${_file}" -out "${_file}".aes -pbkdf2 -k env:KRABBY_PATTY_SECRET_RECIPE && return
            ## NOT Using Krabby Patty Secret Recipe For Decryption
            [ -z "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            openssl ${OPENSSL_CIPHER_TYPE} -salt -e -a -in "${_file}" -out "${_file}".aes && return
        ;;
        "df"|"DF"|"DECRYPT-FILE"|"decrypt-file")
            local _file="${2}"
            [ ! -f "${_file}" ] && \
            echo -e "\n[${Bred}ERROR${White}] ${Yellow}File not found. Find it.${White}" && return 1
            ## Using Krabby Patty Secret Recipe For Decryption
            [ -n "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            openssl ${OPENSSL_CIPHER_TYPE} -salt -d -a -in "${_file}" -out "${_file%\.aes}" -pbkdf2 -k env:KRABBY_PATTY_SECRET_RECIPE && return
            ## NOT Using Krabby Patty Secret Recipe For Decryption
            [ -z "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            openssl ${OPENSSL_CIPHER_TYPE} -salt -d -a -in "${_file}" -out "${_file%\.aes}" && return
        ;;
        "es"|"ES"|"ENCRYPT-STRING"|"encrypt-string")
            local _string="${2}"
            [ -z "${_string}" ] && \
            echo -e "\n[${Bred}ERROR${White}] ${Yellow}String is not valid, what're you doing?${White}" && return 1
            ## Using Krabby Patty Secret Recipe For Decryption
            [ -n "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            echo "${_string}" | openssl ${OPENSSL_CIPHER_TYPE} -salt -e -a -pbkdf2 -k env:KRABBY_PATTY_SECRET_RECIPE && return
            ## NOT Using Krabby Patty Secret Recipe For Decryption
            [ -z "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            echo "${_string}" | openssl ${OPENSSL_CIPHER_TYPE}-salt -e -a && return
        ;;
        "ds"|"DS"|"DECRYPT-STRING"|"decrypt-string")
            local _string="${2}"
            [ -z "${_string}" ] && \
            echo -e "\n[${Bred}ERROR${White}] ${Yellow}String is not valid, what're you doing?${White}" && return 1
            ## Using Krabby Patty Secret Recipe For Decryption
            [ -n "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            echo "${_string}" | openssl ${OPENSSL_CIPHER_TYPE} -salt -d -a -pbkdf2 -k env:KRABBY_PATTY_SECRET_RECIPE && return
            ## NOT Using Krabby Patty Secret Recipe For Decryption
            [ -z "${KRABBY_PATTY_SECRET_RECIPE}" ] && \
            echo "${_string}" | openssl ${OPENSSL_CIPHER_TYPE} -salt -d -a && return
        ;;
        *) echo -e "\n[${Bred}ERROR${White}] ${Yellow}Invalid Arguement${White}";; ## Obviously you didn't listen and put something stupid.
    esac
} ## End of Function