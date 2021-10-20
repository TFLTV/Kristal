local Collider = Class()

function Collider:init(x, y, parent)
    self.parent = parent

    self.x = x or 0
    self.y = y or 0
end

function Collider:getTransform()
    if self.parent then
        return self.parent:getFullTransform()
    else
        return nil
    end
end

function Collider:getTransformsWith(other)
    if self.parent and other.parent and self.parent.parent == other.parent.parent then
        return self.parent:getTransform(), other.parent:getTransform()
    else
        return self:getTransform(), other:getTransform()
    end
end

function Collider:getPointFor(other, x, y)
    if self.parent and other.parent then
        return other.parent:getRelativePos(self.parent, other.x + x, other.y + y)
    elseif self.parent then
        return self.parent:getFullTransform():inverseTransformPoint(other.x + x, other.y + y)
    elseif other.parent then
        return other.parent:getFullTransform():transformPoint(other.x + x, other.y + y)
    else
        return other.x + x, other.y + y
    end
end

function Collider:collidesWith(other)
    return false
end

return Collider