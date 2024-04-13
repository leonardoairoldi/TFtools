% Frequency range builders
frangelin = @(low, high, step) low:step:high;
frangelog = @(low, high, pointsindec) logspace(log10(low), log10(high), ceil(log10(high/low) * pointsindec));

%% Transfer Function
% A transfer function can be built as
%   f = frequency vector
%
%   tf = polef(f, fp) .* zero(f, fp) .* ...
%   
% This returns a tf vector calculated in the frequency range
% For a symolic transfer function maintaining the dependance on f,
% build the tf using a function handle depending on f
%
%   tff = @(f) polef(f, fp) .* zero(f, fp) .* ...
%
% You can then feed in f a vector or point, the result will be a tf
% vector calculated in the given f range.


% Add transfer function building blocks
% Pole
poletau = @(f, tau) 1 ./ (1 + 1j*2*pi*f*tau);
polef = @(f, fpole) 1 ./ (1 + 1j*f/fpole);
poleorigin = @(f, C) 1 ./ (1j*2*pi*f*C);
% Zero
zerotau = @(f, tau) (1 + 1j*2*pi*f*tau);
zerof = @(f, fzero) (1 + 1j*f/fzero);
zeroorigin = @(f, L) (1j*f*L);
% Complex Conjugate Pole - Zero
poleccfQ = @(f, fcc, Q) 1 ./ (1 + (1j * f / (fcc * Q)) + (1j*f).^2 / fcc^2);
zeroccfQ = @(f, fcc, Q) (1 + (1j * f / (fcc * Q)) + (1j*f).^2 / fcc^2);


%% Analisys
%cutoff3dBafter = @(tff, fplateu) 

%% Plotting
% Set global graph settings with grid on
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

bodemag = @(tf) abs(tf);
bodephase = @(tf) unwrap(atan2(imag(tf), real(tf)));

plotdb = @(f, tf) semilogx(f, 20*log10(bodemag(tf)));
plotbode = @(f, tf) loglog(f, bodemag(tf));
plotphase = @(f, tf) semilogx(f, rad2deg(bodephase(tf)), '--');
plotlinlin = @(f, tf) plot(f, bodemag(tf));
plotsemilog = @(f, tf) semilogx(f, bodemag(tf));