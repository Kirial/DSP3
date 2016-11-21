

% 1. Lavpas-filter til st�jreduktion (fjern noget hvid-st�j fra et talesignal)
% Indspil selv et talesignal i Matlab og tilf�j efterf�lgende hvid st�j til signalet i Matlab. 
% Analyser signalet f�r og efter tilf�jelse af hvid st�j � 
% og bestem de n�dvendige filterspecifikationer til et lavpas-filter, 
% s� kun de absolut n�dvendige talesignaler (med st�j oveni) kommer igennem filteret.
% Analyser signalet igen efter filtrering.




%function [] = dsp3_opg1_v1()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hvis man selv skal optage skal man bruge det funktion. 
% sample_freq = 48000;    %sample frequency 48 kHz 
% bits = 16;              %bits
% record_1 = audiorecorder(sample_freq,bits,1,1);
% disp('Start speaking.') 
% record(record_1);       % record
% record_time = 3.7;      % record time in sec 
% pause(record_time);     %
% stop(record_1);         % stop recording 
% disp('End of Recording.');
% play(record_1);         % afspil  
% pause(record_time);        
% audio_data = getaudiodata(record_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hvis man skal tage en eksisterende audio fil skal man bruge det 
audio_name = 'audio_klip.wav';              %talen 
sampling_freq = 48000;                      %samplings frekvens
T = 1/sampling_freq;                  %Tid mellem Samples 
audio_samples = [1,3.7*sampling_freq ];     %hvor lang tid der skal samples 
[audio_d,sampling_freq] = audioread(audio_name,audio_samples);
audio_data = audio_d(:,1)';
tid_data = 0:T:3.7-T;
% skal udkomenteres hvis det skal afspilles 
% sound(audio_data,sampling_freq);
% pause(3.7);                                 % hvis man vil afspile lyd s� s�t pause p� 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%% begynd p� tale analyse %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(tid_data,audio_data);
title('Tale plot')
xlabel('tid')
xlabel('amplitude')

%fft
audio_data_fft = fft(audio_data);
fft_freq = (0*(length(audio_data)-1))*(sampling_freq/length(audio_data)); 
figure

%end