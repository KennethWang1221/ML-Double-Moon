function [M_shuffled] = caesarian_shuffle(M)

M = M';
[n_row, n_col] = size(M);

shuffle_seq = randperm(n_col);

for i = (1:n_col),
    M_shuffled(:,i) = M(:,shuffle_seq(i));
end
end