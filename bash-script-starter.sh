#!/bin/bash

# your script here

echo "aws help, enter command:"

read commands_entered
#echo "debug - commands_entered: $commands_entered"

#aws "$commands_entered" help

(aws $commands_entered help)
