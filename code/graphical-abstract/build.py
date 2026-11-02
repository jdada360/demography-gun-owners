#!/usr/bin/env python3
"""Generate three graphical-abstract concepts for the gun-ownership demography paper.

Elsevier spec: minimum 1328 x 531 px (2.5:1), 300 dpi, Arial/Times/Courier/Symbol only,
legible when shrunk to roughly 500 x 200 px in the table of contents.

Canvas here is 2100 x 840 px = 7.0 x 2.8 in at 300 dpi, same 2.5:1 ratio.

All values are from Table 1 and the female-share-by-race figure of the manuscript
(source of truth: tables/summary-year-2.tex and
figures/female-share-by-race-pooled-periods.png in the Overleaf folder).
"""

import os

W, H = 2100, 840
OUT = os.path.join(os.path.dirname(__file__), "..", "..", "output", "graphical-abstract")

# ---------------------------------------------------------------- data

YEARS = [2013, 2015, 2017, 2019, 2021, 2023, 2025]

PREVALENCE = [22, 20, 25, 27, 29, 27, 33]          # % of adults who own a gun
FEMALE     = [27, 28, 31, 30, 35, 33, 39]          # % of gun owners who are female
BLACK      = [6.2, 6.6, 7.6, 8.6, 7.6, 11, 13]     # % of gun owners, Black non-Hispanic
WHITE      = [80, 81, 77, 72, 74, 70, 71]
SOUTH      = [42, 44, 43, 47, 43, 48, 48]
WEST       = [22, 20, 19, 17, 21, 19, 16]

# pooled 2013-2019 -> 2021-2025, % female within racial/ethnic group
FEMALE_BY_RACE = [
    ("White, non-Hispanic", 29, 36),
    ("Black, non-Hispanic", 30, 42),
    ("Hispanic",            28, 30),
    ("Other",               27, 32),
]

N_OWNERS = "5,494"
N_TOTAL = "16,709"
SOURCE = "National Survey of Gun Policy · 7 biennial waves, 2013–2025"
SAMPLE = f"N = {N_OWNERS} adult gun owners of {N_TOTAL} respondents"

# ---------------------------------------------------------------- palette
# matches ggthemes::scale_color_economist as used in the paper's figure

C_START = "#01a2d9"   # early period / 2013
C_END   = "#014d64"   # late period / 2025
C_LINE  = "#B9C6CB"   # connectors, muted series
C_INK   = "#16242B"   # primary text
C_MUTE  = "#6E7F87"   # secondary text
C_PALE  = "#DCE6E9"   # neutral fill (e.g. male, White share)
C_MID   = "#8FB3BF"   # tertiary fill
C_BAND  = "#F2F6F7"
C_NEUT  = "#C3D4DA"   # neutral bar fill (Male, White share)   # footer band

FONT = "Arial, Helvetica, sans-serif"


def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def text(x, y, s, size=20, fill=C_INK, weight="normal", anchor="start",
         spacing=None, style=""):
    extra = f' letter-spacing="{spacing}"' if spacing else ""
    if style:
        extra += f' font-style="{style}"'
    return (f'<text x="{x:.1f}" y="{y:.1f}" font-family="{FONT}" font-size="{size}" '
            f'font-weight="{weight}" fill="{fill}" text-anchor="{anchor}"{extra}>'
            f'{esc(s)}</text>')


def rich(x, y, runs, size=20, fill=C_MUTE, anchor="start"):
    """A line of text with per-run weight/colour. runs = [(string, weight, fill), ...]"""
    spans = "".join(
        f'<tspan font-weight="{w}" fill="{c}">{esc(s)}</tspan>' for s, w, c in runs)
    return (f'<text x="{x:.1f}" y="{y:.1f}" font-family="{FONT}" font-size="{size}" '
            f'fill="{fill}" text-anchor="{anchor}" xml:space="preserve">{spans}</text>')


