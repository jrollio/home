#!/bin/python

##
# https://github.com/nkmk/python-snippets/blob/9aa92683cc6f1d557dbbc6eed7b9aca593a9142c/notebook/file_io_with_open.py
##

import re
import sys


c = l = ''
srchStr = re.compile('^[^#].*local\ userpart')

with open(sys.argv[1]) as f:
    c = f.read().replace('\\\n','')
    m = re.search(r'^[^#].*local userpart', c)
    # print(type(c),c,l)
    if str.find(c,'^[^#].*local userpart') > -1:
        print(c)
    l += c
    c = ''

# print((re.search('^[^#].*local\ userpart', l)).group(0))
# print(type(l),len(l),l)
f.close()


with open(sys.argv[1]) as g:
    # lines = g.read().replace('\\\n','')
    lines = g.readlines()
    g.close()
i=0
for ln in lines:
    # sys.stdout.write(ln)
    print(ln.replace('\\\n',''))
# print((re.search('^[^#].*local\ userpart', l)).group(0))
# print(type(l),len(l),l)

#with open(sys.argv[1], encoding='utf-8') as fp:
#    for line_no, line in enumerate(fp,1):
#        print(line_no, line)
#        print(line.removesuffix('\\\n'))

#print([for line in open(sys.argv[1],'r',encoding='utf-8').read()])
# for line in open(sys.argv[1],'r',encoding='utf-8'):
#     print(line.rstrip('\\\n'),end='')


    # print(f.read().replace('\\\n',''))

    # s = f.read()
    # print(s.replace('\\\n',''))
    # t = f.readline()
    # u = f.readlines()
    # print(type(f),f.read())
    # print(type(s),s)

# for line_no, line in enumerate(l,1):
#     print(line_no,line)
# print(s)
# print(t)
# print(u[0])



# with open(path) as f:
#     s = f.read()
#     print(type(s))
#     print(s)
# # <class 'str'>
# line 1
# line 2
# line 3

# with open(path) as f:
#     s = f.read()
