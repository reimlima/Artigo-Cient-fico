#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
[ Script ]

[ Dependencies ]

    TwitterSearch must be installed

    $ pip install TwitterSearch

[ How to Begin ]

    To run this script you'll need Developer Credentials from Twitter
    More informations at: https://dev.twitter.com/

    Once you have the Credentials, fill the array TwitterSearch bellow with:
    consumer_key, consumer_secret, access_token, access_token_secret

[ ToDo ]

    Command line options
        -f 'outputfile' (csv or json)
        -s 'strings to search'

'''

import sys
import getopt
from TwitterSearch import *
import urllib3
urllib3.disable_warnings()

fileHandle = ""

def usage():
    print "use: " + sys.argv[0] + " -f <nome do arquivo> -o <output format csv, json, hadoop> -s <string1 string2 stringN>"
    sys.exit(2)

def main():

    try:
        opts, args = getopt.getopt(sys.argv[1:], "f:o:s:", ["filename=", "output=", "strings="])
        if opts == []:
            usage()
        filename = None
        strings = None
        for o, a in opts:
            if o == "-f":
                filename = a
            elif o in ("-o"):
                output = a
            elif o in ("-s"):
                strings = a
            else:
                usage()

        fileHandle = open(filename, 'w')
        keyWords = strings.split()
    except getopt.GetoptError as err:
        # print help information and exit:
        print str(err) # will print something like "option -a not recognized"
        usage()
        sys.exit(2)

    try:
        tso = TwitterSearchOrder() 
        tso.set_keywords(keyWords)
        tso.set_language('pt')
        tso.set_include_entities(False)

        ts = TwitterSearch(
            consumer_key = '',
            consumer_secret = '',
            access_token = '',
            access_token_secret = ''
         )

        for tweet in ts.search_tweets_iterable(tso):
            if output == "csv":
                tweetToFile = tweet['created_at'].encode('utf-8') + ';' + tweet['user']['screen_name'].encode('utf-8') + ';' + tweet['text'].encode('utf-8') + ';\n'
                fileHandle.write(tweetToFile)
            elif output == "json":
                tweetToFile = '{ "twitter": [ { "date": "' + tweet['created_at'].encode('utf-7') + '", "user": "' + tweet['user']['screen_name'].encode('utf-8') + '", "text": "' + tweet['text'].encode('utf-8') + '" } ] }\n'
                fileHandle.write(tweetToFile)
            elif output == "hadoop":
                tweetToFile = 'date = ' + tweet['created_at'].encode('utf-8') + '| user = ' + tweet['user']['screen_name'].encode('utf-8') + '| text = ' + tweet['text'].encode('utf-8') + '\n'
                fileHandle.write(tweetToFile)
            else:
                print "Invalid Output Format"
                usage()

        fileHandle.close()

    except TwitterSearchException as e:
        print(e)


if __name__ == "__main__":
    try:
        main()
    except IOError:
        print "Saindo abruptamente"
        traceback.print_exc()
