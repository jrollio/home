#!/bin/python

import re
import sys

#with open(sys.argv[1], encoding='utf-8') as fp:
#    for line_no, line in enumerate(fp,1):
#        print(line_no, line)
#        print(line.removesuffix('\\\n'))

#print([for line in open(sys.argv[1],'r',encoding='utf-8').read()])
for line in open(sys.argv[1],'r',encoding='utf-8'):
    print(line.rstrip('\\\n'),end='')
