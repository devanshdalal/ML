import csv,math,random,sys
from operator import itemgetter

def printlist(lis):
	for x in lis:
		for y in x:
			print '{:15}'.format(y),
		print
	print 

filename = 'train-0.data'
with open('q3_data/'+filename) as f:
    reader = csv.reader(f, delimiter="\t")
    data = list(reader)

data = map(lambda x: map(lambda y:-1 if y=='?' else int(y),x), data )
length = 1.0*len(data);

# printlist(data[:100])

examples = [ [] for i in data ]
wts = [ [] for i in data ]
for j,x in enumerate(data):
	[d,i,g,s,l] = x
	index, val = min(enumerate(x), key=itemgetter(1))
	if val>-1:
		examples[j]+=[tuple(x)]
		wts[j]+=[1.0]
	else:
		if index==2:
			examples[j]=[(d,i,1,s,l),(d,i,2,s,l),(d,i,3,s,l)]
			wts[j]=[1.0/3,1.0/3,1.0/3]
		else:
			x[index]=0
			examples[j],wts[j],x[index]=[tuple(x)],[0.5,0.5],1
			examples[j]+=[tuple(x)]
			x[index]=-1

# exit(0)
#  log liklihood
def logf(data):
	ans = 0.0
	for i,x in enumerate(data):
		[diff,intel,grade,sat,letter]=data[i]
		ans += math.log(D if diff==1 else 1-D) + math.log(I if intel==1 else 1-I)
		ind = diff + 2*intel
		ans += math.log(gtab[ind][grade-1]) + math.log(stab[intel][sat]);
		ans += math.log(ltab[grade-1][letter]); 
	return ans;

D=0; # probability of diff = 1 (D1)
I=0; # probability of intelligence = 1 (I1) 
gtab=[[0 for e in range(3)] for e in range(4)]
stab=[[0 for e in range(2)] for e in range(2)]
ltab=[[0 for e in range(2)] for e in range(3)]

def prob(x,D,I,gtab,stab,ltab):
	[diff,intel,grade,sat,letter]=x
	ind = diff + 2*intel
	ans = (D if diff==1 else 1-D)*(I if intel==1 else 1-I)
	ans *= (gtab[ind][grade-1])*(stab[intel][sat]);
	ans *= (ltab[grade-1][letter]); 
	return ans;

def count(examples,template,wts):
	def my_condition(t):
		for x in xrange(0,5):
			if template[x]>-1 and template[x]!=t[x]:
				return False
		return True
	accu=0.0;
	for i,x in enumerate(examples):
		lis=[wts[i][j] for j,y in enumerate(x) if my_condition(y)]
		accu+=sum(lis)
	return accu

D = count(examples,[1,-1,-1,-1,-1],wts)/count(examples,[-1,-1,-1,-1,-1],wts)
I = count(examples,[-1,1,-1,-1,-1],wts)/count(examples,[-1,-1,-1,-1,-1],wts)
for x in xrange(0,3):
	for y in xrange(0,2):
		for z in xrange(0,2):
			gtab[2*y+z][x]=count(examples,[z,y,x+1,-1,-1],wts)/count(examples,[z,y,-1,-1,-1],wts);
for x in xrange(0,2):
	for y in xrange(0,2):
		stab[y][x]=count(examples,[-1,y,-1,x,-1],wts)/count(examples,[-1,y,-1,-1,-1],wts);
for x in xrange(0,2):
	for y in xrange(0,3):
		ltab[y][x]=count(examples,[-1,-1,y+1,-1,x],wts)/count(examples,[-1,-1,y+1,-1,-1],wts);

print "D",D 
print "I",I 
print "gtab"
printlist(gtab)
print "stab"
printlist(stab)
print "ltab"
printlist(ltab)

with open('q3_data/test.data') as f:
    reader = csv.reader(f, delimiter="\t")
    data = list(reader)

data = map(lambda x: map(lambda y:-1 if y=='?' else int(y),x), data )
length = 1.0*len(data);

print "log liklihood", logf(data)