function Ex81
  print_result(0)
  print_result(30)
  print_result(60)
  print_result(90)
  print_result(120)
  print_result(150)
  print_result(180)
  
  plot_helper()
endfunction

function print_result(angle)
  result = helper(angle);
  printf("angle: %f; magnitude: %f; degrees: %f\n",
         angle, result(1), rad2deg(result(2)));
endfunction

function plot_helper()
  x = linspace(0, 180, 90);
  mags = results(x, 1);
  alphas = results(x, 2);
  hold off;
  [ax, h1, h2] = plotyy(x, mags, x, rad2deg(alphas));
  xlabel("Degrees");
  ylabel(ax(1), "Magnitude (Newtons)");
  ylabel(ax(2), "Direction Angle (Degrees)");
  title("Magnitude and Direction by Angle Between Vectors");
  printf("Plot finished.\n");
endfunction

function VAL = results(angles, index)
  vals = [];
  for theta = angles
    polar = helper(theta);
    vals = [ vals, polar(index) ];
  end
  VAL = vals;
endfunction

function VAL = helper(theta)
  f1 = pol2comp(275, deg2rad(0));
  f2 = pol2comp(180, deg2rad(theta));
  w = f1 + f2;
  VAL = comp2pol(w);
endfunction
