function VAL = comp2pol(vec)
  len = norm(vec);
  theta = atan(vec(2) / vec(1));
  VAL = [ len, theta ];
endfunction
