setDevelopmentMode(true)
local sx,sy = guiGetScreenSize()
local px,py = 1440,900
local x,y =  (sx/px), (sy/py)

zonas_seguras ={
    {1150.4775390625, -1384.837890625, 0.0, 100, 94, 100},
    {1576.12890625, 1781.6796875, 0.0, 70, 80, 100}
}

function crearZonasSeguras()
    for i, _ in ipairs(zonas_seguras) do
        zona_verde = createColCuboid(zonas_seguras[i][1], zonas_seguras[i][2], zonas_seguras[i][3], zonas_seguras[i][4], zonas_seguras[i][5], zonas_seguras[i][6])
        radar_verde = createRadarArea(zonas_seguras[i][1], zonas_seguras[i][2], zonas_seguras[i][4], zonas_seguras[i][5], 0, 255, 0, 100)
        addEventHandler("onClientColShapeHit", zona_verde, function(hitPlayer)
            if getElementType(hitPlayer) == "player" then
                setPedWeaponSlot(hitPlayer, 0)
                cambiarControlesPlayer(false)
                addEventHandler("onClientRender", getRootElement(), mostrarTexto)
                addEventHandler("onClientPlayerDamage", hitPlayer, quitarDano)
            end
        end)
        addEventHandler("onClientColShapeLeave", zona_verde, function(hitPlayer)
            if getElementType(hitPlayer) == "player" then
                cambiarControlesPlayer(true)
                removeEventHandler("onClientRender", getRootElement(), mostrarTexto)
                removeEventHandler("onClientPlayerDamage", hitPlayer, quitarDano)
            end
        end)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, crearZonasSeguras)

function cambiarControlesPlayer(status)
    toggleControl("fire", status)
    toggleControl("next_weapon", status)
    toggleControl("previous_weapon", status)
    toggleControl("aim_weapon", status)
    toggleControl("vehicle_fire", status)
    toggleControl("vehicle_secondary_fire", status)
end

function mostrarTexto()
    dxDrawText("Estas en Zona Segura", x*292, y*644, x*1176, y*695, tocolor(0,255,0,255), 1.6, "sans", "center", "center", false, false, true, false, false)
end

function quitarDano()
    cancelEvent()
end