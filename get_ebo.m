function [EBO_matrix]=get_ebo()
    l = [50 40 45 51 25 48 60 45 10]*1e-3 ; % Arrival intensities
    T = [4 7 14 5 10 18 24 8 12]; % Repair times [hours]
    c = [14 19 25 15 10 45 80 33 30]'; % LRUj cost
    s = [0 0 0 0 0 0 0 0 0]'; % Initial distribution of spare parts
    C = c'*s; % Total cost of spare parts at base - this is g
    spares = [0 0 0 0 0 0 0 0 0];
    EBO_0 = l* T'; % This is f ?
    C_budget = 500;
    % The function f should be the number of planes grounded due to
    % lack of LRUj
    p = [];
    R = [];
    EBO = [];
    EBO_matrix = [];
    p_matrix =[];
    R_matrix = [];

    smax = 50;
    for i = 1:9;
        lamT=l(i)*T(i);
        %lamT = lambda*T;
        p(1) = exp(-lamT);
        R(1) = 1 - p(1);
        EBO(1) = lamT;
        %smax = floor(C_budget/c(i));

        for s=1:smax;
            s_next=s+1;
            p(s_next) = lamT*p(s)/s; 
            R(s_next) = R(s) - p(s_next); 
            EBO(s_next) = EBO(s) - R(s);
        end
        p_matrix = [p_matrix p'];
        EBO_matrix = [EBO_matrix EBO'];
        R_matrix = [R_matrix R'];
        p_all{i} = p';
    end
end