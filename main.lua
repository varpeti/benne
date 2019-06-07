local shape =
{
    {x=   0,y=   0},
    {x= 100,y=   0},
    {x= 150,y=  50},
    {x= 100,y= 100},
    {x=   0,y= 100},
}

local points =
{
    {x= 100,y=  50},
    {x=  20,y=  80},
    {x= 150,y=   0},
    {x=  99,y=  99},
    {x= 125,y=  76},
    {x=  50,y=  50},
    {x=   1,y=   0}
}

function sign(p1, p2, p3)
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)
end

function isPointInTriangle(p, p0, p1, p2)
    local A = 1/2 * (-p1.y * p2.x + p0.y * (-p1.x + p2.x) + p0.x * (p1.y - p2.y) + p1.x * p2.y);
    local sign = 1 if A<0 then sign = -1 end
    local s = (p0.y * p2.x - p0.x * p2.y + (p2.y - p0.y) * p.x + (p0.x - p2.x) * p.y) * sign;
    local t = (p0.x * p1.y - p0.y * p1.x + (p0.y - p1.y) * p.x + (p1.x - p0.x) * p.y) * sign;
    
    return s>=0 and t>=0 and (s+t)<=(2*A*sign);
end

function copyPoint(b)
    local a = {x=b.x,y=b.y}
    return a
end

function copyShape(b)
    local a = {}
    for i,point in ipairs(b) do
        table.insert(a, copyPoint(point))
    end
    return a
end

function shape2Triangles(shape)
    local triangles = {}

    local s = copyShape(shape)

    while #s>=3 do
        local triangle = {{x=0,y=0},{x=0,y=0},{x=0,y=0}}
        triangle[1] = copyPoint(s[1])
        triangle[2] = copyPoint(s[2])
        triangle[3] = copyPoint(s[3])
        table.remove(s,2)
        table.insert(triangles,triangle)
    end
    return triangles
end

function isInside(shape,point)
    local triangles = shape2Triangles(shape)

    for i,triangle in ipairs(triangles) do
        if isPointInTriangle(point,triangle[1],triangle[2],triangle[3]) then return true end
    end
    return false
end


for p,point in ipairs(points) do
    print(isInside(shape,point))
end