%% ====step 0 ====%%
clear;
%load data_shuffled1.mat;%
rad =12;
width =10;
dist =0;
num_tr =1000;
num_te =2000;
num_samp =num_tr+num_te;
epochs =50;
fprintf('This is Perceptron for Double Moon Binary Classiication\n');
fprintf('______________________________');
fprintf('Generating halfmoon data at the below ...\n');
fprintf('------------------------------');


fprintf(' Halfmoon radius : %2.1f\n',rad);
fprintf(' Halfmoon width : %2.1f\n', width);

num_samp =num_tr+num_te; %number of samples
epochs = 50;

[data,data_shuffled] = halfmoon(rad,width,dist,num_samp);
%% 

%%===============step1 :initialization of Perceptron network=========%%


num_in = 2;
b = dist/2;
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
    data_shuffled_tr =data_shuffled(:,shuffle_seq);
    for i =1:num_tr
        x = [1; data_shuffled_tr(1:2,i)];
        d = data_shuffled_tr(3,i);
        y =mysign(w'*x);
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
%%=== In order to avoid the display problem of eps file in LaTeX. =========

%%============colormaping the figure here============%%
%%====in order to avoid the display problesm of eps fie=======%%
% figure;
% hold on;
%% ==== Testing ===%%

for i =num_tr+1:num_samp
        x = [1; data_shuffled(1:2,i)];
        d = data_shuffled(3,i);
        y =mysign(w'*x);
        ee_te(i) =d-y;
end

mse_te = mean(ee_te.^2)






