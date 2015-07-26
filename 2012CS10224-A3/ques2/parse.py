
fd = open('digitlabels.txt','r');
labels = fd.read()
fd.close()

fd = open('digitdata.txt','r');
data = fd.read();
fd.close()

data = map(lambda x: x.split(' ')[1:], data.split('\n')[1:]);
labels = map(lambda x: x.split(' ')[1:],labels.split('\n')[1:]);

# print len(data),len(labels)

for x in xrange(0,len(labels)):
	print reduce(lambda a, b:a+' '+b,  labels[x]+data[x])
