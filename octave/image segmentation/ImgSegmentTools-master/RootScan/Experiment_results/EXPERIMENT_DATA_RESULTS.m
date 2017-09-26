%THIS PROGRAM WILL ANALYZE ALL THE DATA OBTAINED FROM THE AERENCHYMA
%EXPERIMENT.






%READ IN THE DATA FILES


READ_IBM = load('AEREN_EXPERIMENT_IBM.txt');
READ_NYH = load('AEREN_EXPERIMENT_NYH.txt');
READ_OHW = load('AEREN_EXPERIMENT_OHW.txt');
READ_CC = load('AEREN_EXPERIMENT_CC.txt');


%CALCULATE THE RELATIVE CELL CONTRASTS

for F = 1:4;

    switch F
        
        case 1
            
            TEMPS = READ_IBM;
            
        case 2
            
            TEMPS = READ_NYH;
            
        case 3
            
            TEMPS = READ_OHW;
            
        case 4
            
            TEMPS = READ_CC;
            
    end;
    
        for H = 1:max(TEMPS, 2)
    
            index_temps = find(TEMPS(:, 2) == H);
            
            mean_contrast = mean(TEMPS(index_temps, 23));
            TEMPS(index_temps, 23) = TEMPS(index_temps, 23)/mean_contrast;
    
    
    
        end;

    
    switch F
        
        case 1
            
            READ_IBM = TEMPS;
            
        case 2
            
            READ_NYH = TEMPS;
            
        case 3
            
            READ_OHW = TEMPS;
            
        case 4
            
            READ_CC = TEMPS;
            
    end;
    
    
    
end;

%REMOVE ALL NAN DATA.



%SUBSET EACH DATA SET BASED ON WHAT INFORMATION IS BEING USED IN THE
%ANALYSIS.

USE_ONLY_A_IBM = READ_IBM(READ_IBM(:, 1) == 2, :); %SUBSET ONLY DATA FROM AERENCHYMA IN IBM.
USE_ONLY_A_NYH = READ_NYH(READ_NYH(:, 1) == 2, :); %SUBSET ONLY DATA FROM AERENCHYMA IN NYH.
USE_ONLY_A_OHW = READ_OHW(READ_OHW(:, 1) == 2, :); %SUBSET ONLY DATA FROM AERENCHYMA IN OHW.
USE_ONLY_A_CC = READ_CC(READ_CC(:, 1) == 2, :); %SUBSET ONLY DATA FROM AERENCHYMA IN CC. 


USE_ALL_DATA_IBM = READ_IBM(READ_IBM(:, 1) == 1, :); %SUBSET ALL GOOD DATA FROM AERENCHYMA IN IBM.
USE_ALL_DATA_NYH = READ_NYH(READ_NYH(:, 1) == 1, :); %SUBSET ALL GOOD DATA FROM AERENCHYMA IN NYH.
USE_ALL_DATA_OHW = READ_OHW(READ_OHW(:, 1) == 1, :); %SUBSET ALL GOOD DATA FROM AERENCHYMA IN OHW.
USE_ALL_DATA_CC = READ_CC(READ_CC(:, 1) == 1, :); %SUBSET ALL GOOD DATA FROM AERENCHYMA IN CC.




%CHECK TO MAKE SURE THE CORRECT SUBSETS WERE APPLIED TO THE DATA.

SIZE_ONLY_A = [size(USE_ONLY_A_IBM, 1) size(USE_ONLY_A_NYH, 1) size(USE_ONLY_A_OHW, 1) size(USE_ONLY_A_CC, 1)];
SIZE_ALL = [size(USE_ALL_DATA_IBM, 1) size(USE_ALL_DATA_NYH, 1) size(USE_ALL_DATA_OHW, 1) size(USE_ALL_DATA_CC, 1)];

SIZE_RAW = [size(READ_IBM, 1) size(READ_NYH, 1) size(READ_OHW, 1) size(READ_CC, 1)];

DIFF_SUBSETS = SIZE_RAW - (SIZE_ONLY_A + SIZE_ALL); %SHOULD EQUAL ZERO.



%DEFINE CLASS VARIABLE.

%g



%SUBSET ONLY THE AERENCHYMA DATA FROM THE DATA MATRICES.

SUB_A_IBM = vertcat(USE_ONLY_A_IBM(USE_ONLY_A_IBM(:, 26) == 2, :), USE_ALL_DATA_IBM(USE_ALL_DATA_IBM(:, 26) == 2, :));
[r, c] = find(isnan(SUB_A_IBM)); %REMOVE NANs.
SUB_A_IBM(r,:) = [];

SUB_A_OHW = vertcat(USE_ONLY_A_NYH(USE_ONLY_A_NYH(:, 26) == 2, :), USE_ALL_DATA_NYH(USE_ALL_DATA_NYH(:, 26) == 2, :));
[r, c] = find(isnan(SUB_A_OHW)); %REMOVE NANs.
SUB_A_OHW(r,:) = [];

SUB_A_NYH = vertcat(USE_ONLY_A_OHW(USE_ONLY_A_OHW(:, 26) == 2, :), USE_ALL_DATA_OHW(USE_ALL_DATA_OHW(:, 26) == 2, :));
[r, c] = find(isnan(SUB_A_NYH)); %REMOVE NANs
SUB_A_NYH(r,:) = [];


SUB_A_CC = vertcat(USE_ONLY_A_CC(USE_ONLY_A_CC(:, 26) == 2, :), USE_ALL_DATA_CC(USE_ALL_DATA_CC(:, 26) == 2, :));
[r, c] = find(isnan(SUB_A_CC)); %REMOVE NANs.
SUB_A_CC(r,:) = [];


%SUBSET ONLY THE CORTEX CELLS FROM THE DATA MATRICES.

SUB_CORT_CELLS_IBM = USE_ALL_DATA_IBM(USE_ALL_DATA_IBM(:, 26) == 1, :);
[r, c] = find(isnan(SUB_CORT_CELLS_IBM)); %REMOVE NANs.
SUB_CORT_CELLS_IBM(r,:) = [];

