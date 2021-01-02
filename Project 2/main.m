%%% MAIN

% Rezultate entropij shranimo v celico, tako da je najprej ime posnetka,
% potem entropija za signal 3 in potem entropija za signal 2 za isti
% posnetek. Enako potem za ostale posnetke, samo da shranimo v naslednji
% "predalček"

files = dir('Data/*.mat');
Entr = cell(length(files), 3);
i = 1;
for file = files'
    name = file.name(1 : end - 5);
    [sig3, sig2] = entropy(name);
    Entr{i, 1} = name;
    Entr{i, 2} = sig3;
    Entr{i, 3} = sig2;
    i = i + 1;
end


% Entr{1,:} -- tko dobimo rezultat za entropijo enega posnetka (3. in 2.
% signal)