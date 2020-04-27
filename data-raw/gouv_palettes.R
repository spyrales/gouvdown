# Definition des palettes
gouv_palettes <- list(
  "pal_gouv_fr" = gouv_colors("bleu_france", "blanc", "rouge_marianne"),
  "pal_gouv_a" = gouv_colors("a0", "a1", "a2", "a3", "a4"),
  "pal_gouv_b" = gouv_colors("b0", "b1", "b2", "b3", "b4"),
  "pal_gouv_c" = gouv_colors("c0", "c1", "c2", "c3", "c4"),
  "pal_gouv_d" = gouv_colors("d0", "d1", "d2", "d3", "d4"),
  "pal_gouv_e" = gouv_colors("e0", "e1", "e2", "e3", "e4"),
  "pal_gouv_f" = gouv_colors("f0", "f1", "f2", "f3", "f4"),
  "pal_gouv_g" = gouv_colors("g0", "g1", "g2", "g3", "g4"),
  "pal_gouv_h" = gouv_colors("h0", "h1", "h2", "h3", "h4"),
  "pal_gouv_i" = gouv_colors("i0", "i1", "i2", "i3", "a4"),
  "pal_gouv_j" = gouv_colors("j0", "j1", "j2", "j3", "j4"),
  "pal_gouv_k" = gouv_colors("k0", "k1", "k2", "k3", "k4"),
  "pal_gouv_l" = gouv_colors("l0", "l1", "l2", "l3", "l4"),
  "pal_gouv_m" = gouv_colors("m0", "m1", "m2", "m3", "m4"),
  "pal_gouv_n" = gouv_colors("n0", "n1", "n2", "n3", "n4"),
  "pal_gouv_o" = gouv_colors("o0", "o1", "o2", "o3", "o4"),
  "pal_gouv_p" = gouv_colors("p0", "p1", "p2", "p3", "p4"),
  "pal_gouv_q" = gouv_colors("q0", "q1", "q2", "q3", "a4"),
  "pal_gouv_r" = gouv_colors("r1", "r2", "r3", "r4"),
  "pal_gouv_qual1" = gouv_colors(paste0(letters[1:18], "1")),
  "pal_gouv_qual2" = gouv_colors("c1", "f1", "h1", "k1", "p1"),
  "pal_gouv_div1" = gouv_colors("f0", "f1", "f2", "f3", "f4", "h4", "h3", "h2", "h1", "h0"),
  "pal_gouv_div2" = gouv_colors("p0", "p1", "p2", "p3", "p4", "c4", "c3", "c2", "c1", "c0")
)

usethis::use_data(gouv_palettes)
