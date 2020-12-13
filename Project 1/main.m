% MAIN SCRIPT

files = dir('Data/*.mat');
for file = files'
    name = file.name(1 : end - 5);
    Detector(name);   
end