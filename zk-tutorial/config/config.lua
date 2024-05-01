config = {}
config.debug = false;
config.popUpMessage = "Welcome to zK tutorial, Do you wish to start our tutorial or skip it?";
config.Locations = {
    [1] = {
        Location = "Gun Store", 
        LocationDescription = "You can purchase guns here, however you might be asked for your id and other information, if you really want a gun without being tracked to you this isn't the place to go.",
        CameraLocation = vec3(17.2784, -1152.3330, 44.4257),
        CameraPoint = vec3(17.3906, -1117.3589, 29.7911);
    };
    [2] = {
        Location = "Legion Square", 
        LocationDescription = "This is a chill zone, a lot of people go here to talk to there friends, play in the park, or even rob some civilians, whatever floats your boat.",
        CameraLocation = vec3(220.8129, -1044.9304, 62.0464),
        CameraPoint = vec3(187.9803, -974.9086, 36.0898);
    };
    [3] = {
        Location = "Simeons Dealership", 
        LocationDescription = "This is one of our many vehicle dealerships, crime rate is typicially low around this area, as its nearby to a police station, you can get anything from low end vehicles, to the best in the city, check out our boy simon when your free or in need of some wheels",
        CameraLocation = vec3(-96.3759, -1118.4254, 47.1564),
        CameraPoint = vec3(-59.2380, -1105.7490, 26.4358);
    };
    [4] = {
        Location = "Los Santos Weapon Dealer", 
        LocationDescription = "This is Vespucci PD, do you have a crime to report, or want to apply for our police jobs, this is your place, beware firearms are not aloud within the police zone.",
        CameraLocation = vec3(-1075.8790, -757.8564, 50.0828),
        CameraPoint = vec3(-1078.2189, -797.3642, 19.2868);
    };
}


--exports.zk-tutorial:InitiateTutorial()


