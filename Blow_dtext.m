function [ X ] = Blow_dtext(plte, pbox, sbox )
xl = plte(1:4);

xr = plte(5:8);

n = 19;
for i =1 : 16
    for j = 1 :4
        xl(1,j) = bitxor(xl(1,j),pbox(n-i,j));
    end
    F = Ffunction(xl,sbox);
    for j = 1: 4
        xr(1,j) = bitxor(xr(1,j),F(1,j));
    end
    temp = xl;
    xl = xr;
    xr = temp;
end
temp = xl;
xl = xr;
xr = temp;
p1 = pbox(2,:);
p2 = pbox(1,:);

for j =1:4
    xr(1,j) = bitxor(xr(1,j),p1(1,j));
    xl(1,j) = bitxor(xl(1,j),p2(1,j));
end
X = horzcat(xl,xr);
end
