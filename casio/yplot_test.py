import casioplot as scr

def show():
  scr.show_screen()

def xy(x, y, c='k'):
  scr.set_pixel(x, 192-y, color(c))

def color(c):
  cols = {
    'k': (0,0,0),
    'r': (255,0,0),
    'g': (0,255,0),
    'b': (0,0,255),
    'v': (127,0,255),
    'y': (255,255,0),
    'o': (255,128,0),
    'm': (255,0,255),
    'c': (128,128,128)
  }
  if not c in cols:
    return (0,0,0)
  else:
    return cols[c]

def allx(f):
  for i in range(384):
    f(i)


allx(lambda i: xy(i, int(i*.9), 'k'))
allx(lambda i: xy(i, int(i*.8), 'y'))
allx(lambda i: xy(i, int(i*.7), 'r'))
allx(lambda i: xy(i, int(i*.6), 'c'))
allx(lambda i: xy(i, int(i*.5), 'm'))
allx(lambda i: xy(i, int(i*.4), 'o'))
allx(lambda i: xy(i, int(i*.3), 'v'))
allx(lambda i: xy(i, int(i*.2), 'b'))
allx(lambda i: xy(i, int(i*.1), 'g'))
show()

