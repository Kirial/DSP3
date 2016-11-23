% --- Opgave 2

%clear, close all

close all

% 2. B�ndpas-filter til analyse af vokaler �a�  �e�  �i�
% Indspil selv lyd som indeholder vokalerne �a�  �e�  �i� � 
% analyser signalerne og bestem de n�dvendige filterspecifikationer 
% s� f.eks. et �a� detekteres i �en talestr�m�. Implementer filteret 
% i Matlab og dokumenter designet.

%function [] = dsp3_opg2_v1()

% --- Load lydfiler

file_t = '/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3/audio_klip.wav';
file_a = '/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3/aaaaaaaaaa.wav';
file_e = '/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3/e.wav';
file_i = '/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3/iiiiiiiiiiiiiiiiii.wav';

% --- Meta

samplingRate = 48000; % [fs]
%timeVector = 0:1/samplingRate:samples-1/samplingRate;

% --- Sampling

[sound_t,samplingRate] = audioread(file_t);
[sound_a,samplingRate] = audioread(file_a);
[sound_e,samplingRate] = audioread(file_e);
[sound_i,samplingRate] = audioread(file_i);

[length_t, height_t] = size(sound_t);
[length_a, height_a] = size(sound_a);
[length_e, height_e] = size(sound_e);
[length_i, height_i] = size(sound_i);

sample_t = [1,length_t];
sample_a = [1,length_a];
sample_e = [1,length_e];
sample_i = [1,length_i];


% --- Fourior Transformation - For at finde frekvens b�nd for A,E,I

t_fft = abs(fft(sound_t));
t_fft = t_fft(1:length_t/2);
t_f = samplingRate * (0:length_t/2-1)/length_t;

a_fft = abs(fft(sound_a));
a_fft = a_fft(1:length_a/2);
a_f = samplingRate * (0:length_a/2-1)/length_a;

e_fft = abs(fft(sound_e));
e_fft = e_fft(1:length_e/2);
e_f = samplingRate * (0:length_e/2-1)/length_e;

i_fft = abs(fft(sound_i));
i_fft = i_fft(1:length_i/2);
i_f = samplingRate * (0:length_i/2-1)/length_i;


% --- Plotting

figure

t1 = subplot(2,1,1);
plot(sound_t);
title(t1,'Tidsdom�ne T');
xlabel(t1,'Tid');
ylabel(t1,'Amplitude');

t2 = subplot(2,1,2);
plot(t_f,t_fft);
title(t2,'Frekvensdom�ne T');
axis([25,4000,0,max(t_fft)]);
xlabel(t2,'Frekvens');
ylabel(t2,'Amplitide');

figure

fs_sound_max = 4000;
fs_sound_min = 25;

a1 = subplot(3,2,1);
plot(sound_a);
title(a1,'Tidsdom�ne A');
xlabel(a1,'Tid');
ylabel(a1,'Amplitude');

a2 = subplot(3,2,2);
plot(a_f,a_fft);
title(a2,'Frekvensdom�ne A');
axis([fs_sound_min,fs_sound_max,0,max(a_fft)]);
xlabel(a2,'Frekvens');
ylabel(a2,'Amplitide');
line(220,0);

e1 = subplot(3,2,3);
plot(sound_a);
title(e1,'Tidsdom�ne E');
xlabel(e1,'Tid');
ylabel(e1,'Amplitude');

e2 = subplot(3,2,4);
plot(e_f,e_fft);
title(e2,'Frekvensdom�ne E');
axis([fs_sound_min,fs_sound_max,0,max(e_fft)]);
xlabel(e2,'Frekvens');
ylabel(e2,'Amplitide');

i1 = subplot(3,2,5);
plot(sound_i);
title(i1,'Tidsdom�ne I');
xlabel(i1,'Tid');
ylabel(i1,'Amplitude');

i2 = subplot(3,2,6);
plot(i_f,i_fft);
title(i2,'Frekvensdom�ne I');
axis([fs_sound_min,fs_sound_max,0,max(i_fft)]);
xlabel(i2,'Frekvens');
ylabel(i2,'Amplitide');

[a_power,a_index] = max(a_fft);
a_top = a_f(a_index);

[e_power,e_index] = max(e_fft);
e_top = e_f(e_index);

[i_power,i_index] = max(i_fft);
i_top = i_f(i_index);

% --- Bandpass - Filter

a_band = 20; % Frekvensb�ndbredde
a_lcut = a_top - a_band/2; % Lower Cutoff Frequency
a_ucut = a_top + a_band/2; % Upper Cutoff Frequency

e_band = 20;
e_lcut = e_top - e_band/2;
e_ucut = e_top + e_band/2;

i_band = 20;
i_lcut = i_top - i_band/2;
i_ucut = i_top + i_band/2;


% --- Filter Coefficients ---

a_omL = 2 * pi * (a_lcut / samplingRate)
a_omU = 2 * pi * (a_ucut / samplingRate)

a_bpf_h0 = (a_omU - a_omL) / pi
a_bpf_h1 = (sin(a_omU*1)) / 1 * pi - (sin(a_omL*1)) / 1 * pi
a_bpf_h2 = (sin(a_omU*2)) / 2 * pi - (sin(a_omL*2)) / 2 * pi

% "AAaaa..."

t_filteredA = filter(bandpassfilter7,sound_t);
a_filteredA = filter(bandpassfilter7,sound_a);
a_filteredA = filter(bandpassfilter7,sound_a);
a_filteredA = filter(bandpassfilter7,sound_a);

figure

subplot(2,1,1);

plot(t_filteredA);

subplot(2,1,2);

plot(sound_t);

sound(sound_t,samplingRate);

pause(4);

sound(t_filteredA,samplingRate);

pause(4);

sound(a_filteredA,samplingRate);

% "IIiii..."

% "EEeee..."

%end