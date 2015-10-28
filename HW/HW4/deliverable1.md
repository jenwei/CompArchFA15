\\ Why "gating the clock" is a bad idea in practice \\

"Gating the clock" is bad because of the side effects of having the `enable` signal glitch. What happens then is that the `enable` glitch will send false positive edges, meaning that more positive edges will appear than expected (returned positive edges > actual positive edges, which is not what we'd want).