def chip(x, y, label, col, size=19):
    return (f'<rect x="{x:.1f}" y="{y-13:.1f}" width="20" height="20" rx="4" fill="{col}"/>'
            + text(x + 28, y + 4, label, size=size, fill=C_MUTE))


def fmt(v):
    """Format a percentage the way the manuscript does."""
    return f"{v:g}%"


def sparkline(vals, x, y, w, h, pad=0.18):
    """Polyline + endpoint dots for a 7-wave series. Returns (svg, last_x, last_y)."""
    lo, hi = min(vals), max(vals)
    span = (hi - lo) or 1
    lo -= span * pad
    hi += span * pad
    def px(i):
        return x + w * i / (len(vals) - 1)
    def py(v):
        return y + h - h * (v - lo) / (hi - lo)
    pts = " ".join(f"{px(i):.1f},{py(v):.1f}" for i, v in enumerate(vals))
    g = [f'<polyline points="{pts}" fill="none" stroke="{C_LINE}" '
         f'stroke-width="6" stroke-linejoin="round" stroke-linecap="round"/>']
    for i, v in enumerate(vals):
        if i in (0, len(vals) - 1):
            continue
        g.append(f'<circle cx="{px(i):.1f}" cy="{py(v):.1f}" r="5.5" fill="{C_LINE}"/>')
    g.append(f'<circle cx="{px(0):.1f}" cy="{py(vals[0]):.1f}" r="11" fill="{C_START}"/>')
    g.append(f'<circle cx="{px(len(vals)-1):.1f}" cy="{py(vals[-1]):.1f}" r="15" fill="{C_END}"/>')
    return "".join(g), px(0), py(vals[0]), px(len(vals) - 1), py(vals[-1])


def person(x, y, s, fill):
    """Simple standing-person glyph, roughly 20x36 units before scaling."""
    return (f'<g transform="translate({x:.1f},{y:.1f}) scale({s:.4f})" fill="{fill}">'
            f'<circle cx="0" cy="-26" r="8.5"/>'
            f'<path d="M -9.5 -15 Q -9.5 -17.5 0 -17.5 Q 9.5 -17.5 9.5 -15 '
            f'L 8 4 L 3.2 4 L 2.4 -8 L -2.4 -8 L -3.2 4 L -8 4 Z"/>'
            f'<rect x="-8" y="4" width="6.2" height="14" rx="2.4"/>'
            f'<rect x="1.8" y="4" width="6.2" height="14" rx="2.4"/>'
            f'</g>')


def frame(body):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" '
            f'viewBox="0 0 {W} {H}">'
            f'<rect width="{W}" height="{H}" fill="#FFFFFF"/>{body}</svg>')


# ================================================================ Concept A
# All three shifts, chart-led minimal: one sparkline per shift.

