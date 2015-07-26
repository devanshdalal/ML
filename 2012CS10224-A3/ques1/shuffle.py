import random
def chunks(l, n):
	n=len(l)/n
	for i in xrange(0, len(l), n):
		yield l[i:i+n]

def write(cfile,data):
	with open(cfile,'w') as target:
		for _, line in data:
			target.write( line )

with open('20ng-rec_talk.txt','r') as source:
	data = [ (random.random(), line) for line in source ]
data.sort()
data = list(chunks(data,5));

for x in xrange(0,5):
	lis=[];
	for y in xrange(0,5):
		if y==x:
			continue
		lis = lis + data[y]
	write('train'+str(x+1) , lis )
	write('test'+str(x+1) , data[x] )
