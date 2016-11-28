function opg4_filter = opg4_filter
%OPG4_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.0 and the Signal Processing Toolbox 7.2.
% Generated on: 28-Nov-2016 11:48:46

% Equiripple Highpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 96;  % Sampling Frequency

N     = 24;  % Order
Fstop = 0;   % Stopband Frequency
Fpass = 3;   % Passband Frequency
Wstop = 1;   % Stopband Weight
Wpass = 1;   % Passband Weight
dens  = 20;  % Density Factor

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, [0 Fstop Fpass Fs/2]/(Fs/2), [0 0 1 1], [Wstop Wpass], ...
           {dens});
opg4_filter = dfilt.dffir(b);

% [EOF]
