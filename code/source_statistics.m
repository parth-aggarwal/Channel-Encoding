function [unique_symbol, probability]=source_statistics(text)

unique_symbol = unique(text); 
count_symbol = histc(text, unique_symbol);

% calculating each symbol probability 
probability = count_symbol / length(text); 

% sorting probability in descending order 
[probability, index] = sort(probability, 'descend'); 
unique_symbol = unique_symbol(index);
end