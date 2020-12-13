% Move the reference file next to the qrs to compare
    
files = dir('Data/*.atr');
for file = files'
    a = copyfile(file)
    name = file.name(1 : end - 4);
    disp(name)
    movefile(strcat(name, '.atr'), 'Data1');
end
