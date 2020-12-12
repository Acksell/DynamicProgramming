function [fstarfunc]=get_fstar(getDecisions, state_update, obj, LRUs, budget)
    memo=zeros(LRUs+1, budget+1);
    has_calculated=zeros(LRUs+1, budget+1);
    decisions=zeros(LRUs,budget+1);
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

            [opt, decision]=min(values);
            decisions(stage,state+1)=decision-1; % -1 because index.
        else % no more decisions, reached end of all stages.
            opt=0;
            memo(stage, state+1)=0;
            decisions(stage,state+1)=0;
            has_calculated(stage, state+1)=1;
        end
    end

    function [sol, best_decisions]=startRecursion(state)
        sol=fstar(1, state);
        best_decisions=zeros(1,LRUs);
        % get optimal decisions.
        s=state;
        stage=1;
        while stage<=LRUs
            decision=decisions(stage, s+1);
            best_decisions(stage)=decision;
            s=state_update(stage, s, decision);
            stage=stage+1;
        end
    end
    fstarfunc=@startRecursion;
end