%% This program calculates all the next possible state for a given system

%% WORKS WELL
function [state_out,dim] = state_calculator2(M) 
% use DP to reduce number of redundant calculation
% state_op - state output operator 
% state_out - state output final
% incomplete in the sense that it is not time efficient
% make the code time efficient later if needed
state_op = next_state_calculator(ones(1,M),M); % initialize as State as - {1 1 ... 1:1}
cur_size = size(state_op,1); % = 2
cur_size_prev = 1;   
state_out = state_op;
while cur_size_prev ~= cur_size % run as long as prev and curr dict size is unequal
    %state_out_prev = state_out;
    for i = 1:cur_size
        state_out = [state_out; next_state_calculator(state_op(i,:),M)];
    end
    state_out = sortrows(state_out);
    state_out = rem_com_row(state_out);   
    
    state_op = state_out;
    cur_size_prev = cur_size;
    cur_size = size(state_op,1);
end
dim = size(state_out,1);
end

