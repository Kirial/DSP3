% %opgave 4
% 
% 4. Højpasfilter til at finde triggerpunkt for EKG signal (ekg signal fra øvelse 1)
% Anvendt EKG signalet fra øvelse 1 – og proces signalet gennem et højpasfilter 
% så man kan finde et passende ’triggerpunkt’ til at bestemme bestemte steder på signalet. 
% Implementer filteret i Matlab og dokumenter designet.

%function [] = dsp3_opg4_v1()
load('nervesignal2.mat');
figure
plot(nsVectorExp2(:,2),nsVectorExp2(:,1));

EKG_fft = fft(nsVectorExp2(:,1));
P2 = abs(EKG_fft);
P1 = P2(1:128/2+1);
EKG_x =  8*(0:(128/2))/128;
figure
plot(EKG_x,P1);
this_signal = filter(opg4_filter, nsVectorExp2(:,1));
figure
plot(this_signal);

%end