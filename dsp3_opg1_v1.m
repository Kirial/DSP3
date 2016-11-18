
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