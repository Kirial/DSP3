% opgave2

% 2. B�ndpas-filter til analyse af vokaler �a�  �e�  �i�
% Indspil selv lyd som indeholder vokalerne �a�  �e�  �i� � 
% analyser signalerne og bestem de n�dvendige filterspecifikationer 
% s� f.eks. et �a� detekteres i �en talestr�m�. Implementer filteret 
% i Matlab og dokumenter designet.


function [] = dsp3_opg2_v1()

% Bandpass - Filter

lowerCutoffFrequency = 4000;

upperCutoffFrequency = 5000;

samplingRate = 8000;

% --- Filter Coefficients ---

Omega_low = 2 * pi * (lowerCutoffFrequency / samplingRate)

Omega_up = 2 * pi * (upperCutoffFrequency / samplingRate)



% "AAaaa..."

% "IIiii..."

% "EEeee..."

end