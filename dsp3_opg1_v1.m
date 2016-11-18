% 1. Lavpas-filter til støjreduktion (fjern noget hvid-støj fra et talesignal)
% Indspil selv et talesignal i Matlab og tilføj efterfølgende hvid støj til signalet i Matlab. 
% Analyser signalet før og efter tilføjelse af hvid støj – 
% og bestem de nødvendige filterspecifikationer til et lavpas-filter, 
% så kun de absolut nødvendige talesignaler (med støj oveni) kommer igennem filteret.
% Analyser signalet igen efter filtrering.




function [] = dsp3_opg1_v1()

sample_freq = 48000;    %sample frequency 48 kHz 
bits = 16;              %bits
record_1 = audiorecorder(sample_freq,bits,1,1);
disp('Start speaking.') 
record(record_1);       % record
record_time = 5;        % record time in sec 
pause(record_time);     %
stop(record_1);         % stop recording 
disp('End of Recording.');
play(record_1);         % afspil  
pause(5);               % 
record_1_data = getaudiodata(record_1);

end