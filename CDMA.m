% Parameters
numSatellites = 4;
numUsersPerSatellite = 5;
codeLength = 10;  % Length of spreading code
totalCodes = 20;  % Total available spreading codes

% Generate random spreading codes for each satellite
spreadingCodes = randi([0, 1], totalCodes, codeLength);

% Initialize interference matrix
interferenceMatrix = zeros(numSatellites, numUsersPerSatellite);

% Assign spreading codes to users randomly
assignedCodes = zeros(numSatellites, numUsersPerSatellite);
for satID = 1:numSatellites
    assignedCodes(satID, :) = randi([1, totalCodes], 1, numUsersPerSatellite);
end

% Simulate interference calculation
for satID = 1:numSatellites
    for userID = 1:numUsersPerSatellite
        userCode = assignedCodes(satID, userID);
        
        % Calculate interference for each user based on other users' codes
        for otherSatID = 1:numSatellites
            if otherSatID ~= satID
                interferenceMatrix(satID, userID) = interferenceMatrix(satID, userID) + ...
                    sum(assignedCodes(otherSatID, :) == userCode);
            end
        end
    end
end

% Calculate interference levels and system capacity
totalInterference = sum(interferenceMatrix, 'all');
systemCapacity = totalCodes * numSatellites - totalInterference;

disp('Interference Matrix:');
disp(interferenceMatrix);
fprintf('Total Interference: %d\n', totalInterference);
fprintf('System Capacity: %d\n', systemCapacity);
