local isPromptDisplayed = false;
local isTutorialStarted = false;
local currentTutorialCamera = nil;
local currentLocation = 1;
local maxLocations = #config.Locations

local function deleteTutorialCamera()
    SetCamActive(currentTutorialCamera, false)
    RenderScriptCams(false, false, 1, true, true)
    DestroyCam(currentTutorialCamera, false)
    currentTutorialCamera = nil;
end

local function setCameraAtLocation()
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    RequestCollisionAtCoord(config.Locations[currentLocation].CameraPoint[1], config.Locations[currentLocation].CameraPoint[2], config.Locations[currentLocation].CameraPoint[3])
    SetEntityCoords(playerPed, config.Locations[currentLocation].CameraPoint[1], config.Locations[currentLocation].CameraPoint[2], config.Locations[currentLocation].CameraPoint[3])
    if currentTutorialCamera then
        DestroyCam(currentTutorialCamera, 1)
        currentTutorialCamera = nil;
    end
    currentTutorialCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", config.Locations[currentLocation].CameraLocation[1], config.Locations[currentLocation].CameraLocation[2], config.Locations[currentLocation].CameraLocation[3], 320.00, 0.00, -50.00, 40.00, false, 0)
    PointCamAtCoord(currentTutorialCamera, config.Locations[currentLocation].CameraPoint[1], config.Locations[currentLocation].CameraPoint[2], config.Locations[currentLocation].CameraPoint[3])
    SetCamActive(currentTutorialCamera, true)
    RenderScriptCams(true, true, 500, true, true)
end

local function hideDuringTutorial()
    DisplayRadar(true) -- stuff you want to hide during tutorial, huds, whatever it may be will go here.
end

local function finishedTutorial()
    DoScreenFadeIn(500)
    isPromptDisplayed = false;
    isTutorialStarted = false;
    currentTutorialCamera = nil;
    currentLocation = 1;
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true, 0)
    SetEntityCoords(PlayerPedId(),-1034.5088, -2730.9915, 13.7566)
    deleteTutorialCamera()
    SetNuiFocus(isPromptDisplayed, isPromptDisplayed)
    Wait(500)
    DoScreenFadeIn(500)
end

local function goNextOrBackwards(action)
    if action == "back" then
        if currentLocation ~= 1 then
            currentLocation = currentLocation - 1;
            SendNUIMessage({event = "buildSlide", locationName = config.Locations[currentLocation].Location, locationDescription = config.Locations[currentLocation].LocationDescription})
            setCameraAtLocation()
        end
    elseif action == "forward" then
        if currentLocation ~= maxLocations then
            currentLocation = currentLocation + 1;
            SendNUIMessage({event = "buildSlide", locationName = config.Locations[currentLocation].Location, locationDescription = config.Locations[currentLocation].LocationDescription})
            setCameraAtLocation()
        end
    end
end

local function showTutorialPopUP()
    SendNUIMessage({event = "show-popup", popUpMessage = config.popUpMessage})
    isPromptDisplayed = not isPromptDisplayed;
    SetNuiFocus(isPromptDisplayed, isPromptDisplayed)
end

exports('InitiateTutorial', function()
    showTutorialPopUP()
end)
  

if config.debug then
    RegisterCommand("testprompt", function()
        showTutorialPopUP()
    end)
end

RegisterNUICallback('zK:TriggerAction', function(data, cb)
    if data.event == "skip" then
        isPromptDisplayed = not isPromptDisplayed;
        SetNuiFocus(isPromptDisplayed, isPromptDisplayed)
        finishedTutorial()
    elseif data.event == "start" then
        hideDuringTutorial()
        setCameraAtLocation()
        SendNUIMessage({event = "buildSlide", locationName = config.Locations[currentLocation].Location, locationDescription = config.Locations[currentLocation].LocationDescription, maxSlides = maxLocations})
    elseif data.event == "next" then
        goNextOrBackwards("forward")
    elseif data.event == "back" then
        goNextOrBackwards("back")
    elseif data.event == "finish" then
        finishedTutorial()
    end
end)