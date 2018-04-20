a = 1;
b = -1;
an = @(a,b) 1 - 3 * a - b;
alist = zeros(100,1);
alist(1) = 1;
alist(2) = -1;
for i = 3:100
    alist(i) = an(alist(i-2),alist(i-1));
end

alist