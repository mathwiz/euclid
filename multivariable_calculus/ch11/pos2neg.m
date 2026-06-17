function VAL = pos2neg(theta)
  t = rem(theta, 2*pi);
  neg = t - 2 * pi;
  if (neg < pi) 
    VAL = neg + pi; 
  else
    VAL = neg; 
  end; 
endfunction
