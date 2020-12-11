function [getDecisionsFunc]=getPossibleDecisions(costs)
    function [decisions]=getDecisions(stage, state)
        if stage > length(costs) % no more decisions to be made.
            decisions=[];
        else
            possible = state/costs(stage);
            decisions=0:possible;       
        end
        
    end
    getDecisionsFunc=@getDecisions;
end
    