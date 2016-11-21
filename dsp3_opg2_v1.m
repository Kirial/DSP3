% opgave2

clear, close all

% 2. Båndpas-filter til analyse af vokaler ’a’  ’e’  ’i’
% Indspil selv lyd som indeholder vokalerne ’a’  ’e’  ’i’ – 
% analyser signalerne og bestem de nødvendige filterspecifikationer 
% så f.eks. et ’a’ detekteres i ’en talestrøm’. Implementer filteret 
% i Matlab og dokumenter designet.

%path('/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3');


%function [] = dsp3_opg2_v1()

% Load lydfiler

audio_test = '/Users/nb/Education/DTU/3-Semester/Signalbehandling/DSP3/audio_klip.wav';

% Meta

samplingRate = 48000; % [fs]

samples = 187328; % [samples]

%timeVector = 0:1/samplingRate:samples-1/samplingRate;

sample_test = [1,samples];

% Sampling

[sound_test,samplingRate] = audioread(audio_test,sample_test);


% Fourior Transformation - For at finde frekvens bånd for A,E,I

yTest = fft(sound_test);

mTest = abs(yTest);

pTest = unwrap(angle(yTest));

fTest = (0:length(yTest)-1)*100/length(yTest);

subplot(2,1,1);

plot(fTest,mTest);

% Bandpass - Filter



lowerCutoffFrequency = 4000;

upperCutoffFrequency = 5000;



% --- Filter Coefficients ---

omegaLow = 2 * pi * (lowerCutoffFrequency / samplingRate)

omegaUp = 2 * pi * (upperCutoffFrequency / samplingRate)



% "AAaaa..."

% "IIiii..."

% "EEeee..."

%end