def plot(x, y, c=0):
  print(x, y, c)

j = 192
for i in range(384):
  plot(i, int(j))
  j -= .5

