function params = displayParams%% % CODE TO SAVE GAMMA TABLE% Gamma table should be linear%  gamma = (ones(3,1)*(0:255)/255)';%  gammaTable = (ones(3,1)*(0:255))';% %% % where to save?% pth = fullfile(vistadispRootPath, 'exptTools', 'displays','CBI_Propixx');% %% save(fullfile(pth, 'gamma'), 'gamma', 'gammaTable');% Critical parametersparams.numPixels    = [1920 1080];params.dimensions   = [16/9*36 36]; % cmparams.distance     = 83.5;params.frameRate    = 60;params.cmapDepth    = 8;params.screenNumber = 1;% Descriptive parametersparams.position = 'Propixx default';params.stereoFlag = 0;% parameters which can make programming the display easierparams.flipLR = 0;params.flipUD = 0;