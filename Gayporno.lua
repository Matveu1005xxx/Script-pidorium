package = 'com.axlebolt.standoff2'
if gg.getTargetPackage() ~= package then
    gg.alert('Запусти скрипт в игре Standoff 2!')
    os.exit()
end

gg.setVisible(true)

local url = 'https://pastebin.com/raw/suE14ds6'
local response = gg.makeRequest(url)

if not response then
    gg.alert('Нет подключения к интернету!')
    os.exit()
end

local defaultFov = tonumber(response.content) or 90
local currentFov = defaultFov

function changeFov(value)
    local modifiedValue = value * 1.35
    gg.clearResults()
    gg.searchNumber(currentFov, gg.TYPE_FLOAT)
    local count = gg.getResultCount()
    
    if count > 0 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do
            v.value = modifiedValue
            v.freeze = false
        end
        gg.setValues(results)
        gg.toast('FOV изменен на: ' .. value)
        currentFov = modifiedValue
    else
        gg.toast('Значение FOV не найдено')
    end
    gg.clearResults()
end

function resetFov()
    gg.clearResults()
    gg.searchNumber(currentFov, gg.TYPE_FLOAT)
    local count = gg.getResultCount()
    
    if count > 0 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do
            v.value = defaultFov
            v.freeze = false
        end
        gg.setValues(results)
        gg.toast('FOV сброшен на стандартный')
        currentFov = defaultFov
    else
        gg.toast('Значение FOV не найдено')
    end
    gg.clearResults()
end

function FovMenu()
    local menu = gg.choice({
        'Изменить FOV',
        'Сбросить FOV',
        'Назад'
    }, nil, 'Меню FOV')
    
    if menu == 1 then
        local slider = gg.prompt({
            'Введите значение FOV (1-180):'
        }, {90}, {'number'})
        
        if slider and slider[1] then
            local value = tonumber(slider[1])
            if value and value >= 1 and value <= 180 then
                changeFov(value)
            else
                gg.alert('Допустимые значения: 1-180')
            end
        end
    elseif menu == 2 then
        resetFov()
    end
end

function MainMenu()
    local menu = gg.choice({
        'FOV',
        'Выход'
    }, nil, 't.me/Zalupium and qwertx_crack')
    
    if menu == 1 then
        FovMenu()
    elseif menu == 2 then
        os.exit()
    end
end

gg.toast('cum to my ass pls')
while true do
    if gg.isVisible() then
        gg.setVisible(false)
        MainMenu()
    end
    gg.sleep(100)
end
