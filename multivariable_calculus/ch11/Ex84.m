function Ex84
  result = helper();
  printf("Resultant magnitude: %f; degrees: %f\n",
         result(1), rad2deg(result(2)));
endfunction

function VAL = helper()
  f1 = pol2comp(400, deg2rad(-30));
  f2 = pol2comp(280, deg2rad(45));
  f3 = pol2comp(350, deg2rad(135));
  w = f1 + f2 + f3;
  VAL = comp2pol(w);
endfunction
