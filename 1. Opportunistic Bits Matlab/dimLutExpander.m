dim_lut = [0 1 2 3];
size = 1024*32;
dim = zeros(size,1)
dim(1:4,1) = dim_lut
i_next = 5;
i_curr = 3;
i_addd = 4;
while i_next ~= size+1
   dim(i_next) = dim(i_curr) + dim(i_addd);
   i_next = i_next + 1;
   i_curr = i_curr + 1;
   dim(i_next) = dim(i_curr) + dim(i_addd);
   i_next = i_next + 1;
   i_curr = i_curr + 1;
   i_addd = i_addd + 1;
end
dim;