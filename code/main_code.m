clc;
clear all;
close all;                  

Generator = [1 1 1; 1 0 1]; 
shift = 1; 


%                  Reading Text                
disp('Reading data: '); 
file = fopen('Data/source_data.txt');
text = fread(file, '*char')';
disp(file);



%                        Source Statistics                       
[unique_symbol, probability] = source_statistics(text); 



%                        Huffman Encoding                         
disp('Huffman encoding: '); 
code_word = huffman_encoding(probability); 




%                        Stream Generator                        
disp('Stream generator: '); 
bit_stream = stream_generator(unique_symbol, code_word, text);
input = bit_stream;


%                        Channel Coding                          
disp('Channel coding: '); 
channel_coded = convolutional_coding(bit_stream, Generator)
d=length(channel_coded);
%      BSC Channel                                     
disp('BSC: ');
ndata = bsc(channel_coded,0.25);  

%    Channel Decoding    
disp('Channel decoding: ');
bit_stream = viterbi_decoder(ndata, Generator, shift); 

output = bit_stream; 

%     Huffman Decoding                       
disp('Huffman decoding: ');
decoded_msg = huffman_decoding(unique_symbol, code_word, bit_stream); 



%                    Received Data                     
disp('Writing data: ');
f = fopen('Data/received.txt','w+');
fprintf(f, decoded_msg);
fclose(f);



%                  Error Calculation   
Error = sum(abs(input - output)); 
disp(['Total Bit Error: ' num2str(Error)]); 
p = Error/d;

disp(['Total no. of bits: ' num2str(d)]);
disp(['Performance: ' num2str(1-p)]);


