function [int] = int_gauss(a,b,f,n)
    % a, b: left and right ends of interval
    % f: handle to integrand function
    % n: number of Gauss points to be used

    m = (b-a)/2;
    q = (a+b)/2;

    switch n
        case(1) % when n = 1
            w = 2;
            tau = 0;
        case(2)
            w = [1 1];
            tau = [-1/sqrt(3) 1/sqrt(3)];
        case(3)
            w = [5/9 8/9 5/9];
            tau = [-sqrt(3/5) 0 sqrt(3/5)];
    end

    int = m*sum(w.*f(m*tau+q));

    % if n = 2
    % w(1)*f(m*tau(1)+q) + w(2)*f(m*tau(2)+q)
end
