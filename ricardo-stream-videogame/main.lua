start = false
playing = false

messages = {
    sprites = {13, 29, 45},
    left = 11
}

function _init()
    rectfill(0,0,128,128,2)
    cursor(1, 50)
    print("xingue o chat para receber pix", 14)
    print("mas nao deixe a vizinha escutar")
    print("ela odeia palavrao")
    
    cursor(1, 104)
    print("cima/baixo para mover", 6)
    print("c para xingar")    
    print("x para comecar")
end

function _update()
    -- jogando
    if (start and playing) then
        handle_ricardo()
        handle_vizinha()
        handle_shoot()
        handle_chat()
    -- no menu inicial
    elseif (not start) then 
        if (btn(5)) then start=true playing=true end
    -- perdeu
    else
        if(btn(5)) then
            chat.users = {}
            chat.count = 0

            ricardo.money = 0
            ricardo.hit = 0

            shoot.bullets = {}

            playing = true
        end
    end
end

function _draw()
    -- jogando
    if (start and playing) then
        cls()
        
        map(0, 0, 0, 0, 128, 32)

        -- desenha vizinha
        spr(17, vizinha.x, vizinha.y, 1, 1)

        rectfill(20, top, 22, bottom, 5)    
        
        -- mensagens na tela subindo
        for row = 1,(region.height/8) do
            if (chat.count >= row) then
                sprite = messages.sprites[(chat.count+((region.height/8)-row))%3 +1]
                spr(sprite, 11*8, region.top+((region.height/8)-row)*8, 2, 1)
            end
        end

        -- desenha usuários
        for user in all(chat.users) do
            spr(user.sprite, user.x, user.y, 1, 1)
        end
        
        -- desenha xingamentos
        for bullet in all(shoot.bullets) do
            cursor(bullet.x, bullet.y, 7)
            print(bullet.curse)
            -- esconde o xingamento atrás do ricardo
            --rectfill(ricardo.x, ricardo.y, 127, ricardo.y+8, 1)
            -- circfill(shot.x, shot.y, shot_size)
        end
        
        -- desenha ricardo
        sprite = ricardo.sprites.normal
        if (shoot.is_shooting) then sprite = ricardo.sprites.shooting end
        spr(sprite, ricardo.x, ricardo.y, 1, 1)
        
        cursor(2, 2, 3)
        print("R$" .. ricardo.money)
    
    -- no menu inicial
    elseif (not start) then
    -- perdeu
    else
        cls()
        
        print("ganhou R$" .. ricardo.money.." em pix", 3)
        print("xingou "..ricardo.hit.." de "..chat.count.." usuarios do chat", 12)
        
        print("cabo a live", 64-11*2, 64-8-7, 8)
        spr(24, 64-8, 64-8, 2, 2)

        print("aperte x para jogar de novo", 0, 120, 5)
    end
end 


