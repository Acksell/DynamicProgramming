

costs=[14 19 25 15 10 45 80 33 30];
% F_n(s_n), possible decision set
decisionsGetter = getPossibleDecisions(costs);
%state update
h=@(stage, state, decision) state - decision*costs(stage);

EBO_matrix=get_ebo();
fstar=get_fstar(decisionsGetter, h, EBO_matrix);

sol=fstar(1, 100)
