
function [] = dsp3_opg1_v1()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hvis man selv skal optage skal man bruge det funktion. 
% sample_freq = 48000;    %sample frequency 48 kHz 
% bits = 16;              %bits
% record_1 = audiorecorder(sample_freq,bits,1,1);
% disp('Start speaking.') 
% record(record_1);       % record
% record_time = 3.7;      % record time in sec 
% pause(record_time);     %
% stop(record_1);         % stop recording 
% disp('End of Recording.');
% play(record_1);         % afspil  
% pause(record_time);        
% audio_data = getaudiodata(record_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hvis man skal tage en eksisterende audio fil skal man bruge det 
audio_name = 'audio_klip.wav';              %talen 
sampling_freq = 48000;                      %samplings frekvens
T_opg_1 = 1/sampling_freq;                  %Tid mellem Samples 
audio_samples = [1,3.7*sampling_freq ];     %hvor lang tid der skal samples 
[audio_data,sampling_freq] = audioread(audio_name,audio_samples);
sound(audio_data,sampling_freq);
pause(3.7);                                 % hvis man vil afspile lyd så sæt pause på 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%% begynd på tale analyse %%%%%%%%%%%%%%%%%%%%%%%%%%%%


end