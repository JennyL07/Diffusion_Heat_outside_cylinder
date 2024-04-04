% Diffusion outside a sphere
function c_sphere = Analytical_sphere(z_full,r)
    z_column = z_full';
    r_sphere = sqrt(r.^2 + z_column.^2);
    c_sphere = 1-1./r_sphere;
    c_sphere(r_sphere<=1) = 0;
end
