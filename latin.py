#!/usr/bin/python

import random

class Verb:
    """
    Represents a single latin verb.
    self.pparts contains the principle
    parts of the verb.
    self.difficulty is the associated
    difficulty value
    Can be easily extended to support
    other features such as declension
    """

    def __init__(self,string):
	"""
	Parses a line of text and fills
	the appropriate fields.
	"""

	splitpoint=string.rindex(" ")
	self.pparts=string[:splitpoint]
	self.difficulty=float(string[splitpoint:])

    def __str__(self):
	"""String Representation of the object"""

	return self.pparts+" "+str(self.difficulty)

class SynopsisGenerator:
    """
    Reads in values from a database
    of verbs and associated difficulty
    level, then is able to choose a
    random verb with a random person,
    number, and voice for students to
    synopsize. The only bug currently is
    that the generator will give a voice
    even for deponent verbs, but this can
    be easily fixed if another version
    is created which includes support for
    verbs' declensions
    """

    def __init__(self,dblocation):
	"""
	Accepts the location of the database
	file and fills the current list of verbs.
	Also creates a self.instructions variable
	which contains the instructions to be
	displayed every time the program is started
	up and the default lists of persons, numbers,
	and voices
	"""

	self.dblocation=dblocation
	self.verbs=self.getVerbs(self.dblocation)
	self.maximum=None
	self.minimum=None
	self.persons=["1st","2nd","3rd"]
	self.numbers=["Singular","Plural"]
	self.voices=["Active","Passive"]
	self.instructions= "Instructions:\n"+\
			   "At the prompt, hit enter to generate a new random verb, person, number, and voice.\n"+\
			   "To set the minimum difficulty rating, at the prompt type in \"min\" (without the quotes) and hit enter."+\
			   "Similarly, to set the maximum difficulty rating, at the prompt type in \"max\" (without the quotes) and hit enter.\n"+\
			   "To list all cataloged verbs, at the prompt type in \"list\" (without the quotes) and hit enter.\n"+\
			   "To see these instructions again, at the prompt type in \"help\" (without quotes) and hit enter.\n"+\
			   "To exit, type in \"exit\" (without the quotes) and hit enter.\n"

    def generate(self):
	"""
	Executes the main loop of the program.
	First prints the instructions, then allows
	the user to either pick a random synopsis
	task, set new minimum and maximum difficulty
	ratings, or exit.
	"""
	print "Welcome to the Random Synopsis Generator!"
	print self.instructions
	inp=""
	while inp!="exit":
	    self.printVerbStatus()
	    inp=raw_input("Hit enter for a new verb: ").strip().lower()
	    if(len(inp)<1):
		self.randomSynopsis()
	    elif(inp=="list"):
		self.listVerbs()
	    elif(inp=="exit"):
		break
	    elif(inp=="max"):
		self.setNewMax()
	    elif(inp=="min"):
		self.setNewMin()
	    elif(inp=="help"):
		print self.instructions
	    else:
		print "Command \"%s\" unrecognized. Enter \"help\" (without the quotes) for help." % inp
	    print ""
	print "Thank you for using the Random Synopsis Generator!"

    def printVerbStatus(self):
	"""
	Prints the current status of
	the verb database, namely the
	total number of catalogued verbs
	and the current number of valid verbs
	"""

	print "Total Verb Count: %d" % len(self.verbs)
	print "Valid Verb Count: %d" % len(self.validVerbs())

    def getVerbs(self,dblocation):
	"""
	Given the file name of a list of verbs
	and their difficulties, this function
	opens the file, creates a new Verb
	object from each line, sorts the new
	list in order of difficulty (not the
	most essential task per se, but good
	practice) and returns it.
	"""

	f=open(dblocation)
	data=[i for i in f.read().split("\n") if len(i)>0]
	f.close()
	verbs=[Verb(i) for i in data]
	verbs=sorted(verbs, key=lambda v: v.difficulty)
	verbs.reverse()
	return verbs

    def randomSynopsis(self):
	"""Prints out a random verb, person, number, and voice"""

	verbs=self.validVerbs()
	if len(verbs)<1:
	    print "No verbs could be found satisfying the current minimum and maximum difficulty levels"
	    return

	verb=random.choice(verbs)
	person=random.choice(self.persons)
	number=random.choice(self.numbers)
	voice=random.choice(self.voices)

	print "Verb: %s" % verb.pparts
	print "Verb Difficulty: %s" % verb.difficulty
	print "Person: %s" % person
	print "Number: %s" % number
	print "Voice: %s" % voice

    def listVerbs(self):
	"""Lists all the currently catalogued verbs"""

	print "\n".join([str(i) for i in self.verbs])

    def randomVerb(self):
	"""
	Returns a random verb from the current
	list of verbs, given restrictions on
	minimum and maximum difficulty
	"""

	return random.choice(self.validVerbs())

    def validVerbs(self):
	"""
	Given the current restrictions (or lack
	of restrictions) on the minimum and maximum
	allowable values for returned verbs, returns
	a list of valid verbs to choose from.
	"""

	if self.maximum==None and self.minimum==None:
	    return self.verbs
	elif self.maximum==None:
	    return [i for i in self.verbs if i.difficulty>=self.minimum]
	elif self.minimum==None:
	    return [i for i in self.verbs if i.difficulty<=self.maximum]
	else:
	    return [i for i in self.verbs if self.minimum<=i.difficulty<=self.maximum]

    def setNewMin(self):
	"""
	Allows the user to set a new minimum value.
	The user can enter "." to set the value to
	(effectively) negative infinity, leave it
	blank to keep the current minimum value,
	or set a new custom minimum value.
	"""

	print "To set a new minimum value, type in the value and hit enter."
	print "To reset the minimum value (back to having no minimum value) enter \".\" (without the quotes) and hit enter."
	print "To keep the current minimum value, leave this field blank and hit enter."
	print "Current minimum value: %s" % self.minimum

	newMin=raw_input("Desired Value: ").strip()
	while newMin!="" and newMin!="." and not self.isValidFloat(newMin):
	    print "\"%s\" is an invalid entry. Please try again." % newMin
	    newMin=raw_input("Desired Value: ").strip()
	if self.isValidFloat(newMin):
	    self.minimum=float(newMin)
	elif newMin==".":
	    self.minimum=None

    def setNewMax(self):
	"""
	Allows the user to set a new maximum value.
	The user can enter "." to set the value to
	(effectively) positive infinity, leave it
	blank to keep the current maximum value,
	or set a new custom maximum value.
	"""

	print "To set a new maximum value, type in the value and hit enter."
	print "To reset the maximum value (back to having no maximum value) enter \".\" (without the quotes) and hit enter."
	print "To keep the current maximum value, leave this field blank and hit enter."
	print "Current maximum value: %s" % self.maximum

	newMax=raw_input("Desired Value: ").strip()
	while newMax!="" and newMax!="." and not self.isValidFloat(newMax):
	    print "\"%s\" is an invalid entry. Please try again." % newMax
	    newMax=raw_input("Desired Value: ").strip()
	if self.isValidFloat(newMax):
	    self.maximum=float(newMax)
	elif newMax==".":
	    self.maximum=None

    def isValidFloat(self,inp):
	"""Checks whether a given string can be converted to a float."""
	try:
	    float(inp)
	    return True
	except ValueError:
	    return False
	    
if(__name__=="__main__"):
    dblocation="db.txt"
    generator=SynopsisGenerator(dblocation)
    generator.generate()
