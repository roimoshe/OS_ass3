import sys,os
print("start test")
cmd = "make clean;"
# cmd +="print('<-------NONE------>');"
cmd += "make qemu-nox SELECTION=NONE;make clean;"
# cmd +="print('<-------AQ------>');"
cmd += "make qemu-nox SELECTION=AQ;make clean;"
# cmd +="print('<-------SCFIFO------>');"
cmd += "make qemu-nox SELECTION=SCFIFO;make clean;"
# cmd +="print('<-------LAPA------>');"
cmd += "make qemu-nox SELECTION=LAPA;make clean;"
# cmd +="print('<-------NFUA------>');"
cmd += "make qemu-nox SELECTION=NFUA;make clean;"

os.system(cmd)

# to run the script type : python3 run_all_selections.py