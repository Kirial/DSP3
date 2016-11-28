% % opgave 3
% 
% Båndstop filter til fjernelse af brumsignal
% I folderen ’Signaler_til_opgave3’ ligger et signal med indlejret brum. 
% Analyser signalet og bestem de nødvendige filterspecifikationer så brummen fjernes. 
% Implementer filteret i Matlab og dokumenter designet.

load('opg3_signal.mat')
figure
plot(myRecording);
title('myRecording');
xlabel('tid');
ylabel('amplitude');

Fs = 8000;  % Sampling Frequency

% sound(myRecording, Fs);
% pause(8);
% clear sound
fft_recording = abs(fft(myRecording));

%%%%%% FFT af Recording
fft_recording_plot_y = fft_recording(1:length(fft_recording)/2+1);
fft_recording_plot_x = (8000)*(0:(length(fft_recording)/2))/length(fft_recording);

figure
plot (fft_recording_plot_x,fft_recording_plot_y);
title('FFT af myRecording før filtre');
xlabel('Frekvens');
ylabel('Magnitude');

%%%%%%%%%%%%% Hvis man ønsker at få signalet ud som en wave fil.%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Export signal to Wav file.
% Fs = 8000;
% filename = 'handel.wav';
% audiowrite(filename,myRecording,Fs);
% clear Fs


%%%%%% Udsnit af signalet for at analysere hvor der ikke er tale %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
audio_name = 'handel.wav';   %talen 
T = 1/Fs;                    %Tid mellem Samples 
audio_samples = [1,2.4*Fs ]; %hvor lang tid der skal samples 
[audio_d,Fs] = audioread(audio_name,audio_samples);
brummen = audio_d(:,1)';
tid_data = 54.8:T:57.5-T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fft_brumen = abs(fft(brummen));
brumme_test_plot_y = fft_brumen(1:length(fft_brumen)/2+1);
brumme_test_plot_x = (8000)*(0:(length(fft_brumen)/2))/length(fft_brumen);

figure
t1 = subplot(2,1,1);
plot (brumme_test_plot_x,brumme_test_plot_y);
title(t1, 'FFT af signal uden tale før filtre');
xlabel(t1, 'Frekvens');
ylabel(t1, 'Magnitude');

% sound(brummen);
% pause(2.7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filtre %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       % Highpass filter
% All frequency values are in Hz.

Fstop = 150;             % Stopband Frequency
Fpass = 160;             % Passband Frequency
Dstop = 1e-05;           % Stopband Attenuation
Dpass = 0.057501127785;  % Passband Ripple
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop, Fpass]/(Fs/2), [0 1], [Dstop, Dpass]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
highpass = dfilt.dffir(b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       % Lowpass filter

Fpass1 = 2500;            % Passband Frequency
Fstop1 = 2600;            % Stopband Frequency
Dpass1 = 0.057501127785;  % Passband Ripple
Dstop1 = 0.01;            % Stopband Attenuation
dens1  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N1, Fo1, Ao1, W1] = firpmord([Fpass1, Fstop1]/(Fs/2), [1 0], [Dpass1, Dstop1]);

% Calculate the coefficients using the FIRPM function.
b1  = firpm(N1, Fo1, Ao1, W1, {dens1});
lowpass = dfilt.dffir(b1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filtre slut %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%% Test af HP_filter på udsnit uden tale  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% brumme_test = abs(fft(brummen));
% brumme_test_plot_y = brumme_test(1:length(brumme_test)/2+1);
% brumme_test_plot_x = (8000)*(0:(length(brumme_test)/2))/length(brumme_test);
% figure
% plot (brumme_test_plot_x,brumme_test_plot_y);
% title('FFT af myRecording');
% xlabel('Frekvens');
% ylabel('Magnitude');

% sound(brumme);
% pause(3);
% clear sound

brumme_filter_test = filter(highpass, myRecording);

% sound(brumme_filter_test);
% pause(3);
% clear sound

brumme_filter_test = filter(lowpass, brumme_filter_test);

% sound(brumme_filter_test);
% pause(3);
% clear sound

brumme_filter_test = abs(fft(brumme_filter_test));
brumme_test_filter_plot_y = brumme_filter_test(1:length(brumme_filter_test)/2+1);
brumme_test_filter_plot_x = (8000)*(0:(length(brumme_filter_test)/2))/length(brumme_filter_test);
%figure

t2 = subplot(2,1,2);
plot (brumme_test_filter_plot_x,brumme_test_filter_plot_y);
title(t2, 'FFT af signal uden tale efter filtre');
xlabel(t2, 'Frekvens');
ylabel(t2, 'Magnitude');

%%%%%%%%%%%%%%%%%%% Test af filtre på hele signalet %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fft_test = abs(fft(myRecording));
fft_test_plot_y = fft_test(1:length(fft_test)/2+1);
fft_test_plot_x = (8000)*(0:(length(fft_test)/2))/length(fft_test);
figure

t1 = subplot(2,1,1);
plot (fft_test_plot_x,fft_test_plot_y);
title(t1, 'FFT af myRecording før filtre');
xlabel(t1, 'Frekvens');
ylabel(t1, 'Magnitude');

% sound(myRecording);
% pause(8);
% clear sound


filter_test = filter(lowpass, myRecording);

% sound(filter_test);
% pause(8);
% clear sound

filter_test = filter(highpass, filter_test);

% sound(filter_test);
% pause(8);
% clear sound

fft_filter_test = abs(fft(filter_test));
fft_test_filter_plot_y = fft_filter_test(1:length(fft_filter_test)/2+1);
fft_test_filter_plot_x = (8000)*(0:(length(fft_filter_test)/2))/length(fft_filter_test);
%figure

t2 = subplot(2,1,2);
plot (fft_test_filter_plot_x,fft_test_filter_plot_y);
title(t2, 'FFT af myRecording efter filtre');
xlabel(t2, 'Frekvens');
ylabel(t2, 'Magnitude');

