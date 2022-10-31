#!/usr/bin/env python3
# 2022/10 Michael Grate
# We want to test if we can see the site!

import sys, logging
from requests import get

# Logging to file and standard out. # Do this once and share between classes.
log_file = '/tmp/site-test.log'
logger = logging.getLogger('site-test')
formatter = logging.Formatter('%(asctime)s %(levelname)-8s %(message)s',datefmt='%Y-%m-%d_%H:%M:%S')
handlers=[
    logging.FileHandler(log_file),
    logging.StreamHandler(sys.stdout)
    ]
for handler in handlers:
    handler.setFormatter(formatter)
    handler.setLevel(logging.INFO) # Default log level INFO.
    logger.propagate = False # Prevents duplicate log entries.
    logger.addHandler(handler)
    logger.setLevel(logging.INFO) # Default log level INFO.

class Tests:
    def __init__(self):
        # Declare variables, not war.
        self.allowed = ["3.121.56.176", "75.166.43.168"]
        self.url = 'https://risczerodemonstration.s3.us-west-2.amazonaws.com/index.html'
        self.iprsvp = 'https://api.ipify.org'
        self.expected_text = 'snake velocity. moves one grid length every frame in either the x or y direction'
                
    def site_available(self):
        r = get(self.url).text
        if self.expected_text in r:
            logger.info('We saw the site, and it was awesome!')
            sys.exit(0)
        else:
            print('We could not see the site!')
            sys.exit(1)
    
    def whoami_verify(self):
        ip = get(self.iprsvp).text
        logger.info(f'For your information, your IP Address is {ip}')        
        if ip in self.allowed:
            logger.info('Congratulations! You are allowed to access the site!')
        else:
            logger.error('Sorry buddy, you are not on the Allow list. Whomp whomp.')
            sys.exit(1)

    def main(self):
        self.whoami_verify()            
        self.site_available()

if __name__ == '__main__':
    Tests().main()

