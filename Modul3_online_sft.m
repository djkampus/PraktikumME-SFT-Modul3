%unfinished block for Eplane%langsung gerak ke penugasan
%using spec B
c=3e8;%agar bisa pakai Hz
f=3e9;%frekuensi kerjadalam Hz
lambda=c/f;%menentukan panjang gelombang
eta=377;%impedansi ruang bebas
I=1;%arus maksimum masuk antena
l=lambda/2;%panjang antena. bisa berubah
k=(2*pi)/lambda;%wavenuber
theta=(0:0.01:2*pi);%sudut elevasi
r=10*lambda;%radius spherical coordinate/ bisa dibilang magnitude.
%sebentar magnitude disini faedahnya apa? 

%rumus Eplane. bisa diganti sin ke cos%rumus langsung ke penugasan
Eplane=((1j*eta*I*exp(-1j*k.*r))/(4*pi.*r)).*cos(theta);
%unfinished block for Eplane%

%unfinished array factor%
N=16;%jumlah array antena
d=lambda/2;%jarak antar elemen array/spacingnya lambda/2
beta=0;%fase eksitasi
psi=k*d*cos(theta)+beta;
AF=(1/N)*((sin((N/2)*psi))./sin((1/2)*psi));
%unfinished array factor%

%ETotal radiasi kombinasi belum diconvert ke dB
Etotal=Eplane.*AF;

%Power pattern dan konversi magnitude ke dB
rtheta=abs(Eplane);%bisa Eplane atau AF
Rtheta=10*log10(rtheta);

%Rnormalisasi
Rnorm=Rtheta-min(Rtheta);
%Rnorm perlu dinolkan di 1,1 sebelum plotting
Rnorm(1,1)=0;
%pembentukan matrix
phi_matrix=[];
for iterator=0:0.01:2*pi
    phi_matrix=[phi_matrix;0:0.01:2*pi];
end
theta_matrix=transpose(phi_matrix);
%bentuk matriks Rnorm
Rnorm_matrix=[];
for i=1:629
    for k=1:629
        Rnorm_matrix(k,i)=Rnorm(1,k);
    end
end
%pembentukan matrix


%konversi sphere-coord to cartesian
phi=(0:0.01:2*pi);
x=Rnorm_matrix .*cos(theta_matrix) .*cos(phi_matrix);
y=Rnorm_matrix .*cos(theta_matrix) .*sin(phi_matrix);
z=Rnorm .*sin(theta_matrix);

%plotting
%polarplot(Rtheta); ini sudah siap
polarplot(10*log10(abs(AF)))%tidak digabung konversinya ke dB dulu
