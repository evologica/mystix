#!/usr/bin/python

doc = """CheckUnderlines
                by elite01-gmx-de

Usage: checkunderlines.py <file.ini>

Checks .ini files for d&uplicate &underlines in one [section]
If the duplicates are intended, use:
#ENDSECT to simulate a new section.
#SKIP to skip all lines until #STOPSKIP is found
Redistribution in original and changed, compiled and source form is allowed provided that this notice is preserved and, if distributing in compiled form, the source used to compile the program is shipped with the executable."""

import sys

if len(sys.argv) != 2:
	print doc
	sys.exit()

file = open(sys.argv[1], "r")

chars = {}

section = "<Unknown>"
skip = False
thingsAreFine = True

for line in file:
	line = line.strip()
	if len(line) == 0:
		continue
	if line == '#STOPSKIP':
		skip = False
		continue
	if skip: continue
	if line == '#SKIP':
		skip = True
		continue
	if line == '#ENDSECT':
		chars = {}
		continue
	if line[0] == '[':
		section = line[1:-1]
		chars = {}
		continue
	if line[0] == '#':
		continue
	equalsindex = line.find('=')
	if equalsindex != -1:
		value = line[equalsindex + 1:]
		andindex = value.find('&')
		if andindex != -1:
			char = value[andindex + 1]
			ampCount = value.count('&')
			if ampCount > 1:
				print "There are %i ampersands in '%s'. I'm ignoring all but the first one." % (ampCount, value)
			if value[-1] == '&':
				print "The last character in '%s' is an ampersand." % (value)
				if ampCount == 1:
					continue
			if chars.has_key(char):
				print "%s in %s: '%s' (previously: '%s')" % (char, section, value, chars[char])
				thingsAreFine = False
			else:
				chars[char] = value
file.close()

if thingsAreFine:
	print """Congratulations!

Things seem to be fine. That doesn't mean they are fine, but if you haven't used #SKIP too often, there's a good chance they are."""
