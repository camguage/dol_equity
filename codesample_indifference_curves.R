# this code creates the base visualizations used "Asymmetric Partisan Voter Turnout Games"
# it produces "indifference" curves for supporters of candidate A and candidate B based on the probabilities of different electoral outcomes

# calculates the probability that candidate A wins the election

count0 = 0
count1 = 0
count2 = 0
A_wins = function(n, pa, qa, qb) {
  pb = 1 - pa
  A = ceiling(n*pa)
  B = ceiling(n*pb)
  A_wins_conditional = function(i) {
    j = seq(from = i + 1, to = A, by = 1)
    for (val in j) {
      l = choose(A, val) * (qa ^ val) * ((1 - qa) ^ (A - val))
      count0 = count0 + l
    }
    count1 = count0*(choose(B, i) * (qb ^ i) * (1 - qb) ^ (B - i))
    print(count1)
  }
  k = seq(from = 0, to = B, by = 1)
  for (i in k) {
    m = A_wins_conditional(i)
    count2 = count2 + m
  }
  print(count2)
}

# calculates the probability that candidate B wins the election

count0 = 0
count1 = 0
count2 = 0
B_wins = function(n, pa, qa, qb) {
  pb = 1 - pa
  A = ceiling(n*pa)
  B = ceiling(n*pb)
B_wins_conditional = function(i) {
  j = seq(from = i + 1, to = B, by = 1)
  for (val in j) {
    l = choose(B, val) * (qb ^ val) * ((1 - qb) ^ (B - val))
    count0 = count0 + l
  }
  count1 = count0*(choose(A, i) * (qa ^ i) * (1 - qa) ^ (A - i))
  print(count1)
}
k = seq(from = 0, to = B - 1, by = 1)
for (i in k) {
  m = B_wins_conditional(i)
  count2 = count2 + m
}
print(count2)
}

# calculates the probability that the election results in a tie

count0 = 0
tie = function(n, pa, qa, qb) {
  pb = 1 - pa
  A = ceiling(n*pa)
  B = ceiling(n*pb)
  k = seq(from = 0, to = B, by = 1)
  for (i in k) {
    l = choose(A, i) * (qa ^ i) * ((1 - qa) ^ (A - i)) * choose(B, i) * (qb ^ i) * ((1 - qb) ^ (B - i))
    count0 = count0 + l
  }
  print(count0)
}

# calculates the indifference curve for A supporters. Parameters can be changed within the function

qa_1 = seq(from = 0, to = 1, length = 101)
qb_1 = seq(from = 0, to = 1, length = 101)
plotting_function_1 = function(qa_1, qb_1) {
  n = 10
  pa = .6
  c = 0
  answer_1 = A_wins(n, pa, qa_1, qb_1) * (1 - c * (pa - .5)) + (B_wins(n, pa, qa_1, qb_1)) * (-1) + tie(n, pa, qa_1, qb_1) * (.5)
  return(answer_1)
}
z_1 = outer(qa_1, qb_1, plotting_function_1)

# calculates the indifference curve for B supporters. Parameters can be changed within the function

qa_2 = seq(from = 0, to = 1, length = 101)
qb_2 = seq(from = 0, to = 1, length = 101)
plotting_function_2 = function(qa_2, qb_2) {
  n = 10
  pa = .6
  c = 0
  answer_2 = A_wins(n, pa, qa_2, qb_2) * (-1) + (B_wins(n, pa, qa_2, qb_2)) * (1 - c * (.5 - pa)) + tie(n, pa, qa_2, qb_2) * (.5)
  return(answer_2)
}
z_2 = outer(qa_2, qb_2, plotting_function_2)

# plots the indifference curves

par(pty="s")
contour(qa_1, qb_1, z_1, levels = c(0), xlab = expression(italic('q'[A])), ylab = expression(italic('q'[B])), col = "red", drawlabels = FALSE, lwd = 2)
contour(qa_2, qb_2, z_2, levels = c(0), add = TRUE, col = "blue", drawlabels = FALSE, lwd = 2)
