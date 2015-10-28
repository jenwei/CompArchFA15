def genInputStr(n):
    out = ""
    for i in range(n-1):
        out+="input%d," %i
    out+="input%d" %(n-1)
    print out
    
def genInputList(n):
    for i in range(n):
        print "input[31:0] input%d;"%i
    
def genAssignList(n):
    for i in range(n):
        print "assign mux[%d] = input%d;" %(i,i)
        
if __name__ == '__main__':
    genInputStr(32)
    genInputList(32)
    genAssignList(32)