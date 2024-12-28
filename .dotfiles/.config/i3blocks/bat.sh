#!/bin/bash
#
#
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" == "Charging" ]; then
	acpi | awk -F ', ' '{print"󰂄" $2}'
else
	acpi | awk -F ', ' '{print"󱈑" $2}'
fi
