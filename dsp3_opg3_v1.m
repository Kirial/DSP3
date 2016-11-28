% % opgave 3
% 
% Båndstop filter til fjernelse af brumsignal
% I folderen ’Signaler_til_opgave3’ ligger et signal med indlejret brum. 
% Analyser signalet og bestem de nødvendige filterspecifikationer så brummen fjernes. 
% Implementer filteret i Matlab og dokumenter designet.

load('opg3_signal.mat')
figure
plot(myRecording);
title('fft for udsnit af filen kun med brum.');


sound(myRecording, 8000);
pause(8);
clear sound
fft_recording = fft(myRecording);
figure
plot (abs(fft_recording));

%%%%%%%%%%%%% Hvis man ønsker at få signalet ud som en wave fil.%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Export signal to Wav file.
% Fs = 8000;
% filename = 'handel.wav';
% audiowrite(filename,myRecording,Fs);
% clear Fs


%%%%%% Udsnit af signalet for at analysere hvor der ikke er tale %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
audio_name = 'handel.wav';              %talen 
sampling_freq = 8000;                   %samplings frekvens
T = 1/sampling_freq;                    %Tid mellem Samples 
audio_samples = [1,2.4*sampling_freq ]; %hvor lang tid der skal samples 
[audio_d,sampling_freq] = audioread(audio_name,audio_samples);
brummen = audio_d(:,1)';
tid_data = 54.8:T:57.5-T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fft_brummen = fft(brummen);
figure
plot (abs(fft_brummen));
sound(brummen);
pause(2.7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equiripple Highpass filter designed using the FIRPM function.
% All frequency values are in Hz.
Fs = 8000;  % Sampling Frequency

Fstop = 130;             % Stopband Frequency
Fpass = 140;             % Passband Frequency
Dstop = 0.0001;          % Stopband Attenuation
Dpass = 0.057501127785;  % Passband Ripple
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop, Fpass]/(Fs/2), [0 1], [Dstop, Dpass]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
HP_Brum = dfilt.dffir(b);



%%%%%%%%%%% Test af HP_filter på udsnit uden tale 100-110 &&&&&&&&&&&&&&&&&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filter1_u_brum = filter(HP_Brum, brummen);
sound(filter1_u_brum);
pause(2.7);
clear sound

figure 
fft1_brummen = fft(filter1_u_brum);
plot (abs(fft1_brummen));
title('fft for udsnit af filen kun med brum.');

% %%%%%%%%%%% Test af LP_filter på udsnit uden tale 8000-8100 &&&&&&&&&&&&&&&&&
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Equiripple Lowpass filter designed using the FIRPM function.
% % All frequency values are in Hz.
% 
% Fpass = 8000;            % Passband Frequency
% Fstop = 8100;            % Stopband Frequency
% Dpass = 0.057501127785;  % Passband Ripple
% Dstop = 0.0001;          % Stopband Attenuation
% dens  = 20;              % Density Factor
% 
% % Calculate the order from the parameters using FIRPMORD.
% [N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);
% 
% % Calculate the coefficients using the FIRPM function.
% b  = firpm(N, Fo, Ao, W, {dens});
% LP_Brum = dfilt.dffir(b);
%%%%%%%%%%% Test af HP_filter på udsnit uden tale 100-110 &&&&&&&&&&&&&&&&&
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filter2_u_brum = filter(LP_Brum, filter1_u_brum);
% sound(filter2_u_brum);
% pause(2.7);
% clear sound
% 
% figure 
% fft1_brummen = fft(filter2_u_brum);
% plot (abs(fft1_brummen));
% title('fft for udsnit af filen kun med brum.');

%%%%%%%%%%%%%%%%%%%% endelig test af filter på lydfilen. %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filter_u_brum = filter(HP_Brum, myRecording);
sound(filter_u_brum);
pause(8);
clear sound

filter2_u_brum = filter(BP_Brum, filter_u_brum);
sound(filter2_u_brum);
pause(8);
clear sound

figure
plot (brummen);
figure
plot (abs(brummen));

