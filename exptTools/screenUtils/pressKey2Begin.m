function [time0, quitProg] = pressKey2Begin(params)% [time0, quitProg] = pressKey2Begin(params)%   Displays 'please press any key to begin' on the SCREEN%   just below the center of the screen and waits for the %   user to press a key.% returns the current time at start of scan, and ok (true if experiment is%       started, false if the quit key is pressed)if ischar(params.triggerKey)    promptString = sprintf('Running %s run %d. Please press %s key to begin, or %s to quit.', ...        params.experiment, params.runID, params.triggerKey, params.quitProgKey);else    promptString = sprintf('Running %s run %d. Experiment will begin when trigger is received. Or press %s to quit.', ...        params.experiment, params.runID, params.quitProgKey);endScreen('FillRect', params.display.windowPtr, params.display.backColorRgb);drawFixation(params);dispStringInCenter(params, promptString, 0.55);iwait = true;while iwait    WaitSecs(0.01);        switch params.site        case {'UMC-3T' 'UMC-7T'}                        % At these sites, the trigger is sent through a serial port            % which KbCheck cannot read, so we use PsychToolbox' IOPort                        output = deviceUMC('wait for trigger', params.siteSpecific.port);                        if ~isempty(output)                 % start experiment (stop waiting)                iwait    = false;                 quitProg = false;            end                                otherwise                        % KbWait and KbCheck are device dependent. We use KbCheck in a            % while loop instead of KbWait, as KbWait is reported to be            % unreliable and would need a device input as well.                        [ssKeyIsDown, ~, ssKeyCode] = KbCheck(-1);                                if ssKeyIsDown                str = KbName(find(ssKeyCode));                if iscell(str), str = str{1}; end                                % we just query the first element in str because  KbName                % and KbCheck when used together can return unwanted                % characters (for example, KbName(KbCheck) return '5%' when                % only the '5' key is pressed).                str = str(1);                                switch str                    case params.quitProgKey                        % Quit the experiment gracefully                        quitProg = true;                                                break;                                            case params.triggerKey                        iwait = false;                        quitProg = false;                    otherwise                        % do nothing                end                     end    endendtime0 = GetSecs;return;