%%
dxl_SerialOpen('COM7')

%%
dxl_SerialClose()

%%
displ = [18, -6, -60];

%%
displ = [-2,20,145]

%%
RRR_reverse(dh, displ, 0)

%%
RRR_forward(dh)

%%
RRR_FDA(dh, 45)

%%
RRR_RDA(dh)

%%
SHELL_RRR_go_configuration(dh, displ, 1);

%%
