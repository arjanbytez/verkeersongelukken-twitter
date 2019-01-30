################################################################################
# DOWNLOAD IMAGES BASED ON A LIST OF URLS
# This script downloads all URLs in file downloads.txt and changes the names
# in order to be able to save them to disk. When an image is not found, an
# error is returned and logged. It is up to the user how to handle those errors.
#
# USAGE
# Run with 'python download-urls-from-txt.py > logurls.txt to save errors.'
# Script written by Arjan Zuidhof, Jan 30 2019
################################################################################
import os
import sys
import requests

headers = headers={'User-Agent': 'Mozilla/5.0 (Macintosh)'}
files = 0
errors = 0

with open('downloads.txt', 'r') as f:
    print("Downloading...")
    for url in f:
        url=url.replace("\n", "")
        downloadLink = url.replace("/", "_").replace(":", "").replace(",", "").replace("=", "").replace("%", "").replace("#", "")
        downloadLink = downloadLink.split("?", 1)[0] # everything behind ? is unneccesary
        try: # to prevent the script from breaking because of bad SSL-certificates etc.
            respons = requests.get(url, headers=headers)
            if respons.status_code != 200:
                print(">>> ERROR ", respons.status_code, " for file ", url)
                errors += 1
            else:
                with open(downloadLink, 'wb') as photo:
                    photo.write(respons.content)
                    files +=1
        except: # catch all unhandled errors
            e = sys.exc_info()[0]
            print(e)
            errors += 1
    print ("Done downloading " + str(files) + " images.", str(errors), " errors encountered.")
