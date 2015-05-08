import sys
import requests
import re
import csv
import math
from bs4 import BeautifulSoup

#[u'1:40 - 3:00 PM, TR\n', u'ECS 010\n', u'Intro to Programm', u'Butner, M ', u'9:00 - 9:50 AM, F\n']
# USING PYTHON 3



def scrape_class():
    r= (open('C:/Users/Pouneh/Desktop/DavisComputerScienceClubClassPreviewCode/table.html', 'r')).read()

    soup = BeautifulSoup(r)
    
    row_results = soup.findAll('td',title='View Course Detail')

    global stripped_row
    stripped_row=[]
    for i in range(0,len(row_results)-1):
        stripped_row.append(row_results[i].text)

    global k
    k= 0

    rowValues=[]
    kval=[]
    level =0;
    global full_string

    while (k< len(stripped_row)):
        maybeRow=casek0_1()
        if (k%5 != 1 and level ==1):
            rowValues.append(maybeRow)
        elif (k%5 == 1 and len(maybeRow) > 2 and maybeRow[2] not in kval):
            kval.append(maybeRow[2])
            rowValues.append(maybeRow)
            level =1
        else:
            level =0
     

#start output to CSV stuff
    output_classes=open('classes.csv', "wt", newline='', encoding='utf8')
    writer_classes = csv.writer(output_classes , delimiter = ',')

    headers = ["COURSE ","INSTRUCTOR","TITLE","TIME","ROOM"]

    writer_classes.writerow([headers[0] , headers[1], headers[2] ,  headers[3], headers[4]])
    writer_classes.writerow(['Announcements', '','','',''])



    numClasses = math.floor(len(rowValues) /5)

    for j in range(numClasses):
        a = j*5
        b = j*5 + 1
        c = j*5 + 2
        d = j*5 + 3
        e = j*5 + 4
        #                             course        instructor      title             time             room
        writer_classes.writerow([rowValues[a][2], rowValues [d][2], rowValues [c][2], rowValues[e][3], rowValues[a][3]])

            


    output_classes.close()


#CRN, Time, and Dates , course number, location
def casek0_1():
    global k
    rowcase=[]
    full_string=stripped_row[k].strip('\n')
    #print (full_string)
   
    #get CRN and date/time
    rowValues=[]
    b=0 #full_string traversed
    value=""
    for j in range(2):
        value=""
        #bypass blank space
        while((ord(full_string[b]) <47) or ((ord(full_string[b])>57) and (ord(full_string[b]) <65)) or ord(full_string[b])>90):
            b=b+1
            if(b == len(full_string)-1):
                break
        #grab next CSV row value
        while(b < len(full_string) and full_string[b] != '\n'):
            #print(full_string[b])
            value=value+(full_string[b])
            b=b+1
            if (b == len(full_string)-1):
                break
        #value=value+full_string[b]
       #record next CSV row value
        rowValues.append(value[0:b])

    k=k+1
    if (k < len(stripped_row)):
        full_string=stripped_row[k].strip('\n')

        #get course number and location
        b=0 #full_string traversed
        value=""
        for j in range(2):
            value=""
            #bypass blank space
            while((ord(full_string[b]) <47) or ((ord(full_string[b])>57) and (ord(full_string[b]) <65)) or ord(full_string[b])>90):
                b=b+1
                if(b == len(full_string)-1):
                    break
            #grab next CSV row value
            while(b < len(full_string) and full_string[b] != '\n' ):
                #print(full_string[b])
                value=value+(full_string[b])
                b=b+1
                if (b == len(full_string)-1):
                    break
            
            #value=value+full_string[b]
           #record next CSV row value
            rowValues.append(value[0:b])


    return (rowValues)

scrape_class()

#k%5 
# case 0: CRN, Time and Dates
# case 1: Course, location
# case 3: title
# case 4: Instructor



