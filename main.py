# This is a sample Python script.

import sys,os

def exe(command):
   try:
       if "cd " in command: # If the user wants to change directories
            x = command.split(" ")
            dir = x[1]
            change_dirdown(os.getcwd(),dir)

       elif "cd.."in command:
           change_dirup(os.getcwd())

       elif "|" in command: # If the user wants to create a pipe for two commands/// Move this else if to if > statement
           cms = command.split("|") #split into first command and second command
           c1 = cms[0].split(" ") #Split the first command by spaces to get the command and the flags
           c2 = cms[1].split(" ") #Split the second command by spaces to get the command and the flags

           r = os.fork() # Create the new process

           if r < 0: #Error
             print("Error")

           elif r == 0: #Child will only read
             os.dup2(pw,1,True)
             os.close(pw)
             os.execve("D:/Cygwin/bin/"+c1[0],[c1[0]],os.environ)
             os.close(1)

           else:# Parent
             os.dup2(pr, 0, True)
             os.close(pr)  # Parent process will only write
             os.execve("D:/Cygwin/bin/"+c2[1],[c2[1]],os.environ)
             os.close(0)
             return
       else:
           if ">" in command:
             redir = command.split(">")
             redir[1] = redir[1].replace(" ","")
             redir[0] = redir[0].replace(" ", "")
             sys.stdout = open(redir[1],'w')

           elif "<" in command:
             redir = command.split("<")
             redir[1] = redir[1].replace(" ","")
             sys.stdin = open(redir[1],'R')

           x = command.split(" ")
           cmnd = x[0]
           r = os.fork()
           if r < 0:
               print("There was an error with the fork")
           elif r == 0:
               os.execve("D:/Cygwin/bin/"+cmnd,x,os.environ)
           else:
               if "&" not in command:
                   os.wait()

               return
   except FileNotFoundError:
       print("The command was not found")

def change_dirdown(current,dir):
    try:
        os.chdir(current+"/"+dir)
    except NotADirectoryError:
        print("Could not find directory")

def change_dirup(current): #Change directory when the input is 0
    try:
        i = (len(current)-1)
        c=current[i]
        while c != "/":
            i -= 1
            c=current[i]

        newd = current[0:i]

        if newd != "D:":
            os.chdir(newd)
            return
        else:
            print("Can't go up in the directories")
            return
    except NotADirectoryError:
        print("Could not find directory")



dir = "D:/Cygwin/bin"
os.chdir(dir)

pr,pw = os.pipe()
sys.ps1="$$$"

while True:

    print(sys.ps1.encode())
    c = input()

    if c == "file":
        print("file path:")
        pth = input()
        f = open(pth,"r")
        for line in f:
            if "#" in line[0]:
                None
            else:
                exe(line)
            print(line)

#    elif c == "path":

    elif c == "quit":
        break

    else:
        exe(c)

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
