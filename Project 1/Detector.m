function Detector(record)
  % Summary of this function and detailed explanation goes here

  % First convert the record into matlab (creates recordm.mat):
  % wfdb2mat -r record

  % Setting parameters in QRS DETECTOR function!!!
  
  file_name = sprintf('Data/%sm.mat', record);
  t = cputime();
  
  idx = QRSdetector(file_name);
  fprintf('Running time: %f\n', cputime() - t);
  
  % Writting asc file
  asci_name = sprintf('%s.asc', record); 
  fid = fopen(asci_name, 'wt');  
  for i = 1 : size(idx, 2)
      fprintf(fid, '0:00:00.00 %d N 0 0 0\n', idx(1, i));
  end 
  fclose(fid);
  movefile(strcat(record, '.asc'), 'Data');

  % Now convert the .asc text output to binary WFDB format:
  % wrann -r record -a qrs <record.asc
  % And evaluate against reference annotations (atr) using bxb:
  % bxb -r record -a atr qrs
  
  rec = sprintf('Data/%s', record);
  wrann(rec, 'qrs', idx(1, :)'); 
end