def concept_a():
    g = []
    g.append(text(60, 78, "US gun owners became more female, more racially diverse, "
                          "and more Southern", size=44, weight="bold"))
    g.append(text(60, 116, SOURCE + " · " + SAMPLE, size=21, fill=C_MUTE))
    g.append(f'<line x1="60" y1="146" x2="{W-60}" y2="146" stroke="{C_PALE}" stroke-width="3"/>')

    # ---- left rail: overall prevalence, full height
    g.append(text(60, 206, "ADULTS WHO OWN A GUN", size=20, weight="bold",
                  fill=C_MUTE, spacing="1.6"))
    spark, x0, y0, x1, y1 = sparkline(PREVALENCE, 90, 290, 230, 200)
    g.append(spark)
    g.append(text(x0, y0 - 32, "22%", size=40, weight="bold", fill=C_START,
                  anchor="middle"))
    g.append(text(x0, y0 + 44, "2013", size=20, fill=C_MUTE, anchor="middle"))
    g.append(text(x1 + 26, y1 + 22, "33%", size=78, weight="bold", fill=C_END))
    g.append(text(x1 + 30, y1 + 58, "2025", size=21, fill=C_MUTE))
    g.append(text(60, 612, "+11 percentage points", size=26, weight="bold"))
    g.append(text(60, 648, "in gun ownership prevalence", size=26, fill=C_MUTE))

    g.append(f'<line x1="505" y1="180" x2="505" y2="690" stroke="{C_PALE}" stroke-width="3"/>')

    # ---- three panels
    panels = [
        ("Female",              "share of all gun owners", FEMALE, 27, 39),
        ("Black, non-Hispanic", "share of all gun owners", BLACK, 6.2, 13),
        ("South",               "share of all gun owners", SOUTH, 42, 48),
    ]
    xs = [550, 1055, 1560]
    for (lab, sub, vals, a, b), px0 in zip(panels, xs):
        g.append(text(px0, 206, lab, size=30, weight="bold"))
        g.append(text(px0, 236, sub, size=20, fill=C_MUTE))
        spark, sx0, sy0, sx1, sy1 = sparkline(vals, px0, 290, 275, 130)
        g.append(spark)
        g.append(text(px0 - 4, sy0 - 26, fmt(a), size=30, weight="bold", fill=C_START))
        g.append(text(px0 + 300, sy1 + 22, fmt(b), size=66, weight="bold", fill=C_END))
        g.append(text(px0, 452, "2013", size=19, fill=C_MUTE))
        g.append(text(px0 + 275, 452, "2025", size=19, fill=C_MUTE, anchor="middle"))

    # ---- counterweights
    g.append(f'<line x1="550" y1="520" x2="{W-60}" y2="520" stroke="{C_PALE}" stroke-width="3"/>')
    g.append(rich(550, 575, [
        ("Meanwhile the ", "normal", C_MUTE),
        ("White, non-Hispanic", "bold", C_INK), (" share fell ", "normal", C_MUTE),
        ("80% → 71%", "bold", C_END), ("     and the ", "normal", C_MUTE),
        ("West’s", "bold", C_INK), (" share fell ", "normal", C_MUTE),
        ("22% → 16%", "bold", C_END)], size=29))
    g.append(text(550, 645, "Time trends in ownership differ by gender (p=0.004), "
                            "race and ethnicity (p<0.001), and region (p=0.037)",
                  size=22, fill=C_MUTE, style="italic"))

    # ---- footer
    g.append(f'<rect x="0" y="710" width="{W}" height="{H-710}" fill="{C_BAND}"/>')
    g.append(text(60, 782, "The gun-owning population is neither homogeneous nor static — "
                           "prevention strategies and public health messaging must evolve with it.",
                  size=30, weight="bold", fill=C_END))
    return frame("".join(g))


# ================================================================ Concept B
# Diversification, pictogram: 10x10 person grids + the paper's dumbbell figure.

