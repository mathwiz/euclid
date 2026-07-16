function Ex81(deg)
  result = helper(deg);
  printf("magnitude: %f; degrees: %f\n",
         result(1), rad2deg(result(2)));
endfunction

function VAL = helper(theta)
  f1 = pol2comp(275, deg2rad(0));
  f2 = pol2comp(180, deg2rad(theta));
  w = f1 + f2;
  VAL = comp2pol(w);
endfunction
