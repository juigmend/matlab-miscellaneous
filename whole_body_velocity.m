% whole-body velocity
% this should work, you can choose any if the two flavors:

d_filled = mcfillgaps(d);
d_vel = mctimeder(d_filled);
d_norm = mcnorm(d_vel);
wb_vel = sum(d_norm.data,2);

s_vel = abs(diff(mcspread(d),2));

figure
n_sp = 2;
i_sp = 0;

i_sp = i_sp + 1;
subplot(n_sp,1,i_sp)
plot(wb_vel)
title('magnitude of whole-body velocity')

i_sp = i_sp + 1;
subplot(n_sp,1,i_sp)
plot(s_vel)
title('magnitude of spread velocity')
