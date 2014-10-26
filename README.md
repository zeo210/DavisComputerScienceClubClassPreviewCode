Davis Computer Science Club Class Preview Code
==============================================
This is the slideshow program used by the Davis Computer Science Club for their quarterly Course Preview meeting. The main reason for this program is because the information about the courses being offered the upcoming quarter changes frequently (ex: location, time, professor, availability changes). The program is split into two different parts: The Scraper and The Presenter. Both parts are very hacky and sloppy since this was made during the school year with other obligations I had to attend to, but it works!

The Scraper is created in Python and uses the BeautifulSoup library to parse through our target url (The UC Davis Computer Science Course Offering page) and make a CSV file that is readable in The Presenter program. It takes the page source from our target, separates the HTML table of courses, creates a CSV file listing out each course. This CSV file is then moved to the presenter program where it will be used. The CSV file can also be edited to make custom slides (like announcements).

The Presenter is created in Processing and uses the Motion library to make a slideshow where each slide is a upcoming course (or possibly a custom slide). When the program starts it reads the CSV file and creates a slide object for every line in the CSV file. After the program finish reading the CSV file The Presenter then pops up an applet with a slide presenting information from the first line of the CSV file. The user use the left or right arrow keys to change the slide presenting different lines of the CSV file when needed.

This program is available to be worked on for the Davis Computer Science Club to use in the future and will be updated whenever I have time add or clean up some code.

==============================================
Additional Notes:
The Webscraper runs on Python 2. You will need to install pip, and have it install BeautifulSoup and requests.

The Webscraper file needs to be modified to parse from the most recent quarter. ALSO!!! Webscraper parses through an obsolete page - a PDF parser will be created for presentations Spring 2015 and onwards.

The CSV file created in the webscraper needs to be modified in the manner listed below, and then moved to the presenter program manually.

CSV Modification:
	Remove graduate course lines - this presentation is geared towards undergraduates.
	If desired - manually add in EEC and GE courses, and other slides, as desired 