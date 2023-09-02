function SSE = fitexptau2(guess, x, y)
% SSE = fitexptau(guess, x, y);
% fit two exponentials to data to reflect the fast initial and slow rectifying current
% guess is a vector of initial guesses for amplitude and tau
% x and y are vectors of values (i.e. DATA.time and DATA.data set for a specific Iinj trace, respectively)
% SSE is the sum of squared errors

A1   = guess(1);
tau1 = guess(2);
A2   = guess(3);
tau2 = guess(4);
C    = guess(5);

Est = [A1.*exp(-x./tau1)]+[A2.*exp(-x./tau2)]+C;

SSE = sum( (Est-y).^2 );

%plot(x, y, 'ko')
%hold on
%plot(x, Est, 'r-', 'LineWidth', 2)
%hold off
%drawnow
