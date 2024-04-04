% Extend negative z direction by symmetry
function [c_full,z_full] = extend_z(c,z)
    c_down = flip(c(:,2:end),2);
    z_down = -flip(z(2:end));
    z_full = [z_down, z];
    c_full = [c_down, c];
end
