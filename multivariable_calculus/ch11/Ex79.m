function Ex79
  f1 = pol2comp(2, deg2rad(33))
  f2 = pol2comp(3, deg2rad(-125))
  f3 = pol2comp(2.5, deg2rad(110))
  w = f1 + f2 + f3
  result = comp2pol(w);
  printf("vector: [%f, %f]; length: %f; theta: %f\n", w(1), w(2), 
         result(1), result(2));
  printf("vector: [%f, %f]; length: %f; degrees: %f\n", w(1), w(2), 
         result(1), rad2deg(result(2)));
endfunction
