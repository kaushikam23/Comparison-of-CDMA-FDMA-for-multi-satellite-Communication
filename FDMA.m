% Parameters
numSatellites = 4;
numUsersPerSatellite = 5;
totalFrequencyBands = 20;
reuseFactor = 4;

% Calculate available frequency bands per satellite
frequencyBandsPerSatellite = totalFrequencyBands / reuseFactor;

% Generate random bandwidth requirements for users
bandwidthRequirements = randi([1, 5], numSatellites, numUsersPerSatellite);

% Initialize interference matrix
interferenceMatrix = zeros(numSatellites, numUsersPerSatellite);

% Simulate frequency allocation and interference calculation
for satID = 1:numSatellites
    for userID = 1:numUsersPerSatellite
        userBandwidth = bandwidthRequirements(satID, userID);
        
        % Calculate interference for each user based on allocated frequency bands
        for otherSatID = 1:numSatellites
            if otherSatID ~= satID
                interferenceMatrix(satID, userID) = interferenceMatrix(satID, userID) + ...
                    sum(bandwidthRequirements(otherSatID, :) == userBandwidth);
            end
        end
    end
end

% Calculate interference levels and system capacity
totalInterference = sum(interferenceMatrix, 'all');
systemCapacity = totalFrequencyBands - totalInterference;

disp('Interference Matrix:');
disp(interferenceMatrix);
fprintf('Total Interference: %d\n', totalInterference);
fprintf('System Capacity: %d\n', systemCapacity);
