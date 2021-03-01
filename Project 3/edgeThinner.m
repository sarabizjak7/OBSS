function edg = edgeThinner(Ang,mag)
  
  n = 2; 
  m = 2;
  edg = mag(n, m);
  ang = Ang(n ,m);
 
  if ang == 0 || abs(ang) == 3.1
        edg = compare(mag(n, m), mag(n, m - 1), mag(n, m + 1));

  elseif abs(ang) == 1.6       
        edg = compare(mag(n, m), mag(n + 1, m), mag(n - 1, m));

  % horizontalno        
  elseif ang == 0.8 || ang == -2.4
        edg = compare(mag(n, m), mag(n + 1, m + 1), mag(n - 1, m - 1));  
   
  % vertikalno     
  elseif ang == 2.4 || ang == -0.8
        edg = compare(mag(n, m), mag(n + 1, m - 1), mag(n - 1, m + 1));
  else

  end
    
end