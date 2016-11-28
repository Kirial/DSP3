% %opgave 4
% 
% 4. Højpasfilter til at finde triggerpunkt for EKG signal (ekg signal fra øvelse 1)
% Anvendt EKG signalet fra øvelse 1 – og proces signalet gennem et højpasfilter 
% så man kan finde et passende ’triggerpunkt’ til at bestemme bestemte steder på signalet. 
% Implementer filteret i Matlab og dokumenter designet.

%function [] = dsp3_opg4_v1()
load('nervesignal3.mat');
% convert cell to double 
new_nsVector = cell2mat(nsVector);
amplitude_EKG = repmat(new_nsVector(:,1)',1,4);
EKG_length = length(amplitude_EKG);
f_sample = 96;
tid_EKG = 0:(1/f_sample):((EKG_length/f_sample)-(1/f_sample));
figure
subplot(2,2,1)
plot(tid_EKG,amplitude_EKG);
xlabel('tid (s)')
ylabel('amplitude (mV)')

%fft
EKG_fft = fft(amplitude_EKG);
pos_fft = abs(EKG_fft);
plot_signal = pos_fft(1:EKG_length/2+1);
EKG_x =  (f_sample)*(0:(EKG_length/2))/EKG_length;
subplot(2,2,3)
plot(EKG_x,plot_signal);
xlabel('Frekvens (Hz)')
ylabel('Magnitude')

this_signal = filter(opg4_filter, amplitude_EKG);
subplot(2,2,2)
plot(tid_EKG,this_signal);
xlabel('tid (s)')
ylabel('amplitude (mV)')
this_signal_fft = fft(this_signal);
P4 = abs(this_signal_fft);
P3 = P4(1:EKG_length/2+1);
subplot(2,2,4)
plot(EKG_x,P3);
xlabel('Frekvens (Hz)')
ylabel('Magnitude')

figure 
plot(tid_EKG,amplitude_EKG);
hold
plot(tid_EKG,this_signal);
xlabel('tid (s)')
ylabel('amplitude (mV)')
legend('Original EKG','Filtreret EKG');
% %end