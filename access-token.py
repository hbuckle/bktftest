#!/usr/bin/env python

import sys, json, datetime
token = json.load(sys.stdin)
output = {}
output["tokenType"] = token["token_type"]
output["expiresIn"] = token["expires_in"]
output["resource"] = token["resource"]
output["refreshToken"] = token["refresh_token"]
output["accessToken"] = token["access_token"]
output["expiresOn"] = datetime.fromtimestamp(int(token["expires_on"])).isoformat(' ', 'microseconds')
print(json.dumps(output))