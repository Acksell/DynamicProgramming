function [fstarfunc]=get_fstar(getDecisions, state_update, obj, LRUs, budget)
    memo=zeros(LRUs+1, budget+1);
    has_calculated=zeros(LRUs+1, budget+1);
    function [opt]=fstar(stage, state)
        possible_decisions=getDecisions(stage, state);
        values = zeros(1, length(possible_decisions) );
        if ~isempty(possible_decisions)
            for decision=possible_decisions % decisions are from 0 to k, so add 1 to appease matlab.
                next_stage = stage + 1; % next LRU
                next_state = state_update(stage, state, decision);
                if ~(has_calculated(next_stage, next_state+1)==1) % if we have not calculated it, use it
                    val = fstar(next_stage, next_state);
                    memo(next_stage, next_state+1) = val;
                    has_calculated(next_stage, next_state+1) = 1;
                end
                values(decision+1) = obj(decision+1, stage) + memo(next_stage, next_state+1);
            end
            [opt, ~]=min(values);
        else % no more decisions, reached end of all stages.
            opt=0;
            memo(stage, state+1)=0;
            has_calculated(stage, state+1)=1;
        end
    end
    fstarfunc=@fstar;
end