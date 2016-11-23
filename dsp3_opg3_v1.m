% % opgave 3
% 
% Båndstop filter til fjernelse af brumsignal
% I folderen ’Signaler_til_opgave3’ ligger et signal med indlejret brum. 
% Analyser signalet og bestem de nødvendige filterspecifikationer så brummen fjernes. 
% Implementer filteret i Matlab og dokumenter designet.

%function [] = dsp3_opg3_v1()


load('opg3_signal.mat')

plot(myRecording);


%sound(myRecording, 8000);
%pause(5);
fft_recording = fft(myRecording);
figure
plot (abs(fft_recording));
beh_recording = filter(brummefilter, myRecording);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Export signal to Wav file.
% Fs = 8000;
% filename = 'handel.wav';
% audiowrite(filename,myRecording,Fs);
% clear y Fs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hvis man skal tage en eksisterende audio fil skal man bruge det 
audio_name = 'handel.wav';              %talen 
sampling_freq = 8000;                   %samplings frekvens
T = 1/sampling_freq;                    %Tid mellem Samples 
audio_samples = [1,2.4*sampling_freq ]; %hvor lang tid der skal samples 
[audio_d,sampling_freq] = audioread(audio_name,audio_samples);
brummen = audio_d(:,1)';
tid_data = 54.8:T:57.5-T;
% % skal udkomenteres hvis det skal afspilles 
%sound(brummen,sampling_freq);
% pause(3.7);                        % hvis man vil afspile lyd så sæt pause på 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure 
fft_brummen = fft(brummen);
plot (abs(fft_brummen));
title('tru shit');

filter_u_brum = filter(crazy, myRecording);
sound(filter_u_brum);
pause(10);
clear sound

figure
plot (brummen);
figure
plot (abs(brummen));

