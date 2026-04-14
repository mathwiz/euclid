function VAL = comp2pol(v)
  len = norm(v);
  theta = atan(v(2) / v(1));;
  VAL = [ len, theta ];
endfunction
