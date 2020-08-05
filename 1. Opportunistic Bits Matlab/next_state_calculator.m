function state_op = next_state_calculator(state_ip,M)

state = state_ip;
if state(1) >= 2 
    state(1) = state(1) - 2;
    state = sort(state,'descend');
    next_states = zeros(M,M);
    for i = 1 : M
        tempstate = state;
        tempstate(i) = tempstate(i) + 1;
        tempstate = sort(tempstate,'descend');
        next_states(i,:) = tempstate;
    end
    next_states = sortrows(next_states);
    index = 1;
    while index < size(next_states,1)
        if(next_states(index,:) == next_states(index+1,:))
            next_states(index+1,:) = [];
        else
            index = index + 1;
        end
    end
    size_a = size(next_states,1);
    next_state_2 = zeros(M*size_a,M);
    for j = 1:size_a
        tempstate = next_states(j,:);
        for k = 1 : M
            tempstate2 = tempstate;
            tempstate2(k) = tempstate2(k) + 1;
            tempstate2 = sort(tempstate2,'descend');
            next_state_2((j-1)*M + k,:) = tempstate2;
        end
    end
    next_states = next_state_2;
    
else % state(1) < 2
    state(1) = 0;
    next_states = zeros(M,M);
    for i = 1:M
        tempstate = state;
        tempstate(i) = tempstate(i) + 1;
        tempstate = sort(tempstate,'descend');
        next_states(i,:) = tempstate;
    end
end
next_states = sortrows(next_states);
index = 1;
while index < size(next_states,1)
    if(next_states(index,:) == next_states(index+1,:))
        next_states(index+1,:) = [];
    else
        index = index + 1;
    end
end

state_op = next_states;
end
%     state(1) = state(1) - 2;
%     next_states = zeros(M^2,M);
%     for i = 1:M
%         tempstate = state;
%         tempstate(i) = tempstate(i) + 1;
%         for j = 1:M
%             tempstate2 = tempstate;
%             tempstate2(j) = tempstate2(j) + 1;
%             tempstate2 = sort(tempstate2,'descend');
%             next_states((i-1)*M+j,:) = tempstate2;
%         end
%     end