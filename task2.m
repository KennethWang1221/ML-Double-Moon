%% ====step 0 ====%%
%clear;
%clc
%load data_shuffled1.mat;%
M = csvread('caesarian.csv.arff');

num_tr =40;
num_te =40;
num_samp =num_tr+num_te;
epochs =30;
fprintf('This is Perceptron for Caesarian Binary Classiication\n');
fprintf('______________________________');

[M_shuffled] = caesarian_shuffle(M);
%% 

%%===============step1 :initialization of Perceptron network=========%%


num_in = 5;
b = 1;
err =0;
%%eta= 0.95;
eta = rand()/2;
w = [b;zeros(num_in,1)];

%%=================Main Loop============%%
%% 
%%step 2,3: activation and actual response

st=cputime;
fprintf('Training  the perceptron ....\n');
fprintf('================================');

for epoch =1:epochs
    shuffle_seq = randperm(num_tr);
    data_shuffled_tr =M_shuffled(:,shuffle_seq);
    for i =1:num_tr
        x = [1; data_shuffled_tr(1:5,i)]; % rows: 1:5, col: i
        d = data_shuffled_tr(6,i);
        y =mysign1(w'*x);
        ee(i) =d-y;
        
        %% step4 :update of weight
        w_new = w+eta*(d-y)*x;
        %
        %
        %
        w=w_new;
    end
    
    mse(epoch) = mean(ee.^2);
end

fprintf(' Points trained : %d\n',num_tr);
fprintf(' Time cost : %4.2f seconds\n',cputime - st);
fprintf('-------------------------------\n');

%% ==== Poltting Learning Curve==%%
figure;
array = linspace(1,1,epoch);
plot(mse,'k');
title('Learning curve');
xlabel('Number of epochs');ylabel('MSE');

%%============colormaping the figure here============%%
%%====in order to avoid the display problesm of eps fie=======%%
% figure;
% hold on;
%% ==== Testing ===%%

for i =num_tr+1:num_samp
        x = [1; M_shuffled(1:5,i)];
        d = M_shuffled(6,i);
        y =mysign(w'*x);
        ee_te(i) =d-y;
end

mse_te = mean(ee_te.^2)