def concept_b():
    g = []
    g.append(text(60, 76, "Who owns a gun in America has changed",
                  size=44, weight="bold"))
    g.append(text(60, 114, SOURCE + " · " + SAMPLE, size=21, fill=C_MUTE))
    g.append(f'<line x1="60" y1="144" x2="{W-60}" y2="144" stroke="{C_PALE}" stroke-width="3"/>')

    g.append(text(60, 196, "OF EVERY 100 GUN OWNERS", size=20, weight="bold",
                  fill=C_MUTE, spacing="1.6"))

    # ---- two 10x10 person grids, female highlighted
    def grid(ox, oy, n_female, year, pct):
        out = [text(ox, oy - 20, str(year), size=32, weight="bold", fill=C_MUTE)]
        step = 40
        k = 0
        for r in range(10):
            for c in range(10):
                k += 1
                fill = C_START if k <= n_female else C_PALE
                out.append(person(ox + c * step + 14, oy + r * step + 34, 0.72, fill))
        out.append(text(ox, oy + 10 * step + 66, f"{pct}% were women",
                        size=32, weight="bold", fill=C_END))
        return "".join(out)

    g.append(grid(60, 250, 27, 2013, 27))
    g.append(text(505, 490, "→", size=96, weight="bold", fill=C_MUTE, anchor="middle"))
    g.append(grid(580, 250, 39, 2025, 39))

    g.append(f'<line x1="1055" y1="180" x2="1055" y2="700" stroke="{C_PALE}" stroke-width="3"/>')

    # ---- right: female share within each racial/ethnic group (the paper's Figure)
    g.append(text(1105, 196, "SHARE OF EACH GROUP'S OWNERS WHO ARE WOMEN",
                  size=20, weight="bold", fill=C_MUTE, spacing="1.2"))
    g.append(text(1105, 232, "2013–2019 pooled → 2021–2025 pooled",
                  size=21, fill=C_MUTE))

    bx, bw = 1480, 480
    lo, hi = 25, 44
    def dx(v):
        return bx + bw * (v - lo) / (hi - lo)
    for i, (lab, a, b) in enumerate(FEMALE_BY_RACE):
        y = 300 + i * 86
        g.append(text(1105, y + 10, lab, size=27, weight="bold"))
        g.append(f'<line x1="{dx(a):.1f}" y1="{y}" x2="{dx(b):.1f}" y2="{y}" '
                 f'stroke="{C_LINE}" stroke-width="13" stroke-linecap="round"/>')
        g.append(f'<circle cx="{dx(a):.1f}" cy="{y}" r="13" fill="{C_START}"/>')
        g.append(f'<circle cx="{dx(b):.1f}" cy="{y}" r="17" fill="{C_END}"/>')
        g.append(text(dx(a) - 24, y + 10, fmt(a), size=25, fill=C_START,
                      weight="bold", anchor="end"))
        g.append(text(dx(b) + 26, y + 11, fmt(b), size=34, fill=C_END, weight="bold"))

    # ---- right footer: race composition
    g.append(f'<line x1="1105" y1="652" x2="{W-60}" y2="652" stroke="{C_PALE}" stroke-width="3"/>')
    g.append(text(1105, 700, "Black, non-Hispanic share of all gun owners",
                  size=24, fill=C_MUTE))
    g.append(text(1105, 752, "6.2%", size=52, weight="bold", fill=C_START))
    g.append(text(1230, 750, "→", size=46, fill=C_MUTE))
    g.append(text(1300, 754, "13%", size=62, weight="bold", fill=C_END))
    g.append(text(1450, 752, "more than doubled in 12 years",
                  size=26, fill=C_INK, style="italic"))
    return frame("".join(g))


# ================================================================ Concept C
# Growth, then composition: one big slope + 100% stacked composition bars.

