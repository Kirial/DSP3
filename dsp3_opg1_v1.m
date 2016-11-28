

% 1. Lavpas-filter til støjreduktion (fjern noget hvid-støj fra et talesignal)
% Indspil selv et talesignal i Matlab og tilføj efterfølgende hvid støj til signalet i Matlab. 
% Analyser signalet før og efter tilføjelse af hvid støj – 
% og bestem de nødvendige filterspecifikationer til et lavpas-filter, 
% så kun de absolut nødvendige talesignaler (med støj oveni) kommer igennem filteret.
% Analyser signalet igen efter filtrering.


%function [] = dsp3_opg1_v1()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %hvis man selv skal optage skal man bruge det funktion. 
% sample_freq = 48000;    %sample frequency 48 kHz 
% bits = 16;              %bits
% record_1 = audiorecorder(sample_freq,bits,1,1);
% disp('Start speaking.') 
% record(record_1);       % record
% record_time = 3.8;      % record time in sec 
% pause(record_time);     %
% stop(record_1);         % stop recording 
% disp('End of Recording.');
% audio_d = getaudiodata(record_1);
% audio_d_long = audio_d(:,1)';
% audio_data = audio_d_long(1:177600);
% % play(record_1);         % afspil  
% % pause(record_time);        
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
% % skal udkomenteres hvis det skal afspilles 
% sound(audio_data,sampling_freq);
% pause(3.7);                        % hvis man vil afspile lyd så sæt pause på 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%% begynd på tale analyse %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,1,1)  
plot(tid_data,audio_data);
title('Tale plot')
xlabel('tid (s)')
ylabel('amplitude (V)')

%fft
audio_data_fft = fft(audio_data);
abs_audio_data = abs(audio_data_fft);
plot_signal = abs_audio_data(1:length(audio_data)/2+1); % vælger kun det interval som vi skal bruge 
fft_freq = (sampling_freq )*(0:(length(audio_data)/2))/length(audio_data); % frekvens resolution 
subplot(2,1,2) 
plot(fft_freq, plot_signal)
xlabel('Freqvens (Hz)')
ylabel('Magnitude')

%tilførsel af støj 
noise_audio_data = awgn(audio_data,15);
% %hvis man skal afspille data med støj skal man udkomentere de næste 2 linje 
% sound(noise_audio_data,sampling_freq);
% pause(3.7); 

figure
subplot(2,2,1)  
plot(tid_data,noise_audio_data);
title('Tale plot med støj')
xlabel('tid (s)')
ylabel('amplitude (V)')

%fft med støj
noise_audio_data_fft = fft(noise_audio_data); 
subplot(2,2,3)
abs_noise = abs(noise_audio_data_fft);
noise_plot_signal = abs_noise(1:length(audio_data)/2+1);
plot(fft_freq,noise_plot_signal)
xlabel('Frekvens (Hz)')
ylabel('Magnitude')

%filter brug 
filter_noise_audio_data = filter(L_filter,noise_audio_data); 
subplot(2,2,2)  
plot(tid_data,filter_noise_audio_data);
title('Tale plot efter filter')
xlabel('tid (s)')
ylabel('amplitude (V)')

%fft med støj med filter 
filter_noise_audio_data_fft = fft(filter_noise_audio_data); 
subplot(2,2,4) 
filter_noise_abs = abs(filter_noise_audio_data_fft);
filter_noise_plot = filter_noise_abs(1:length(audio_data)/2+1);
plot(fft_freq,filter_noise_plot)
xlabel('Frekvens (Hz)')
ylabel('Magnitude')
% %hvis man skal afspille data med støj skal man udkomentere de næste 2 linje 
% sound(filter_noise_audio_data,sampling_freq);
% pause(3.7);


%end