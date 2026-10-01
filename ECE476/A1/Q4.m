a_meters = 22.86*10^-3;
b_meters = 10.16*10^-3;
m = 2;
n=1;
t= 0;
c = 3*10^8;

k_cutoff_squared = (m*pi/a_meters)^2+(n*pi/b_meters)^2;
f_cutoff = c/(2*pi)*sqrt(k_cutoff_squared);

f = 22*10^9;
omega = f*2*pi;

beta = sqrt((omega/c)^2-k_cutoff_squared);
lambda_g = (2*pi)/beta;

%Wall 1 (x=0)
y = linspace(0, b_meters, 12);
z = linspace(0, 2*lambda_g, 40);
[Z, Y] = meshgrid(z, y);%Wall is 2d surface, need current value at every single point. makes the list of all (z, y) positions, so your formulas can be evaluated everywhere at once.          

Js1y = real(-cos(pi.*Y/b_meters) .* exp(-1j*beta.*Z) * exp(1j*omega*t));
Js1z = real(1j*beta*pi/(k_cutoff_squared*b_meters) .* sin(pi.*Y/b_meters) .* exp(-1j*beta.*Z) * exp(1j*omega*t));

figure
quiver(Z*1e3, Y*1e3, Js1z, Js1y, 0.6)   % positions in mm. quiver draws one arrow per point, using Jzfor the horizontal part and Jy for the vertical part.
xlabel('z (mm)'); ylabel('y (mm)'); title('Wall 1 (x = 0)')
axis tight
ylim([-1 b_meters*1e3 + 1])  

%Wall 2 (x=a)
Js2y = real(cos(pi.*Y/b_meters) .* exp(-1j*beta.*Z) * exp(1j*omega*t));
Js2z = real(-1j*beta*pi/(k_cutoff_squared*b_meters) .* sin(pi.*Y/b_meters) .* exp(-1j*beta.*Z) * exp(1j*omega*t));

figure
quiver(Z*1e3, Y*1e3, Js2z, Js2y, 0.6)  
xlabel('z (mm)'); ylabel('y (mm)'); title('Wall 2 (x = a)')
axis tight
ylim([-1 b_meters*1e3 + 1])

%Wall 3 (y = 0)
x = linspace(0,a_meters,25);
z = linspace(0, 2*lambda_g, 40);
[X,Z] = meshgrid(x,z);

Js3x = real(cos(2*pi*X/a_meters).*exp(-1j*beta*Z)*exp(1j*omega*t));
Js3z = real(-1*j*2*beta*pi/(k_cutoff_squared*a_meters).*sin(2*pi*X/a_meters).*exp(-1j*beta*Z)*exp(1j*omega*t));

figure
quiver(X*1e3, Z*1e3, Js3x, Js3z, 0.4)   
xlabel('x (mm)'); ylabel('z (mm)'); title('Wall 3 (y = 0)')
axis tight

%Wall 4 (y = b)
Js4x = real(cos(2*pi*X/a_meters).*exp(-1j*beta*Z)*exp(1j*omega*t));
Js4z = real(-1*j*2*beta*pi/(k_cutoff_squared*a_meters).*sin(2*pi*X/a_meters).*exp(-1j*beta*Z)*exp(1j*omega*t));

figure
quiver(X*1e3, Z*1e3, Js4x, Js4z, 0.4)   
xlabel('x (mm)'); ylabel('z (mm)'); title('Wall 4 (y = b)')
axis tight