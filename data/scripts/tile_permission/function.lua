function setPermission(var)
    tile = Tile(position)

    if var.teleportPos then
        teleportPos = var.teleportPos
    else 
        error()
    end
    
    if var.description then
        description = var.description
    else 
        description = "Voc� n�o pode passar."
    end

    if var.permission then
        permission = var.permission
    else
        error()
    end

end
