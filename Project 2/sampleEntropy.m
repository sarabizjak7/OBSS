function se = sampleEntropy(sig,m,r)

N = length(sig);
r = r * std(sig);

A = 0; % # of matches of length m-1
B = 0; % # of matches of length m

for i = 1:N-m-1
  for j = i+1:N-m-1
    match = 1;
    for k = 1:m-1
      if abs(sig(i+k)-sig(j+k)) > r
	match = 0;
	break;
      end
      if match == 1
	B = B + 1;
	if abs(sig(i+m)-sig(j+m))<r
	  A = A + 1;
	end
      end
    end
  end  
end

if A == 0 | B == 0
  se = -log((N-m)/(N-m-1));
else
  se = -log(A/B);
end

end