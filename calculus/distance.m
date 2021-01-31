function d = distance(v1, v2)
  sum = 0;
  for i = 1:length(v1)
    sum += (v2(i) - v1(i))^2;
  endfor
  d = sqrt(sum);
end
