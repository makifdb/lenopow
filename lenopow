#!/usr/bin/env bash

# Maintainer: Mehmet Akif Duba <mail[at]makifdb[dot]com>

# Based on the code from:
# Lenovsky    <lenovsky@pm.me>

readonly VERSION=1.0.4
readonly BATTERY_PROTECTION='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'
readonly BATTERY_PROTECTION_ON=1
readonly BATTERY_PROTECTION_OFF=0

usage() {
    # Prints general usage of the script.

    cat <<EOF
    usage: ${0##*/} [operation]
    operations:
    -h, --help        Show this message.
    -v, --version     Show script version.
    -s, --status      Show battery protection status.
    -e, --enable      Enable battery protection (charge level 55-60%).
    -d, --disable     Disable battery protection (charge level 100%).
EOF
}

die() {
    # Raises an error message and exits.
    # param: $1: $error_message: error message

    local exit_code=1
    local error_message="$1"

    echo "${0##*/}: ${error_message}" 1>&2

    exit "${exit_code}"
}

battery_protection_show() {
    # Shows battery protection status based on $BATTERY_PROTECTION value.

    local status="$(cat "${BATTERY_PROTECTION}")"

    if [[ "${status}" -eq "${BATTERY_PROTECTION_ON}" ]]; then
        echo "Battery protection: ENABLED"
    elif [[ "${status}" -eq "${BATTERY_PROTECTION_OFF}" ]]; then
        echo "Battery protection: DISABLED"
    else
        echo "Battery protection: UNKNOWN"
    fi
}

battery_protection_store() {
    # Stores value in $BATTERY_PROTECTION
    # param: $1: $store: values for $BATTERY_PROTECTION, where:
    #   * 1 -> enabled
    #	* 0 -> disabled

    local store="$1"

    if [[ "${store}" -eq "${BATTERY_PROTECTION_ON}" ]]; then
        echo 'Battery protection enabled (charge level 55-60%)'
        sudo bash -c "echo '${store}' >'${BATTERY_PROTECTION}'"
    elif [[ "${store}" -eq "${BATTERY_PROTECTION_OFF}" ]]; then
        echo 'Battery protection disabled (charge level 100%)'
        sudo bash -c "echo '${store}' >'${BATTERY_PROTECTION}'"
    else
        die "Invalid value encountered in 'battery_protection_store()'"
    fi
}

main() {
    # Parses command-line arguments in order to perform the stuff.
    # param: $1: $key: key to the stuff

    local key="$1"

    case "${key}" in
    -h | --help)
        usage
        ;;
    -v | --version)
        echo "${0##*/} v${VERSION}"
        ;;
    -s | --status)
        battery_protection_show
        ;;
    -e | --enable)
        battery_protection_store "${BATTERY_PROTECTION_ON}"
        ;;
    -d | --disable)
        battery_protection_store "${BATTERY_PROTECTION_OFF}"
        ;;
    "")
        die "No operation specified. See '${0##*/} --help'."
        ;;
    *)
        die "Invaild operation '${key}'. See '${0##*/} --help'."
        ;;
    esac
}

main "$@"
