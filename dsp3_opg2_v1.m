% opgave2

% 2. B�ndpas-filter til analyse af vokaler �a�  �e�  �i�
% Indspil selv lyd som indeholder vokalerne �a�  �e�  �i� � 
% analyser signalerne og bestem de n�dvendige filterspecifikationer 
% s� f.eks. et �a� detekteres i �en talestr�m�. Implementer filteret 
% i Matlab og dokumenter designet.


%function [] = dsp3_opg2_v1()

% Load lydfiler

audio_name = 'audio_klip.wav';



% Meta

samplingRate = 48000; % [fs]

sampleLength = 10; % [sek]

timeVector = 0:1/samplingRate:sampleLength-1/samplingRate;

% Sampling




% Fourior Transformation - For at finde frekvens b�nd for A,E,I

%yA = fft(


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