SUB_CORT_CELLS_NYH = USE_ALL_DATA_NYH(USE_ALL_DATA_NYH(:, 26) == 1, :);
[r, c] = find(isnan(SUB_CORT_CELLS_NYH)); %REMOVE NANs.
SUB_CORT_CELLS_NYH(r,:) = [];

SUB_CORT_CELLS_OHW = USE_ALL_DATA_OHW(USE_ALL_DATA_OHW(:, 26) == 1, :);
[r, c] = find(isnan(SUB_CORT_CELLS_OHW)); %REMOVE NANs.
SUB_CORT_CELLS_OHW(r,:) = [];

SUB_CORT_CELLS_CC = USE_ALL_DATA_CC(USE_ALL_DATA_CC(:, 26) == 1, :);
[r, c] = find(isnan(SUB_CORT_CELLS_CC)); %REMOVE NANs.
SUB_CORT_CELLS_CC(r,:) = [];





TOT_CORT_CELLS = vertcat(SUB_CORT_CELLS_IBM, SUB_CORT_CELLS_NYH, SUB_CORT_CELLS_OHW, SUB_CORT_CELLS_CC);
TOT_AEREN = vertcat(SUB_A_IBM, SUB_A_NYH, SUB_A_OHW, SUB_A_CC);


%DEFINE ALL VARIABLES. 

%------CC-------%


%HYPOTHESIS(s) 1-3: AERENCHYMA ARE LOCATED WITHIN A SPECIFIC DISTANCE RANGE
%FROM THE INNER CORTEX.

    %DISPLAY THE HISTOGRAM DATA FOR ALL FAMILIES.

        SS = get(0, 'ScreenSize');
        

        

%         %----------OHW----------%
% 
         [no, xo] = hist(SUB_CORT_CELLS_OHW(:, 27), 500);
         [n2o, x2o] = hist(SUB_A_OHW(:, 27), 500);
% 
% 
%         figure('Position', [0, 0, SS(3), SS(4)])
%         subplot(2,1,1);
%         hist(SUB_CORT_CELLS_OHW(:, 27), 500), axis([0 1 0 75]);
%         title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         subplot(2,1,2);
%         hist(SUB_A_OHW(:, 27), 500), axis([0 1 0 max(n2o)+5]);
%         title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         
%         
%         %----------NYH----------%
% 
         [nn, xn] = hist(SUB_CORT_CELLS_NYH(:, 27), 500);
         [n2n, x2n] = hist(SUB_A_NYH(:, 27), 500);
% 
% 
%         figure('Position', [0, 0, SS(3), SS(4)])
%         subplot(2,1,1);
%         hist(SUB_CORT_CELLS_NYH(:, 27), 500), axis([0 1 0 300]);
%         title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         subplot(2,1,2);
%         hist(SUB_A_NYH(:, 27), 500), axis([0 1 0 max(n2n)+5]);
%         title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
% 
% 
% 
%         %----------IBM----------%
% 
         [ni, xi] = hist(SUB_CORT_CELLS_IBM(:, 27), 500);
         [n2i, x2i] = hist(SUB_A_IBM(:, 27), 500);
% 
% 
%         figure('Position', [0, 0, SS(3), SS(4)])
%         subplot(2,1,1);
%         hist(SUB_CORT_CELLS_IBM(:, 27), 500), axis([0 1 0 100]);
%         title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         subplot(2,1,2);
%         hist(SUB_A_IBM(:, 27), 500), axis([0 1 0 max(n2i)+5]);
%         title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
% 
%         %----------CC----------%
% 
        [nc, xc] = hist(SUB_CORT_CELLS_CC(:, 27), 500);
        [n2c, x2c] = hist(SUB_A_CC(:, 27), 500);
% 
% 
%         figure('Position', [0, 0, SS(3), SS(4)])
%         subplot(2,1,1);
%         hist(SUB_CORT_CELLS_CC(:, 27), 500), axis([0 1 0 250]);
%         title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         subplot(2,1,2);
%         hist(SUB_A_CC(:, 27), 500), axis([0 1 0 max(n2c)+5]);
%         title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
% 
%         %----------AGGREGATE DATA-----------%
%         
%         
        [n, x] = hist(TOT_CORT_CELLS(:, 27), 500);
        [n2, x2] = hist(TOT_AEREN(:, 27), 500);
% 
% 
%         figure('Name', 'Aggregate of CC, IBM, NYH and OHW', 'Position', [0, 0, SS(3), SS(4)])
%         subplot(2,1,1);
%         hist(TOT_CORT_CELLS(:, 27), 500), axis([0 1 0 600]);
%         title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;
% 
%         subplot(2,1,2);
%         hist(TOT_AEREN(:, 27), 500), axis([0 1 0 max(n2)+5]);
%         title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
%         xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
%         ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
%         grid on;


