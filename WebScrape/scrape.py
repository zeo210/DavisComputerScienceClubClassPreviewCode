import sys
import requests
import re
import csv
from BeautifulSoup import BeautifulSoup


def scrape_class():
    url = "http://nook.cs.ucdavis.edu/cgi-bin/pipeline." \
          "pl?_pipeline=/usr/ns-home/cgi-bin/modules/classes/13-14/spring-db.pl"

    # spoof some headers so the request appears to be coming from a browser, not a bot
    headers = {
        "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5)",
        "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "accept-charset": "ISO-8859-1,utf-8;q=0.7,*;q=0.3",
        "accept-encoding": "gzip,deflate,sdch",
        "accept-language": "en-US,en;q=0.8",
    }

    # make the request to the search url, passing in the the spoofed headers.
    r = requests.get(url, headers=headers)  # assign the response to a variable r

    # check the status code of the response to make sure the request went well
    if r.status_code != 200:
        print("request denied")
        return
    else:
        print("scraping " + url)

    soup = BeautifulSoup(r.text)

    #get table header
    header_results = soup.findAll('th')

    #get table rows
    row_results = soup.findAll('tr')

    output_classes = open('classes.csv', "wb")
    writer_classes = csv.writer(output_classes, delimiter=',')

    #print headers
    for header_result in header_results:
        print header_result.text

    writer_classes.writerow([header_results[0].text, header_results[1].text, header_results[3].text,
                             header_results[5].text, header_results[6].text, "PREREQS"
    ])

    #break down each row and print each element in each row
    for row_result in row_results:
        sub_results = row_result.findAll('td')
        length = len(sub_results)
        print sub_results

        if length == 8:
            print "~~~~~~~~~~~~Adding Class"
            writer_classes.writerow([sub_results[0].text, sub_results[1].text, sub_results[3].text,
                                     sub_results[5].text, sub_results[6].text, None
            ])
            #matched = re.match("ECS%d%d%d")
        elif length == 6:
            print "~~~~~~~~~~~~Lab/Section/Discussion #TODO (OPTIONAL)"
        else:
            print "~~~~~~~~~~~~not using row, skipping"
            continue

        #for sub_result in sub_results:
        #    print sub_result.find(text=True)

    output_classes.close()

scrape_class()
