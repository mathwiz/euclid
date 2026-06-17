function VAL = rad2deg(theta)
  t = rem(theta, 2*pi);
  VAL = t * 180 / pi;
endfunction
