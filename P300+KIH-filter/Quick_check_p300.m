% Programm for extraction P300
%Data = textread('research.asc'); %GremIS_9.10.20
Data = textread('research_2.asc'); %Kuleshov_9.10.20
%Signals = textread('only_num_signals.txt');
close all;
t_sec = 60;
freq_discr = 500; % sampling frequency, Hz
offset = 0;
Ip = 0;
Length_epoch = 0;
% our experiment series
Nexp = 4; % 9 experiments
ch = 6; % Stim(1), Fpz(2), Fz(3), C3(4), C4(5), Cz(6), P3(7), P4(8), Pz(9)

%Nexp = input('Number of experiment(1-9):'); %command-line in Matlab2019
%ch = input('Number of chanel Pz = 9, Cz = 6:'); %command-line in Matlab2019
for Nexp = 1:9
%time and counting
%t = [2,0, 6,0, 8,15, 10,0, 14,0, 16,15, 18,0, 22,0, 24,15]; %GremIS
t = [0,50, 4,50, 7,5, 8,50, 12,50, 15,5, 16,50, 20,50, 23,5]; %Kuleshov
Ip = t(2 * Nexp - 1) * t_sec * freq_discr + t(2 * Nexp)*freq_discr; % offset

%time for experiment
OX = zeros(Length_epoch, 1);
for local = 1:250
    OX(local, 1) = (local-1)*2;
end;
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
SSep = zeros(Length_epoch/2, 9); % matrix for summing signals
SSep1 = zeros(Length_epoch/2, 9); % matrix for animation and norminetting
Max9 = zeros(Length_epoch, 9);
max_noise = zeros(8,1);
Norminette = zeros(9, 1); % norma
% windows for summing
kdel = 1;
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
    for i = 1:Length_epoch/2
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
%     [b, a] = sos2tf(SOS,G);
%     SSep = filter(b,a, SSep);
%     SSep = filter(Hd, SSep);
%     a = fir1(100,[0.07 0.13], 'stop');
%     SSep = filter(a, 1, SSep);
    for local1 = 1:9
        SSep1(:, local1) = SSep(:, local1) / Norminette(local1, 1);
    end;
    
    % excretion of P300
    for local2 = 110:225
        for p = 1:9
            Max9(local2, p) = SSep1(local2, p);
        end;
    end;
    [max_p300, latency] = max(Max9(:, 9));
    latency = latency*2; 
    for tr = 1:8
        max_noise(tr, 1) = max(Max9(:, tr));
    end;
    max_noise1 = max(max_noise);
    res = max_p300 / max_noise1;
    %figure;
%     Ht1 = plot(OX, SSep1(:, 1), 'b', OX, SSep1(:, 2), 'g', OX, SSep1(:, 3), 'r', OX, SSep1(:, 4), 'y', OX, SSep1(:, 5), 'k', OX, SSep1(:, 6), 'c', OX, SSep1(:, 7), 'm', OX, SSep1(:, 8), OX, SSep1(:, 9));
%     
%     if (ch == 9)
%         title(['Series:', num2str(Nexp), ', electrode Pz', ', window:', num2str(window),', target stimuli:', num2str(Norminette(9, 1)),', exretion:', num2str(res),', Amplitude:', num2str(max_p300),' uV',', Latency:', num2str(latency),' ms']);
%     elseif (ch == 6)
%         title(['Series:', num2str(Nexp), ', electrode Cz', ', window:', num2str(window),', target stimuli:', num2str(Norminette(9, 1)), ', exretion:', num2str(res),', Amplitude:', num2str(max_p300),' uV',', Latency:', num2str(latency),' ms']);
%     end;
%     grid on;
%     set(Ht1, 'LineWidth', 1);
%     xlabel('Time, ms');
%     ylabel('Amplitude, uV');
%     %%%%pause(0.05);
end;
    St1=['C:\Users\IVAN\Documents\MATLAB\P300+KIH-filter\results_window\test\Cz\',num2str(Nexp), '\', num2str(window),'.bmp'];
    Fig=figure('Position',[600 225 800 550]);
    Ht2 = plot(OX, SSep1(:, 1), 'b', OX, SSep1(:, 2), 'g', OX, SSep1(:, 3), 'r', OX, SSep1(:, 4), 'y', OX, SSep1(:, 5), 'k', OX, SSep1(:, 6), 'c', OX, SSep1(:, 7), 'm', OX, SSep1(:, 8), OX, SSep1(:, 9));
    grid on;
    set(Ht2, 'LineWidth', 1)
    legend1 = ['Stim 1:', num2str(Norminette(1,1))];
    legend2 = ['Stim 2:', num2str(Norminette(2,1))];
    legend3 = ['Stim 3:', num2str(Norminette(3,1))];
    legend4 = ['Stim 4:', num2str(Norminette(4,1))];
    legend5 = ['Stim 5:', num2str(Norminette(5,1))];
    legend6 = ['Stim 6:', num2str(Norminette(6,1))];
    legend7 = ['Stim 7:', num2str(Norminette(7,1))];
    legend8 = ['Stim 8:', num2str(Norminette(8,1))];
    legend9 = ['Stim 9:', num2str(Norminette(9,1))];
    legend = [legend1 newline legend2  newline legend3 newline legend4 newline legend5 newline legend6 newline legend7 newline legend8 newline legend9];
    text(10,max_p300/2,legend);
    xlabel('Time, ms');
    ylabel('Amplitude,uV');
    if (ch == 9)
        St2 = ['Series:', num2str(Nexp), ', electrode Pz', ', window:', num2str(window),', target stimuli:', num2str(Norminette(9, 1)), ', exretion:', num2str(res), ', Amplitude:', num2str(max_p300),' uV', ', Latency:', num2str(latency), ' ms'];
    elseif (ch == 6)
        St2 = ['Series:', num2str(Nexp), ', electrode Cz', ', window:', num2str(window),', target stimuli:', num2str(Norminette(9, 1)), ', exretion:', num2str(res), ', Amplitude:', num2str(max_p300),' uV', ', Latency:', num2str(latency), ' ms'];
    end;
    title(St2);
    print(Fig,'-dbmp',St1);
    % set massives to zero (nullify)
    Ht2=0;
    SSep = zeros(Length_epoch/2, 9); % matrix for summing signals
    %SSep1 = zeros(Length_epoch/2, 9); % matrix for animation and norminetting
    Max9 = zeros(Length_epoch, 9);
    max_noise = zeros(8,1);
    Norminette = zeros(9, 1); % norma
end;
end;