# select sum(a) 
# from R 
# where b + c > 10

def main():
    a = []
    b = []
    c = []
    for idx in range(1024):
        a.append(idx)
        b.append(2 * idx)
        c.append(4 * idx)
    
    ret = 0

    for idx in range(1024):
        if not (b[idx] + c[idx] > 10):
            continue
        ret += a[idx]
    
    return ret
    
if __name__ == "__main__":
    print(main())