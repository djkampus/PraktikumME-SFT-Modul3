%unfinished block for Eplane%
c=3e8;%agar bisa pakai Hz
f=300000;%frekuensi kerjadalam Hz
lambda=c/f;%menentukan panjang gelombang
eta=377;%impedansi ruang bebas
I=1e5;%arus maksimum masuk antena
l=lambda/2;%panjang antena. bisa berubah
k=(2*pi)/lambda;%wavenuber
theta=(0:0.01:2*pi);%sudut elevasi
r=10*lambda;%radius spherical coordinate/ bisa dibilang magnitude.
%sebentar magnitude disini faedahnya apa? 

%rumus Eplane. bisa diganti sin ke cos
Eplane=((1j*eta*I*exp(-1j*k.*r))/(4*pi.*r)).*cos(theta);
%unfinished block for Eplane%

%unfinished array factor%
N=5;%jumlah array antena
d=40;%jarak antar elemen array
beta=pi/2;%fase eksitasi
psi=k*d*cos(theta)+beta;
AF=(1/N)*((sin((N/2)*psi))./sin((1/2)*psi));
%unfinished array factor%

%ETotal radiasi kombinasi belum diconvert ke dB
Etotal=Eplane.*AF;

%Power pattern dan konversi magnitude ke dB
rtheta=abs(Eplane);%bisa Eplane atau AF
Rtheta=10*log10(rtheta);

%pembentukan matrix
phi_matrix=[];
for iterator=0:0.01:2*pi
    phi_matrix=[phi_matrix;0:0.01:2*pi];
end
theta_matrix=transpose(phi_matrix);
%pembentukan matrix

%konversi sphere-coord to cartesian
x=r .*cos(theta) .*cos(r);
y=r .*cos(theta) .*sin(r);
z=r .*sin(theta);

%plotting
%polarplot(Rtheta); ini sudah siap
polarplot(10*log10(abs(AF)))%tidak digabung konversinya ke dB dulu
