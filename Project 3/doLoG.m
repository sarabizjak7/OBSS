 kernel = calcLoG(5.25); % produces kernel with size 31x31
 size(kernel)
 mesh(kernel); title('calcLoG(5.25)');
 figure;
 plot([-15:15],kernel(15,:)); title('cross-section of calcLoG(5.25) kernel');
 figure;
 kernelO = fspecial('log', 31, 5.25);
 mesh(kernelO); title('fspecial(''log'', 31, 5.25)');
 
 kernel = calcLoG(2.56);
 figure;
 mesh(kernel); title('calcLoG(2.56)');
 figure;
 kernelO = fspecial('log', 15, 2.56);
 mesh(-kernelO); title('fspecial(''log'', 23, 2.56)');