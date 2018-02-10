function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 10-Feb-2018 19:22:19


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), array2table(table2array(inputTable(:,{'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), 'VariableNames', {'LBP_1', 'LBP_2', 'LBP_3', 'LBP_4', 'LBP_5', 'LBP_6', 'LBP_7', 'LBP_8', 'LBP_9', 'LBP_10', 'LBP_11', 'LBP_12', 'LBP_13', 'LBP_14', 'LBP_15', 'LBP_16', 'LBP_17', 'LBP_18', 'LBP_19', 'LBP_20', 'LBP_21', 'LBP_22', 'LBP_23', 'LBP_24', 'LBP_25', 'LBP_26', 'LBP_27', 'LBP_28', 'LBP_29', 'LBP_30', 'LBP_31', 'LBP_32', 'LBP_33', 'LBP_34', 'LBP_35', 'LBP_36', 'LBP_37', 'LBP_38', 'LBP_39', 'LBP_40', 'LBP_41', 'LBP_42', 'LBP_43', 'LBP_44', 'LBP_45', 'LBP_46', 'LBP_47', 'LBP_48', 'LBP_49', 'LBP_50', 'LBP_51', 'LBP_52', 'LBP_53', 'LBP_54', 'LBP_55', 'LBP_56', 'LBP_57', 'LBP_58', 'LBP_59', 'HOG_1', 'HOG_2', 'HOG_3', 'HOG_4', 'HOG_5', 'HOG_6', 'HOG_7', 'HOG_8', 'HOG_9', 'HOG_10', 'HOG_11', 'HOG_12', 'HOG_13', 'HOG_14', 'HOG_15', 'HOG_16', 'HOG_17', 'HOG_18', 'HOG_19', 'HOG_20', 'HOG_21', 'HOG_22', 'HOG_23', 'HOG_24', 'HOG_25', 'HOG_26', 'HOG_27', 'HOG_28', 'HOG_29', 'HOG_30', 'HOG_31', 'HOG_32', 'HOG_33', 'HOG_34', 'HOG_35', 'HOG_36', 'HOG_37', 'HOG_38', 'HOG_39', 'HOG_40', 'HOG_41', 'HOG_42', 'HOG_43', 'HOG_44', 'HOG_45', 'HOG_46', 'HOG_47', 'HOG_48', 'HOG_49', 'HOG_50', 'HOG_51', 'HOG_52', 'HOG_53', 'HOG_54', 'HOG_55', 'HOG_56', 'HOG_57', 'HOG_58', 'HOG_59', 'HOG_60', 'HOG_61', 'HOG_62', 'HOG_63', 'HOG_64', 'HOG_65', 'HOG_66', 'HOG_67', 'HOG_68', 'HOG_69', 'HOG_70', 'HOG_71', 'HOG_72', 'HOG_73', 'HOG_74', 'HOG_75', 'HOG_76', 'HOG_77', 'HOG_78', 'HOG_79', 'HOG_80', 'HOG_81', 'HOG_82', 'HOG_83', 'HOG_84', 'HOG_85', 'HOG_86', 'HOG_87', 'HOG_88', 'HOG_89', 'HOG_90', 'HOG_91', 'HOG_92', 'HOG_93', 'HOG_94', 'HOG_95', 'HOG_96', 'HOG_97', 'HOG_98', 'HOG_99', 'HOG_100', 'HOG_101', 'HOG_102', 'HOG_103', 'HOG_104', 'HOG_105', 'HOG_106', 'HOG_107', 'HOG_108', 'HOG_109', 'HOG_110', 'HOG_111', 'HOG_112', 'HOG_113', 'HOG_114', 'HOG_115', 'HOG_116', 'HOG_117', 'HOG_118', 'HOG_119', 'HOG_120', 'HOG_121', 'HOG_122', 'HOG_123', 'HOG_124', 'HOG_125', 'HOG_126', 'HOG_127', 'HOG_128', 'HOG_129', 'HOG_130', 'HOG_131', 'HOG_132', 'HOG_133', 'HOG_134', 'HOG_135', 'HOG_136', 'HOG_137', 'HOG_138', 'HOG_139', 'HOG_140', 'HOG_141', 'HOG_142', 'HOG_143', 'HOG_144', 'glcm_1', 'glcm_2', 'glcm_3', 'glcm_4', 'glcm_5', 'glcm_6', 'glcm_7', 'glcm_8', 'glcm_9', 'glcm_10', 'glcm_11', 'glcm_12', 'glcm_13', 'glcm_14', 'glcm_15', 'glcm_16', 'glcm_17', 'glcm_18', 'glcm_19', 'glcm_20', 'glcm_21', 'glcm_22', 'glcm_23', 'glcm_24', 'glcm_25', 'glcm_26', 'glcm_27', 'glcm_28', 'glcm_29', 'glcm_30', 'glcm_31', 'glcm_32', 'glcm_33', 'glcm_34', 'glcm_35', 'glcm_36', 'glcm_37', 'glcm_38', 'glcm_39', 'glcm_40', 'glcm_41', 'glcm_42', 'glcm_43', 'glcm_44', 'glcm_45', 'glcm_46', 'glcm_47', 'glcm_48', 'glcm_49', 'glcm_50', 'glcm_51', 'glcm_52', 'glcm_53', 'glcm_54', 'glcm_55', 'glcm_56', 'glcm_57', 'glcm_58', 'glcm_59', 'glcm_60', 'glcm_61', 'glcm_62', 'glcm_63', 'glcm_64', 'ProjectionX_1', 'ProjectionX_2', 'ProjectionX_3', 'ProjectionX_4', 'ProjectionX_5', 'ProjectionX_6', 'ProjectionX_7', 'ProjectionX_8', 'ProjectionX_9', 'ProjectionX_10', 'ProjectionX_11', 'ProjectionX_12', 'ProjectionX_13', 'ProjectionX_14', 'ProjectionX_15', 'ProjectionX_16', 'ProjectionX_17', 'ProjectionX_18', 'ProjectionX_19', 'ProjectionX_20', 'ProjectionX_21', 'ProjectionX_22', 'ProjectionX_23', 'ProjectionX_24', 'ProjectionX_25', 'ProjectionX_26', 'ProjectionX_27', 'ProjectionX_28', 'ProjectionX_29', 'ProjectionX_30', 'ProjectionX_31', 'ProjectionX_32', 'ProjectionX_33', 'ProjectionX_34', 'ProjectionX_35', 'ProjectionX_36', 'ProjectionX_37', 'ProjectionX_38', 'ProjectionX_39', 'ProjectionX_40', 'ProjectionX_41', 'ProjectionX_42', 'ProjectionX_43', 'ProjectionX_44', 'ProjectionX_45', 'ProjectionX_46', 'ProjectionX_47', 'ProjectionX_48', 'ProjectionX_49', 'ProjectionX_50', 'ProjectionX_51', 'ProjectionX_52', 'ProjectionX_53', 'ProjectionX_54', 'ProjectionX_55', 'ProjectionX_56', 'ProjectionX_57', 'ProjectionX_58', 'ProjectionX_59', 'ProjectionX_60', 'ProjectionX_61', 'ProjectionX_62', 'ProjectionX_63', 'ProjectionX_64', 'ProjectionY_1', 'ProjectionY_2', 'ProjectionY_3', 'ProjectionY_4', 'ProjectionY_5', 'ProjectionY_6', 'ProjectionY_7', 'ProjectionY_8', 'ProjectionY_9', 'ProjectionY_10', 'ProjectionY_11', 'ProjectionY_12', 'ProjectionY_13', 'ProjectionY_14', 'ProjectionY_15', 'ProjectionY_16', 'ProjectionY_17', 'ProjectionY_18', 'ProjectionY_19', 'ProjectionY_20', 'ProjectionY_21', 'ProjectionY_22', 'ProjectionY_23', 'ProjectionY_24', 'ProjectionY_25', 'ProjectionY_26', 'ProjectionY_27', 'ProjectionY_28', 'ProjectionY_29', 'ProjectionY_30', 'ProjectionY_31', 'ProjectionY_32', 'ProjectionY_33', 'ProjectionY_34', 'ProjectionY_35', 'ProjectionY_36', 'ProjectionY_37', 'ProjectionY_38', 'ProjectionY_39', 'ProjectionY_40', 'ProjectionY_41', 'ProjectionY_42', 'ProjectionY_43', 'ProjectionY_44', 'ProjectionY_45', 'ProjectionY_46', 'ProjectionY_47', 'ProjectionY_48', 'ProjectionY_49', 'ProjectionY_50', 'ProjectionY_51', 'ProjectionY_52', 'ProjectionY_53', 'ProjectionY_54', 'ProjectionY_55', 'ProjectionY_56', 'ProjectionY_57', 'ProjectionY_58', 'ProjectionY_59', 'ProjectionY_60', 'ProjectionY_61', 'ProjectionY_62', 'ProjectionY_63', 'ProjectionY_64'})];

predictorNames = {'Mean', 'Stdev', 'LBP_1', 'LBP_2', 'LBP_3', 'LBP_4', 'LBP_5', 'LBP_6', 'LBP_7', 'LBP_8', 'LBP_9', 'LBP_10', 'LBP_11', 'LBP_12', 'LBP_13', 'LBP_14', 'LBP_15', 'LBP_16', 'LBP_17', 'LBP_18', 'LBP_19', 'LBP_20', 'LBP_21', 'LBP_22', 'LBP_23', 'LBP_24', 'LBP_25', 'LBP_26', 'LBP_27', 'LBP_28', 'LBP_29', 'LBP_30', 'LBP_31', 'LBP_32', 'LBP_33', 'LBP_34', 'LBP_35', 'LBP_36', 'LBP_37', 'LBP_38', 'LBP_39', 'LBP_40', 'LBP_41', 'LBP_42', 'LBP_43', 'LBP_44', 'LBP_45', 'LBP_46', 'LBP_47', 'LBP_48', 'LBP_49', 'LBP_50', 'LBP_51', 'LBP_52', 'LBP_53', 'LBP_54', 'LBP_55', 'LBP_56', 'LBP_57', 'LBP_58', 'LBP_59', 'HOG_1', 'HOG_2', 'HOG_3', 'HOG_4', 'HOG_5', 'HOG_6', 'HOG_7', 'HOG_8', 'HOG_9', 'HOG_10', 'HOG_11', 'HOG_12', 'HOG_13', 'HOG_14', 'HOG_15', 'HOG_16', 'HOG_17', 'HOG_18', 'HOG_19', 'HOG_20', 'HOG_21', 'HOG_22', 'HOG_23', 'HOG_24', 'HOG_25', 'HOG_26', 'HOG_27', 'HOG_28', 'HOG_29', 'HOG_30', 'HOG_31', 'HOG_32', 'HOG_33', 'HOG_34', 'HOG_35', 'HOG_36', 'HOG_37', 'HOG_38', 'HOG_39', 'HOG_40', 'HOG_41', 'HOG_42', 'HOG_43', 'HOG_44', 'HOG_45', 'HOG_46', 'HOG_47', 'HOG_48', 'HOG_49', 'HOG_50', 'HOG_51', 'HOG_52', 'HOG_53', 'HOG_54', 'HOG_55', 'HOG_56', 'HOG_57', 'HOG_58', 'HOG_59', 'HOG_60', 'HOG_61', 'HOG_62', 'HOG_63', 'HOG_64', 'HOG_65', 'HOG_66', 'HOG_67', 'HOG_68', 'HOG_69', 'HOG_70', 'HOG_71', 'HOG_72', 'HOG_73', 'HOG_74', 'HOG_75', 'HOG_76', 'HOG_77', 'HOG_78', 'HOG_79', 'HOG_80', 'HOG_81', 'HOG_82', 'HOG_83', 'HOG_84', 'HOG_85', 'HOG_86', 'HOG_87', 'HOG_88', 'HOG_89', 'HOG_90', 'HOG_91', 'HOG_92', 'HOG_93', 'HOG_94', 'HOG_95', 'HOG_96', 'HOG_97', 'HOG_98', 'HOG_99', 'HOG_100', 'HOG_101', 'HOG_102', 'HOG_103', 'HOG_104', 'HOG_105', 'HOG_106', 'HOG_107', 'HOG_108', 'HOG_109', 'HOG_110', 'HOG_111', 'HOG_112', 'HOG_113', 'HOG_114', 'HOG_115', 'HOG_116', 'HOG_117', 'HOG_118', 'HOG_119', 'HOG_120', 'HOG_121', 'HOG_122', 'HOG_123', 'HOG_124', 'HOG_125', 'HOG_126', 'HOG_127', 'HOG_128', 'HOG_129', 'HOG_130', 'HOG_131', 'HOG_132', 'HOG_133', 'HOG_134', 'HOG_135', 'HOG_136', 'HOG_137', 'HOG_138', 'HOG_139', 'HOG_140', 'HOG_141', 'HOG_142', 'HOG_143', 'HOG_144', 'glcm_1', 'glcm_2', 'glcm_3', 'glcm_4', 'glcm_5', 'glcm_6', 'glcm_7', 'glcm_8', 'glcm_9', 'glcm_10', 'glcm_11', 'glcm_12', 'glcm_13', 'glcm_14', 'glcm_15', 'glcm_16', 'glcm_17', 'glcm_18', 'glcm_19', 'glcm_20', 'glcm_21', 'glcm_22', 'glcm_23', 'glcm_24', 'glcm_25', 'glcm_26', 'glcm_27', 'glcm_28', 'glcm_29', 'glcm_30', 'glcm_31', 'glcm_32', 'glcm_33', 'glcm_34', 'glcm_35', 'glcm_36', 'glcm_37', 'glcm_38', 'glcm_39', 'glcm_40', 'glcm_41', 'glcm_42', 'glcm_43', 'glcm_44', 'glcm_45', 'glcm_46', 'glcm_47', 'glcm_48', 'glcm_49', 'glcm_50', 'glcm_51', 'glcm_52', 'glcm_53', 'glcm_54', 'glcm_55', 'glcm_56', 'glcm_57', 'glcm_58', 'glcm_59', 'glcm_60', 'glcm_61', 'glcm_62', 'glcm_63', 'glcm_64', 'ProjectionX_1', 'ProjectionX_2', 'ProjectionX_3', 'ProjectionX_4', 'ProjectionX_5', 'ProjectionX_6', 'ProjectionX_7', 'ProjectionX_8', 'ProjectionX_9', 'ProjectionX_10', 'ProjectionX_11', 'ProjectionX_12', 'ProjectionX_13', 'ProjectionX_14', 'ProjectionX_15', 'ProjectionX_16', 'ProjectionX_17', 'ProjectionX_18', 'ProjectionX_19', 'ProjectionX_20', 'ProjectionX_21', 'ProjectionX_22', 'ProjectionX_23', 'ProjectionX_24', 'ProjectionX_25', 'ProjectionX_26', 'ProjectionX_27', 'ProjectionX_28', 'ProjectionX_29', 'ProjectionX_30', 'ProjectionX_31', 'ProjectionX_32', 'ProjectionX_33', 'ProjectionX_34', 'ProjectionX_35', 'ProjectionX_36', 'ProjectionX_37', 'ProjectionX_38', 'ProjectionX_39', 'ProjectionX_40', 'ProjectionX_41', 'ProjectionX_42', 'ProjectionX_43', 'ProjectionX_44', 'ProjectionX_45', 'ProjectionX_46', 'ProjectionX_47', 'ProjectionX_48', 'ProjectionX_49', 'ProjectionX_50', 'ProjectionX_51', 'ProjectionX_52', 'ProjectionX_53', 'ProjectionX_54', 'ProjectionX_55', 'ProjectionX_56', 'ProjectionX_57', 'ProjectionX_58', 'ProjectionX_59', 'ProjectionX_60', 'ProjectionX_61', 'ProjectionX_62', 'ProjectionX_63', 'ProjectionX_64', 'ProjectionY_1', 'ProjectionY_2', 'ProjectionY_3', 'ProjectionY_4', 'ProjectionY_5', 'ProjectionY_6', 'ProjectionY_7', 'ProjectionY_8', 'ProjectionY_9', 'ProjectionY_10', 'ProjectionY_11', 'ProjectionY_12', 'ProjectionY_13', 'ProjectionY_14', 'ProjectionY_15', 'ProjectionY_16', 'ProjectionY_17', 'ProjectionY_18', 'ProjectionY_19', 'ProjectionY_20', 'ProjectionY_21', 'ProjectionY_22', 'ProjectionY_23', 'ProjectionY_24', 'ProjectionY_25', 'ProjectionY_26', 'ProjectionY_27', 'ProjectionY_28', 'ProjectionY_29', 'ProjectionY_30', 'ProjectionY_31', 'ProjectionY_32', 'ProjectionY_33', 'ProjectionY_34', 'ProjectionY_35', 'ProjectionY_36', 'ProjectionY_37', 'ProjectionY_38', 'ProjectionY_39', 'ProjectionY_40', 'ProjectionY_41', 'ProjectionY_42', 'ProjectionY_43', 'ProjectionY_44', 'ProjectionY_45', 'ProjectionY_46', 'ProjectionY_47', 'ProjectionY_48', 'ProjectionY_49', 'ProjectionY_50', 'ProjectionY_51', 'ProjectionY_52', 'ProjectionY_53', 'ProjectionY_54', 'ProjectionY_55', 'ProjectionY_56', 'ProjectionY_57', 'ProjectionY_58', 'ProjectionY_59', 'ProjectionY_60', 'ProjectionY_61', 'ProjectionY_62', 'ProjectionY_63', 'ProjectionY_64'};
predictors = inputTable(:, predictorNames);
response = inputTable.Labels;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 3, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', ['*'; 'B'; 'K'; 'N'; 'P'; 'Q'; 'R'; 'b'; 'k'; 'n'; 'p'; 'q'; 'r']);

% Create the result struct with predict function
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), array2table(table2array(t(:,{'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), 'VariableNames', {'LBP_1', 'LBP_2', 'LBP_3', 'LBP_4', 'LBP_5', 'LBP_6', 'LBP_7', 'LBP_8', 'LBP_9', 'LBP_10', 'LBP_11', 'LBP_12', 'LBP_13', 'LBP_14', 'LBP_15', 'LBP_16', 'LBP_17', 'LBP_18', 'LBP_19', 'LBP_20', 'LBP_21', 'LBP_22', 'LBP_23', 'LBP_24', 'LBP_25', 'LBP_26', 'LBP_27', 'LBP_28', 'LBP_29', 'LBP_30', 'LBP_31', 'LBP_32', 'LBP_33', 'LBP_34', 'LBP_35', 'LBP_36', 'LBP_37', 'LBP_38', 'LBP_39', 'LBP_40', 'LBP_41', 'LBP_42', 'LBP_43', 'LBP_44', 'LBP_45', 'LBP_46', 'LBP_47', 'LBP_48', 'LBP_49', 'LBP_50', 'LBP_51', 'LBP_52', 'LBP_53', 'LBP_54', 'LBP_55', 'LBP_56', 'LBP_57', 'LBP_58', 'LBP_59', 'HOG_1', 'HOG_2', 'HOG_3', 'HOG_4', 'HOG_5', 'HOG_6', 'HOG_7', 'HOG_8', 'HOG_9', 'HOG_10', 'HOG_11', 'HOG_12', 'HOG_13', 'HOG_14', 'HOG_15', 'HOG_16', 'HOG_17', 'HOG_18', 'HOG_19', 'HOG_20', 'HOG_21', 'HOG_22', 'HOG_23', 'HOG_24', 'HOG_25', 'HOG_26', 'HOG_27', 'HOG_28', 'HOG_29', 'HOG_30', 'HOG_31', 'HOG_32', 'HOG_33', 'HOG_34', 'HOG_35', 'HOG_36', 'HOG_37', 'HOG_38', 'HOG_39', 'HOG_40', 'HOG_41', 'HOG_42', 'HOG_43', 'HOG_44', 'HOG_45', 'HOG_46', 'HOG_47', 'HOG_48', 'HOG_49', 'HOG_50', 'HOG_51', 'HOG_52', 'HOG_53', 'HOG_54', 'HOG_55', 'HOG_56', 'HOG_57', 'HOG_58', 'HOG_59', 'HOG_60', 'HOG_61', 'HOG_62', 'HOG_63', 'HOG_64', 'HOG_65', 'HOG_66', 'HOG_67', 'HOG_68', 'HOG_69', 'HOG_70', 'HOG_71', 'HOG_72', 'HOG_73', 'HOG_74', 'HOG_75', 'HOG_76', 'HOG_77', 'HOG_78', 'HOG_79', 'HOG_80', 'HOG_81', 'HOG_82', 'HOG_83', 'HOG_84', 'HOG_85', 'HOG_86', 'HOG_87', 'HOG_88', 'HOG_89', 'HOG_90', 'HOG_91', 'HOG_92', 'HOG_93', 'HOG_94', 'HOG_95', 'HOG_96', 'HOG_97', 'HOG_98', 'HOG_99', 'HOG_100', 'HOG_101', 'HOG_102', 'HOG_103', 'HOG_104', 'HOG_105', 'HOG_106', 'HOG_107', 'HOG_108', 'HOG_109', 'HOG_110', 'HOG_111', 'HOG_112', 'HOG_113', 'HOG_114', 'HOG_115', 'HOG_116', 'HOG_117', 'HOG_118', 'HOG_119', 'HOG_120', 'HOG_121', 'HOG_122', 'HOG_123', 'HOG_124', 'HOG_125', 'HOG_126', 'HOG_127', 'HOG_128', 'HOG_129', 'HOG_130', 'HOG_131', 'HOG_132', 'HOG_133', 'HOG_134', 'HOG_135', 'HOG_136', 'HOG_137', 'HOG_138', 'HOG_139', 'HOG_140', 'HOG_141', 'HOG_142', 'HOG_143', 'HOG_144', 'glcm_1', 'glcm_2', 'glcm_3', 'glcm_4', 'glcm_5', 'glcm_6', 'glcm_7', 'glcm_8', 'glcm_9', 'glcm_10', 'glcm_11', 'glcm_12', 'glcm_13', 'glcm_14', 'glcm_15', 'glcm_16', 'glcm_17', 'glcm_18', 'glcm_19', 'glcm_20', 'glcm_21', 'glcm_22', 'glcm_23', 'glcm_24', 'glcm_25', 'glcm_26', 'glcm_27', 'glcm_28', 'glcm_29', 'glcm_30', 'glcm_31', 'glcm_32', 'glcm_33', 'glcm_34', 'glcm_35', 'glcm_36', 'glcm_37', 'glcm_38', 'glcm_39', 'glcm_40', 'glcm_41', 'glcm_42', 'glcm_43', 'glcm_44', 'glcm_45', 'glcm_46', 'glcm_47', 'glcm_48', 'glcm_49', 'glcm_50', 'glcm_51', 'glcm_52', 'glcm_53', 'glcm_54', 'glcm_55', 'glcm_56', 'glcm_57', 'glcm_58', 'glcm_59', 'glcm_60', 'glcm_61', 'glcm_62', 'glcm_63', 'glcm_64', 'ProjectionX_1', 'ProjectionX_2', 'ProjectionX_3', 'ProjectionX_4', 'ProjectionX_5', 'ProjectionX_6', 'ProjectionX_7', 'ProjectionX_8', 'ProjectionX_9', 'ProjectionX_10', 'ProjectionX_11', 'ProjectionX_12', 'ProjectionX_13', 'ProjectionX_14', 'ProjectionX_15', 'ProjectionX_16', 'ProjectionX_17', 'ProjectionX_18', 'ProjectionX_19', 'ProjectionX_20', 'ProjectionX_21', 'ProjectionX_22', 'ProjectionX_23', 'ProjectionX_24', 'ProjectionX_25', 'ProjectionX_26', 'ProjectionX_27', 'ProjectionX_28', 'ProjectionX_29', 'ProjectionX_30', 'ProjectionX_31', 'ProjectionX_32', 'ProjectionX_33', 'ProjectionX_34', 'ProjectionX_35', 'ProjectionX_36', 'ProjectionX_37', 'ProjectionX_38', 'ProjectionX_39', 'ProjectionX_40', 'ProjectionX_41', 'ProjectionX_42', 'ProjectionX_43', 'ProjectionX_44', 'ProjectionX_45', 'ProjectionX_46', 'ProjectionX_47', 'ProjectionX_48', 'ProjectionX_49', 'ProjectionX_50', 'ProjectionX_51', 'ProjectionX_52', 'ProjectionX_53', 'ProjectionX_54', 'ProjectionX_55', 'ProjectionX_56', 'ProjectionX_57', 'ProjectionX_58', 'ProjectionX_59', 'ProjectionX_60', 'ProjectionX_61', 'ProjectionX_62', 'ProjectionX_63', 'ProjectionX_64', 'ProjectionY_1', 'ProjectionY_2', 'ProjectionY_3', 'ProjectionY_4', 'ProjectionY_5', 'ProjectionY_6', 'ProjectionY_7', 'ProjectionY_8', 'ProjectionY_9', 'ProjectionY_10', 'ProjectionY_11', 'ProjectionY_12', 'ProjectionY_13', 'ProjectionY_14', 'ProjectionY_15', 'ProjectionY_16', 'ProjectionY_17', 'ProjectionY_18', 'ProjectionY_19', 'ProjectionY_20', 'ProjectionY_21', 'ProjectionY_22', 'ProjectionY_23', 'ProjectionY_24', 'ProjectionY_25', 'ProjectionY_26', 'ProjectionY_27', 'ProjectionY_28', 'ProjectionY_29', 'ProjectionY_30', 'ProjectionY_31', 'ProjectionY_32', 'ProjectionY_33', 'ProjectionY_34', 'ProjectionY_35', 'ProjectionY_36', 'ProjectionY_37', 'ProjectionY_38', 'ProjectionY_39', 'ProjectionY_40', 'ProjectionY_41', 'ProjectionY_42', 'ProjectionY_43', 'ProjectionY_44', 'ProjectionY_45', 'ProjectionY_46', 'ProjectionY_47', 'ProjectionY_48', 'ProjectionY_49', 'ProjectionY_50', 'ProjectionY_51', 'ProjectionY_52', 'ProjectionY_53', 'ProjectionY_54', 'ProjectionY_55', 'ProjectionY_56', 'ProjectionY_57', 'ProjectionY_58', 'ProjectionY_59', 'ProjectionY_60', 'ProjectionY_61', 'ProjectionY_62', 'ProjectionY_63', 'ProjectionY_64'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(x));
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Mean', 'Stdev', 'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2017b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), array2table(table2array(inputTable(:,{'LBP', 'HOG', 'glcm', 'ProjectionX', 'ProjectionY'})), 'VariableNames', {'LBP_1', 'LBP_2', 'LBP_3', 'LBP_4', 'LBP_5', 'LBP_6', 'LBP_7', 'LBP_8', 'LBP_9', 'LBP_10', 'LBP_11', 'LBP_12', 'LBP_13', 'LBP_14', 'LBP_15', 'LBP_16', 'LBP_17', 'LBP_18', 'LBP_19', 'LBP_20', 'LBP_21', 'LBP_22', 'LBP_23', 'LBP_24', 'LBP_25', 'LBP_26', 'LBP_27', 'LBP_28', 'LBP_29', 'LBP_30', 'LBP_31', 'LBP_32', 'LBP_33', 'LBP_34', 'LBP_35', 'LBP_36', 'LBP_37', 'LBP_38', 'LBP_39', 'LBP_40', 'LBP_41', 'LBP_42', 'LBP_43', 'LBP_44', 'LBP_45', 'LBP_46', 'LBP_47', 'LBP_48', 'LBP_49', 'LBP_50', 'LBP_51', 'LBP_52', 'LBP_53', 'LBP_54', 'LBP_55', 'LBP_56', 'LBP_57', 'LBP_58', 'LBP_59', 'HOG_1', 'HOG_2', 'HOG_3', 'HOG_4', 'HOG_5', 'HOG_6', 'HOG_7', 'HOG_8', 'HOG_9', 'HOG_10', 'HOG_11', 'HOG_12', 'HOG_13', 'HOG_14', 'HOG_15', 'HOG_16', 'HOG_17', 'HOG_18', 'HOG_19', 'HOG_20', 'HOG_21', 'HOG_22', 'HOG_23', 'HOG_24', 'HOG_25', 'HOG_26', 'HOG_27', 'HOG_28', 'HOG_29', 'HOG_30', 'HOG_31', 'HOG_32', 'HOG_33', 'HOG_34', 'HOG_35', 'HOG_36', 'HOG_37', 'HOG_38', 'HOG_39', 'HOG_40', 'HOG_41', 'HOG_42', 'HOG_43', 'HOG_44', 'HOG_45', 'HOG_46', 'HOG_47', 'HOG_48', 'HOG_49', 'HOG_50', 'HOG_51', 'HOG_52', 'HOG_53', 'HOG_54', 'HOG_55', 'HOG_56', 'HOG_57', 'HOG_58', 'HOG_59', 'HOG_60', 'HOG_61', 'HOG_62', 'HOG_63', 'HOG_64', 'HOG_65', 'HOG_66', 'HOG_67', 'HOG_68', 'HOG_69', 'HOG_70', 'HOG_71', 'HOG_72', 'HOG_73', 'HOG_74', 'HOG_75', 'HOG_76', 'HOG_77', 'HOG_78', 'HOG_79', 'HOG_80', 'HOG_81', 'HOG_82', 'HOG_83', 'HOG_84', 'HOG_85', 'HOG_86', 'HOG_87', 'HOG_88', 'HOG_89', 'HOG_90', 'HOG_91', 'HOG_92', 'HOG_93', 'HOG_94', 'HOG_95', 'HOG_96', 'HOG_97', 'HOG_98', 'HOG_99', 'HOG_100', 'HOG_101', 'HOG_102', 'HOG_103', 'HOG_104', 'HOG_105', 'HOG_106', 'HOG_107', 'HOG_108', 'HOG_109', 'HOG_110', 'HOG_111', 'HOG_112', 'HOG_113', 'HOG_114', 'HOG_115', 'HOG_116', 'HOG_117', 'HOG_118', 'HOG_119', 'HOG_120', 'HOG_121', 'HOG_122', 'HOG_123', 'HOG_124', 'HOG_125', 'HOG_126', 'HOG_127', 'HOG_128', 'HOG_129', 'HOG_130', 'HOG_131', 'HOG_132', 'HOG_133', 'HOG_134', 'HOG_135', 'HOG_136', 'HOG_137', 'HOG_138', 'HOG_139', 'HOG_140', 'HOG_141', 'HOG_142', 'HOG_143', 'HOG_144', 'glcm_1', 'glcm_2', 'glcm_3', 'glcm_4', 'glcm_5', 'glcm_6', 'glcm_7', 'glcm_8', 'glcm_9', 'glcm_10', 'glcm_11', 'glcm_12', 'glcm_13', 'glcm_14', 'glcm_15', 'glcm_16', 'glcm_17', 'glcm_18', 'glcm_19', 'glcm_20', 'glcm_21', 'glcm_22', 'glcm_23', 'glcm_24', 'glcm_25', 'glcm_26', 'glcm_27', 'glcm_28', 'glcm_29', 'glcm_30', 'glcm_31', 'glcm_32', 'glcm_33', 'glcm_34', 'glcm_35', 'glcm_36', 'glcm_37', 'glcm_38', 'glcm_39', 'glcm_40', 'glcm_41', 'glcm_42', 'glcm_43', 'glcm_44', 'glcm_45', 'glcm_46', 'glcm_47', 'glcm_48', 'glcm_49', 'glcm_50', 'glcm_51', 'glcm_52', 'glcm_53', 'glcm_54', 'glcm_55', 'glcm_56', 'glcm_57', 'glcm_58', 'glcm_59', 'glcm_60', 'glcm_61', 'glcm_62', 'glcm_63', 'glcm_64', 'ProjectionX_1', 'ProjectionX_2', 'ProjectionX_3', 'ProjectionX_4', 'ProjectionX_5', 'ProjectionX_6', 'ProjectionX_7', 'ProjectionX_8', 'ProjectionX_9', 'ProjectionX_10', 'ProjectionX_11', 'ProjectionX_12', 'ProjectionX_13', 'ProjectionX_14', 'ProjectionX_15', 'ProjectionX_16', 'ProjectionX_17', 'ProjectionX_18', 'ProjectionX_19', 'ProjectionX_20', 'ProjectionX_21', 'ProjectionX_22', 'ProjectionX_23', 'ProjectionX_24', 'ProjectionX_25', 'ProjectionX_26', 'ProjectionX_27', 'ProjectionX_28', 'ProjectionX_29', 'ProjectionX_30', 'ProjectionX_31', 'ProjectionX_32', 'ProjectionX_33', 'ProjectionX_34', 'ProjectionX_35', 'ProjectionX_36', 'ProjectionX_37', 'ProjectionX_38', 'ProjectionX_39', 'ProjectionX_40', 'ProjectionX_41', 'ProjectionX_42', 'ProjectionX_43', 'ProjectionX_44', 'ProjectionX_45', 'ProjectionX_46', 'ProjectionX_47', 'ProjectionX_48', 'ProjectionX_49', 'ProjectionX_50', 'ProjectionX_51', 'ProjectionX_52', 'ProjectionX_53', 'ProjectionX_54', 'ProjectionX_55', 'ProjectionX_56', 'ProjectionX_57', 'ProjectionX_58', 'ProjectionX_59', 'ProjectionX_60', 'ProjectionX_61', 'ProjectionX_62', 'ProjectionX_63', 'ProjectionX_64', 'ProjectionY_1', 'ProjectionY_2', 'ProjectionY_3', 'ProjectionY_4', 'ProjectionY_5', 'ProjectionY_6', 'ProjectionY_7', 'ProjectionY_8', 'ProjectionY_9', 'ProjectionY_10', 'ProjectionY_11', 'ProjectionY_12', 'ProjectionY_13', 'ProjectionY_14', 'ProjectionY_15', 'ProjectionY_16', 'ProjectionY_17', 'ProjectionY_18', 'ProjectionY_19', 'ProjectionY_20', 'ProjectionY_21', 'ProjectionY_22', 'ProjectionY_23', 'ProjectionY_24', 'ProjectionY_25', 'ProjectionY_26', 'ProjectionY_27', 'ProjectionY_28', 'ProjectionY_29', 'ProjectionY_30', 'ProjectionY_31', 'ProjectionY_32', 'ProjectionY_33', 'ProjectionY_34', 'ProjectionY_35', 'ProjectionY_36', 'ProjectionY_37', 'ProjectionY_38', 'ProjectionY_39', 'ProjectionY_40', 'ProjectionY_41', 'ProjectionY_42', 'ProjectionY_43', 'ProjectionY_44', 'ProjectionY_45', 'ProjectionY_46', 'ProjectionY_47', 'ProjectionY_48', 'ProjectionY_49', 'ProjectionY_50', 'ProjectionY_51', 'ProjectionY_52', 'ProjectionY_53', 'ProjectionY_54', 'ProjectionY_55', 'ProjectionY_56', 'ProjectionY_57', 'ProjectionY_58', 'ProjectionY_59', 'ProjectionY_60', 'ProjectionY_61', 'ProjectionY_62', 'ProjectionY_63', 'ProjectionY_64'})];

predictorNames = {'Mean', 'Stdev', 'LBP_1', 'LBP_2', 'LBP_3', 'LBP_4', 'LBP_5', 'LBP_6', 'LBP_7', 'LBP_8', 'LBP_9', 'LBP_10', 'LBP_11', 'LBP_12', 'LBP_13', 'LBP_14', 'LBP_15', 'LBP_16', 'LBP_17', 'LBP_18', 'LBP_19', 'LBP_20', 'LBP_21', 'LBP_22', 'LBP_23', 'LBP_24', 'LBP_25', 'LBP_26', 'LBP_27', 'LBP_28', 'LBP_29', 'LBP_30', 'LBP_31', 'LBP_32', 'LBP_33', 'LBP_34', 'LBP_35', 'LBP_36', 'LBP_37', 'LBP_38', 'LBP_39', 'LBP_40', 'LBP_41', 'LBP_42', 'LBP_43', 'LBP_44', 'LBP_45', 'LBP_46', 'LBP_47', 'LBP_48', 'LBP_49', 'LBP_50', 'LBP_51', 'LBP_52', 'LBP_53', 'LBP_54', 'LBP_55', 'LBP_56', 'LBP_57', 'LBP_58', 'LBP_59', 'HOG_1', 'HOG_2', 'HOG_3', 'HOG_4', 'HOG_5', 'HOG_6', 'HOG_7', 'HOG_8', 'HOG_9', 'HOG_10', 'HOG_11', 'HOG_12', 'HOG_13', 'HOG_14', 'HOG_15', 'HOG_16', 'HOG_17', 'HOG_18', 'HOG_19', 'HOG_20', 'HOG_21', 'HOG_22', 'HOG_23', 'HOG_24', 'HOG_25', 'HOG_26', 'HOG_27', 'HOG_28', 'HOG_29', 'HOG_30', 'HOG_31', 'HOG_32', 'HOG_33', 'HOG_34', 'HOG_35', 'HOG_36', 'HOG_37', 'HOG_38', 'HOG_39', 'HOG_40', 'HOG_41', 'HOG_42', 'HOG_43', 'HOG_44', 'HOG_45', 'HOG_46', 'HOG_47', 'HOG_48', 'HOG_49', 'HOG_50', 'HOG_51', 'HOG_52', 'HOG_53', 'HOG_54', 'HOG_55', 'HOG_56', 'HOG_57', 'HOG_58', 'HOG_59', 'HOG_60', 'HOG_61', 'HOG_62', 'HOG_63', 'HOG_64', 'HOG_65', 'HOG_66', 'HOG_67', 'HOG_68', 'HOG_69', 'HOG_70', 'HOG_71', 'HOG_72', 'HOG_73', 'HOG_74', 'HOG_75', 'HOG_76', 'HOG_77', 'HOG_78', 'HOG_79', 'HOG_80', 'HOG_81', 'HOG_82', 'HOG_83', 'HOG_84', 'HOG_85', 'HOG_86', 'HOG_87', 'HOG_88', 'HOG_89', 'HOG_90', 'HOG_91', 'HOG_92', 'HOG_93', 'HOG_94', 'HOG_95', 'HOG_96', 'HOG_97', 'HOG_98', 'HOG_99', 'HOG_100', 'HOG_101', 'HOG_102', 'HOG_103', 'HOG_104', 'HOG_105', 'HOG_106', 'HOG_107', 'HOG_108', 'HOG_109', 'HOG_110', 'HOG_111', 'HOG_112', 'HOG_113', 'HOG_114', 'HOG_115', 'HOG_116', 'HOG_117', 'HOG_118', 'HOG_119', 'HOG_120', 'HOG_121', 'HOG_122', 'HOG_123', 'HOG_124', 'HOG_125', 'HOG_126', 'HOG_127', 'HOG_128', 'HOG_129', 'HOG_130', 'HOG_131', 'HOG_132', 'HOG_133', 'HOG_134', 'HOG_135', 'HOG_136', 'HOG_137', 'HOG_138', 'HOG_139', 'HOG_140', 'HOG_141', 'HOG_142', 'HOG_143', 'HOG_144', 'glcm_1', 'glcm_2', 'glcm_3', 'glcm_4', 'glcm_5', 'glcm_6', 'glcm_7', 'glcm_8', 'glcm_9', 'glcm_10', 'glcm_11', 'glcm_12', 'glcm_13', 'glcm_14', 'glcm_15', 'glcm_16', 'glcm_17', 'glcm_18', 'glcm_19', 'glcm_20', 'glcm_21', 'glcm_22', 'glcm_23', 'glcm_24', 'glcm_25', 'glcm_26', 'glcm_27', 'glcm_28', 'glcm_29', 'glcm_30', 'glcm_31', 'glcm_32', 'glcm_33', 'glcm_34', 'glcm_35', 'glcm_36', 'glcm_37', 'glcm_38', 'glcm_39', 'glcm_40', 'glcm_41', 'glcm_42', 'glcm_43', 'glcm_44', 'glcm_45', 'glcm_46', 'glcm_47', 'glcm_48', 'glcm_49', 'glcm_50', 'glcm_51', 'glcm_52', 'glcm_53', 'glcm_54', 'glcm_55', 'glcm_56', 'glcm_57', 'glcm_58', 'glcm_59', 'glcm_60', 'glcm_61', 'glcm_62', 'glcm_63', 'glcm_64', 'ProjectionX_1', 'ProjectionX_2', 'ProjectionX_3', 'ProjectionX_4', 'ProjectionX_5', 'ProjectionX_6', 'ProjectionX_7', 'ProjectionX_8', 'ProjectionX_9', 'ProjectionX_10', 'ProjectionX_11', 'ProjectionX_12', 'ProjectionX_13', 'ProjectionX_14', 'ProjectionX_15', 'ProjectionX_16', 'ProjectionX_17', 'ProjectionX_18', 'ProjectionX_19', 'ProjectionX_20', 'ProjectionX_21', 'ProjectionX_22', 'ProjectionX_23', 'ProjectionX_24', 'ProjectionX_25', 'ProjectionX_26', 'ProjectionX_27', 'ProjectionX_28', 'ProjectionX_29', 'ProjectionX_30', 'ProjectionX_31', 'ProjectionX_32', 'ProjectionX_33', 'ProjectionX_34', 'ProjectionX_35', 'ProjectionX_36', 'ProjectionX_37', 'ProjectionX_38', 'ProjectionX_39', 'ProjectionX_40', 'ProjectionX_41', 'ProjectionX_42', 'ProjectionX_43', 'ProjectionX_44', 'ProjectionX_45', 'ProjectionX_46', 'ProjectionX_47', 'ProjectionX_48', 'ProjectionX_49', 'ProjectionX_50', 'ProjectionX_51', 'ProjectionX_52', 'ProjectionX_53', 'ProjectionX_54', 'ProjectionX_55', 'ProjectionX_56', 'ProjectionX_57', 'ProjectionX_58', 'ProjectionX_59', 'ProjectionX_60', 'ProjectionX_61', 'ProjectionX_62', 'ProjectionX_63', 'ProjectionX_64', 'ProjectionY_1', 'ProjectionY_2', 'ProjectionY_3', 'ProjectionY_4', 'ProjectionY_5', 'ProjectionY_6', 'ProjectionY_7', 'ProjectionY_8', 'ProjectionY_9', 'ProjectionY_10', 'ProjectionY_11', 'ProjectionY_12', 'ProjectionY_13', 'ProjectionY_14', 'ProjectionY_15', 'ProjectionY_16', 'ProjectionY_17', 'ProjectionY_18', 'ProjectionY_19', 'ProjectionY_20', 'ProjectionY_21', 'ProjectionY_22', 'ProjectionY_23', 'ProjectionY_24', 'ProjectionY_25', 'ProjectionY_26', 'ProjectionY_27', 'ProjectionY_28', 'ProjectionY_29', 'ProjectionY_30', 'ProjectionY_31', 'ProjectionY_32', 'ProjectionY_33', 'ProjectionY_34', 'ProjectionY_35', 'ProjectionY_36', 'ProjectionY_37', 'ProjectionY_38', 'ProjectionY_39', 'ProjectionY_40', 'ProjectionY_41', 'ProjectionY_42', 'ProjectionY_43', 'ProjectionY_44', 'ProjectionY_45', 'ProjectionY_46', 'ProjectionY_47', 'ProjectionY_48', 'ProjectionY_49', 'ProjectionY_50', 'ProjectionY_51', 'ProjectionY_52', 'ProjectionY_53', 'ProjectionY_54', 'ProjectionY_55', 'ProjectionY_56', 'ProjectionY_57', 'ProjectionY_58', 'ProjectionY_59', 'ProjectionY_60', 'ProjectionY_61', 'ProjectionY_62', 'ProjectionY_63', 'ProjectionY_64'};
predictors = inputTable(:, predictorNames);
response = inputTable.Labels;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
