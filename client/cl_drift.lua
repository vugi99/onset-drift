local mult = 1 -- drift variable

local vehicles_blacklist = {
    10,
    20,
    26,
    30,
    31,
    33,
    34,
    41,
}

function IsVehicleBlacklisted(veh)
    local id = GetVehicleModel(veh)
    for i, v in ipairs(vehicles_blacklist) do
        if v == id then
            return true
        end
    end
    return false
end

AddEvent("OnGameTick",function(ds)
    local veh = GetPlayerVehicle(GetPlayerId())
    if (veh ~= 0 and IsValidVehicle(veh) and GetVehicleDriver(veh) == GetPlayerId()) then
        if (not IsVehicleInAir(veh) and not IsVehicleBlacklisted(veh)) then
            local vehsk = GetVehicleSkeletalMeshComponent(veh)
            local speed = GetVehicleForwardSpeed(veh)
            local wsa1 = GetVehicleWheelSteerAngle(veh, 1)
            local mult2 = mult * ds
            if (speed > 1 or speed < -1) then
                if (wsa1 > 1 or wsa1 < -1) then
                    wsa1 = wsa1 / 10
                    vehsk:SetPhysicsAngularVelocityInDegrees(FVector(0, 0, speed * wsa1 * mult2), true)
                end
            end
        end
    end
end)