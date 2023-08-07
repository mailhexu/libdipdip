def get_module_name(fname):
    used_module=[]
    with open(fname) as myfile:
        for line in myfile:
            if line.strip().startswith("use"):
                l=line.split(" :,")
                l[1]
    
