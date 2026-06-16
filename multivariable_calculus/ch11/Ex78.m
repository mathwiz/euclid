function Ex78
  u = pol2comp(45, deg2rad(20))
  v = pol2comp(32, deg2rad(-50))
  w = u + v;
  result = comp2pol(w);
  printf("vector: [%f, %f]; length: %f; theta: %f\n", w(1), w(2), 
         result(1), result(2));
endfunction
