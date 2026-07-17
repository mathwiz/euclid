function Ex82
  result = helper();
  printf("Resultant magnitude: %f; degrees: %f\n",
         result(1), rad2deg(result(2)));
endfunction

function VAL = helper()
  f1 = pol2comp(500, deg2rad(30));
  f2 = pol2comp(200, deg2rad(-45));
  w = f1 + f2;
  VAL = comp2pol(w);
endfunction
