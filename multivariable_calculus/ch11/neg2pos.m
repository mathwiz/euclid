function VAL = neg2pos(theta)
  t = rem(theta, 2*pi);
  pos = t + 2 * pi;
  if (pos > pi) 
    VAL = pos - pi; 
  else
    VAL = pos; 
  end; 
endfunction
