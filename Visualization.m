clear
clc

a = 1; % Radius
L = 1; %length
rmax = 40;
zmax = 40;

%% One example
N = 201; Nr = N; Nz = N;
r = linspace(0,rmax,Nr);
z = linspace(0,zmax,Nz);

c_cylinder = Laplace_cylinder(Nr, Nz, L, a, r, z); % solution in z>0,r>0 
[c_full,z_full] = extend_z(c_cylinder, z); % solution in r>0, all z
c_sphere = Analytical_sphere(z_full,r); % solution for a sphere

%% Visual concentration fields: cylinder 
figure
pcolor(r,z_full, c_full')
caxis([0,1])
shading interp
colorbar
axis equal
xlim([0,10])
ylim([-10,10])
xlabel('r')
ylabel('z')
title('C_c_y_l_i_n_d_e_r')
set(gca,'Fontsize', 16)

%% Visual concentration fields: cylinder and sphere
figure
subplot(1,2,1)
pcolor(r,z_full, c_full')
caxis([0,1])
shading interp
colorbar
axis equal
xlim([0,rmax])
ylim([-zmax,zmax])
xlabel('r')
ylabel('z')
title('C_c_y_l_i_n_d_e_r')
set(gca,'Fontsize', 16)
% Compare with sphere
subplot(1,2,2)
pcolor(r,z_full, c_sphere)
caxis([0,1])
shading interp
colorbar
axis equal
xlim([0,rmax])
ylim([-zmax,zmax])
xlabel('r')
ylabel('z')
title('C_s_p_h_e_r_e')
set(gca,'Fontsize', 16)

%% Visual difference with sphere
figure
c_difference = abs(c_sphere-c_full');
subplot(1,2,1)
pcolor(r,z_full, c_difference)
colormap(flipud(bone))
shading interp
colorbar
axis equal
xlim([0,rmax])
ylim([-zmax,zmax])
xlabel('r')
ylabel('z')
title('|C_s_p_h_e_r_e - C_c_y_l_i_n_d_e_r|')
set(gca,'Fontsize', 16)
subplot(1,2,2)
pcolor(r,z_full, c_difference)
colormap(flipud(bone))
shading interp
colorbar
axis equal
xlim([0,rmax])
ylim([-zmax,zmax])
xlabel('r')
ylabel('z')
title('|C_s_p_h_e_r_e - C_c_y_l_i_n_d_e_r|')
set(gca,'Fontsize', 16)
hold on
contour(r,z_full,c_difference, [0.02,0.02],'ShowText','on','linewidth',1,'color','k')
