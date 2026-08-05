clc;
clear;
close all;

%==========================================================
% Project:
% Comparative Frequency Spectrum Analysis of Digital Window Functions
%
% Developed by:
% Sounak Chattopadhyay
%
% MATLAB Version:
% MATLAB R2013 Compatible
%==========================================================

disp('===============================================');
disp(' Comparative Frequency Spectrum Analysis ');
disp('===============================================');

N = input('Enter the Window Length (N): ');

if N<=1
    error('Window length must be greater than 1');
end

W = linspace(-pi,pi,1000);

%% =========================================================
% RECTANGULAR WINDOW
%===========================================================

Wr = sin((W*N)/2)./sin(W/2);

index = isnan(Wr) | isinf(Wr);
Wr(index) = N;

%% =========================================================
% HANNING WINDOW
%===========================================================

Whn = 0.5*Wr + ...
      0.25*(sin((W*N/2-pi*N/(N-1)))./sin(W/2-pi/(N-1))) + ...
      0.25*(sin((W*N/2+pi*N/(N-1)))./sin(W/2+pi/(N-1)));

Whn(isnan(Whn)) = 0;
Whn(isinf(Whn)) = 0;

%% =========================================================
% HAMMING WINDOW
%===========================================================

Whm = 0.54*Wr + ...
      0.23*(sin((W*N/2-pi*N/(N-1)))./sin(W/2-pi/(N-1))) + ...
      0.23*(sin((W*N/2+pi*N/(N-1)))./sin(W/2+pi/(N-1)));

Whm(isnan(Whm)) = 0;
Whm(isinf(Whm)) = 0;

%% =========================================================
% BLACKMAN WINDOW
%===========================================================

WB = 0.42*Wr + ...
     0.25*(sin((W*N/2-pi*N/(N-1)))./sin(W/2-pi/(N-1))) + ...
     0.25*(sin((W*N/2+pi*N/(N-1)))./sin(W/2+pi/(N-1))) + ...
     0.04*(sin((W*N/2-2*pi*N/(N-1)))./sin(W/2-2*pi/(N-1))) + ...
     0.04*(sin((W*N/2+2*pi*N/(N-1)))./sin(W/2+2*pi/(N-1)));

WB(isnan(WB)) = 0;
WB(isinf(WB)) = 0;

%% =========================================================
% FIGURE 1
%===========================================================

figure('Name','Window Function Analysis',...
       'NumberTitle','off');

set(gcf,'Color','white');

annotation('textbox',[0 0.96 1 0.04],...
    'String','Comparative Frequency Spectrum Analysis of Window Functions',...
    'HorizontalAlignment','center',...
    'FontSize',14,...
    'FontWeight','bold',...
    'EdgeColor','none');

%% =========================================================
% RECTANGULAR WINDOW
%===========================================================

subplot(4,2,1)

plot(W/pi,20*log10(abs(Wr)+eps),...
    'b','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Rectangular Window Spectrum');

subplot(4,2,2)

plot(W/pi,unwrap(angle(Wr)),...
    'r','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Phase (Radians)');
title('Rectangular Window Phase');

%% =========================================================
% HANNING WINDOW
%===========================================================

subplot(4,2,3)

plot(W/pi,20*log10(abs(Whn)+eps),...
    'm','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Hanning Window Spectrum');

subplot(4,2,4)

plot(W/pi,unwrap(angle(Whn)),...
    'r','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Phase (Radians)');
title('Hanning Window Phase');

%% =========================================================
% HAMMING WINDOW
%===========================================================

subplot(4,2,5)

plot(W/pi,20*log10(abs(Whm)+eps),...
    'g','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Hamming Window Spectrum');

subplot(4,2,6)

plot(W/pi,unwrap(angle(Whm)),...
    'r','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Phase (Radians)');
title('Hamming Window Phase');

%% =========================================================
% BLACKMAN WINDOW
%===========================================================

subplot(4,2,7)

plot(W/pi,20*log10(abs(WB)+eps),...
    'k','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Magnitude (dB)');
title('Blackman Window Spectrum');

subplot(4,2,8)

plot(W/pi,unwrap(angle(WB)),...
    'r','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency');
ylabel('Phase (Radians)');
title('Blackman Window Phase');

%% Save First Figure

saveas(gcf,'Output.png');

disp('Output Figure Saved Successfully.');

%% =========================================================
% FIGURE 2 : COMPARISON OF WINDOW FUNCTIONS
%===========================================================

figure('Name','Comparison of Window Functions',...
       'NumberTitle','off');

set(gcf,'Color','white');

plot(W/pi,20*log10(abs(Wr)+eps),...
    'b','LineWidth',2);
hold on;

plot(W/pi,20*log10(abs(Whn)+eps),...
    'm','LineWidth',2);

plot(W/pi,20*log10(abs(Whm)+eps),...
    'g','LineWidth',2);

plot(W/pi,20*log10(abs(WB)+eps),...
    'k','LineWidth',2);

grid on;
box on;

xlabel('Normalized Frequency','FontSize',11);
ylabel('Magnitude (dB)','FontSize',11);

title('Comparison of Frequency Response of Window Functions',...
      'FontSize',13);

legend('Rectangular',...
       'Hanning',...
       'Hamming',...
       'Blackman',...
       'Location','Best');

axis([-1 1 -120 35]);

saveas(gcf,'Comparison.png');

disp('Comparison Figure Saved Successfully.');

%% =========================================================
% NUMERICAL SUMMARY
%===========================================================

disp(' ');
disp('===============================================');
disp('      WINDOW FUNCTION ANALYSIS SUMMARY');
disp('===============================================');

fprintf('\nWindow Length (N) : %d\n',N);

fprintf('\nWindows Analysed:\n');
disp('1. Rectangular Window');
disp('2. Hanning Window');
disp('3. Hamming Window');
disp('4. Blackman Window');

disp(' ');
disp('Expected Characteristics');
disp('---------------------------------------------');
disp('Rectangular : Highest Resolution, Highest Leakage');
disp('Hanning     : Moderate Leakage');
disp('Hamming     : Lower Leakage');
disp('Blackman    : Best Side-lobe Suppression');

disp(' ');
disp('Output Files Generated:');
disp('---------------------------------------------');
disp('1. Output.png');
disp('2. Comparison.png');

disp(' ');
disp('Project Completed Successfully.');
disp('===============================================');
