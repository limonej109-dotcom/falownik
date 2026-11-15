import numpy as np, sys
out = sys.argv[1]
N = 2**18
def sig(ma, mf):
    th = np.arange(N+1)/N*2*np.pi
    ph = (mf*th/(2*np.pi)) % 1.0
    tri = np.where(ph<0.5, 1-4*ph, -3+4*ph)
    ref = ma*np.sin(th)
    return th, tri, ref
def steps(th, u):
    # coordinates for const plot: value changes
    pts=[(th[0],u[0])]
    ch = np.nonzero(np.diff(u))[0]+1
    for i in ch: pts.append((th[i],u[i]))
    pts.append((th[-1],u[-1]))
    return " ".join(f"({x:.4f},{y:g})" for x,y in pts)
def tri_pts(mf):
    xs = np.arange(0, 2*mf+1)*np.pi/mf
    ys = [1 if k%2==0 else -1 for k in range(len(xs))]
    return " ".join(f"({x:.4f},{y})" for x,y in zip(xs,ys))
ma, mf = 0.8, 9
th,tri,ref = sig(ma,mf)
bip = np.where(ref>tri,1,-1)
ua = (ref>tri).astype(int); ub = ((-ref)>tri).astype(int)
uni = ua-ub

common_ax = r"""width=0.92\textwidth, xmin=0, xmax=6.2832, enlarge x limits=false,
      xtick={0,1.5708,3.1416,4.7124,6.2832},
      xticklabels={$0$,$\frac{\pi}{2}$,$\pi$,$\frac{3\pi}{2}$,$2\pi$},
      tick label style={font=\footnotesize}, label style={font=\small},
      grid=major, grid style={gray!25}"""

def write(name, body):
    open(f"{out}/{name}.tex","w").write(body)

write("rozdz2_pwm_bipolarna", rf"""% Przebiegi bipolarnej modulacji SPWM (m_a = {ma}, m_f = {mf}) -- wygenerowane skryptem
\begin{{tikzpicture}}
  \begin{{groupplot}}[group style={{group size=1 by 2, vertical sep=6mm, xticklabels at=edge bottom}},
      {common_ax}, height=4.6cm]
    \nextgroupplot[ymin=-1.25, ymax=1.25, ylabel={{$u_\mathrm{{tri}},\ u_\mathrm{{ref}}$}},
      ytick={{-1,0,1}}, legend style={{font=\footnotesize, at={{(1,1)}}, anchor=south east, legend columns=2, draw=none, fill=none}}]
      \addplot[gray, thin] coordinates {{{tri_pts(mf)}}};
      \addlegendentry{{$u_\mathrm{{tri}}$}}
      \addplot[black, very thick, domain=0:6.2832, samples=200] {{{ma}*sin(deg(x))}};
      \addlegendentry{{$u_\mathrm{{ref}}$}}
    \nextgroupplot[ymin=-1.35, ymax=1.35, ylabel={{$u_\mathrm{{o}}/U_\mathrm{{DC}}$}}, xlabel={{$\omega_1 t$}},
      ytick={{-1,0,1}}]
      \addplot[black, const plot, thin] coordinates {{{steps(th,bip)}}};
      \addplot[black, dashed, thick, domain=0:6.2832, samples=200] {{{ma}*sin(deg(x))}};
  \end{{groupplot}}
\end{{tikzpicture}}
""")

