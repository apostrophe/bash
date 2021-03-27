#!/bin/bash

# -e makes the whole script exit upon failure
# -o pipeline forces a failure when there's a failure anywhere
# in the pipeline (cmd1 | cmd2 | cmd3)  
set -eo pipefail

logFilePath="/home/bschilke/Documents/linux/scripts/aws-related/get_aws_forecast_log"
# why you're checking, or a change you've made recently in your account
comment=$1

echo >> $logFilePath
echo `date` >> $logFilePath

if [ -n "$comment" ]
then
      echo "NOTE: $comment" >> $logFilePath
fi

_log() {
	echo "$@"
	echo "$@" >> $logFilePath
}

_logWithFormat() {
	printf "  amt: $ %0.2f\n" $1
	printf "  amt: $ %0.2f\n" $1 >> $logFilePath
}

forecast_raw_data="$(aws ce get-cost-forecast --time-period Start=$(date -d "$(date +%Y%m%d) +1 day" +%Y-%m-%d),End=$(date -d "$(date +%Y%m01) +1 month -1 day" +%Y-%m-%d) --metric BLENDED_COST --granularity MONTHLY)"
#_log "forecast_raw_data: $forecast_raw_data"

_log "---------------------------------------------"
_log "FORECAST"
forecast_start_date="$(echo $forecast_raw_data | jq -r '.ForecastResultsByTime[0].TimePeriod.Start')"
_log "start: $forecast_start_date"

forecast_end_date="$(echo $forecast_raw_data | jq -r '.ForecastResultsByTime[0].TimePeriod.End')"
_log "  end: $forecast_end_date"

forecast_amount="$(echo $forecast_raw_data | jq -r '.Total.Amount')"
#printf "  amt: $ %0.2f\n" "$forecast_amount"
_logWithFormat "$forecast_amount"
_log "---------------------------------------------"


current_actual_raw_data="$(aws ce get-cost-and-usage --time-period Start=$(date +"%Y-%m-01"),End=$(date +"%Y-%m-%d") --metric BLENDED_COST --granularity MONTHLY)"
#_log "current_actual_raw_data: $current_actual_raw_data"

_log "---------------------------------------------"
_log "CURRENT/ACTUAL"
current_actual_start_date="$(echo $current_actual_raw_data | jq -r '.ResultsByTime[0].TimePeriod.Start')"
_log "start: $current_actual_start_date"

current_actual_end_date="$(echo $current_actual_raw_data | jq -r '.ResultsByTime[0].TimePeriod.End')"
_log "  end: $current_actual_end_date"

current_actual_amount="$(echo $current_actual_raw_data | jq -r '.ResultsByTime[0].Total.BlendedCost.Amount')"
#printf "  amt: $ %0.2f\n" "$current_actual_amount"
_logWithFormat "$current_actual_amount"
_log "---------------------------------------------"


