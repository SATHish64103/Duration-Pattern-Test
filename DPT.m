function [number_of_correct_responses, number_of_wrong_responses] = DPT(long_dur, short_dur, freq, number_of_reversals)

% This script can be used to run duration pattern test. The current default
% parameters used similar to procedure used in the study
% (https://pubmed.ncbi.nlm.nih.gov/30461390/). But default can be 
% manipulated by user input arguments. Frequeny must be entered in hertz and 
% durations in msec. Stimulus generation functions used in this script took from psychoacoustics toolbox.

% Default settings:
% Stimulus frequency = 1000 Hz
% Short tone duration = 250 msec
% Long tone duration = 500 msec
% Inter stimulus interval = 300 msec
% number of reversals = 10
% Stimulus envelope rise/fall time = 10 msec

% Usage format:
% [correct, wrong] = DPT
% [correct, wrong] = DPT(long_dur, short_dur)
% [correct, wrong] = DPT(long_dur, short_dur, freq)
% [correct, wrong] = DPT(long_dur, short_dur, freq, number_of_reversals)

% The response by the participant must be given in the following format:
% Eg: If the subject hears long, long, short pattern. Subject response must 
% be LLS (without space inbetween).

% Further queries contact sathish.sreeni58@gmail.com


if nargin == 3
    number_of_reversals = 10;
elseif nargin == 2
    number_of_reversals = 10;
    freq = 1000;
elseif nargin == 0
    number_of_reversals = 10;
    freq = 1000;
    short_dur = 250;
    long_dur = 500;
end

if nargin == 4    
    x = (1:number_of_reversals);
    sf = 44100;
    long_tone = GenerateTone(sf, long_dur, freq);
    long_tone = GenerateEnvelope(sf,long_tone,10,10);
    short_tone = GenerateTone(sf, short_dur, freq);
    short_tone = GenerateEnvelope(sf,short_tone,10,10);
    Inter_stim_interval = zeros(round(sf*(300/1000)),1);
    silence = zeros(round(sf*(50/1000)),1);
    
    % Generate stimulus sequence
    LLS = [long_tone; Inter_stim_interval; long_tone; Inter_stim_interval; short_tone];
    LSL = [long_tone; Inter_stim_interval; short_tone; Inter_stim_interval; long_tone];
    SLL = [short_tone; Inter_stim_interval; long_tone; Inter_stim_interval; long_tone];
    SSL = [short_tone; Inter_stim_interval; short_tone; Inter_stim_interval; long_tone];
    SLS = [short_tone; Inter_stim_interval; long_tone; Inter_stim_interval; short_tone];
    LSS = [long_tone; Inter_stim_interval; short_tone; Inter_stim_interval; short_tone];
    d = [];
    e = [];
    
    % randomize stimulus
    for i = 1
        for j = 1:length(x)
            a = randperm(6);
            for ii = 1
                for jj = 1
                    if a(ii,jj) == 1
                        seq = [silence; LLS; silence];
                        b = 'LLS';
                    elseif a(ii,jj) == 2
                        seq = [silence; LSL; silence];
                        b = 'LSL';
                    elseif a(ii,jj) == 3
                        seq = [silence; SLL; silence];
                        b = 'SLL';
                    elseif a(ii,jj) == 4
                        seq = [silence; SSL; silence];
                        b = 'SSL';
                    elseif a(ii,jj) == 5
                        seq = [silence; SLS; silence];
                        b = 'SLS';
                    elseif a(ii,jj) == 6
                        seq = [silence; LSS; silence];
                        b = 'LSS';
                    end
                end
            end
            
            % Play stimulus sequence
            sound(seq,sf)
            response = input('Type the stimulus sequence you heard: ','s');
            
            % Analyse response
            if strcmpi(b,response) == 1
                disp('CORRECT');
                score = 1;
                d = [d score];
            else
                disp('WRONG');
                score = 1;
                e = [e score];
            end
            
            % Calculate number of correct and wrong responses
            correct = sum(d);
            wrong = sum(e);
        end
    end
final_response = [correct wrong];
number_of_correct_responses = final_response(1,1);
number_of_wrong_responses = final_response(1,2);

else
    x = (1:number_of_reversals);
    sf = 44100;
    long_tone = GenerateTone(sf, long_dur, freq);
    long_tone = GenerateEnvelope(sf,long_tone,10,10);
    short_tone = GenerateTone(sf, short_dur, freq);
    short_tone = GenerateEnvelope(sf,short_tone,10,10);
    Inter_stim_interval = zeros(round(sf*(300/1000)),1);
    silence = zeros(round(sf*(50/1000)),1);
    
    % Generate stimulus sequence
    LLS = [long_tone; Inter_stim_interval; long_tone; Inter_stim_interval; short_tone];
    LSL = [long_tone; Inter_stim_interval; short_tone; Inter_stim_interval; long_tone];
    SLL = [short_tone; Inter_stim_interval; long_tone; Inter_stim_interval; long_tone];
    SSL = [short_tone; Inter_stim_interval; short_tone; Inter_stim_interval; long_tone];
    SLS = [short_tone; Inter_stim_interval; long_tone; Inter_stim_interval; short_tone];
    LSS = [long_tone; Inter_stim_interval; short_tone; Inter_stim_interval; short_tone];
    d = [];
    e = [];
    
    % randomize stimulus
    for i = 1
        for j = 1:length(x)
            a = randperm(6);
            for ii = 1
                for jj = 1
                    if a(ii,jj) == 1
                        seq = [silence; LLS; silence];
                        b = 'LLS';
                    elseif a(ii,jj) == 2
                        seq = [silence; LSL; silence];
                        b = 'LSL';
                    elseif a(ii,jj) == 3
                        seq = [silence; SLL; silence];
                        b = 'SLL';
                    elseif a(ii,jj) == 4
                        seq = [silence; SSL; silence];
                        b = 'SSL';
                    elseif a(ii,jj) == 5
                        seq = [silence; SLS; silence];
                        b = 'SLS';
                    elseif a(ii,jj) == 6
                        seq = [silence; LSS; silence];
                        b = 'LSS';
                    end
                end
            end
            
            % Play stimulus sequence
            sound(seq,sf)
            response = input('Type the stimulus sequence you heard: ','s');
            
            % Analyse response
            if strcmpi(b,response) == 1
                disp('CORRECT');
                score = 1;
                d = [d score];
            else
                disp('WRONG');
                score = 1;
                e = [e score];
            end
            
            % Calculate number of correct and wrong responses
            correct = sum(d);
            wrong = sum(e);
        end
    end
final_response = [correct wrong];
number_of_correct_responses = final_response(1,1);
number_of_wrong_responses = final_response(1,2);
end
end

            
                        
    
