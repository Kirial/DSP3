% %opgave 4
% 
% 4. H�jpasfilter til at finde triggerpunkt for EKG signal (ekg signal fra �velse 1)
% Anvendt EKG signalet fra �velse 1 � og proces signalet gennem et h�jpasfilter 
% s� man kan finde et passende �triggerpunkt� til at bestemme bestemte steder p� signalet. 
% Implementer filteret i Matlab og dokumenter designet.

%function [] = dsp3_opg4_v1()
load('nervesignal.mat');
amplitude_EKG = cell2mat(nsVector3(:,1)');
tid_EKG = cell2mat(nsVector3(:,2)');

figure 
plot(tid_EKG, amplitude_EKG);


%end