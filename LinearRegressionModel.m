classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            
            for i = 1:nargin
                if ischar(varargin{i}) && strcmp(varargin{i},'Data')
                    obj.trainingData = varargin{i+1};
                elseif ischar(varargin{i}) && strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i+1};
                end
            end
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J

            hValue = obj.hypothesis();
            error = (hValue - obj.trainingData.commandVar).^2;
            J = sum(error)/(2*m);
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code

            hValue = X * obj.theta;
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            
            costs = zeros(length(theta0_vals),length(theta1_vals)); % init storage !
            % calculation
            for i = 1:100
                for j = 1:100
                    obj.setTheta(theta0_vals(i),theta1_vals(j))
                    cost = obj.costFunction();
                    costs(j,i) = cost;
                end
            end
            
            %plotting
            contour(theta0_vals,theta1_vals,costs);
            hold on;
            xlabel('\theta_0');
            xlim([50 150]);
            ylabel('\theta_1');
            ylim([0 2]);
            plot(obj.thetaOptimum(1),obj.thetaOptimum(2),"rx","MarkerSize",10,"LineWidth",2);

        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label

            % calculation
            for i = 1:100
                for j = 1:100
                    obj.setTheta(theta0_vals(i),theta1_vals(j))
                    cost = obj.costFunction();
                    costs(j,i) = cost;
                end
            end
            
            % plotting
            surf(theta0_vals,theta1_vals,costs)
            xlabel('\theta_0');
            ylabel('\theta_1');
            
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           % add the final trained model plot to the figure ('b-')
           % update the legend
           
           hold on;
           xAxis = linspace(310, 640, 2);
           xlim([300 650]);
           yAxis = xAxis * obj.theta(2) + obj.theta(1);
           ylim([250 650]);
           plot(xAxis, yAxis, "b-");
           legend("Training Data", "Linear Regression Model")
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


