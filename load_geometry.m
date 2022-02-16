function neighbors = load_geometry(L, dim)
    %input:  lattice size L (square, cube, ... lattice), spatial dimension dim
    %output: matrix neighbors, neighbors(i) is an array with all nearest
    %neighbors of lattice site i

    if dim==1
        lex = zeros(L, 1);
        neighbors = zeros(L, 2);

        for i= 1:L
            neighbors(i) = lex(mod(i,L)+1);
            neighbors(i) = lex(mod(i-2,L)+1);
        end
    elseif dim==2
        lex = zeros(L,L);
        x = zeros(L*L,1);
        y = zeros(L*L,1);
        neighbors = zeros(L*L,4);
    
        for i=1:L
            for j=1:L
                lex(i,j)=i+(j-1)*L;
                x(lex(i,j))=i;
                y(lex(i,j))=j;
            end
        end
    
        for i=1:L*L
            neighbors(i,1) = lex(mod(x(i),L)+1,y(i));
            neighbors(i,2) = lex(mod(x(i)-2,L)+1,y(i));
            neighbors(i,3) = lex(x(i),mod(y(i),L)+1);
            neighbors(i,4) = lex(x(i),mod(y(i)-2,L)+1);
        end
    else
        warning("Unsuitable dimension, currently only dim<=2 is supported")
    end
end

