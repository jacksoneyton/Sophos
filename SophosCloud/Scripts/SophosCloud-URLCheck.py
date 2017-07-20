import urllib
import argparse

parser = argparse.ArgumentParser(description = "Sophos Installer URL Checker")

parser.add_argument(
    '--url',
    dest='check_URL',
    help='Installer URL to check'
)

result = parser.parse_args()

print urllib.urlopen(result.check_URL).getcode()