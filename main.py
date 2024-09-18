# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import threading,time

full = threading.Lock()
mutex = threading.Lock()

def producer(): # This is thread 2
 for x in range(1000):
  full.acquire() #acquires full after t1 releases
  mutex.acquire()

  print("put")
  time.sleep(1)

  full.release()
  mutex.release()

def consumer(): # This is thread 1
 for x in range(1000):
  mutex.acquire() #acquires mutex first and not full
  full.acquire()

  print("get")
  time.sleep(1)

  mutex.release() # changing the order in which I release here will allow each thread to aqcuire only one lock
  full.release() # causing deadlock since t2 may acquire full and t1 may acquire mutex


t1 = threading.Thread(target= consumer,)
t2 = threading.Thread(target= producer,)
t1.start()
t2.start()


# See PyCharm help at https://www.jetbrains.com/help/pycharm/
