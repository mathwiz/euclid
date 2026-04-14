function Ex77
  result = ex77_helper(1, pi/6, 1, pi/3);
  printf("vector: [%f, %f]; length: %f; theta: %f\n", result(1),
         result(2), result(3), result(4));
endfunction

function VAL = ex77_helper(ulen, utheta, vlen, vtheta)
  u = pol2comp(ulen, utheta);
  v = pol2comp(vlen, vtheta);
  w = sum(u, v);
  VAL =  [w, comp2pol(w)];
endfunction

