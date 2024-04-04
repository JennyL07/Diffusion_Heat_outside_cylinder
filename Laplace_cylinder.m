function [c] = Laplace_cylinder(Nr, Nz, L, a, r, z)

    dr = r(2)-r(1);
    dz = z(2)-z(1);

    NumNodes = Nr * Nz;
    A   = sparse(NumNodes, NumNodes);
    RHS = zeros(NumNodes,1);

    Node = zeros(Nr, Nz);
    Node(1:NumNodes) = [1:NumNodes];

    % Surface index
    ind_zs = find(z<=L, 1, 'last' );
    ind_rs = find(r<=a, 1, 'last' );

    % Central region ------------------------------------------------------
    for i = ind_rs+1:Nr-1
        for j = 2:Nz-1
            ANode_i = Node(i,j);  

            A(ANode_i, Node(i-1, j  ) ) = -(1/r(i))*(0.5/dr) + 1/dr^2;
            A(ANode_i, Node(i  , j  ) ) = - 2/dr^2 - 2/dz^2;
            A(ANode_i, Node(i+1, j  ) ) =  (1/r(i))*(0.5/dr) + 1/dr^2;

            A(ANode_i, Node(i  , j-1) ) =  1/dz^2;
            A(ANode_i, Node(i  , j+1) ) =  1/dz^2;
        end
    end
    for i = 2:Nr-1
        for j = ind_zs+1:Nz-1
            ANode_i = Node(i,j);  

            A(ANode_i, Node(i-1, j  ) ) = -(1/r(i))*(0.5/dr) + 1/dr^2;
            A(ANode_i, Node(i  , j  ) ) = - 2/dr^2 - 2/dz^2;
            A(ANode_i, Node(i+1, j  ) ) =  (1/r(i))*(0.5/dr) + 1/dr^2;

            A(ANode_i, Node(i  , j-1) ) =  1/dz^2;
            A(ANode_i, Node(i  , j+1) ) =  1/dz^2;
        end
    end

    % Boundary condition --------------------------------------------------
    % Surface and inside cylinder
    for i = 1:ind_rs
        for j = 1:ind_zs
            ANode_i = Node(i,j);
            A(ANode_i, Node(i, j)) = 1;
            RHS(ANode_i) = 1;
        end
    end

    % Far-field 
    j = Nz;
    for i = 1:Nr
        ANode_i = Node(i,j);
        A(ANode_i, Node(i, j)) = 1;
    end
    i = Nr;
    for j = 1:Nz
        ANode_i = Node(i,j);
        A(ANode_i, Node(i, j)) = 1;
    end

    % Neumann at r=0, z>L (phi symmetry)
    ind_zl = find(z>L, 1, 'first' );
    i = 1;
    for j = ind_zl:Nz
        ANode_i = Node(i,j);
        A(ANode_i, Node(i  , j  )) = -1;
        A(ANode_i, Node(i+1, j  )) = 1;
    %     A(ANode_i, Node(i  , j  )) = 1;
    %     RHS(ANode_i) = 1;
    end
    % Neumann at z=0, r>a (z<0 and z>0 symmetry)
    ind_ra = find(r>a, 1, 'first' );
    j = 1;
    for i = ind_ra:Nr
        ANode_i = Node(i,j);
        A(ANode_i, Node(i  , j  )) = -1;
        A(ANode_i, Node(i  , j+1)) = 1;
    %     A(ANode_i, Node(i  , j  )) = 1;
    %     RHS(ANode_i) = 1;
    end

    c_vector = A\RHS;
    c_matrix = reshape(c_vector, Nr, Nz);
    c = 1 - c_matrix;
end
