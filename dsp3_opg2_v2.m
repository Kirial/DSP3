

Fs = 48000;
a_lc= 238;2
a_hc = 248;

filterLength = 24;

a_ol = 2 * pi * (a_lc/Fs);

a_oh = 2 * pi * (a_hc/Fs);

a_coef = zeros(1,filterLength);

a_coef(round(filterLength/2)) = (a_oh-a_ol)/pi;

for n = round(filterLength/2)+1:filterLength
    
    a_coef(n) = (sin(a_oh*n)/pi*n) - (sin(a_ol*n) / pi*n);

end

for n = 1: round(filterLength/2)-1
   
    a_coef(n) = -a_coef(filterLength-n);
    
end

[hz,w] = freqz(a_coef,[1],512);

phi = 180 * unwrap(angle(hz))/pi;

subplot(2,1,1); plot(w,20*log10(abs(hz))),grid;
xlabel('Frequency (radians)');
ylabel('Magnitude Response (dB)');

subplot(2,1,2); plot(w, phi); grid;
xlabel('Frequency (radians)');
ylabel('Phase (degrees)');

