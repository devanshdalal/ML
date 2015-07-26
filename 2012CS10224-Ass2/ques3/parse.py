filename = raw_input()
f = open(filename,'r')
filedata = f.read()
f.close()

# Replace the target string
filedata=filedata.replace('republican', '0')
filedata=filedata.replace('democrat', '1')
filedata=filedata.replace('y', '1')
filedata=filedata.replace('n', '2')
filedata=filedata.replace('?', '3')
print filedata