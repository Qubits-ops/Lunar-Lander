
music = love.audio.newSource("music1.mp3","stream")

Vaisseau = {}
Vaisseau.x = 0
Vaisseau.y  = 0
Vaisseau.vx = 0
Vaisseau.vy = 0
Vaisseau.speed = 2
Vaisseau.angle = -90
Vaisseau.img = love.graphics.newImage("images/ship.png")

plateforme = {}
plateforme.largeur = 800
plateforme.hauteur = 40
plateforme.x = 0
plateforme.y = 600 - plateforme.hauteur

engine = {}
--engine.x = 1
--engine.y  = 1
engine.img = love.graphics.newImage("images/engine.png")
engineIsOn = false
engineIsOn2 = false

fondE = {}
fondE.x = 1
fondE.y = 1
fondE.img = love.graphics.newImage("images/espace.png")

print(Vaisseau.img:getWidth())
print(Vaisseau.img:getHeight())
function love.load()
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
 
  Vaisseau.x = largeur/2
  Vaisseau.y = hauteur/2 
end

function love.update(dt)
  love.audio.play(music)
  if love.keyboard.isDown("up") then
    engineIsOn = true
    
    local angle_radiant = math.rad(Vaisseau.angle)
    
    local force_x = math.cos(angle_radiant) * (Vaisseau.speed * dt)
    local force_y = math.sin(angle_radiant) * (Vaisseau.speed * dt)
    Vaisseau.vx = Vaisseau.vx + force_x
    Vaisseau.vy = Vaisseau.vy + force_y
  else
    engineIsOn = false
    --Vaisseau.y = Vaisseau.y + 1
    
  end
  if love.keyboard.isDown("right") then
    Vaisseau.angle = Vaisseau.angle + 1
    if math.abs(Vaisseau.angle) > 360 then
      Vaisseau.angle = 0
    end
    
  end
  if love.keyboard.isDown("left") then
    Vaisseau.angle = Vaisseau.angle - 1
    if Vaisseau.angle < -360 then
      Vaisseau.angle = 0
    
    end
  end
  if love.keyboard.isDown("down") then
    engineIsOn2 = true
    local angle_radiant = math.rad(Vaisseau.angle)
    
    local force_x = math.cos(angle_radiant) * (Vaisseau.speed * dt)
    local force_y = math.sin(angle_radiant) * (Vaisseau.speed * dt)
    Vaisseau.vx = Vaisseau.vx - force_x
    Vaisseau.vy = Vaisseau.vy - force_y
  else
    engineIsOn2 = false
  end
  Vaisseau.x = Vaisseau.x + Vaisseau.vx
  Vaisseau.y = Vaisseau.y + Vaisseau.vy
  if Vaisseau.y >= plateforme.y + plateforme.hauteur then
      print("bravo tu as atteint la plateforme")
       --Vaisseau.vy = 0
 end

end

function love.draw()
  local sDebug = ""
  sDebug = sDebug.."Angle: "..tostring(Vaisseau.angle)
  love.graphics.draw(fondE.img,fondE.x,fondE.y)
  love.graphics.print(sDebug,1,1)
  love.graphics.draw(Vaisseau.img,Vaisseau.x,Vaisseau.y,math.rad(Vaisseau.angle),1,1,Vaisseau.img:getWidth()/2,Vaisseau.img:getHeight()/2)
  if engineIsOn == true or engineIsOn2 == true then
    love.graphics.draw(engine.img,Vaisseau.x,Vaisseau.y,math.rad(Vaisseau.angle),1,1,engine.img:getWidth()/2,engine.img:getHeight()/2)
  end
  love.graphics.rectangle("fill",plateforme.x,plateforme.y,plateforme.largeur,plateforme.hauteur)

end
