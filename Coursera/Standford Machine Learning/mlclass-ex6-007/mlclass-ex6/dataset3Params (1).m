function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_steps = [ 0.01, 0.03, 0.1, 0.3, 1.0, 3.0, 10.0, 30.0];
sigma_steps = [ 0.01, 0.03, 0.1, 0.3, 1.0, 3.0, 10.0, 30.0];

% C_steps = [0.01; 0.3; 1;  3];
% sigma_steps = [0.01; 0.3; 1; 3];

optimal_error =  99;
optimal_C = 0;
optimal_sigma = 0;


for C_test = C_steps
	for sigma_test = sigma_steps
		model= svmTrain(X, y, C_test, @(x1, x2) gaussianKernel(x1, x2, sigma_test));
		predictions = svmPredict(model, Xval);
		error = mean(double(predictions ~= yval));
		if (error < optimal_error)
			optimal_error = error;
			optimal_C = C_test;
			optimal_sigma = sigma_test;
		end
	end
end

C = optimal_C;
sigma = optimal_sigma;

disp(C);
disp(sigma);








% =========================================================================

end
