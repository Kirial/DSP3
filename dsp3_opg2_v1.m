% --- Opgave 2

%clear, close all

close all

% 2. Båndpas-filter til analyse af vokaler ’a’  ’e’  ’i’
% Indspil selv lyd som indeholder vokalerne ’a’  ’e’  ’i’ – 
% analyser signalerne og bestem de nødvendige filterspecifikationer 
% så f.eks. et ’a’ detekteres i ’en talestrøm’. Implementer filteret 
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


% --- Fourior Transformation - For at finde frekvens bånd for A,E,I

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
title(t1,'Tidsdomæne T');
xlabel(t1,'Tid');
ylabel(t1,'Amplitude');

t2 = subplot(2,1,2);
plot(t_f,t_fft);
title(t2,'Frekvensdomæne T');
axis([25,4000,0,max(t_fft)]);
xlabel(t2,'Frekvens');
ylabel(t2,'Amplitide');

figure

fs_sound_max = 4000;
fs_sound_min = 25;

a1 = subplot(3,2,1);
plot(sound_a);
title(a1,'Tidsdomæne A');
xlabel(a1,'Tid');
ylabel(a1,'Amplitude');

a2 = subplot(3,2,2);
plot(a_f,a_fft);
title(a2,'Frekvensdomæne A');
axis([fs_sound_min,fs_sound_max,0,max(a_fft)]);
xlabel(a2,'Frekvens');
ylabel(a2,'Amplitide');
line(220,0);

e1 = subplot(3,2,3);
plot(sound_a);
title(e1,'Tidsdomæne E');
xlabel(e1,'Tid');
ylabel(e1,'Amplitude');

e2 = subplot(3,2,4);
plot(e_f,e_fft);
title(e2,'Frekvensdomæne E');
axis([fs_sound_min,fs_sound_max,0,max(e_fft)]);
xlabel(e2,'Frekvens');
ylabel(e2,'Amplitide');

i1 = subplot(3,2,5);
plot(sound_i);
title(i1,'Tidsdomæne I');
xlabel(i1,'Tid');
ylabel(i1,'Amplitude');

i2 = subplot(3,2,6);
plot(i_f,i_fft);
title(i2,'Frekvensdomæne I');
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

a_band = 20; % Frekvensbåndbredde
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

% --- FILTERS

a_bpf = a_bandpassfilter8;

e_bpf = e_bandpassfilter2;

i_bpf = i_bandpassfilter2;


freqz(a_bpf);
freqz(e_bpf);
freqz(i_bpf);

% --- Test Filtered

t_filteredA = filter(a_bpf,sound_t);
t_filteredE = filter(e_bpf,sound_t);
t_filteredI = filter(i_bpf,sound_t);

figure

orig_t = subplot(4,1,1);
plot(sound_t);
title(orig_t,'Original');

bpfa_t = subplot(4,1,2);
plot(t_filteredA);
title(bpfa_t,'Test filtered A');

bpfe_t = subplot(4,1,3);
plot(t_filteredE);
title(bpfe_t,'Test filtered E');

bpfi_t = subplot(4,1,4);
plot(t_filteredI);
title(bpfi_t,'Test filtered I');

%sound(sound_t,samplingRate); pause(4);
%sound(t_filteredA,samplingRate); pause(4);

% "AAaaa..."

a_filteredA = filter(a_bpf,sound_a);
e_filteredA = filter(a_bpf,sound_e);
i_filteredA = filter(a_bpf,sound_i);

% "IIiii..."

a_filteredE = filter(e_bpf,sound_a);
e_filteredE = filter(e_bpf,sound_e);
i_filteredE = filter(e_bpf,sound_i);

% "EEeee..."

a_filteredI = filter(i_bpf,sound_a);
e_filteredI = filter(i_bpf,sound_e);
i_filteredI = filter(i_bpf,sound_i);


% --- Results

figure

orig_a = subplot(4,3,1);
plot(sound_a);
title(orig_a,'Original A');

bpfa_a = subplot(4,3,4);
plot(a_filteredA);
title(bpfa_a,'A filtered A');

bpfa_e = subplot(4,3,7);
plot(e_filteredA);
title(bpfa_e,'E filtered A');

bpfa_i = subplot(4,3,10);
plot(i_filteredA);
title(bpfa_i,'I filtered A');

%---

orig_e = subplot(4,3,2);
plot(sound_e);
title(orig_e,'Original E');

bpfe_a = subplot(4,3,5);
plot(a_filteredE);
title(bpfe_a,'A filtered E');

bpfe_e = subplot(4,3,8);
plot(e_filteredE);
title(bpfe_e,'E filtered E');

bpfe_i = subplot(4,3,11);
plot(i_filteredE);
title(bpfe_i,'I filtered E');

%---

orig_i = subplot(4,3,3);
plot(sound_i);
title(orig_i,'Original I');

bpfi_a = subplot(4,3,6);
plot(a_filteredI);
title(bpfi_a,'A filtered I');

bpfi_e = subplot(4,3,9);
plot(e_filteredI);
title(bpfi_e,'E filtered I');

bpfi_i = subplot(4,3,12);
plot(i_filteredI);
title(bpfi_i,'I filtered I');

%end