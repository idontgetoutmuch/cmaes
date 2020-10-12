#!/usr/bin/env python
import cma
import numpy as np
import sys

def sendline(str):
  msg = "<CMAES_WRAPPER_PY2HS> " + str + "\n"
  sys.stdout.write(msg)
  sys.stdout.flush()

def recvline():
  return sys.stdin.readline()

def communicator(xs):
  query = "q " + " ".join(map(str,xs))
  sendline(query)
  return float(recvline())


# set default options
opts = cma.Options()
opts['CMA_active'] = True
opts['tolfun'] = 0

# read initial guesses
initxs = list(map(float, recvline().split()))
# read the initial standard deviation
sigma = float(recvline())

# set additional option pairs
numberOfOpts = int(recvline())
for i in range(numberOfOpts):
  key = recvline().strip()
  val = recvline().strip()
  opts[key] = eval(val)

res = cma.fmin(communicator, initxs, sigma, **opts)

sendline("a " + " ".join(map(str,res[0])))
