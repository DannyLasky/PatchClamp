function SSE = fitexptau1(guess, x, y)
% SSE = fitexptau1(guess, x, y);
% fit a 'single' exponential to data
% Guess is a vector of initial guesses for amplitude and tau
% x and y are vectors of values (i.e. DATA.time and DATA.data set for a specific Iinj trace, respectively)
% SSE is the sum of squared errors

A   = guess(1);
tau = guess(2);
C   = guess(3);

Est = A.*exp(-x./tau)+C;

SSE = sum( (Est-y).^2 );

%plot(x, y, 'ko')
%hold on
%plot(x, Est, 'r-', 'LineWidth', 2)
%hold off
%drawnow
