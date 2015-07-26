import csv,math,random,sys
from operator import itemgetter
f = open('CPT2.txt'+str(sys.argv[1]),'w')

def printlist(lis):
	for x in lis:
		for y in x:
			f.write( '{:6}'.format(y))
		f.write('\n')
	f.write('\n')
	
filename = str(sys.argv[1]) # 'train-60.data'
with open('q3_data/'+filename) as myfile:
    reader = csv.reader(myfile, delimiter="\t")
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

def prob(x,D,I,gtab,stab,ltab):
	[diff,intel,grade,sat,letter]=x
	ind = diff + 2*intel
	ans = (D if diff==1 else 1-D)*(I if intel==1 else 1-I)
	ans *= (gtab[ind][grade-1])*(stab[intel][sat]);
	ans *= (ltab[grade-1][letter]); 
	return ans;

def calculatewt(e,D,I,gtab,stab,ltab,ind):
	if ind==0:
		l0 = prob([0]+e[1:],D,I,gtab,stab,ltab)
		l1 = prob([1]+e[1:],D,I,gtab,stab,ltab)
		return [l0/(l1+l0),l1/(l1+l0)];
	elif ind==1:
		l0 = prob(e[:1]+[0]+e[2:],D,I,gtab,stab,ltab)
		l1 = prob(e[:1]+[1]+e[2:],D,I,gtab,stab,ltab)
		return [l0/(l1+l0),l1/(l1+l0)];
	elif ind==2:
		l0 = prob(e[:2]+[1]+e[3:],D,I,gtab,stab,ltab)
		l1 = prob(e[:2]+[2]+e[3:],D,I,gtab,stab,ltab)
		l2 = prob(e[:2]+[3]+e[3:],D,I,gtab,stab,ltab)
		return [l0/(l2+l1+l0),l1/(l2+l1+l0),l2/(l2+l1+l0)]
	elif ind==3:
		l0 = prob(e[:3]+[0]+e[4:],D,I,gtab,stab,ltab)
		l1 = prob(e[:3]+[1]+e[4:],D,I,gtab,stab,ltab)
		return [l0/(l1+l0),l1/(l1+l0)]
	elif ind==4:
		l0 = prob(e[:4]+[0],D,I,gtab,stab,ltab)
		l1 = prob(e[:4]+[1],D,I,gtab,stab,ltab)
		return [l0/(l1+l0),l1/(l1+l0)]
	return [-1]

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

# print examples
iteration = 1

D=random.random(); # probability of diff = 1 (D1)
I=random.random(); # probability of intelligence = 1 (I1) 
gtab=[[random.random() for e in range(3)] for e in range(4)]
gtab = map(lambda x:map(lambda y:y/sum(x),x), gtab)
stab=[[random.random() for e in range(2)] for e in range(2)]
stab = map(lambda x:map(lambda y:y/sum(x),x), stab)
ltab=[[random.random() for e in range(2)] for e in range(3)]
ltab = map(lambda x:map(lambda y:y/sum(x),x), ltab)

oldgtab = gtab; oldD = 0;
oldstab = stab; oldI = 0;
oldltab = ltab;

while iteration<20:
	# topological order D,I,G,S,L
	# E step
	for i in xrange(0,int(length)):
		y,miss = data[i],-1
		for x in xrange(0,5):
			if y[x]==-1:
				miss=x
		if miss>-1:
			wts[i]=calculatewt(y,D,I,gtab,stab,ltab,miss)
			# assert( abs(sum(wts[i])-1.0)<0.000001 )

	# M STEP
	# assert(count(examples,[-1,-1,-1,-1,-1],wts)==length)
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

	diff=max(abs(oldD-D),abs(oldI-I));
	for i,a in enumerate(gtab):
		diff=max([diff]+[abs(x - y) for x, y in zip(oldgtab[i], a)]);
	for i,a in enumerate(stab):
		diff=max([diff]+[abs(x - y) for x, y in zip(oldstab[i], a)]);
	for i,a in enumerate(ltab):
		diff=max([diff]+[abs(x - y) for x, y in zip(oldltab[i], a)]);
	if diff<0.0001:
		break;
	iteration+=1

f.write("I"+str(I)) 
f.write("D"+str(D)) 
f.write("gtab")
printlist(gtab)
f.write("stab")
printlist(stab)
f.write("ltab")
printlist(ltab)

with open('q3_data/test.data') as myfile:
    reader = csv.reader(myfile, delimiter="\t")
    data = list(reader)

data = map(lambda x: map(lambda y:-1 if y=='?' else int(y),x), data )
length = 1.0*len(data);

logdata=logf(data);
f.write('log liklihood'+ str(logdata))
print logdata
f.close()
