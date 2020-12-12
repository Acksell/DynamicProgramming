costs=[14 19 25 15 10 45 80 33 30];
% F_n(s_n), possible decision set
decisionsGetter = getPossibleDecisions(costs);
%state update
h=@(stage, state, decision) state - decision*costs(stage);

EBO_matrix=get_ebo();
LRUs=9;
max_budget=500;
fstar=get_fstar(decisionsGetter, h, EBO_matrix, LRUs, max_budget);

budgets=1:500;
sols=zeros(1,length(budgets));
decisions=zeros(length(budgets),LRUs);
for b=1:length(budgets)
    [sol, spares]=fstar(budgets(b));
    sols(b)=sol;
    decisions(b,:)=spares;
end
plot(budgets, sols,'-k')
title('Optimal solutions')
xlabel('Cost')
ylabel('EBOs')

