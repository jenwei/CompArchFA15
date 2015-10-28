# Deliverable 5 Functions
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
        
def genRegList(n):
    for i in range(1,n):
        print "register32 reg%d(RegOut%d,WriteData,DecodeOut[%d],Clk);" %(i,i,i)
        
# Deliverable 7/8 Functions
if __name__ == '__main__':
    #5
    #genInputStr(32)
    #genInputList(32)
    #genAssignList(32)
    
    #7/8
    genRegList(32)
