Zc = @(f, C) 1 ./ (1j*2*pi*f*C);
Zl = @(f, L) (1j*2*pi*f*L);

par = @(Zx, Zy) (Zx .* Zy)./(Zx + Zy);
