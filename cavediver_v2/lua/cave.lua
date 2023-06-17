top=45 -- max y ceiling
btm=85 -- min y floor

function update_kv(s)
    for i=1,s do
        del(kv, kv[1])
    end
    fill_kv()
end

function fill_kv()
    while(#kv<=128) do
        local ty=mid(0,kv[#kv][1]+flr(rnd(7))-3,top)
        local by=mid(127,kv[#kv][2]+flr(rnd(7))-3,btm)
        add(kv, {ty, by})
    end
end

function draw_kv()
    for x=0,127 do
        line(x,0,x,kv[x+1][1],6)
        line(x,127,x,kv[x+1][2],6)
    end
end

function init_kv()
    kv = {}
    if(#kv==0) add(kv,{flr(rnd(top)),btm+flr(rnd(127-btm))})
    fill_kv()
end