%close all;
        
        %-----------subplot composite-------------%
        
        
        %CALC. NORMAL PDF FOR AERENC.
        
        
        
        
        XNCC = 0:.02:1;
        
        YNCC = normpdf(XNCC, mean(SUB_A_CC(:, 27)), std(SUB_A_CC(:, 27)));
        YNCC = YNCC/(length(YNCC)/std(SUB_A_CC(:, 27)));
        
        YNIBM = normpdf(XNCC, mean(SUB_A_IBM(:, 27)), std(SUB_A_IBM(:, 27)));
        YNIBM = YNIBM/(length(YNIBM)/std(SUB_A_IBM(:, 27)));
        
        YNNYH = normpdf(XNCC, mean(SUB_A_NYH(:, 27)), std(SUB_A_OHW(:, 27)));
        YNNYH = YNNYH/(length(YNNYH)/std(SUB_A_NYH(:, 27)));
        
        YNOHW = normpdf(XNCC, mean(SUB_A_OHW(:, 27)), std(SUB_A_OHW(:, 27)));
        YNOHW = YNOHW/(length(YNOHW)/std(SUB_A_OHW(:, 27)));
        
        
        %CALC. NORMAL PDF FOR CORTEX CELLS
        
       
        YNCC_CORT = normpdf(XNCC, mean(SUB_CORT_CELLS_CC(:, 27)), std(SUB_CORT_CELLS_CC(:, 27)));
        YNCC_CORT = YNCC_CORT/(length(YNCC_CORT)/std(SUB_CORT_CELLS_CC(:, 27)));
        
        YNIBM_CORT = normpdf(XNCC, mean(SUB_CORT_CELLS_IBM(:, 27)), std(SUB_CORT_CELLS_IBM(:, 27)));
        YNIBM_CORT = YNIBM_CORT/(length(YNIBM_CORT)/std(SUB_CORT_CELLS_IBM(:, 27)));
        
        YNNYH_CORT = normpdf(XNCC, mean(SUB_CORT_CELLS_NYH(:, 27)), std(SUB_CORT_CELLS_NYH(:, 27)));
        YNNYH_CORT = YNNYH_CORT/(length(YNNYH_CORT)/std(SUB_CORT_CELLS_NYH(:, 27)));
        
        YNOHW_CORT = normpdf(XNCC, mean(SUB_CORT_CELLS_OHW(:, 27)), std(SUB_CORT_CELLS_OHW(:, 27)));
        YNOHW_CORT = YNOHW_CORT/(length(YNOHW_CORT)/std(SUB_CORT_CELLS_OHW(:, 27)));
        
        
        %PLOT SUBPLOTS.
        
        Y_D1 = 0:.001:.01;
        Y_D2 = 0:.001:.014;
        
        figure('Position', [0, 0, SS(3), SS(4)]);
        subplot(2,4,1);
        bar(xc, nc/sum(nc)), axis([0 1 0 .01]), ylabel('Frequency', 'FontSize', 18), hold on;
        xlabel('Normalized Distance', 'FontSize', 18);
        %plot(XNCC, YNCC_CORT, 'r', 'LineWidth', 4);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_CC(:, 27)) + std(SUB_CORT_CELLS_CC(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_CC(:, 27)) - std(SUB_CORT_CELLS_CC(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_CC(:, 27)), Y_D1, 'g', 'LineWidth', 3);
        text(.68, .0085, 'CC', 'FontSize', 20, 'FontWeight', 'bold');
        
        
        subplot(2,4,2);
        bar(xi, ni/sum(ni)), axis([0 1 0 .01]), xlabel('Normalized Distance', 'FontSize', 18), hold on;
        %plot(XNCC, YNIBM_CORT, 'r', 'LineWidth', 4);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_IBM(:, 27)) + std(SUB_CORT_CELLS_IBM(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_IBM(:, 27)) - std(SUB_CORT_CELLS_IBM(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_IBM(:, 27)), Y_D1, 'g', 'LineWidth', 3);
        text(.67, .0085, 'IBM', 'FontSize', 20, 'FontWeight', 'bold');
        text(.60, .0112, 'Cortex Cell Areas', 'FontSize', 28, 'FontWeight', 'bold');
        
        subplot(2,4,3);
        bar(xn, nn/sum(nn)), axis([0 1 0 .01]), xlabel('Normalized Distance', 'FontSize', 18), hold on;
        %plot(XNCC, YNNYH_CORT, 'r', 'LineWidth', 4);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_NYH(:, 27)) + std(SUB_CORT_CELLS_NYH(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_NYH(:, 27)) - std(SUB_CORT_CELLS_NYH(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_NYH(:, 27)), Y_D1, 'g', 'LineWidth', 3);
        text(.66, .0085, 'NYH', 'FontSize', 20, 'FontWeight', 'bold');
        
        
        subplot(2,4,4);
        bar(xo, no/sum(no)), axis([0 1 0 .01]), xlabel('Normalized Distance', 'FontSize', 18), hold on;
        %plot(XNCC, YNOHW_CORT, 'r', 'LineWidth', 4);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_OHW(:, 27)) + std(SUB_CORT_CELLS_OHW(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_OHW(:, 27)) - std(SUB_CORT_CELLS_OHW(:, 27)), Y_D1, '-r', 'LineWidth', 3);
        plot(Y_D1*0 + mean(SUB_CORT_CELLS_OHW(:, 27)), Y_D1, 'g', 'LineWidth', 3);
        text(.63, .0085, 'OHW', 'FontSize', 20, 'FontWeight', 'bold');
        
        
        subplot(2,4,5);
        bar(x2c, n2c/sum(n2c)), axis([0 1 0 .014]), ylabel('Frequency', 'FontSize', 18), hold on;
        xlabel('Normalized Distance', 'FontSize', 18);
        %plot(XNCC, YNCC, 'r', 'LineWidth', 4);
        plot(Y_D2*0 + mean(SUB_A_CC(:, 27)) + std(SUB_A_CC(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_CC(:, 27)) - std(SUB_A_CC(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_CC(:, 27)), Y_D2, 'g', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_CC(:, 27)) + 2*std(SUB_A_CC(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_CC(:, 27)) - 2*std(SUB_A_CC(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        text(.68, .012, 'CC', 'FontSize', 20, 'FontWeight', 'bold');
        
        
        subplot(2,4,6);
        bar(x2i, n2i/sum(n2i)), axis([0 1 0 .014]), hold on;
        xlabel('Normalized Distance', 'FontSize', 18);
        %plot(XNCC, YNIBM, 'r', 'LineWidth', 4);
        plot(Y_D2*0 + mean(SUB_A_IBM(:, 27)) + std(SUB_A_IBM(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_IBM(:, 27)) - std(SUB_A_IBM(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_IBM(:, 27)), Y_D2, 'g', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_IBM(:, 27)) + 2*std(SUB_A_IBM(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_IBM(:, 27)) - 2*std(SUB_A_IBM(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        text(.67, .012, 'IBM', 'FontSize', 20, 'FontWeight', 'bold');
        text(.56, .0155, 'Aerenchyma Areas', 'FontSize', 28, 'FontWeight', 'bold');
        
        subplot(2,4,7);
        bar(x2n, n2n/sum(n2n)), axis([0 1 0 .014]), hold on;
        xlabel('Normalized Distance', 'FontSize', 18);
        %plot(XNCC, YNNYH, 'r', 'LineWidth', 4);
        plot(Y_D2*0 + mean(SUB_A_NYH(:, 27)) + std(SUB_A_NYH(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_NYH(:, 27)) - std(SUB_A_NYH(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_NYH(:, 27)), Y_D2, 'g', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_NYH(:, 27)) + 2*std(SUB_A_NYH(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_NYH(:, 27)) - 2*std(SUB_A_NYH(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        text(.66, .012, 'NYH', 'FontSize', 20, 'FontWeight', 'bold');
        
        subplot(2,4,8);
        bar(x2o, n2o/sum(n2o)), axis([0 1 0 .014]), hold on;
        xlabel('Normalized Distance', 'FontSize', 18);
        %plot(XNCC, YNOHW, 'r', 'LineWidth', 4);
        plot(Y_D2*0 + mean(SUB_A_OHW(:, 27)) + std(SUB_A_OHW(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_OHW(:, 27)) - std(SUB_A_OHW(:, 27)), Y_D2, '-r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_OHW(:, 27)), Y_D2, 'g', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_OHW(:, 27)) + 2*std(SUB_A_OHW(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        plot(Y_D2*0 + mean(SUB_A_OHW(:, 27)) - 2*std(SUB_A_OHW(:, 27)), Y_D2, '--r', 'LineWidth', 3);
        text(.74, .012, 'OHW', 'FontSize', 20, 'FontWeight', 'bold');
        
        
        
        %TEST THE RADIAL DISTANCES (IN AERENCHYMA) BETWEEN FAMILIES.
        
            
        
            [h_CC_IBM, p_CC_IBM, ci_CC_IBM] = ttest2(SUB_A_CC(:, 27), SUB_A_IBM(:, 27)); %CC VS. IBM.
            [h_CC_NYH, p_CC_NYH, ci_CC_NYH] = ttest2(SUB_A_CC(:, 27), SUB_A_NYH(:, 27)); %CC VS. NYH
            [h_CC_OHW, p_CC_OHW, ci_CC_OHW] = ttest2(SUB_A_CC(:, 27), SUB_A_OHW(:, 27)); %CC VS. OHW
            [h_IBM_NYH, p_IBM_NYH, ci_IBM_NYH] = ttest2(SUB_A_IBM(:, 27), SUB_A_NYH(:, 27)); %IBM VS. NYH.
            [h_IBM_OHW, p_IBM_OHW, ci_IBM_OHW] = ttest2(SUB_A_IBM(:, 27), SUB_A_OHW(:, 27)); %IBM VS. OHW.
            [h_NYH_OHW, p_NYH_OHW, ci_NYH_OHW] = ttest2(SUB_A_NYH(:, 27), SUB_A_OHW(:, 27)); %NYH VS. OHW
        
        
            TEST_MATRIX = [h_CC_IBM h_CC_NYH h_CC_OHW h_IBM_NYH h_IBM_OHW h_NYH_OHW; p_CC_IBM p_CC_NYH p_CC_OHW p_IBM_NYH p_IBM_OHW p_NYH_OHW];
        
        
            %CONCLUSION: THE RELATIVE POSITION OF AERENCHYMA IN CORTEX
            %REGIONS ARE SIGNIFICANTLY DIFFERENT BETWEEN FAMILIES.
            
            
            
            
            
            %TEST THE RADIAL DISTANCES (IN CORTEX AREAS) BETWEEN FAMILIES.
        
            
        
            [h_CC_IBM, p_CC_IBM, ci_CC_IBM] = ttest2(SUB_CORT_CELLS_CC(:, 27), SUB_CORT_CELLS_IBM(:, 27)); %CC VS. IBM.
            [h_CC_NYH, p_CC_NYH, ci_CC_NYH] = ttest2(SUB_CORT_CELLS_CC(:, 27), SUB_CORT_CELLS_NYH(:, 27)); %CC VS. NYH
            [h_CC_OHW, p_CC_OHW, ci_CC_OHW] = ttest2(SUB_CORT_CELLS_CC(:, 27), SUB_CORT_CELLS_OHW(:, 27)); %CC VS. OHW
            [h_IBM_NYH, p_IBM_NYH, ci_IBM_NYH] = ttest2(SUB_CORT_CELLS_IBM(:, 27), SUB_CORT_CELLS_NYH(:, 27)); %IBM VS. NYH.
            [h_IBM_OHW, p_IBM_OHW, ci_IBM_OHW] = ttest2(SUB_CORT_CELLS_IBM(:, 27), SUB_CORT_CELLS_OHW(:, 27)); %IBM VS. OHW.
            [h_NYH_OHW, p_NYH_OHW, ci_NYH_OHW] = ttest2(SUB_CORT_CELLS_NYH(:, 27), SUB_CORT_CELLS_OHW(:, 27)); %NYH VS. OHW
        
        
            TEST_MATRIX = [h_CC_IBM h_CC_NYH h_CC_OHW h_IBM_NYH h_IBM_OHW h_NYH_OHW; p_CC_IBM p_CC_NYH p_CC_OHW p_IBM_NYH p_IBM_OHW p_NYH_OHW];
            
            %CONCLUSION: THE RELATIVE POSITION OF AERENCHYMA IN CORTEX
            %REGIONS ARE SIGNIFICANTLY DIFFERENT BETWEEN FAMILIES WITH THE
            %EXCEPTION OF THE COMPARISION OF IBM AND NYH.
            
            
            
            %TEST THE RADIAL DISTANCES BETWEEN CORTEX CELLS AND AERENCHYA
            %CELLS (WITHIN THE SAME FAMILY).  THIS IS THE IMPORTANT TEST.
            
            
            [h_CC, p_CC, ci_CC] = ttest2(SUB_CORT_CELLS_CC(:, 27), SUB_A_CC(:, 27)); %CC
            [h_IBM, p_IBM, ci_IBM] = ttest2(SUB_CORT_CELLS_IBM(:, 27), SUB_A_IBM(:, 27)); %IBM.
            [h_NYH, p_NYH, ci_NYH] = ttest2(SUB_CORT_CELLS_NYH(:, 27), SUB_A_NYH(:, 27)); %NYH.
            [h_OHW, p_OHW, ci_OHW] = ttest2(SUB_CORT_CELLS_OHW(:, 27), SUB_A_OHW(:, 27)); %OHW.
            
            
            TEST_MATRIX = [h_CC h_IBM h_NYH h_OHW; p_CC p_IBM p_NYH p_OHW];
            
            
            %CONCLUSION: THE RELATIVE POSITION OF AERENCHYMA VS. CORTEX
            %CELLS ARE SIGNIFICANTLY DIFFERENT FOR ALL FAMILIES.  THIS IS
            %GOOD NEW FOR THE GENERAL ROOT-SCAN 5000 PROGRAM.  WE CAN SPEED
            %THINGS UP.  
            
    %%        
            
      %---------------------------END H(s) 1-3----------------------------%      
            
        
    %HYPOTHESIS(s) 4: AERENCHYMA SIZE IS SIGNIFICANTLY DIFFERENT THAN
    %CORTEX CELL SIZES.  THIS IS COMPLEX TEST SINCE LOCATION PLAYS A HUGE
    %ROLE IN CORTEX CELL SIZES.

    %DISPLAY THE HISTOGRAM DATA FOR ALL FAMILIES.
        
        
        
            %DISPLAY THE HISTOGRAM DATA FOR ALL FAMILIES.
        


        %----------OHW----------%

        [no, xo] = hist(SUB_CORT_CELLS_OHW(:, 28), 500);
        [n2o, x2o] = hist(SUB_A_OHW(:, 28), 500);


        figure('Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        hist(SUB_CORT_CELLS_OHW(:, 28), 500), axis([0 max(x2o)/2 0 max(no)+5]);
        title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        hist(SUB_A_OHW(:, 28), 500), axis([0 max(x2o)/2 0 max(n2o)+5]);
        title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        
        
        %----------NYH----------%

        [nn, xn] = hist(SUB_CORT_CELLS_NYH(:, 28), 500);
        [n2n, x2n] = hist(SUB_A_NYH(:, 28), 500);


        figure('Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        hist(SUB_CORT_CELLS_NYH(:, 28), 500), axis([0 max(x2n)/2 0 max(nn)+5]);
        title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        hist(SUB_A_NYH(:, 28), 500), axis([0 max(x2n)/2 0 max(n2n)+5]);
        title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;




        %----------IBM----------%

        [ni, xi] = hist(SUB_CORT_CELLS_IBM(:, 28), 500);
        [n2i, x2i] = hist(SUB_A_IBM(:, 28), 500);


        figure('Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        hist(SUB_CORT_CELLS_IBM(:, 28), 500), axis([0 max(x2i)/2 0 max(ni)+5]);
        title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        hist(SUB_A_IBM(:, 28), 500), axis([0 max(x2i)/2 0 max(n2i)+5]);
        title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;


        %----------CC----------%

        [nc, xc] = hist(SUB_CORT_CELLS_CC(:, 28), 500);
        [n2c, x2c] = hist(SUB_A_CC(:, 28), 500);


        figure('Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        hist(SUB_CORT_CELLS_CC(:, 28), 500), axis([0 max(x2c)/2 0 max(nc)+5]);
        title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        hist(SUB_A_CC(:, 28), 500), axis([0 max(x2c)/2 0 max(n2c)+5]);
        title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;


        %----------AGGREGATE DATA-----------%
        
        
        [n, x] = hist(TOT_CORT_CELLS(:, 28), 500);
        [n2, x2] = hist(TOT_AEREN(:, 28), 500);


        figure('Name', 'Aggregate of CC, IBM, NYH and OHW', 'Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        bar(x, n/sum(n)), axis([0 max(x2)/2 0 .1]);
        title('Cortex Cell Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        bar(x2, n2/sum(n2)), axis([0 max(x2)/2 0 .1]);
        title('Aerenchyma Areas', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Normalized Radius From Inner Cortex', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        
    
    
    %HYPOTHESIS(s) 5: CELL CONTRAST TESTING.  DO AERENCHYMA CELLS HAVE
    %DIFFERENT LEVELS OF CONTRAST RELATIVE TO CORTEX CELLS.
    
    

        %----------AGGREGATE DATA-----------%
        
        
        [n, x] = hist(TOT_CORT_CELLS(:, 23), 255);
        [n2, x2] = hist(TOT_AEREN(:, 23), 255);

        line_vect = 0:.0001:.025;

        figure('Name', 'Aggregate of CC, IBM, NYH and OHW', 'Position', [0, 0, SS(3), SS(4)])
        subplot(2,1,1);
        bar(x, n/sum(n)), axis([0 255 0 .025]), hold on;
        plot(line_vect*0 + mean(TOT_CORT_CELLS(:, 23)) + std(TOT_CORT_CELLS(:, 23)), line_vect, 'r', 'LineWidth', 3);
        plot(line_vect*0 + mean(TOT_CORT_CELLS(:, 23)) - std(TOT_CORT_CELLS(:, 23)), line_vect, 'r', 'LineWidth', 3);
        plot(line_vect*0 + mean(TOT_CORT_CELLS(:, 23)), line_vect, 'g', 'LineWidth', 3);
        
        title('Linear Contrast (Cortext Cells)', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Contrast', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;

        subplot(2,1,2);
        bar(x2, n2/sum(n2)), axis([0 255 0 .025]), hold on;
        plot(line_vect*0 + mean(TOT_AEREN(:, 23)) + std(TOT_AEREN(:, 23)), line_vect, 'r', 'LineWidth', 3);
        plot(line_vect*0 + mean(TOT_AEREN(:, 23)) - std(TOT_AEREN(:, 23)), line_vect, 'r', 'LineWidth', 3);
        plot(line_vect*0 + mean(TOT_AEREN(:, 23)), line_vect, 'g', 'LineWidth', 3);
        
        title('Linear Contrast (Aerenchyma Areas)', 'FontSize', 20, 'FontWeight', 'bold');
        xlabel('Contrast', 'FontSize', 18, 'FontWeight', 'bold');
        ylabel('Frequency', 'FontSize', 18, 'FontWeight', 'bold');
        grid on;
    
    
    
        [h_contrast, p_contrast, ci_contrast] = ttest2(TOT_CORT_CELLS(:, 23), TOT_AEREN(:, 23));
    
    
    
    
    
        figure;
        subplot(2,1,1);
        plot(TOT_CORT_CELLS(:, 27), TOT_CORT_CELLS(:, 28), '.b'), hold on;
    
        DIST_INT = -.025:.025:1.025;
        
        DIST = zeros(length(DIST_INT) - 2, 1);
        FIT = zeros(length(DIST_INT) - 2, 1);
        STD = zeros(length(DIST_INT) - 2, 1);
        
        for J = 1:(length(DIST_INT) - 2)
            
            index = find((TOT_CORT_CELLS(:, 27) >= DIST_INT(J)) & (TOT_CORT_CELLS(:, 27) < DIST_INT(J+2)));
            
            DIST(J) = DIST_INT(J+1);
            
            FIT(J) = mean(TOT_CORT_CELLS(index, 28));
            STD(J) = std(TOT_CORT_CELLS(index, 28));
            
        end;
        
        
        plot(DIST, FIT, 'g', 'LineWidth', 2);
        plot(DIST, FIT + STD, '.-k', 'LineWidth', 2);
        
    
        subplot(2, 1, 2);
        plot(TOT_AEREN(:, 27), TOT_AEREN(:, 28), '.r'), hold on;
       
    
    
    
        DIST_INT = -.025:.025:1.025;
        
        DIST = zeros(length(DIST_INT) - 2, 1);
        FIT = zeros(length(DIST_INT) - 2, 1);
        STD = zeros(length(DIST_INT) - 2, 1);
        
        
        for J = 1:(length(DIST_INT) - 2)
            
            index = find((TOT_AEREN(:, 27) >= DIST_INT(J)) & (TOT_AEREN(:, 27) < DIST_INT(J+2)));
            
            DIST(J) = DIST_INT(J+1);
            
            FIT(J) = mean(TOT_AEREN(index, 28));
            STD(J) = std(TOT_AEREN(index, 28));
            
            
        end;
    
    
        plot(DIST, FIT, 'g', 'LineWidth', 2);    
        plot(DIST, FIT + STD, '.-k', 'LineWidth', 2);
        
        
        
        
        
        
        
        
        
        %take a look at eccentricity.
        
        
        figure;
        plot(-1*TOT_CORT_CELLS(:, 15), TOT_CORT_CELLS(:, 27), '.b', TOT_AEREN(:, 15), TOT_AEREN(:, 27), '.r');
        
        
        
        figure;
        subplot(2, 1, 1);
        plot(TOT_CORT_CELLS(:, 27), TOT_CORT_CELLS(:, 15), '.b')
        
        subplot(2, 1, 2);
        plot(TOT_CORT_CELLS(:, 27), TOT_CORT_CELLS(:, 15), '.b'), hold on;
        plot(TOT_AEREN(:, 27), TOT_AEREN(:, 15), '.r');


        
        
        
        
        
        %area to perimeter ratio results from CC, IBM, NYH and OHW
        
        
        figure;
        subplot(3, 1, 1);
        plot(SUB_CORT_CELLS_CC(:, 27), SUB_CORT_CELLS_CC(:, 4)./SUB_CORT_CELLS_CC(:, 11), '.b'), axis([0 1 0 max(SUB_A_CC(:, 4)./SUB_A_CC(:, 11))]);
        
        subplot(3, 1, 2);
        plot(SUB_A_CC(:, 27), SUB_A_CC(:, 4)./SUB_A_CC(:, 11), '.r'), axis([0 1 0 max(SUB_A_CC(:, 4)./SUB_A_CC(:, 11))]);
        
        
        
        
        DIST_INT = -.025:.025:1.025;
        
        DIST = zeros(length(DIST_INT) - 2, 1);
        FIT = zeros(length(DIST_INT) - 2, 1);
        CI = zeros(length(DIST_INT) - 2, 2);
        FIT2 = zeros(length(DIST_INT) - 2, 1);
        CI2 = zeros(length(DIST_INT) - 2, 2);
        
        A_P = horzcat(SUB_CORT_CELLS_CC(:, 27), SUB_CORT_CELLS_CC(:, 4)./SUB_CORT_CELLS_CC(:, 11));
        A_P = A_P(SUB_CORT_CELLS_CC(:, 11) ~= 0,:);
        A_P2 = horzcat(TOT_AEREN(:, 27), TOT_AEREN(:, 4)./TOT_AEREN(:, 11));
        A_P2 = A_P2(TOT_AEREN(:, 11) ~= 0,:);
        
        
        for J = 1:(length(DIST_INT) - 2)
            
            index = find((A_P(:, 1) >= DIST_INT(J)) & (A_P(:, 1) < DIST_INT(J+2)) & (A_P(:, 1) ~= 0));
            index2 = find((A_P2(:, 1) >= DIST_INT(J)) & (A_P2(:, 1) < DIST_INT(J+2)) & (A_P2(:, 1) ~= 0));
            
            DIST(J) = DIST_INT(J+1);
            
            FIT(J) = mean(A_P(index, 2));
            [h, p, ci] = ttest(A_P(index, 2));
            CI(J, :) = ci';
            
            FIT2(J) = mean(A_P2(index2, 2));
            [h, p, ci] = ttest(A_P2(index2, 2));
            CI2(J, :) = ci';
            
            
        end;
    
        
        subplot(3, 1, 3);
    
        plot(DIST, FIT, 'g', 'LineWidth', 2), axis([0 1 0 max(CI2(:,2))]), hold on;    
        plot(DIST, CI(:,1), '.-k', 'LineWidth', 2);
        plot(DIST, CI(:,2), '.-k', 'LineWidth', 2);
        
        
        plot(DIST, FIT2, 'b', 'LineWidth', 2);    
        plot(DIST, CI2(:,1), '-k', 'LineWidth', 2);
        plot(DIST, CI2(:,2), '-k', 'LineWidth', 2);
        
        
        
        
        
        
        
        
        
        
        
        %plot the variables vs. distance for cortex cells and aerenchyma.
        %%
        
        VAR1_VECT = [10 15 28 34 35 36];
        VAR1_NAME = {'Extents'; 'Eccentricity'; 'Normalized Area'; 'Normalized Perimeter'; 'Normalized Major Axis Length'; 'Normalized Minor Axis Length'};

        AXIS_SETTINGS = [1 1 -1 -1 -1 -1];
        
   for VAR1 = 1:length(VAR1_VECT)
        
        %figure;
        
        for FAM = 1:5 %loop over each family.
            
        D_COL = 5:8;
        FAM_TITLES = {'(CC)'; '(IBM)'; '(NYH)'; '(OHW)'; '(All Familes)'};
        

        
        
        switch FAM
            
            case 1
                
                CORT_DIST = SUB_CORT_CELLS_CC(:,27);
                A_DIST = SUB_A_CC(:,27);
                
                EXTENT_CORT = SUB_CORT_CELLS_CC(:, VAR1_VECT(VAR1));
                EXTENT_A = SUB_A_CC(:, VAR1_VECT(VAR1));
                
            case 2
                
                
                CORT_DIST = SUB_CORT_CELLS_IBM(:,27);
                A_DIST = SUB_A_IBM(:,27);
                
                EXTENT_CORT = SUB_CORT_CELLS_IBM(:, VAR1_VECT(VAR1));
                EXTENT_A = SUB_A_IBM(:, VAR1_VECT(VAR1));
                
            case 3
                
                    
                CORT_DIST = SUB_CORT_CELLS_NYH(:,27);
                A_DIST = SUB_A_NYH(:,27);
                
                EXTENT_CORT = SUB_CORT_CELLS_NYH(:, VAR1_VECT(VAR1));
                EXTENT_A = SUB_A_NYH(:, VAR1_VECT(VAR1));
                
            case 4
                
                 
                CORT_DIST = SUB_CORT_CELLS_OHW(:,27);
                A_DIST = SUB_A_OHW(:,27);
                
                EXTENT_CORT = SUB_CORT_CELLS_OHW(:, VAR1_VECT(VAR1));
                EXTENT_A = SUB_A_OHW(:, VAR1_VECT(VAR1));
                
                
            case 5
                
                CORT_DIST = TOT_CORT_CELLS(:,27);
                A_DIST = TOT_AEREN(:,27);
                
                EXTENT_CORT = TOT_CORT_CELLS(:, VAR1_VECT(VAR1));
                EXTENT_A = TOT_AEREN(:, VAR1_VECT(VAR1));
                
                
        end;
        
        TITLES = [VAR1_NAME(VAR1) ' vs. Distance from Inner Cortex' FAM_TITLES(FAM)];
        
        
        CAT1 = horzcat(CORT_DIST, EXTENT_CORT);
        CAT1 = CAT1(CAT1(:,2) ~= 1, :);
        
        CAT2 = horzcat(A_DIST, EXTENT_A);
        CAT2 = CAT2(CAT2(:,2) ~= 1, :);
        
        
        DIST_INT = -.025:.025:1.025;
        
        DIST = zeros(length(DIST_INT) - 2, 1);
        FIT = zeros(length(DIST_INT) - 2, 1);
        CI = zeros(length(DIST_INT) - 2, 2);
        FIT2 = zeros(length(DIST_INT) - 2, 1);
        CI2 = zeros(length(DIST_INT) - 2, 2);
        
        
        
        for J = 1:(length(DIST_INT) - 2)
            
            index = find((CAT1(:, 1) >= DIST_INT(J)) & (CAT1(:, 1) < DIST_INT(J+2)) & (CAT1(:, 1) ~= 0));
            index2 = find((CAT2(:, 1) >= DIST_INT(J)) & (CAT2(:, 1) < DIST_INT(J+2)) & (CAT2(:, 1) ~= 0));
            
            DIST(J) = DIST_INT(J+1);
            
            FIT(J) = mean(CAT1(index, 2));
            [h, p, ci] = ttest(CAT1(index, 2));
            CI(J, :) = ci';
            
            FIT2(J) = mean(CAT2(index2, 2));
            [h, p, ci] = ttest(CAT2(index2, 2));
            CI2(J, :) = ci';
            
            
        end;
    

        
        

        
        
        
        
            if (AXIS_SETTINGS(VAR1) == -1)
            
                AXIS_SETTINGS1 = max(CAT2(:,2)) + 1;
            
            else
            
                AXIS_SETTINGS1 = AXIS_SETTINGS(VAR1);
            
            
            end;
        
        
        
        figure('Position', [0, 0, SS(3), SS(4)]);
        subplot(2,1,1);
        plot(CAT1(:,1), CAT1(:,2), '.b'), axis([0 1 0 AXIS_SETTINGS1]), hold on;
        title(TITLES, 'FontSize', 20, 'FontWeight', 'Bold');
        plot(DIST, FIT, 'g', 'LineWidth', 2), axis([0 1 0 max(CI2(:,2))]);    
        plot(DIST, CI(:,1), '.-k', 'LineWidth', 2);
        plot(DIST, CI(:,2), '.-k', 'LineWidth', 2);
        
        subplot(2,1,2);
        plot(CAT2(:,1), CAT2(:,2), '.r'), axis([0 1 0 AXIS_SETTINGS1]), hold on;
        plot(DIST, FIT2, 'b', 'LineWidth', 2);    
        plot(DIST, CI2(:,1), '-k', 'LineWidth', 2);
        plot(DIST, CI2(:,2), '-k', 'LineWidth', 2);
        
        
       a = [cell2mat(TITLES) '.jpg'];
    
        print('-djpeg', a);
        
        close all;
        
        
        end;
        
        
   end;
        
 %%       
        
        
 %WITHIN THE RADIAL DISTANCE RANGE DETERMINE IF THERE ARE MORE DEFINING PROPERTIES OF AERENCHYMA.
 
 
 mean_dist_IBM = .35;
 mean_dist_CC = .4;
 mean_dist_NYH = .4;
 mean_dist_OHW = .4;
 
 STD = .2;
        
     
%SUBSET DATA FALLING WITHIN  MEAN +- 2*STD DISTANCE FROM INNER CORTEX
%BOUNDARY.

DIST_AEREN_IBM = USE_ALL_DATA_IBM((USE_ALL_DATA_IBM(:, 27) >= (mean_dist_IBM - STD)) & (USE_ALL_DATA_IBM(:, 27) <= (mean_dist_IBM + STD)), :);
[r, c] = find(isnan(DIST_AEREN_IBM)); %REMOVE NANs.
DIST_AEREN_IBM(r,:) = [];

DIST_AEREN_NYH = USE_ALL_DATA_NYH((USE_ALL_DATA_NYH(:, 27) >= (mean_dist_NYH - STD)) & (USE_ALL_DATA_NYH(:, 27) <= (mean_dist_NYH + STD)), :);
[r, c] = find(isnan(DIST_AEREN_NYH)); %REMOVE NANs.
DIST_AEREN_NYH(r,:) = [];

DIST_AEREN_OHW = USE_ALL_DATA_OHW((USE_ALL_DATA_OHW(:, 27) >= (mean_dist_OHW - STD)) & (USE_ALL_DATA_OHW(:, 27) <= (mean_dist_OHW + STD)), :);
[r, c] = find(isnan(DIST_AEREN_OHW)); %REMOVE NANs.
DIST_AEREN_OHW(r,:) = [];

DIST_AEREN_CC = USE_ALL_DATA_CC((USE_ALL_DATA_CC(:, 27) >= (mean_dist_CC - STD)) & (USE_ALL_DATA_CC(:, 27) <= (mean_dist_CC + STD)), :);
[r, c] = find(isnan(DIST_AEREN_CC)); %REMOVE NANs.
DIST_AEREN_CC(r,:) = [];   
        
        
        

        
 %LOOP THOUGH EACH SAMPLE AND COMPARE THE EXTENT FOR CORTEX AND AERENCHYMA
 %AREAS.
 
 max_samples = [max(DIST_AEREN_CC(:,2)) max(DIST_AEREN_IBM(:,2)) max(DIST_AEREN_NYH(:,2)) max(DIST_AEREN_OHW(:,2))];
 
 PROB_EXTENTS = zeros(max_samples(4), 3);
 
 figure_vect = 8:8:max_samples(4);
 





 
 FAM = {'CC', 'IBM', 'NYH', 'OHW'};
 
 
 for k = 1:4
 
     switch k
         
         case 1
             
           DATA = DIST_AEREN_CC;
             
         case 2
             
           DATA = DIST_AEREN_IBM;
             
         case 3
             
           DATA = DIST_AEREN_NYH;
             
         case 4
             
           DATA = DIST_AEREN_OHW;
             
     end;
      
     figure('Position', [0, 0, SS(3), SS(4)]); 
     J = 1;
    II = 0;     
  count = 0;
 count2 = 0;
 
     for I = 1:max_samples(k)
     
        define_sample = DATA(DATA(:,2) == I, :);
     
     
        SUB_CORT = define_sample(define_sample(:,26) == 1, :); %SUBSET CORTEX AREAS.
     
        SUB_AEREN = define_sample(define_sample(:,26) == 2, :); %SUBSET CORTEX AREAS.
     
        if (size(SUB_AEREN, 1) > 5)
     
        count = count + 1;
         
        count2 = count2 + 1;
     
        %TEST THE POPULATIONS.
     
        MEAN_VAR = mean(define_sample(:, 11));
        STD_VAR = std(define_sample(:, 11));
        
     
        [H, P, CI] = ttest2(SUB_CORT(:, 11), SUB_AEREN(:, 11));
     
        OBJECT_STATS{k,1}{count2, 1} = H;
        OBJECT_STATS{k,1}{count2, 2} = P;
        OBJECT_STATS{k,1}{count2, 3} = CI(1);
        OBJECT_STATS{k,1}{count2, 4} = CI(2);
        
        PROB_EXTENTS(I, 1) = P;
        PROB_EXTENTS(I, 2) = mean(SUB_CORT(:, 11));
        PROB_EXTENTS(I, 3) = std(SUB_CORT(:, 11));
        PROB_EXTENTS(I, 4) = mean(SUB_AEREN(:, 11));
        PROB_EXTENTS(I, 5) = std(SUB_AEREN(:, 11));
     
        [nc,xc] = hist(SUB_CORT(:, 11), 20);
        [na,xa] = hist(SUB_AEREN(:, 11), 20);
     

            if (count == 9)
         
                NAME = ['PERIMETER.' FAM{k} '.' int2str(J) '.jpg'];
                print(NAME, '-djpeg');
                close all;
         
                J = J + 1;
                figure('Position', [0, 0, SS(3), SS(4)]);

                count = 1;

            end; 
     
        II = II + 1;
     
        MAX_NC = 0:.01:max(nc);
        
        subplot(2, 4, count)
        bar(xc, nc, 'r'), hold on;
        bar(xa, na, 'b');
        plot(MEAN_VAR + 0*MAX_NC, MAX_NC, 'g');
        plot(MEAN_VAR + STD_VAR + 0*MAX_NC, MAX_NC, '.-k');
     
        end;
     
     
    end;
        
    
    
         NAME = ['PERIMETER.' FAM{k} '.' int2str(J) '.jpg'];
         print(NAME, '-djpeg');
         close all;   
        
 
         
 end;   
 
 %%
     
 
 save('OBJECT_STATS_EQUIV_DIAM', 'OBJECT_STATS');
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 %%
 
x = 1:max_samples(4);

subplot(2, 1, 1);
plot(x, PROB_EXTENTS(:,2), 'r'), axis([1 max(x) 0 max(PROB_EXTENTS(:,4))]), hold on;
plot(x, PROB_EXTENTS(:,2) - PROB_EXTENTS(:,3), 'g', x, PROB_EXTENTS(:,2) + PROB_EXTENTS(:,3), 'g');

subplot(2, 1, 2);
plot(x, PROB_EXTENTS(:,4), 'b'), axis([1 max(x) 0 max(PROB_EXTENTS(:,4))]), hold on;
plot(x, PROB_EXTENTS(:,4) - PROB_EXTENTS(:,5), 'g', x, PROB_EXTENTS(:,4) + PROB_EXTENTS(:,5), 'g');
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        



