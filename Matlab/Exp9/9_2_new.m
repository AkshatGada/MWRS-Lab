%% EXPERIMENT 9 - PERFORMANCE ANALYSIS OF RAYLEIGH FADING CHANNEL MODEL
%% PART 3 : BFSK in Rayleigh Fading
% Monte Carlo simulation to estimate and plot the error probability of a 
% binary orthogonal signaling (BFSK) communication system in Rayleigh fading.

clc; clear;

%% Parameters
EbNo_dB = 0:5:35;   % Eb/N0 range in dB
Eb      = 1;        % Energy per bit
sigma   = 1;        % Rayleigh fading parameter (variance = sigma^2)
N       = 1e5;      % Number of bits (Monte Carlo trials)

BER_sim = zeros(size(EbNo_dB));

for i = 1:length(EbNo_dB)
    No_over_2 = Eb * 10^(-EbNo_dB(i)/10);
    
    alpha = sigma * sqrt(-2 * log(rand(1, N)));   % Rayleigh
    noise = sqrt(No_over_2) * randn(1, N);        % AWGN (real)
    
    y = alpha * sqrt(Eb) + noise;
    
  
    decisions   = (y <= 0);
    num_errors  = sum(decisions);
    
    BER_sim(i) = num_errors / N;
end


rho_b  = 10.^(EbNo_dB/10) * (sigma^2);
BER_th = 0.5 * (1 - sqrt(rho_b ./ (1 + rho_b)));

semilogy(EbNo_dB, BER_sim, '-*', EbNo_dB, BER_th, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate (BER)');
title('Monte Carlo Simulation of BFSK in Rayleigh Fading');
legend('Simulation','Theory','Location','Best');
