from math import floor

def h2d(h):
  while True:
    pass


def d2h(d):
  digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
  n = floor(d)
  h = ''
  while n != 0:
    h = digits[int(n % 16)] + h
    n = int(n / 16)
  return h

def d2dch(d):
  pass


print([ d2h(x) for x in range(15000,15020) ])
