{pkgs, ...}:
pkgs.writeShellScriptBin "sala" ''

  curl --no-progress-meter -X GET "https://api.aladhan.com/v1/timings/28-09-2025?latitude=40.768058&longitude=-111.855700&method=99&methodSettings=17.5,null,15.0&shafaq=general&timezonestring=America%2FDenver&calendarMethod=UAQ"  -H 'accept: application/json'  | jq '.data.timings'

''
