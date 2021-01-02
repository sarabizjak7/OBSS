% TESTING RESULTS

files = dir('Data/*.atr');
for file = files'
    name = file.name(1 : end - 4);
    file_name = sprintf('Data/%s', name);
    bxb(file_name, 'atr', 'qrs', 'test.txt') 
end