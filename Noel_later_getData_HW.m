function [data_, labels_] = later_getData(subjectTag, dataDirectory, expressCutoff)
    % Function to load and preprocess data based on specified criteria

    if nargin < 1 || isempty(subjectTag)
        subjectTag = 'AB';
    end

    if nargin < 2 || isempty(dataDirectory)
        dataDirectory = fullfile('/MATLAB Drive/');
    end

    if nargin < 3 || isempty(expressCutoff)
        expressCutoff = 0.0;
    end

    % Load the data from a .mat file into a structure
    dataStruct = load(fullfile(dataDirectory, [subjectTag '_RT.mat']));

    % Display variable names for debugging
    disp('Variables in the loaded .mat file:');
    disp(fieldnames(dataStruct));  % Display the variable names

    % Extract variables from the structure
    % Check if each variable exists before assigning
    if isfield(dataStruct, 'percorrSum')
        percorrSum = dataStruct.percorrSum;
    else
        error('Variable "percorrSum" not found in the .mat file.');
    end

    if isfield(dataStruct, 'tRxnSum')
        tRxnSum = dataStruct.tRxnSum;
    else
        error('Variable "tRxnSum" not found in the .mat file.');
    end

    if isfield(dataStruct, 'numdirSum')
        numdirSum = dataStruct.numdirSum;
    else
        error('Variable "numdirSum" not found in the .mat file.');
    end

    if isfield(dataStruct, 'labelSum')
        labelSum = dataStruct.labelSum;
    else
        error('Variable "labelSum" not found in the .mat file.');
    end

    % Selection criteria for trials
    Ltrials = percorrSum == 1 & tRxnSum > expressCutoff & tRxnSum < 1.2;

    % Organizing the data into specified categories
    data_ = { ...
        tRxnSum(Ltrials & numdirSum == -1 & labelSum == 1), ... % C_L,0
        tRxnSum(Ltrials & numdirSum == -1 & labelSum ~= 1), ... % C_L,1+
        tRxnSum(Ltrials & numdirSum ==  1 & labelSum == 1), ... % C_R,0
        tRxnSum(Ltrials & numdirSum ==  1 & labelSum ~= 1)};    % C_R,1+

    if nargout > 1
        labels_ = {'Left Choice, No CP', 'Left Choice, CP', 'Right Choice, No CP', 'Right Choice, CP'};
    end
end

function likelihoods = computeLikelihood(data, fits)
    % Compute the likelihoods for the LATER model
    muR = fits(1);      % Mean reaction time
    deltaS = fits(2);   % Standard deviation

    % Initialize total log-likelihood
    logLikelihoodSum = 0;

    % Loop through each data condition
    for i = 1:length(data)
        % Calculate the PDF values for each data point in the condition
        pdf_values = normpdf(data{i}, muR, deltaS);
        
        % Ensure no likelihood is less than a small value to avoid log(0)
        pdf_values(pdf_values < eps) = eps;
        
        % Accumulate the sum of log-likelihoods
        logLikelihoodSum = logLikelihoodSum + sum(log(pdf_values));
    end

    % Return the negative sum of log-likelihoods (for minimization)
    likelihoods = -logLikelihoodSum;
end

% Main script
% Step 1: Load your data
[data, labels] = later_getData('AB', '/MATLAB Drive', 0.2);  

% Step 2: Combine RTs into a single array
RTs = [data{:}];  

% Step 3: Calculate initial values
meanRT = mean(RTs);
stdRT = std(RTs);
initialValues = [meanRT, stdRT];  

% Step 4: Define bounds
lowerBounds = [0.001, 0.001];
upperBounds = [1000, 1000];

% Step 5: Define the objective function
laterErrFcn = @(fits) computeLikelihood(data, fits);

% Step 6: Set optimization options
opts = optimoptions(@fmincon, ...
    'Algorithm',   'active-set', ...
    'MaxIter',     3000, ...
    'MaxFunEvals', 3000);

% Step 7: Create the optimization problem
problem = createOptimProblem('fmincon', ...
    'objective',   laterErrFcn, ...
    'x0',          initialValues, ...
    'lb',          lowerBounds, ...
    'ub',          upperBounds, ...
    'options',     opts);

% Step 8: Create GlobalSearch object
gs = GlobalSearch;

% Step 9: Run the optimization
[fits, nllk] = run(gs, problem);

% Step 10: Display results
fprintf('Optimal Parameters:\n');
fprintf('muR: %.2f\n', fits(1));
fprintf('deltaS: %.2f\n', fits(2));
fprintf('Negative Log-Likelihood: %.2f\n', nllk);

% Generate predicted values based on fitted parameters
muR = fits(1);
deltaS = fits(2);
x_values = linspace(0, 1000, 100);  % Adjust range based on your RT data
predicted_pdf = normpdf(x_values, muR, deltaS);

% Plotting
figure;
histogram(RTs, 'Normalization', 'pdf'); % Histogram of observed data
hold on;
plot(x_values, predicted_pdf, 'r-', 'LineWidth', 2); % Predicted PDF
xlabel('Reaction Time (ms)');
ylabel('Probability Density');
title('Observed Data vs. Fitted Model');
legend('Observed Data', 'Fitted Model');
hold off;

% Calculate residuals
predicted_RTs = muR + deltaS * randn(size(RTs));  % Example prediction
residuals = RTs - predicted_RTs;

% Plot residuals
figure;
scatter(predicted_RTs, residuals);
xlabel('Predicted RTs');
ylabel('Residuals');
title('Residuals vs. Predicted RTs');
hold on;
yline(0, 'r--'); % Horizontal line at zero
hold off;
