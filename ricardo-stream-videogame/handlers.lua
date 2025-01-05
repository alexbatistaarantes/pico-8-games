region = {top = 4*8}
region.bottom = 11*8
region.height = region.bottom - region.top
region.vertical_mid = region.top + (region.height / 2)
region.right_margin = 24

ricardo = {
    x = 2,
    y = region.vertical_mid,
    speed = 2,
    sprites = {normal=1, shooting=2},

    money=0,
    hit=0
}

shoot = {
    delay = 15,
    last = 0,
    speed = 3,
    is_shooting = false,
    curses = {"#@$%!", "!&$#@", "%*#!@+"},
    bullets = {}
}

chat = {
    users = {},
    count = 0,
    sprites = {4, 5, 6, 7, 8, 9},
    speed = 2,
    speeds = {2, 2, 2, 2, 3, 3, 4},
    -- chance de gerar um a cada frame
    chance_pctg = 5,
    last = 0,
    delay = 15,
    -- máximo no jogo em um momento
    max = 6
}

vizinha = {x=127-8, y=region.vertical_mid}

function handle_ricardo()
    -- pra cima
    if (btn(2)) then ricardo.y = max(ricardo.y - ricardo.speed, region.top) end
    -- pra baixo
    if (btn(3)) then ricardo.y = min(ricardo.y + ricardo.speed, region.bottom-8) end
end

function handle_vizinha()
    -- movimenta vizinha
    vizinha.y = region.vertical_mid-4 + (sin(t()/2) * ((region.height/2)-4))
end

function handle_shoot()
    for bullet in all(shoot.bullets) do
        if(bullet.x > 127) then
            del(shoot.bullets, bullet)
        else
            -- xingou usuário
            if (check_if_user_hit(bullet)) then
                del(shoot.bullets, bullet)
                break
            end
            -- vizinha escutou
            if (check_if_vizinha_hit(bullet)) then
                playing=false
                break
            end

            bullet.x += shoot.speed
        end
    end

    -- atira
    if (btn(4) and shoot.last == 0) then
        bullet = {
            y=ricardo.y+3,
            x=ricardo.x+5,
            curse=rnd(shoot.curses)
        }
        add(shoot.bullets, bullet)

        shoot.last = 1
        shoot.is_shooting = true
    -- termina delay
    elseif (shoot.last == shoot.delay) then
        shoot.last = 0
        shoot.is_shooting = false
    -- delay
    elseif (shoot.last >= 1) then
        shoot.last += 1
    end
end

function handle_chat()
    -- movimenta chat
    for user in all(chat.users) do
        if (user.x < 0) then del(chat.users, user) end
        user.x -= user.speed
    end

    -- chance de gerar usuario
    if (chat.last == 0) then
        if (flr(rnd(100)) < chat.chance_pctg and #chat.users < chat.max) then
            y = region.top + flr(rnd(region.bottom - region.top - 8))
            speed = rnd(chat.speeds)
            sprite = rnd(chat.sprites)
            add(chat.users, {x=127-region.right_margin-8, y=y, speed=speed, sprite=sprite})
            chat.last += 1

            chat.count += 1
        end
    -- aumenta ou reseta delay
    else
        if (chat.last == chat.delay) then chat.last = 0 else chat.last += 1 end
    end
end

-- UTILITÁRIOS

function check_if_vizinha_hit(bullet)
    if (
        check_if_hit(
            bullet.x,  bullet.y,  #bullet.curse*4, 5, -- 4 é a largura dos caracteres
            vizinha.x, vizinha.y, 8, 8,
            8
        )
    ) then return true end
    return false
end


function check_if_user_hit(bullet)
    for user in all(chat.users) do
        if (
            check_if_hit(
                bullet.x, bullet.y, #bullet.curse*4, 5, -- 4 é a largura dos caracteres
                user.x,   user.y,   8, 8,
                4
            )
        ) then 
            ricardo.money += (user.speed-1) * 5
            ricardo.hit += 1
            del(chat.users, user)
            return true
        end 
    end
    return false
end

function check_if_hit(x1, y1, w1, h1, x2, y2, w2, h2, margin)
    margin = margin or 1
    if (
        -- direita do obj1 e esquerda do obj2 na mesma coluna
        (x1+w1 >= x2 and x1+w1 <= x2+margin)
        and
        -- obj1 sobrepoe linha do obj2
        ((y1 >= y2 and y1 <= y2+h2) or (y1+h1 >= y2 and y1+h1 <= y2+h2))
    ) then
        return true
    end
    return false
end