write("rozdz2_pwm_unipolarna", rf"""% Przebiegi unipolarnej modulacji SPWM (m_a = {ma}, m_f = {mf}) -- wygenerowane skryptem
\begin{{tikzpicture}}
  \begin{{groupplot}}[group style={{group size=1 by 4, vertical sep=5mm, xticklabels at=edge bottom}},
      {common_ax}]
    \nextgroupplot[height=4.6cm, ymin=-1.25, ymax=1.25, ylabel={{$u_\mathrm{{tri}},\ \pm u_\mathrm{{ref}}$}},
      ytick={{-1,0,1}}, legend style={{font=\footnotesize, at={{(1,1)}}, anchor=south east, legend columns=3, draw=none, fill=none}}]
      \addplot[gray, thin] coordinates {{{tri_pts(mf)}}};
      \addlegendentry{{$u_\mathrm{{tri}}$}}
      \addplot[black, very thick, domain=0:6.2832, samples=200] {{{ma}*sin(deg(x))}};
      \addlegendentry{{$u_\mathrm{{ref}}$}}
      \addplot[black, very thick, densely dotted, domain=0:6.2832, samples=200] {{-{ma}*sin(deg(x))}};
      \addlegendentry{{$-u_\mathrm{{ref}}$}}
    \nextgroupplot[height=3.0cm, ymin=-0.25, ymax=1.3, ylabel={{$s_\mathrm{{a}}$}}, ytick={{0,1}}]
      \addplot[black, const plot, thin] coordinates {{{steps(th,ua)}}};
    \nextgroupplot[height=3.0cm, ymin=-0.25, ymax=1.3, ylabel={{$s_\mathrm{{b}}$}}, ytick={{0,1}}]
      \addplot[black, const plot, thin] coordinates {{{steps(th,ub)}}};
    \nextgroupplot[height=4.2cm, ymin=-1.35, ymax=1.35, ylabel={{$u_\mathrm{{o}}/U_\mathrm{{DC}}$}}, xlabel={{$\omega_1 t$}},
      ytick={{-1,0,1}}]
      \addplot[black, const plot, thin] coordinates {{{steps(th,uni)}}};
      \addplot[black, dashed, thick, domain=0:6.2832, samples=200] {{{ma}*sin(deg(x))}};
  \end{{groupplot}}
\end{{tikzpicture}}
""")

# widma
ma2, mf2 = 0.8, 21
th,tri,ref = sig(ma2,mf2)
th,tri,ref = th[:-1],tri[:-1],ref[:-1]
b = np.where(ref>tri,1.0,-1.0)
u = (ref>tri).astype(float)-((-ref)>tri).astype(float)
def spec(x, hmax=3*mf2+6):
    U = np.abs(np.fft.rfft(x))*2/len(x)
    return " ".join(f"({h},{U[h]:.3f})" for h in range(1,hmax+1) if U[h]>0.01)
write("rozdz2_widma", rf"""% Widma amplitudowe napiecia u_o dla m_a = {ma2}, m_f = {mf2} -- wygenerowane skryptem (FFT)
\begin{{tikzpicture}}
  \begin{{groupplot}}[group style={{group size=1 by 2, vertical sep=14mm, xticklabels at=edge bottom}},
      width=0.92\textwidth, height=4.4cm, xmin=0, xmax={3*mf2+6}, ymin=0, ymax=1.0,
      ytick={{0,0.2,0.4,0.6,0.8,1}},
      xtick={{1,{mf2},{2*mf2},{3*mf2}}}, xticklabels={{$1$,$m_\mathrm{{f}}$,$2m_\mathrm{{f}}$,$3m_\mathrm{{f}}$}},
      tick label style={{font=\footnotesize}}, label style={{font=\small}},
      ymajorgrids, grid style={{gray!25}}, ylabel={{$\hat U_{{\mathrm{{o}}(h)}}/U_\mathrm{{DC}}$}}]
    \nextgroupplot[title={{\small a) modulacja bipolarna}}]
      \addplot[ycomb, black, line width=1.6pt, mark=none] coordinates {{{spec(b)}}};
    \nextgroupplot[title={{\small b) modulacja unipolarna}}, xlabel={{rząd harmonicznej $h$}}]
      \addplot[ycomb, black, line width=1.6pt, mark=none] coordinates {{{spec(u)}}};
  \end{{groupplot}}
\end{{tikzpicture}}
""")
print("ok")
