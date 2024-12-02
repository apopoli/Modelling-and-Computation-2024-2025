function [int] = int_adt(a,b,f,n,tol)
%INT_ADT Integrates a 1D function with adaptive tolerance
%   a,b: left and right boundaries of the domain
%   f: handle to integrand function
%   n: number of Gauss points to be used
%   tol: relative tolerance value

I1 = int_gauss(a,b,f,n);

mp = (a+b)/2;
I2 = int_gauss(a,mp,f,n) + int_gauss(mp,b,f,n);

abs_err = abs(I1-I2);
err = max(abs_err,abs((I1-I2)/I2)); % relative error

if err<=tol
    int = I2; % assign I2 to output
else % if I1 is too different from I2, we need to split further
    I_L = int_adt(a,mp,f,n,tol); % call "mother" function on (left) half-interval
    I_R = int_adt(mp,b,f,n,tol); % call "mother" function on (right) half-interval
    int = I_L + I_R; % sum of two partial integrals
end

end

