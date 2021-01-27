% Programm for extraction P300
Data = textread('research.asc'); %GremIS_9.10.20
%Data = textread('research_2.asc'); %Kuleshov_9.10.20
Signals = textread('only_num_signals.txt');
close all;
t_sec = 60;
freq_discr = 500; % sampling frequency, Hz
offset = 0;
Ip = 0;
Length_epoch = 0;
% our experiment series
Nexp = 7; % 9 experiments
ch = 6
; % Stim(1), Fpz(2), Fz(3), C3(4), C4(5), Cz(6), P3(7), P4(8), Pz(9)

%Nexp = input('Number of experiment(1-9):'); %command-line in Matlab2019
%ch = input('Number of chanel:'); %command-line in Matlab2019

%time and counting
t = [2,0, 6,0, 8,15, 10,0, 14,0, 16,15, 18,0, 22,0, 24,15]; %GremIS
%t = [0,50, 4,50, 7,5, 8,50, 12,50, 15,5, 16,50, 20,50, 23,5]; %Kuleshov
Ip = t(2 * Nexp - 1) * t_sec * freq_discr + t(2 * Nexp)*freq_discr; % offset

% scanning for the first stimul in our experiment series
flag = 0;
while flag == 0
    if Data(Ip, 1) == 1
        flag = 1;
    end;
    Ip = Ip + 1;
end;
%
freq = 0; %frequency in our experiment series, Hz
N = 0;
if Nexp == 1
    offset = 0;
    N = 225;
    freq = 1; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 2
    offset = 225;
    N = 240;
    freq = 2; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 3
    offset = 225 + 240;
    N = 300;
    freq = 4; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 4
    offset = 225 + 240 + 300;
    N = 225;
    freq = 1; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 5
    offset = 225 * 2 + 240 + 300;
    N = 240;
    freq = 2; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 6
    offset = 225 * 2 + 240 * 2 + 300;
    N = 300;
    freq = 4; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 7
    offset = 225 * 2 + 240 * 2 + 300 * 2;
    N = 225;
    freq = 1; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 8
    offset = 225 * 3 + 240 * 2 + 300 * 2;
    N = 240;
    freq = 2; %frequency in our experiment series, H
    Length_epoch = 500;
elseif Nexp == 9
    offset = 225 * 3 + 240 * 3 + 300 * 2;
    N = 300;
    freq = 4; %frequency in our experiment series, H
    Length_epoch = 500;
end;
SSep = zeros(Length_epoch, 9); % matrix for summing signals
SSep1 = zeros(Length_epoch, 9); % matrix for animation and norminetting
Norminette = zeros(9, 1); % norma
kdel = 5;
N = N / kdel; %size of window
for window = 1:kdel
for j = 1:N
    Is = 10 + offset; % first 10 stimuls for testing
    Is = Is + j + N*(window-1);
    if Signals(Is,1) == 8
        Norminette(9,1) = Norminette(9,1) + 1;
    elseif Signals(Is,1) == 0
        Norminette(1,1) = Norminette(1,1) + 1;
    elseif (Signals(Is,1) == 1 || Signals(Is,1) == 10)
        Norminette(2,1) = Norminette(2,1) + 1;
    elseif Signals(Is,1) == 2
        Norminette(3,1) = Norminette(3,1) + 1;
    elseif Signals(Is,1) == 3
        Norminette(4,1) = Norminette(4,1) + 1;
    elseif Signals(Is,1) == 4
        Norminette(5,1) = Norminette(5,1) + 1;
    elseif Signals(Is,1) == 5
        Norminette(6,1) = Norminette(6,1) + 1;
    elseif Signals(Is,1) == 6
        Norminette(7,1) = Norminette(7,1) + 1;
    elseif Signals(Is,1) == 7
        Norminette(8,1) = Norminette(8,1) + 1;
    end;
    for i = 1:Length_epoch
        if Signals(Is,1) == 8
            SSep(i, 9) = SSep(i, 9) - Data(Ip + i + (j - 1)*(freq_discr/freq) + N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 0
            SSep(i, 1) = SSep(i, 1) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif (Signals(Is,1) == 1 || Signals(Is,1) == 10)
            SSep(i, 2) = SSep(i, 2) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 2
            SSep(i, 3) = SSep(i, 3) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 3
            SSep(i, 4) = SSep(i, 4) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 4
            SSep(i, 5) = SSep(i, 5) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 5
            SSep(i, 6) = SSep(i, 6) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 6
            SSep(i, 7) = SSep(i, 7) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        elseif Signals(Is,1) == 7
            SSep(i, 8) = SSep(i, 8) - Data(Ip + i + (j - 1)*(freq_discr/freq)+ N*(window-1)*(freq_discr/freq), ch);
        end;
    end;
    [b, a] = sos2tf(SOS,G);
    SSep = filter(b,a, SSep);
    %SSep = filter(Hd, SSep);
    SSep1(:, 1) = SSep(:, 1) / Norminette(1, 1);
    SSep1(:, 2) = SSep(:, 2) / Norminette(2, 1);
    SSep1(:, 3) = SSep(:, 3) / Norminette(3, 1);
    SSep1(:, 4) = SSep(:, 4) / Norminette(4, 1);
    SSep1(:, 5) = SSep(:, 5) / Norminette(5, 1);
    SSep1(:, 6) = SSep(:, 6) / Norminette(6, 1);
    SSep1(:, 7) = SSep(:, 7) / Norminette(7, 1);
    SSep1(:, 8) = SSep(:, 8) / Norminette(8, 1);
    SSep1(:, 9) = SSep(:, 9) / Norminette(9, 1);
    %figure;
    plot(SSep1);
    title(['Nexp=', num2str(Nexp), ' electrode Pz', ' window:', num2str(window)]);
    xlabel('countdown');
    ylabel('uV');
    pause(0.05);
end;
    figure;
    SSep = zeros(Length_epoch, 9); % matrix for summing signals
    SSep1 = zeros(Length_epoch, 9); % matrix for animation and norminetting
    Norminette = zeros(9, 1); % norma
    %saveas(H, 'H1', jpg);
    %plot(SSep1);
end;