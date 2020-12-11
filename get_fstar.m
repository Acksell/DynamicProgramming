function [fstarfunc]=get_fstar(getDecisions, state_update, obj)
    function [opt]=fstar(stage, state)
        decisions=getDecisions(stage, state);
        values = zeros(1, length(decisions) );
        if ~isempty(decisions)
            for decision=decisions % decisions are from 0 to k, so add 1 to appease matlab.
                values(decision+1) = obj(decision+1, stage) + fstar(stage + 1, state_update(stage, state, decision));
            end
            [opt, ~]=min(values);
        else
            opt=0;
        end
    end
    fstarfunc=@fstar;
end