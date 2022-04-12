from pyvis.network import Network
import pandas as pd
net = Network()

#Building Org Hierarchy

#Step 1 --> Read Data
df=pd.read_csv("D:\PythonProjects\Data\OrgHierarchyNames.csv")

#Find unique Employees (Nodes)

uniqval=df.apply(pd.unique)
arr=[]
for items in uniqval:
    for i in items:
        arr.append(i)
arr = [x for x in arr if pd.notnull(x)]
nodes=set(arr)

#Find relationship among employees (Edges)

#Hierarchy depth
hdepth=len(df.columns)-1
colnames=df.columns


rel=[]
i=0
while (i<hdepth):
    rel.append(list(zip(df[colnames[i]], df[colnames[i+1]])))
    i += 1


refinedrel=[]
for i in range(hdepth):
    for a,b in rel[i]:
        if(str(a) != 'nan' and str(b) !='nan'):
            refinedrel.append(tuple([a,b]))

edges=set(refinedrel)



