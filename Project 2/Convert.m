% Convert all files from .dat to .mat (from Data folder)

files = dir('Data/*.dat');
for file = files'
    name = file.name(1 : end - 4);
    namestr = strcat('Data/', name);
    wfdb2mat(namestr);
    movefile(strcat(name, 'm.mat'), 'Data');
    movefile(strcat(name, 'm.hea'), 'Data');
end
