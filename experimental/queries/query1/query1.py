# select sum(a) 
# from R 
# where b + c > 10

import sys

RELATION_SIZE = 50000

def main():
    a = []
    b = []
    c = []
    for idx in range(RELATION_SIZE):
        a.append(idx)
        b.append(2 * idx)
        c.append(4 * idx)
    
    ret = 0

    for idx in range(RELATION_SIZE):
        if not (b[idx] + c[idx] > 10):
            continue
        ret += a[idx]
    
    return ret
    
if __name__ == "__main__":
    if len(sys.argv) > 1:
        RELATION_SIZE = int(sys.argv[1])
    print(main())