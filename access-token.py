#!/usr/bin/env python

import sys, json
from datetime import datetime, date, time
token = json.load(sys.stdin)
output = {}
output["tokenType"] = token["token_type"]
output["expiresIn"] = token["expires_in"]
output["resource"] = "https://management.core.windows.net/"
output["refreshToken"] = token["refresh_token"]
output["accessToken"] = token["access_token"]
output["expiresOn"] = datetime.fromtimestamp(int(token["expires_on"])).isoformat(' ', 'microseconds')
print(json.dumps(output))