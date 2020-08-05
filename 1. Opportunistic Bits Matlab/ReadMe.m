%% variable definations
% DU - data Unit                --> N
% OB - Oppertunistic Bits       --> K
% CB - Conventional Bits
% N - Number of bits in DU
% K - Number of bits in OB
% M - Total number of DU inside the storage unit
% => N - K is Number of bits in CB
% p_s - DU pair transmission probability
% 
%% { ------------ DATA UNIT ------------ } 
%   _ _ _ _ _ _ _ _  _ _ _ _ _ _ _ _ _ _ _ 
%  |_|_|_|_|_|_|_|_||_|_|_|_|_|_|_|_|_|_|_|
%   1 2 3 4 5 6 7 8  9 0 1 2 3 4 5 6 7 8 9
%  {----  OB  ----} {-------- CB --------}
%  [       K      ] [       N - K        ]
%  [                 N                   ]
%% Function prototype
next_state_calculator();
state_calculator2();
state_calculator();
rem_com_row();

