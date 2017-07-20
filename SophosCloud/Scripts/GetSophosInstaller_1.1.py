__author__ = "Jackson Eyton, Roger Lawrence"
__version__ = "1.1"
__maintainer__ = "Jackson Eyton"
__email__ = "jack@arrc.com"
__status__ = "Production"


import sys
import argparse
import requests


parser = argparse.ArgumentParser(description='Sophos Installer URL Collector')

parser.add_argument(
    '--w',
    action='store_true',
    default=False,
    dest='get_windows',
    help='Gets Sophos installer URL for Windows'
    )

parser.add_argument(
    '--l',
    action='store_true',
    default=False,
    dest='get_linux',
    help='Gets Sophos installer URL for Linux OS'
    )

parser.add_argument(
    '--m',
    action='store_true',
    default=False,
    dest='get_macOS',
    help='Gets Sophos installer URL for Mac OS X'
)

parser.add_argument(
    '--x-api-key',
    dest='get_x_api_key',
    help='enter the sophos provided x-api-key here'
)

parser.add_argument(
    '--Authorization',
    dest='get_authorization',
    help='enter the sophos provided authorization header values (eg. Basic 7yauhi8g8...)'
)

result = parser.parse_args()

# -------------------------------------------------------------------------------------------------
#
# -------------------------------------------------------------------------------------------------

#### CHECKING OS VERSION ####
if result.get_windows:
    os_ver = "Windows"
elif result.get_linux:
    os_ver = "Linux"
elif result.get_macOS:
    os_ver = "Mac OS X"
else:
    print("No Operating System Specified")
    sys.exit()    

try:
    os_ver
except NameError as e:
    print("Exception: " + str(e))
    sys.exit()
#### END OS VERSION CHECK ####

#### CHECKING API KEY EXISTS #####
if not result.get_x_api_key:
    print("No x-api-key value was provided")
    sys.exit()
else:
    api_key = str(result.get_x_api_key)

try:
    result.get_x_api_key
except NameError as e:
    print("Exception: " + str(e))
    sys.exit()
#### END API KEY CHECK ####

#### CHECK AUTHORIZATION EXISTS ####
if not result.get_authorization:
    print("No Authorization header value was provided")
    sys.exit()
else:
    api_auth = str(result.get_authorization)

try:
    result.get_authorization
except NameError as e:
    print("Exception: " +str(e))
    sys.exit()

url = "http://api1.central.sophos.com/gateway/migration-tool/v1/deployment/agent/locations"

headers = {
    'x-api-key': api_key,
    'authorization': api_auth,
    'cache-control': "no-cache",
    }

response = requests.request("GET", url, headers=headers)

if response.status_code == 200:
    apiQuery = response.json()
    for info in apiQuery['installerInfo']:
        if info['platform'] == os_ver:
            if os_ver == "Linux":
                if "SophosInstall.sh" in str(info['url']):
                    print(info['url'])
                elif "SophosInstall.sh" not in str(info['url']):
                    pass
            elif os_ver == "Windows" or os_ver == "Mac OS X":
                    print(info['url'])
            else:
                print("No URL Found for: " + os_ver)
                sys.exit()
