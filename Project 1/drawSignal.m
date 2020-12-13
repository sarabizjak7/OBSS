function drawSignal(name,sig)
  
  sig_len = size(sig)(2);
  start_sig = max(1,0);
  end_sig = min(300000, sig_len); 

  figure('Name',name);
  plot(sig(start_sig:end_sig), 'b'); 
  hold on; %hold off;
    
end