import casioplot as scr

def myplot(x, y, c=0):
  scr.set_pixel(x, y, c)

j = 192
for i in range(384):
  myplot(i, round(j))
  j -= .5

scr.show_screen()
