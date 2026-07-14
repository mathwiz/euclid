function Ex80
  f1 = pol2comp(2, deg2rad(-10))
  f2 = pol2comp(4, deg2rad(140))
  f3 = pol2comp(3, deg2rad(200))
  w = f1 + f2 + f3
  result = comp2pol(w);
  printf("vector: [%f, %f]; length: %f; theta: %f\n", w(1), w(2), 
         result(1), result(2));
  printf("vector: [%f, %f]; length: %f; degrees: %f\n", w(1), w(2), 
         result(1), rad2deg(result(2)));
endfunction