def concept_c():
    g = []
    g.append(text(60, 76, "More Americans own guns — and they are a different population",
                  size=44, weight="bold"))
    g.append(text(60, 114, SOURCE + " · " + SAMPLE, size=21, fill=C_MUTE))
    g.append(f'<line x1="60" y1="144" x2="{W-60}" y2="144" stroke="{C_PALE}" stroke-width="3"/>')

    # ---- left: prevalence slope, large
    g.append(text(60, 198, "ADULTS WHO OWN A GUN", size=20, weight="bold",
                  fill=C_MUTE, spacing="1.6"))
    spark, x0, y0, x1, y1 = sparkline(PREVALENCE, 150, 290, 300, 250)
    g.append(spark)
    g.append(text(140, y0 - 30, "22%", size=48, weight="bold", fill=C_START,
                  anchor="middle"))
    g.append(text(140, y0 + 42, "2013", size=21, fill=C_MUTE, anchor="middle"))
    g.append(text(478, y1 + 22, "33%", size=92, weight="bold", fill=C_END))
    g.append(text(482, y1 + 60, "2025", size=22, fill=C_MUTE))
    g.append(rich(60, 640, [("+11 percentage points", "bold", C_INK),
                            (" across seven", "normal", C_MUTE)], size=25))
    g.append(text(60, 676, "biennial waves", size=25, fill=C_MUTE))

    g.append(f'<line x1="760" y1="180" x2="760" y2="700" stroke="{C_PALE}" stroke-width="3"/>')

    # ---- right: three 100% stacked composition bars, 2013 vs 2025
    g.append(text(810, 198, "AND WHO THEY ARE", size=20, weight="bold",
                  fill=C_MUTE, spacing="1.6"))

    bars = [
        ("Gender", [("Female", 27, C_START), ("Male", 73, C_NEUT)],
                   [("Female", 39, C_START), ("Male", 60, C_NEUT), ("Other", 1, C_MID)],
         [("Female", C_START), ("Male", C_NEUT)]),
        ("Race and ethnicity",
                   [("White", 80, C_NEUT), ("Black", 6.2, C_END),
                    ("Hispanic", 8.5, C_START), ("Other", 5.3, C_MID)],
                   [("White", 71, C_NEUT), ("Black", 13, C_END),
                    ("Hispanic", 10, C_START), ("Other", 6, C_MID)],
         [("White", C_NEUT), ("Black", C_END), ("Hispanic", C_START), ("Other", C_MID)]),
        ("Region", [("Northeast", 13, C_NEUT), ("Midwest", 23, C_MID),
                    ("South", 42, C_END), ("West", 22, C_START)],
                   [("Northeast", 15, C_NEUT), ("Midwest", 21, C_MID),
                    ("South", 48, C_END), ("West", 16, C_START)],
         [("Northeast", C_NEUT), ("Midwest", C_MID), ("South", C_END), ("West", C_START)]),
    ]
    bx, bw, bh = 900, 740, 44
    highlight = {"Gender": "Female", "Race and ethnicity": "Black", "Region": "South"}
    for i, (name, y13, y25, legend) in enumerate(bars):
        top = 248 + i * 160
        # legend chips on their own line above the bars
        lx = 810
        for lab, col in legend:
            g.append(chip(lx, top - 4, lab, col, size=18))
            lx += 40 + 9.6 * len(lab)
        key = highlight[name]
        hv = [v for lab, v, _ in y25 if lab == key][0]
        pv = [v for lab, v, _ in y13 if lab == key][0]
        for j, (yr, segs) in enumerate(((2013, y13), (2025, y25))):
            y = top + 22 + j * (bh + 12)
            g.append(text(810, y + 31, str(yr), size=23, fill=C_MUTE))
            cx = bx
            for lab, v, col in segs:
                wseg = bw * v / 100.0
                g.append(f'<rect x="{cx:.1f}" y="{y}" width="{wseg:.1f}" height="{bh}" '
                         f'fill="{col}"/>')
                if lab == key and wseg > 110:
                    g.append(text(cx + wseg / 2, y + 31, fmt(v), size=26, weight="bold",
                                  fill="#FFFFFF", anchor="middle"))
                cx += wseg
        g.append(rich(bx + bw + 24, top + 76,
                      [(f"{key} ", "bold", C_INK), (f"{fmt(pv)} → ", "normal", C_MUTE),
                       (fmt(hv), "bold", C_END)], size=27))

    # ---- footer
    g.append(f'<rect x="0" y="736" width="{W}" height="{H-736}" fill="{C_BAND}"/>')
    g.append(text(60, 798, "The gun-owning population is neither homogeneous nor static — "
                           "prevention strategies and public health messaging must evolve with it.",
                  size=29, weight="bold", fill=C_END))
    return frame("".join(g))


# ================================================================ main

if __name__ == "__main__":
    os.makedirs(OUT, exist_ok=True)
    for name, fn in (("concept-a", concept_a), ("concept-b", concept_b),
                     ("concept-c", concept_c)):
        path = os.path.join(OUT, name + ".svg")
        with open(path, "w") as f:
            f.write(fn())
        print("wrote", os.path.realpath(path))
