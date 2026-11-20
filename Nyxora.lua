local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local ContentProvider = game:GetService("ContentProvider")
local InsertService = game:GetService("InsertService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

for _, key in ipairs({ "Nyxora", "VXProject" }) do
    local previous = _G[key]
    if type(previous) == "table" and type(previous.Unload) == "function" then
        pcall(previous.Unload)
    end
end

local Unload

local CONFIG = {
    ProjectName = "Nyxora",
    MenuTitle = "Nyxora",
    WatermarkTitle = "Nyxora",
    Credit = "discord · thexeohunt",
    Build = "2.0.0",
    OpenMenuOnStart = true,
    UseDisplayName = true,
    NotifyDuration = 5,
    MaxNotifications = 5,
    GuiName = "Nyxora_Gui",
    FxFolderName = "Nyxora_ClientFX",
    ConfigFile = "Nyxora_Config.json",
    PresenceUrl = "",
    PresenceKey = "nyxora",
    MenuWidth = 660,
    MenuHeight = 460,
}

local UI_SKINS = {
    { Name = "Purple", Colors = {
        Background = Color3.fromRGB(24, 19, 31), Panel = Color3.fromRGB(47, 37, 53),
        Stroke = Color3.fromRGB(64, 50, 74), Accent = Color3.fromRGB(132, 92, 188),
        AccentSoft = Color3.fromRGB(204, 180, 240), SwitchOn = Color3.fromRGB(130, 98, 222),
        SwitchOff = Color3.fromRGB(62, 50, 72), Muted = Color3.fromRGB(160, 144, 184) } },
    { Name = "Green", Colors = {
        Background = Color3.fromRGB(18, 24, 20), Panel = Color3.fromRGB(30, 38, 33),
        Stroke = Color3.fromRGB(46, 62, 51), Accent = Color3.fromRGB(72, 170, 100),
        AccentSoft = Color3.fromRGB(170, 255, 200), SwitchOn = Color3.fromRGB(80, 190, 115),
        SwitchOff = Color3.fromRGB(50, 64, 55), Muted = Color3.fromRGB(136, 156, 143) } },
    { Name = "Blue", Colors = {
        Background = Color3.fromRGB(18, 21, 28), Panel = Color3.fromRGB(30, 35, 45),
        Stroke = Color3.fromRGB(46, 55, 74), Accent = Color3.fromRGB(74, 116, 208),
        AccentSoft = Color3.fromRGB(176, 204, 255), SwitchOn = Color3.fromRGB(88, 128, 228),
        SwitchOff = Color3.fromRGB(50, 58, 78), Muted = Color3.fromRGB(138, 146, 164) } },
    { Name = "Red", Colors = {
        Background = Color3.fromRGB(26, 18, 19), Panel = Color3.fromRGB(39, 30, 31),
        Stroke = Color3.fromRGB(64, 46, 48), Accent = Color3.fromRGB(190, 70, 80),
        AccentSoft = Color3.fromRGB(255, 178, 184), SwitchOn = Color3.fromRGB(215, 85, 95),
        SwitchOff = Color3.fromRGB(66, 50, 52), Muted = Color3.fromRGB(160, 140, 142) } },
    { Name = "Pink", Colors = {
        Background = Color3.fromRGB(27, 19, 25), Panel = Color3.fromRGB(41, 31, 38),
        Stroke = Color3.fromRGB(66, 46, 59), Accent = Color3.fromRGB(205, 85, 160),
        AccentSoft = Color3.fromRGB(255, 184, 228), SwitchOn = Color3.fromRGB(225, 100, 175),
        SwitchOff = Color3.fromRGB(70, 50, 62), Muted = Color3.fromRGB(162, 140, 154) } },
}

local PALETTE_SCHEMES = {
    { Name = "Neon Violet", A = Color3.fromRGB(150, 90, 255), B = Color3.fromRGB(235, 110, 255) },
    { Name = "Mint", A = Color3.fromRGB(80, 255, 200), B = Color3.fromRGB(80, 160, 255) },
    { Name = "Sunset", A = Color3.fromRGB(255, 140, 80), B = Color3.fromRGB(255, 60, 150) },
    { Name = "Lime", A = Color3.fromRGB(190, 255, 70), B = Color3.fromRGB(60, 230, 140) },
    { Name = "Rainbow", Rainbow = true, A = Color3.fromRGB(255, 80, 80), B = Color3.fromRGB(80, 80, 255) },
    { Name = "White", A = Color3.fromRGB(255, 255, 255), B = Color3.fromRGB(205, 215, 240) },
    { Name = "Gold", A = Color3.fromRGB(255, 196, 40), B = Color3.fromRGB(255, 228, 125) },
}

local Settings = {
    UiSkin = 1,
    Palette = 1,
    Fov = 70,
    StretchRes = 0.75,
    WmFps = true,
    WmPing = true,
    WmNick = true,
    Notifications = true,
    MenuKey = "RightShift",
    WingScale = 100,
    FogDensity = 40,
    FogColor = 1,
    SkyMode = 1,
    SkyImage = "",
    CrossStyle = 3,
    CrossSize = 8,
    CrossThick = 2,
    CrossGap = 4,
    CursorColor = 1,
    HatSize = 100,
    JumpStyle = 1,
    ChamsMode = 1,
    RainAmount = 50,
    LightPreset = 1,
    RsPreset = 1,
    RsExposure = 52,
    RsContrast = 56,
    RsVibrance = 56,
    RsTemp = 52,
    RsBloom = 25,
    RsRays = 15,
    RsVignette = 30,
    RsReflect = true,
    RsSoft = true,
    RsDof = false,
    RsLetterbox = false,
    RsMotion = false,
    LoadedBuild = "",
    OwnBadge = 1,
    PresenceOn = true,
    PresenceShare = true,
    PresenceUrl = CONFIG.PresenceUrl,
    BoostMaterials = true,
    BoostTextures = true,
    BoostEffects = true,
    BoostShadows = true,
    Lang = "en",
    SwayLag = 60,
    SwayRoll = 50,
    Enabled = {},
}

local Config = {}
local FileApi = type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"

function Config.Load()
    if not FileApi then return end
    local ok, data = pcall(function()
        if not isfile(CONFIG.ConfigFile) then return nil end
        return HttpService:JSONDecode(readfile(CONFIG.ConfigFile))
    end)
    if not ok or type(data) ~= "table" then return end
    for key, value in pairs(data) do
        if Settings[key] ~= nil and type(Settings[key]) == type(value) then
            Settings[key] = value
        end
    end
end

local savePending = false
function Config.Save()
    if not FileApi or savePending then return end
    savePending = true
    task.delay(1, function()
        savePending = false
        pcall(function()
            writefile(CONFIG.ConfigFile, HttpService:JSONEncode(Settings))
        end)
    end)
end

Config.Load()

local function ClampSetting(key, lo, hi, integer)
    local value = math.clamp(tonumber(Settings[key]) or lo, lo, hi)
    Settings[key] = integer and math.floor(value + 0.5) or value
end
ClampSetting("UiSkin", 1, #UI_SKINS, true)
ClampSetting("Palette", 1, #PALETTE_SCHEMES, true)
ClampSetting("Fov", 40, 120, true)
ClampSetting("StretchRes", 0.5, 1, false)
ClampSetting("WingScale", 50, 150, true)
ClampSetting("FogDensity", 5, 100, true)
ClampSetting("FogColor", 1, 4, true)
ClampSetting("SkyMode", 1, 8, true)
ClampSetting("CrossStyle", 1, 5, true)
if Settings.CrossStyle == 3 and Settings.CrossSize == 8 then Settings.CrossStyle = 1 end
ClampSetting("CrossSize", 2, 40, true)
ClampSetting("CrossThick", 1, 6, true)
ClampSetting("CrossGap", 0, 20, true)
ClampSetting("CursorColor", 1, 2, true)
ClampSetting("OwnBadge", 1, 4, true)
ClampSetting("HatSize", 50, 200, true)
ClampSetting("JumpStyle", 1, 2, true)
ClampSetting("ChamsMode", 1, 3, true)
ClampSetting("RainAmount", 5, 100, true)
ClampSetting("LightPreset", 1, 8, true)
ClampSetting("RsPreset", 1, 7, true)
for _, key in ipairs({ "RsExposure", "RsContrast", "RsVibrance", "RsTemp", "RsBloom", "RsRays", "RsVignette" }) do
    ClampSetting(key, 0, 100, true)
end
if Settings.Lang ~= "en" and Settings.Lang ~= "ru" then Settings.Lang = "en" end
ClampSetting("SwayLag", 0, 100, true)
ClampSetting("SwayRoll", 0, 100, true)
if type(Settings.Enabled) ~= "table" then Settings.Enabled = {} end
if not pcall(function() return Enum.KeyCode[Settings.MenuKey] end) then
    Settings.MenuKey = "RightShift"
end

local LANG = {
    en = {
        tab_player = "Player", tab_world = "World", tab_graphics = "Graphics",
        tab_camera = "Camera", tab_settings = "Settings",

        sec_character = "CHARACTER", sec_head = "HEAD", sec_body = "BODY",
        sec_weather = "WEATHER", sec_sky = "SKY & LIGHT", sec_shaders = "SHADERS",
        sec_perf = "PERFORMANCE", sec_view = "VIEW", sec_crosshair = "CROSSHAIR",
        sec_interface = "INTERFACE",

        f_aura = "Particle Aura", d_aura = "Glowing particles around your body",
        f_orbit = "Orbit Aura", d_orbit = "Neon orbs circling around you",
        f_trails = "Trails", d_trails = "Neon ribbons behind hands and feet",
        f_chams = "Self Chams", d_chams = "Material or fill on your character",
        f_jump = "Jump Circles", d_jump = "Rings on the ground when you jump",
        f_hat = "China Hat", d_hat = "Neon cone hat",
        f_headless = "Headless", d_headless = "Hides head, face and head accessories",
        f_wings = "Wings", d_wings = "Neon wings, flap harder in the air",
        f_korblox = "Korblox Leg", d_korblox = "Icy right leg",
        f_snow = "Snow", d_snow = "Big snowflakes all around",
        f_rain = "Rain", d_rain = "Raindrops around the camera",
        f_fog = "Fog", d_fog = "Atmospheric haze",
        f_sky = "Custom Sky", d_sky = "Stars, skyboxes or your own image",
        f_light = "Lighting", d_light = "Time of day and mood presets",
        f_boost = "FPS Boost", d_boost = "Strips heavy materials, effects and shadows",
        f_fov = "Custom FOV", d_fov = "Change the field of view",
        f_stretch = "Stretched Res", d_stretch = "Squashes the picture vertically",
        f_sway = "Smooth Camera", d_sway = "Lag and tilt while running",
        f_cross = "Crosshair", d_cross = "Custom crosshair in the effect color",

        o_mode = "Mode", o_style = "Style", o_model = "Model",
        o_size = "Size", o_amount = "Intensity",
        o_density = "Density", o_color = "Color", o_sky = "Sky type", o_image = "Image",
        o_image_d = "For the Custom Image mode", o_preset = "Preset", o_value = "Value",
        o_strength = "Strength", o_lag = "Lag", o_roll = "Tilt", o_thick = "Thickness",
        o_gap = "Gap", o_dof = "Depth of Field", o_motion = "Motion Blur",
        o_reflect = "Reflections", o_soft = "Soft Shadows", o_materials = "Simple Materials",
        o_textures = "Remove Textures", o_effects = "Remove Effects", o_shadows = "No Shadows",
        o_rmb = "Right click: back", ph_id = "e.g. 15941444170", ph_image = "Image ID",

        s_lang = "Language", s_lang_d = "Interface language",
        s_skin = "Menu Style", s_skin_d = "Interface color",
        s_palette = "Effect Color", s_palette_d = "Neon for every visual",
        s_key = "Menu Key", s_key_d = "Insert always works, Esc cancels",
        s_notify = "Notifications", s_notify_d = "Pop-ups in the bottom right",
        key_press = "press a key",

        p_watermark = "WATERMARK", p_fps = "Show FPS", p_ping = "Show Ping",
        p_nick = "Show Nick", p_disable = "Disable all", p_unload = "Unload",

        n_ready = "Ready", n_loaded = "Loaded. Click the watermark or press %s to open the menu.",
        n_restored = " Restored modules: %d.", n_on = "%s enabled", n_off = "%s disabled",
        n_fail_on = "Couldn't enable %s", n_fail_off = "Couldn't disable %s",
        n_module = "Module error", n_all_off = "All modules disabled", n_system = "System",
        n_wait = "Please wait, still loading.", n_loading = "Loading", err = "Error",
        n_sky_id = "Enter an image ID for the custom sky", n_sky = "Sky",
        n_lang = "Language: English",
        sec_list = "PLAYER LIST", f_plist = "Player List", d_plist = "Custom Tab list with badges",
        o_badge = "Your badge", o_network = "Nyxora badges", o_network_d = "See other Nyxora users on this server",
        o_share = "Show me to others", o_share_d = "Others with Nyxora see your badge",
        o_server = "Server URL", ph_server = "https://...workers.dev",
        pl_title = "Players", pl_you = "You", n_net = "Network",
        n_nohttp = "Your environment has no request(), Nyxora badges are unavailable",
        n_server = "Badge server is not responding",
        pg_player = "Character visuals and accessories", pg_world = "Weather, sky and lighting",
        pg_graphics = "Post-processing and performance", pg_camera = "View, camera feel and cursor",
        pg_settings = "Language, colors and controls",
        search = "Search", active = "%d active", none_found = "Nothing found",
        l_assets = "Loading assets", l_verify = "Verifying modules", l_start = "Starting up",
        l_done = "Ready", l_first = "First launch setup",
        sec_cursor = "CURSOR", f_cursor = "Custom Cursor", d_cursor = "Replaces the mouse cursor",
        f_reshade = "ReShade", d_reshade = "Color grading, bloom, vignette and depth",
        o_exposure = "Exposure", o_contrast = "Contrast", o_vibrance = "Vibrance",
        o_temp = "Temperature", o_bloom = "Bloom", o_rays = "Sun Rays", o_vignette = "Vignette",
        o_letterbox = "Letterbox", o_letterbox_d = "Cinematic black bars",
    },
    ru = {
        tab_player = "Игрок", tab_world = "Мир", tab_graphics = "Графика",
        tab_camera = "Камера", tab_settings = "Настройки",

        sec_character = "ПЕРСОНАЖ", sec_head = "ГОЛОВА", sec_body = "ТЕЛО",
        sec_weather = "ПОГОДА", sec_sky = "НЕБО И СВЕТ", sec_shaders = "ШЕЙДЕРЫ",
        sec_perf = "ПРОИЗВОДИТЕЛЬНОСТЬ", sec_view = "ОБЗОР", sec_crosshair = "ПРИЦЕЛ",
        sec_interface = "ИНТЕРФЕЙС",

        f_aura = "Аура частиц", d_aura = "Частицы и свечение вокруг тела",
        f_orbit = "Орбитальная аура", d_orbit = "Неоновые шары вокруг игрока",
        f_trails = "Трейлы", d_trails = "Неоновые ленты за руками и ногами",
        f_chams = "Чамсы", d_chams = "Материал или заливка персонажа",
        f_jump = "Круги при прыжке", d_jump = "Кольца на земле при прыжке",
        f_hat = "China Hat", d_hat = "Неоновая шляпа-конус",
        f_headless = "Без головы", d_headless = "Скрывает голову, лицо и аксессуары",
        f_wings = "Крылья", d_wings = "Неоновые крылья, машут сильнее в прыжке",
        f_korblox = "Korblox нога", d_korblox = "Ледяная правая нога",
        f_snow = "Снег", d_snow = "Крупный снег вокруг",
        f_rain = "Дождь", d_rain = "Капли падают вокруг камеры",
        f_fog = "Туман", d_fog = "Атмосферная дымка",
        f_sky = "Своё небо", d_sky = "Звёзды, скайбоксы или своя картинка",
        f_light = "Освещение", d_light = "Пресеты времени суток и настроения",
        f_boost = "Буст FPS", d_boost = "Убирает тяжёлые материалы, эффекты и тени",
        f_fov = "Свой FOV", d_fov = "Меняет поле зрения",
        f_stretch = "Растяг экрана", d_stretch = "Сжимает картинку по вертикали",
        f_sway = "Плавная камера", d_sway = "Отставание и крен при беге",
        f_cross = "Прицел", d_cross = "Свой прицел в цвет эффектов",

        o_mode = "Режим", o_style = "Стиль", o_model = "Модель",
        o_size = "Размер", o_amount = "Сила",
        o_density = "Плотность", o_color = "Цвет", o_sky = "Вид неба", o_image = "Картинка",
        o_image_d = "Для режима «Своя картинка»", o_preset = "Пресет", o_value = "Значение",
        o_strength = "Сила", o_lag = "Отставание", o_roll = "Крен", o_thick = "Толщина",
        o_gap = "Отступ", o_dof = "Глубина резкости", o_motion = "Размытие движения",
        o_reflect = "Отражения", o_soft = "Мягкие тени", o_materials = "Простые материалы",
        o_textures = "Убрать текстуры", o_effects = "Убрать эффекты", o_shadows = "Без теней",
        o_rmb = "Правый клик: назад", ph_id = "например 15941444170", ph_image = "ID картинки",

        s_lang = "Язык", s_lang_d = "Язык интерфейса",
        s_skin = "Стиль меню", s_skin_d = "Цвет интерфейса",
        s_palette = "Цвет эффектов", s_palette_d = "Неон для всех визуалов",
        s_key = "Клавиша меню", s_key_d = "Insert работает всегда, Esc отмена",
        s_notify = "Уведомления", s_notify_d = "Сообщения справа внизу",
        key_press = "нажмите клавишу",

        p_watermark = "ВАТЕРМАРКА", p_fps = "Показывать FPS", p_ping = "Показывать пинг",
        p_nick = "Показывать ник", p_disable = "Отключить всё", p_unload = "Выгрузить",

        n_ready = "Готово", n_loaded = "Загружено. Меню: клик по ватермарке или %s.",
        n_restored = " Восстановлено модулей: %d.", n_on = "«%s» включён", n_off = "«%s» выключен",
        n_fail_on = "Не удалось включить «%s»", n_fail_off = "Не удалось выключить «%s»",
        n_module = "Сбой модуля", n_all_off = "Все модули выключены", n_system = "Система",
        n_wait = "Подождите, скрипт ещё загружается.", n_loading = "Загрузка", err = "Ошибка",
        n_sky_id = "Укажите ID картинки для своего неба", n_sky = "Небо",
        n_lang = "Язык: русский",
        sec_list = "СПИСОК ИГРОКОВ", f_plist = "Список игроков", d_plist = "Свой Tab-список со значками",
        o_badge = "Твой значок", o_network = "Значки Nyxora", o_network_d = "Видеть других с Nyxora на сервере",
        o_share = "Показывать меня другим", o_share_d = "Другие с Nyxora увидят твой значок",
        o_server = "Адрес сервера", ph_server = "https://...workers.dev",
        pl_title = "Игроки", pl_you = "Вы", n_net = "Сеть",
        n_nohttp = "В твоей среде нет request(), значки Nyxora недоступны",
        n_server = "Сервер значков не отвечает",
        None = "Нет", Verified = "Галочка", Premium = "Премиум", ["Verified + Premium"] = "Галочка + Премиум",
        pg_player = "Визуалы и аксессуары персонажа", pg_world = "Погода, небо и освещение",
        pg_graphics = "Постобработка и производительность", pg_camera = "Обзор, камера и курсор",
        pg_settings = "Язык, цвета и управление",
        search = "Поиск", active = "активно: %d", none_found = "Ничего не найдено",
        l_assets = "Загрузка ассетов", l_verify = "Проверка модулей", l_start = "Запуск",
        l_done = "Готово", l_first = "Первый запуск",
        sec_cursor = "КУРСОР", f_cursor = "Свой курсор", d_cursor = "Заменяет курсор мыши",
        f_reshade = "ReShade", d_reshade = "Цветокоррекция, bloom, виньетка и глубина",
        o_exposure = "Экспозиция", o_contrast = "Контраст", o_vibrance = "Насыщенность",
        o_temp = "Температура", o_bloom = "Bloom", o_rays = "Лучи солнца", o_vignette = "Виньетка",
        o_letterbox = "Кинорамка", o_letterbox_d = "Чёрные полосы как в кино",
        Natural = "Натурально", Vivid = "Ярко", ["Warm Film"] = "Тёплая плёнка", Noir = "Нуар",
        Dreamy = "Мечтательно", Cold = "Холодно",

        Purple = "Фиолетовый", Green = "Зелёный", Blue = "Синий", Red = "Красный", Pink = "Розовый",
        ["Neon Violet"] = "Неон-фиолет", Mint = "Мята", Sunset = "Закат", Lime = "Лайм",
        Rainbow = "Радуга", White = "Белый", Gold = "Золото", Gray = "Серый", Dark = "Тёмный",
        Palette = "Цвет эффектов", ["Starry Night"] = "Звёздная ночь", ["Custom Image"] = "Своя картинка",
        ["Sky 1"] = "Небо 1", ["Sky 2"] = "Небо 2", Night = "Ночь", ["Sky 4"] = "Небо 4", ["Red Sky"] = "Красное",
        Dot = "Точка", Cross = "Крестик", ["Cross + Dot"] = "Крестик + точка", Circle = "Круг",
        ["Circle + Dot"] = "Круг + точка", Classic = "Классика", ["Custom ID"] = "Свой ID",
        Flat = "Заливка", Realistic = "Реализм", ["Golden Hour"] = "Золотой час",
        ["Pink Dusk"] = "Розовый закат", ["Night Moon"] = "Лунная ночь", Overcast = "Пасмурно",
        Cyberpunk = "Киберпанк", Arctic = "Арктика", Toxic = "Токсик",
        Cinematic = "Кино", Vibrant = "Сочный", ["Soft Glow"] = "Мягкое свечение",
    },
}

local LocBound = {}
local LangHooks = {}

local function T(key)
    local dict = LANG[Settings.Lang] or LANG.en
    return dict[key] or LANG.en[key] or key
end

local function Loc(inst, key, prop)
    prop = prop or "Text"
    LocBound[#LocBound + 1] = { inst, prop, key }
    inst[prop] = T(key)
    return inst
end

local function OnLang(fn)
    LangHooks[#LangHooks + 1] = fn
end

local function ApplyLang()
    for _, entry in ipairs(LocBound) do
        if entry[1].Parent then entry[1][entry[2]] = T(entry[3]) end
    end
    for _, fn in ipairs(LangHooks) do pcall(fn) end
end

local THEME = {
    Text = Color3.fromRGB(255, 255, 255),
    Error = Color3.fromRGB(235, 84, 96),
    Knob = Color3.fromRGB(240, 238, 246),
}

local function LoadSkin(index)
    for key, color in pairs(UI_SKINS[index].Colors) do
        THEME[key] = color
    end
    THEME.Glass = THEME.Panel:Lerp(THEME.Background, 0.45)
    THEME.GlassOn = THEME.Glass:Lerp(THEME.SwitchOn, 0.3)
    THEME.GlassDeep = THEME.Glass:Lerp(Color3.new(0, 0, 0), 0.3)
    THEME.GlassHover = THEME.Glass:Lerp(THEME.Panel, 0.6)
end
LoadSkin(Settings.UiSkin)

local F = {
    Regular = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Regular),
    Medium = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium),
    SemiBold = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
    Bold = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold),
    Black = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
}

local TI = {
    Instant = TweenInfo.new(0),
    Fast = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Medium = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Out = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
}

local function Create(className, props, children)
    local inst = Instance.new(className)
    local parent = nil
    for key, value in pairs(props or {}) do
        if key == "Parent" then
            parent = value
        else
            inst[key] = value
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    if parent then
        inst.Parent = parent
    end
    return inst
end

local function Corner(radius)
    return Create("UICorner", { CornerRadius = radius })
end

local function Tween(inst, info, goal)
    local tw = TweenService:Create(inst, info, goal)
    tw:Play()
    return tw
end

local function ExpAlpha(speed, dt)
    return 1 - math.exp(-speed * dt)
end

local Maid = {}
Maid.__index = Maid
function Maid.new()
    return setmetatable({ _items = {} }, Maid)
end
function Maid:Give(item)
    self._items[#self._items + 1] = item
    return item
end
function Maid:Clean()
    local items = self._items
    self._items = {}
    for i = #items, 1, -1 do
        local item = items[i]
        local kind = typeof(item)
        if kind == "RBXScriptConnection" then
            item:Disconnect()
        elseif kind == "Instance" then
            pcall(item.Destroy, item)
        elseif kind == "function" then
            pcall(item)
        elseif kind == "table" and type(item.Clean) == "function" then
            item:Clean()
        end
    end
end
local Root = Maid.new()

local Themed = {}
local ThemeHooks = {}

local function Th(inst, map)
    for prop, key in pairs(map) do
        Themed[#Themed + 1] = { inst, prop, key }
        inst[prop] = THEME[key]
    end
    return inst
end

local function OnTheme(fn)
    ThemeHooks[#ThemeHooks + 1] = fn
end

local function ApplySkin(index)
    Settings.UiSkin = index
    LoadSkin(index)
    for _, entry in ipairs(Themed) do
        local inst = entry[1]
        if inst.Parent then
            Tween(inst, TI.Medium, { [entry[2]] = THEME[entry[3]] })
        end
    end
    for _, fn in ipairs(ThemeHooks) do
        pcall(fn)
    end
end

local function GetCamera()
    return Workspace.CurrentCamera
end

local OldFx = Workspace:FindFirstChild(CONFIG.FxFolderName)
if OldFx then OldFx:Destroy() end
local FxFolder = Create("Folder", { Name = CONFIG.FxFolderName, Parent = Workspace })

local Palette = {
    Index = Settings.Palette,
    Changed = Instance.new("BindableEvent"),
    Schemes = PALETTE_SCHEMES,
}

function Palette.Current() return Palette.Schemes[Palette.Index] end
function Palette.IsRainbow() return Palette.Current().Rainbow == true end
function Palette.GetColors()
    local scheme = Palette.Current()
    if scheme.Rainbow then
        local t = os.clock() * 0.15
        return Color3.fromHSV(t % 1, 0.75, 1), Color3.fromHSV((t + 0.3) % 1, 0.75, 1)
    end
    return scheme.A, scheme.B
end
function Palette.Sequence()
    local scheme = Palette.Current()
    if scheme.Rainbow then
        local t = os.clock() * 0.15
        local keys = {}
        for i = 0, 4 do
            keys[#keys + 1] = ColorSequenceKeypoint.new(i / 4, Color3.fromHSV((t + i * 0.2) % 1, 0.75, 1))
        end
        return ColorSequence.new(keys)
    end
    return ColorSequence.new(scheme.A, scheme.B)
end

local OldGui = PlayerGui:FindFirstChild(CONFIG.GuiName)
if OldGui then OldGui:Destroy() end

local ScreenGui = Create("ScreenGui", {
    Name = CONFIG.GuiName, ResetOnSpawn = false, IgnoreGuiInset = true,
    DisplayOrder = 1000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = PlayerGui,
})

for _, child in ipairs(Lighting:GetChildren()) do
    if string.sub(child.Name, 1, 3) == "VX_" then child:Destroy() end
end

local Features = {}
local Modules = {}

local function RegisterFeature(id, name, section)
    Features[id] = Features[id] or { Id = id, Name = name, Section = section, Enabled = false }
    return Features[id]
end

local Notify = {}
local NotifyHolder = Create("Frame", {
    Name = "Notifications", BackgroundTransparency = 1,
    Size = UDim2.new(0, 340, 1, 0), AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.fromScale(1, 1), ZIndex = 20, Parent = ScreenGui,
}, {
    Create("UIPadding", { PaddingRight = UDim.new(0, 16), PaddingBottom = UDim.new(0, 16) }),
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8),
    }),
})

local ActiveNotifs = {}
local notifyCounter = 0
local OFFSCREEN = UDim2.fromOffset(380, 0)

local function BuildNotification(opts)
    notifyCounter += 1
    local isError = opts.Kind == "error"
    local accent = isError and THEME.Error or THEME.AccentSoft

    local wrapper = Create("Frame", {
        Name = "Notify_" .. notifyCounter, LayoutOrder = notifyCounter,
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, Parent = NotifyHolder,
    })

    local card = Create("TextButton", {
        Text = "", AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = THEME.Background, BorderSizePixel = 0,
        Position = OFFSCREEN, Parent = wrapper,
    }, {
        Corner(UDim.new(0, 14)),
        Create("UIStroke", { Color = accent, Thickness = 1, Transparency = 0.7 }),
    })

    Create("Frame", {
        Position = UDim2.fromOffset(10, 14), Size = UDim2.new(0, 3, 1, -28),
        BackgroundColor3 = accent, BorderSizePixel = 0, Parent = card,
    }, { Corner(UDim.new(1, 0)) })

    local body = Create("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, Parent = card,
    }, {
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 16),
        }),
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4) }),
    })

    local head = Create("Frame", {
        LayoutOrder = 1, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), Parent = body,
    })

    Create("TextLabel", {
        BackgroundTransparency = 1, Size = UDim2.new(0.55, 0, 1, 0),
        FontFace = F.Bold, TextSize = 14, TextColor3 = THEME.Text,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Text = opts.Title or (isError and T("err") or CONFIG.ProjectName), Parent = head,
    })

    Create("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1, Size = UDim2.new(0.45, 0, 1, 0),
        FontFace = F.Regular, TextSize = 11, TextColor3 = THEME.Muted,
        TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
        Text = opts.Subtitle or "", Parent = head,
    })

    Create("TextLabel", {
        LayoutOrder = 2, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, FontFace = F.Medium,
        TextSize = 13, TextColor3 = THEME.Text:Lerp(THEME.Muted, 0.25),
        TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
        Text = opts.Body or "", Parent = body,
    })

    local track = Create("Frame", {
        LayoutOrder = 3, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = THEME.Panel, Parent = body,
    }, { Corner(UDim.new(1, 0)) })

    local fill = Create("Frame", {
        BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = accent, Parent = track,
    }, { Corner(UDim.new(1, 0)) })

    local handle = {}
    local closed = false
    function handle.Dismiss()
        if closed then return end
        closed = true
        local index = table.find(ActiveNotifs, handle)
        if index then table.remove(ActiveNotifs, index) end
        Tween(card, TI.Out, { Position = OFFSCREEN }).Completed:Connect(function()
            wrapper:Destroy()
        end)
    end

    card.MouseButton1Click:Connect(handle.Dismiss)

    ActiveNotifs[#ActiveNotifs + 1] = handle
    while #ActiveNotifs > CONFIG.MaxNotifications do
        ActiveNotifs[1].Dismiss()
    end

    Tween(card, TI.Medium, { Position = UDim2.fromOffset(0, 0) })
    local duration = opts.Duration or CONFIG.NotifyDuration
    Tween(fill, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(0, 1) })
    task.delay(duration, handle.Dismiss)

    return handle
end

function Notify.Info(body, subtitle, duration)
    if not Settings.Notifications then return nil end
    return BuildNotification({ Kind = "info", Subtitle = subtitle or CONFIG.ProjectName, Body = body, Duration = duration })
end

function Notify.Error(body, code, subtitle, duration)
    local sub = subtitle or T("err")
    if code then sub = sub .. " · " .. code end
    return BuildNotification({ Kind = "error", Subtitle = sub, Body = body, Duration = duration })
end

local function MakeLogo(parent, layoutOrder, size, holeKey)
    size = size or 26
    local logo = Create("Frame", {
        Name = "Logo", LayoutOrder = layoutOrder or 0, BackgroundTransparency = 1,
        Size = UDim2.fromOffset(size, size), Parent = parent,
    })
    local gem = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(size * 0.66, size * 0.66), Rotation = 45,
        BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = logo,
    }, { Corner(UDim.new(0, math.max(3, math.floor(size * 0.14)))) })
    local gradient = Create("UIGradient", { Rotation = -45, Parent = gem })
    local hole = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(size * 0.28, size * 0.28), Rotation = 45,
        BorderSizePixel = 0, Parent = logo,
    }, { Corner(UDim.new(0, 2)) })
    Th(hole, { BackgroundColor3 = holeKey or "Background" })
    Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.86, 0.14),
        Size = UDim2.fromOffset(math.max(3, size * 0.15), math.max(3, size * 0.15)),
        BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = logo,
    }, { Corner(UDim.new(1, 0)) })
    local function paint()
        gradient.Color = ColorSequence.new(THEME.AccentSoft, THEME.SwitchOn)
    end
    paint()
    OnTheme(paint)
    return logo
end

local Watermark = { Visible = false, Suppressed = false, Shown = false }

do
    local SHOWN = UDim2.new(0.5, 0, 0, 12)
    local HIDDEN = UDim2.new(0.5, 0, 0, -100)

    local frame = Create("Frame", {
        Name = "Watermark", AnchorPoint = Vector2.new(0.5, 0),
        Position = HIDDEN, Size = UDim2.new(0, 0, 0, 40),
        AutomaticSize = Enum.AutomaticSize.X, BorderSizePixel = 0,
        Visible = false, ZIndex = 5, Parent = ScreenGui,
    }, {
        Corner(UDim.new(1, 0)),
        Create("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 18) }),
    })
    Th(frame, { BackgroundColor3 = "Glass" })

    local stroke = Th(Create("UIStroke", { Thickness = 1, Transparency = 0.35, Parent = frame }), { Color = "Stroke" })

    local inner = Create("Frame", {
        Name = "Inner", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X, Parent = frame,
    }, {
        Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10),
        }),
    })

    MakeLogo(inner, 1, 22, "Glass")

    Th(Create("TextLabel", {
        Name = "Title", LayoutOrder = 2, BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
        FontFace = F.Bold, TextSize = 16,
        Text = CONFIG.WatermarkTitle, Parent = inner,
    }), { TextColor3 = "Text" })

    local sep = Th(Create("Frame", {
        Name = "Sep", LayoutOrder = 3, Size = UDim2.fromOffset(1, 18),
        BorderSizePixel = 0, Parent = inner,
    }), { BackgroundColor3 = "Stroke" })

    local stats = Th(Create("TextLabel", {
        Name = "Stats", LayoutOrder = 4, BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
        FontFace = F.Medium, TextSize = 14, Text = "", Parent = inner,
    }), { TextColor3 = "Muted" })

    local button = Create("TextButton", {
        Name = "Click", BackgroundTransparency = 1, Text = "",
        Position = UDim2.fromOffset(-16, 0), Size = UDim2.new(1, 34, 1, 0),
        ZIndex = 5, Parent = frame,
    })

    local displayName = CONFIG.UseDisplayName and LocalPlayer.DisplayName or LocalPlayer.Name
    local fps, ping = 60, 0

    local function readPing()
        local ok, value = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        end)
        if ok and type(value) == "number" then
            return math.floor(value + 0.5)
        end
        local ok2, seconds = pcall(function()
            return LocalPlayer:GetNetworkPing()
        end)
        if ok2 and type(seconds) == "number" then
            return math.floor(seconds * 1000 + 0.5)
        end
        return 0
    end

    local function refresh()
        local parts = {}
        if Settings.WmFps then parts[#parts + 1] = string.format("%d FPS", fps) end
        if Settings.WmPing then parts[#parts + 1] = string.format("%d ms", ping) end
        if Settings.WmNick then parts[#parts + 1] = displayName end
        stats.Text = table.concat(parts, "   ·   ")
        stats.Visible = #parts > 0
        sep.Visible = #parts > 0
    end
    Watermark.Refresh = refresh
    refresh()

    local frames, accum = 0, 0
    Root:Give(RunService.RenderStepped:Connect(function(dt)
        if not Watermark.Shown then
            frames, accum = 0, 0
            return
        end
        frames += 1
        accum += dt
        if accum >= 0.3 then
            fps = math.floor(frames / accum + 0.5)
            frames, accum = 0, 0
            ping = readPing()
            refresh()
        end
    end))

    local hovered = false
    button.MouseEnter:Connect(function()
        hovered = true
        Tween(stroke, TI.Fast, { Color = THEME.Accent, Transparency = 0 })
    end)
    button.MouseLeave:Connect(function()
        hovered = false
        Tween(stroke, TI.Fast, { Color = THEME.Stroke, Transparency = 0.35 })
    end)
    OnTheme(function()
        stroke.Color = hovered and THEME.Accent or THEME.Stroke
    end)

    button.MouseButton1Click:Connect(function()
        if Watermark.ConsumeLongPress and Watermark.ConsumeLongPress() then return end
        if Watermark.OnClick then Watermark.OnClick() end
    end)

    Watermark.Frame = frame

    button.MouseButton2Click:Connect(function()
        if Watermark.OnContext then Watermark.OnContext() end
    end)

    local holdToken = 0
    local longPressed = false
    button.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.Touch then return end
        holdToken += 1
        local mine = holdToken
        longPressed = false
        task.delay(0.5, function()
            if holdToken == mine then
                longPressed = true
                if Watermark.OnContext then Watermark.OnContext() end
            end
        end)
    end)
    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then holdToken += 1 end
    end)
    function Watermark.ConsumeLongPress()
        local was = longPressed
        longPressed = false
        return was
    end

    function Watermark.Present()
        local want = Watermark.Visible and not Watermark.Suppressed
        if want == Watermark.Shown then return end
        Watermark.Shown = want
        if want then
            frame.Visible = true
            ping = readPing()
            refresh()
            Tween(frame, TI.Slow, { Position = SHOWN })
        else
            Tween(frame, TI.Medium, { Position = HIDDEN }).Completed:Connect(function()
                if not Watermark.Shown then frame.Visible = false end
            end)
        end
    end

    function Watermark.SetVisible(state)
        Watermark.Visible = state
        Watermark.Present()
    end

    function Watermark.Suppress(flag)
        Watermark.Suppressed = flag
        Watermark.Present()
    end
end

local function BindCharacter(parentMaid, builder)
    local charMaid = Maid.new()
    local generation = 0
    parentMaid:Give(charMaid)
    parentMaid:Give(function()
        generation += 1
    end)
    local function attach(char)
        generation += 1
        local mine = generation
        charMaid:Clean()
        task.spawn(function()
            local ok, err = pcall(builder, char, charMaid, function()
                return mine == generation and char.Parent ~= nil
            end)
            if not ok then
                warn("[Nyxora] Ошибка в модуле: " .. tostring(err))
            end
        end)
    end
    if LocalPlayer.Character then attach(LocalPlayer.Character) end
    parentMaid:Give(LocalPlayer.CharacterAdded:Connect(attach))
    parentMaid:Give(LocalPlayer.CharacterRemoving:Connect(function()
        generation += 1
        charMaid:Clean()
    end))
end

local function SimpleModule(enable)
    local M = {}
    local maid
    function M.Enable()
        maid = Maid.new()
        enable(maid)
    end
    function M.Disable()
        if maid then
            maid:Clean()
            maid = nil
        end
    end
    return M
end

local function RainbowTicker(maid, apply)
    local timer = 0
    maid:Give(RunService.Heartbeat:Connect(function(dt)
        if not Palette.IsRainbow() then return end
        timer += dt
        if timer > 0.1 then
            timer = 0
            apply()
        end
    end))
end

Modules.Aura = SimpleModule(function(maid)
    BindCharacter(maid, function(char, cmaid, isAlive)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        if not root or not isAlive() then return end

        local emitters = {}
        for _, height in ipairs({ -1.4, 0, 1.4 }) do
            local att = cmaid:Give(Create("Attachment", { Name = "VX_Aura", Position = Vector3.new(0, height, 0), Parent = root }))
            emitters[#emitters + 1] = Create("ParticleEmitter", {
                Color = Palette.Sequence(), LightEmission = 1, LightInfluence = 0,
                Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 0.45),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.2),
                    NumberSequenceKeypoint.new(1, 1),
                }),
                Lifetime = NumberRange.new(1.2, 2.4), Rate = 8,
                Speed = NumberRange.new(0.5, 2.5), SpreadAngle = Vector2.new(180, 180),
                Drag = 1.5, Acceleration = Vector3.new(0, 1.2, 0),
                Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-60, 60),
                Parent = att,
            })
        end

        local function applyColors()
            local sequence = Palette.Sequence()
            for _, e in ipairs(emitters) do e.Color = sequence end
        end
        applyColors()
        cmaid:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(cmaid, applyColors)
    end)
end)

Modules.Headless = (function()
    local HEAD_ATTACHMENTS = {
        HatAttachment = true, HairAttachment = true,
        FaceFrontAttachment = true, FaceCenterAttachment = true,
    }
    return SimpleModule(function(maid)
        BindCharacter(maid, function(char, cmaid, isAlive)
            local head = char:WaitForChild("Head", 10)
            if not head or not isAlive() then return end

            local saved = {}
            cmaid:Give(function()
                for inst, value in pairs(saved) do
                    if inst.Parent then inst.Transparency = value end
                end
            end)

            local function hide(inst)
                if saved[inst] ~= nil then return end
                saved[inst] = inst.Transparency
                inst.Transparency = 1
                cmaid:Give(inst:GetPropertyChangedSignal("Transparency"):Connect(function()
                    if inst.Transparency ~= 1 then inst.Transparency = 1 end
                end))
            end

            local function scanHeadChild(obj)
                if obj:IsA("Decal") then hide(obj) end
            end

            local function scanAccessory(acc)
                if not acc:IsA("Accessory") then return end
                local handle = acc:WaitForChild("Handle", 5)
                if not handle or not isAlive() then return end
                local att = handle:FindFirstChildOfClass("Attachment")
                if att and HEAD_ATTACHMENTS[att.Name] then
                    hide(handle)
                    for _, d in ipairs(handle:GetDescendants()) do
                        if d:IsA("Decal") then hide(d) end
                    end
                end
            end

            hide(head)
            for _, v in ipairs(head:GetChildren()) do scanHeadChild(v) end
            cmaid:Give(head.ChildAdded:Connect(scanHeadChild))
            for _, c in ipairs(char:GetChildren()) do task.spawn(scanAccessory, c) end
            cmaid:Give(char.ChildAdded:Connect(function(c) task.spawn(scanAccessory, c) end))
        end)
    end)
end)()

Modules.Korblox = (function()
    local MESH_ID = "rbxassetid://101851696"
    local TEX_ID = "rbxassetid://101851254"
    return SimpleModule(function(maid)
        BindCharacter(maid, function(char, cmaid, isAlive)
            local humanoid = char:WaitForChild("Humanoid", 10)
            if not humanoid or not isAlive() then return end

            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                local upper = char:WaitForChild("RightUpperLeg", 10)
                local lower = char:WaitForChild("RightLowerLeg", 10)
                local foot = char:WaitForChild("RightFoot", 10)
                if not (upper and lower and foot) or not isAlive() then return end

                local saved = {}
                cmaid:Give(function()
                    for part, value in pairs(saved) do
                        if part.Parent then part.Transparency = value end
                    end
                end)
                for _, part in ipairs({ upper, lower, foot }) do
                    saved[part] = part.Transparency
                    part.Transparency = 1
                end

                local height = upper.Size.Y + lower.Size.Y + foot.Size.Y
                local leg = cmaid:Give(Create("Part", {
                    Name = "VX_Korblox", Size = Vector3.new(1, height, 1),
                    Anchored = true, CanCollide = false, CanQuery = false,
                    CanTouch = false, CastShadow = false, Parent = FxFolder,
                }))
                Create("SpecialMesh", {
                    MeshType = Enum.MeshType.FileMesh, MeshId = MESH_ID, TextureId = TEX_ID,
                    Scale = Vector3.new(1, height / 2, 1), Parent = leg,
                })
                cmaid:Give(RunService.RenderStepped:Connect(function()
                    if upper.Parent then
                        local top = upper.CFrame * CFrame.new(0, upper.Size.Y / 2, 0)
                        leg.CFrame = top * CFrame.new(0, -height / 2, 0)
                    end
                end))
            else
                local leg = char:WaitForChild("Right Leg", 10)
                if not leg or not isAlive() then return end

                local stash = {}
                for _, m in ipairs(leg:GetChildren()) do
                    if m:IsA("SpecialMesh") then stash[#stash + 1] = { m, leg } end
                end
                for _, m in ipairs(char:GetChildren()) do
                    if m:IsA("CharacterMesh") and m.BodyPart == Enum.BodyPart.RightLeg then
                        stash[#stash + 1] = { m, char }
                    end
                end
                cmaid:Give(function()
                    for _, entry in ipairs(stash) do
                        if entry[2].Parent then
                            pcall(function() entry[1].Parent = entry[2] end)
                        end
                    end
                end)
                for _, entry in ipairs(stash) do
                    entry[1].Parent = nil
                end

                cmaid:Give(Create("SpecialMesh", {
                    Name = "VX_Korblox", MeshType = Enum.MeshType.FileMesh,
                    MeshId = MESH_ID, TextureId = TEX_ID, Scale = Vector3.one, Parent = leg,
                }))
            end
        end)
    end)
end)()

Modules.Trails = SimpleModule(function(maid)
    BindCharacter(maid, function(char, cmaid, isAlive)
        local humanoid = char:WaitForChild("Humanoid", 10)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        if not humanoid or not root or not isAlive() then return end
        local r15 = humanoid.RigType == Enum.HumanoidRigType.R15
        local targets = r15 and { "LeftHand", "RightHand", "LeftFoot", "RightFoot" }
            or { "Left Arm", "Right Arm", "Left Leg", "Right Leg" }

        local trails = {}
        for _, name in ipairs(targets) do
            local part = char:WaitForChild(name, 5)
            if part and isAlive() then
                local a0 = cmaid:Give(Create("Attachment", { Name = "VX_T0", Position = Vector3.new(0, 0.3, 0), Parent = part }))
                local a1 = cmaid:Give(Create("Attachment", { Name = "VX_T1", Position = Vector3.new(0, -0.3, 0), Parent = part }))
                trails[#trails + 1] = cmaid:Give(Create("Trail", {
                    Name = "VX_Trail", Attachment0 = a0, Attachment1 = a1, Lifetime = 0.4,
                    MinLength = 0.05, FaceCamera = true, LightEmission = 1,
                    LightInfluence = 0, Color = Palette.Sequence(),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1),
                    }),
                    WidthScale = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
                    }),
                    Parent = part,
                }))
            end
        end

        local function applyColors()
            local seq = Palette.Sequence()
            for _, t in ipairs(trails) do t.Color = seq end
        end
        applyColors()
        cmaid:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(cmaid, applyColors)

        local smooth = 0
        cmaid:Give(RunService.Heartbeat:Connect(function(dt)
            if not root.Parent then return end
            smooth += (root.AssemblyLinearVelocity.Magnitude - smooth) * ExpAlpha(10, dt)
            local moving = smooth > 3
            for _, t in ipairs(trails) do t.Enabled = moving end
        end))
    end)
end)

Modules.OrbitAura = SimpleModule(function(maid)
    BindCharacter(maid, function(char, cmaid, isAlive)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        if not root or not isAlive() then return end
        local folder = cmaid:Give(Create("Folder", { Name = "VX_OrbitAura", Parent = FxFolder }))

        local orbs = {}
        for i = 1, 6 do
            local part = Create("Part", {
                Name = "Orb" .. i, Shape = Enum.PartType.Ball,
                Size = Vector3.new(0.45, 0.45, 0.45), Material = Enum.Material.Neon,
                Anchored = true, CanCollide = false, CanQuery = false,
                CanTouch = false, CastShadow = false, Parent = folder,
            })
            local a0 = Create("Attachment", { Position = Vector3.new(0, 0.15, 0), Parent = part })
            local a1 = Create("Attachment", { Position = Vector3.new(0, -0.15, 0), Parent = part })
            local trail = Create("Trail", {
                Attachment0 = a0, Attachment1 = a1, Lifetime = 0.35,
                MinLength = 0.02, FaceCamera = true, LightEmission = 1, LightInfluence = 0,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1),
                }),
                WidthScale = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
                }),
                Parent = part,
            })
            orbs[i] = {
                Part = part, Trail = trail,
                Phase = (i - 1) * (math.pi * 2 / 6),
                Dir = i % 2 == 0 and 1 or -1,
            }
        end

        local function applyColors()
            local A, B = Palette.GetColors()
            for i, orb in ipairs(orbs) do
                local c = i % 2 == 0 and A or B
                orb.Part.Color = c
                orb.Trail.Color = ColorSequence.new(c)
            end
        end
        applyColors()
        cmaid:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(cmaid, applyColors)

        local angleBase = 0
        cmaid:Give(RunService.RenderStepped:Connect(function(dt)
            if not root.Parent then return end
            dt = math.min(dt, 0.1)
            angleBase += dt * 1.8
            local center = root.Position + Vector3.new(0, 0.5, 0)
            local clock = os.clock()
            for i, orb in ipairs(orbs) do
                local theta = angleBase * orb.Dir + orb.Phase
                orb.Part.CFrame = CFrame.new(center + Vector3.new(
                    math.cos(theta) * 3.2, math.sin(clock * 2 + i) * 0.3, math.sin(theta) * 3.2
                ))
            end
        end))
    end)
end)

Modules.Snow = SimpleModule(function(maid)
    local anchor = maid:Give(Create("Part", {
        Name = "VX_Snow", Anchored = true, CanCollide = false,
        CanQuery = false, CanTouch = false, CastShadow = false, Transparency = 1,
        Size = Vector3.new(140, 1, 140), Parent = FxFolder,
    }))
    Create("ParticleEmitter", {
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
        LightEmission = 0.35, LightInfluence = 0.2,
        Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.8, 0.3), NumberSequenceKeypoint.new(1, 0.9, 0.3),
        }),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.05, 0.05),
            NumberSequenceKeypoint.new(0.9, 0.05), NumberSequenceKeypoint.new(1, 1),
        }),
        Lifetime = NumberRange.new(6, 8), Rate = 260,
        Speed = NumberRange.new(9, 14), SpreadAngle = Vector2.new(12, 12),
        EmissionDirection = Enum.NormalId.Bottom,
        Acceleration = Vector3.new(3, 0, 1.5),
        Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-40, 40),
        Parent = anchor,
    })
    maid:Give(RunService.RenderStepped:Connect(function()
        local cam = GetCamera()
        if cam then
            anchor.CFrame = CFrame.new(cam.CFrame.Position + Vector3.new(0, 40, 0))
        end
    end))
end)

Modules.Fov = (function()
    local M = {}
    local bound = false
    local original = 70
    function M.Enable()
        if bound then return end
        local cam = GetCamera()
        original = cam and cam.FieldOfView or 70
        bound = true
        RunService:BindToRenderStep("Nyxora_Fov", Enum.RenderPriority.Camera.Value + 2, function(dt)
            local c = GetCamera()
            if c then
                c.FieldOfView += (Settings.Fov - c.FieldOfView) * ExpAlpha(10, dt)
            end
        end)
    end
    function M.Disable()
        if not bound then return end
        bound = false
        RunService:UnbindFromRenderStep("Nyxora_Fov")
        local cam = GetCamera()
        if cam then Tween(cam, TI.Slow, { FieldOfView = original }) end
    end
    return M
end)()

Modules.Stretch = (function()
    local M = {}
    local bound = false
    local lastApplied = nil
    function M.Enable()
        if bound then return end
        bound = true
        lastApplied = nil
        RunService:BindToRenderStep("Nyxora_Stretch", Enum.RenderPriority.Camera.Value + 3, function()
            local cam = GetCamera()
            if not cam then return end
            if lastApplied and cam.CFrame == lastApplied then return end
            local y = math.clamp(Settings.StretchRes, 0.5, 1)
            cam.CFrame = cam.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, y, 0, 0, 0, 1)
            lastApplied = cam.CFrame
        end)
    end
    function M.Disable()
        if not bound then return end
        bound = false
        lastApplied = nil
        RunService:UnbindFromRenderStep("Nyxora_Stretch")
    end
    return M
end)()

local function Trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function ResolveImage(text)
    text = Trim(text)
    if text == "" then return nil end
    local digits = text:match("^rbxassetid://(%d+)$") or text:match("^(%d+)$")
    if digits then return "rbxassetid://" .. digits end
    if text:match("^rbxasset") or text:match("^rbxthumb") or text:match("^rbxhttp") then
        return text
    end
    if type(getcustomasset) == "function" then
        local ok, asset = pcall(getcustomasset, text)
        if ok and type(asset) == "string" and asset ~= "" then return asset end
    end
    return nil
end

local function ParseFrames(text)
    local list = {}
    for piece in string.gmatch(Trim(text), "[^,;]+") do
        local id = ResolveImage(piece)
        if id then list[#list + 1] = id end
    end
    return list
end

local function GetTorso(char, humanoid)
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        return char:WaitForChild("UpperTorso", 10)
    end
    return char:WaitForChild("Torso", 10)
end

local function FxPart(props)
    props.Anchored = true
    props.CanCollide = false
    props.CanQuery = false
    props.CanTouch = false
    props.CastShadow = false
    return Create("Part", props)
end

Modules.Wings = SimpleModule(function(maid)
    BindCharacter(maid, function(char, cmaid, isAlive)
        local humanoid = char:WaitForChild("Humanoid", 10)
        if not humanoid or not isAlive() then return end
        local torso = GetTorso(char, humanoid)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        if not torso or not root or not isAlive() then return end

        local folder = cmaid:Give(Create("Folder", { Name = "VX_Wings", Parent = FxFolder }))
        local COUNT = 6
        local feathers = {}
        for side = -1, 1, 2 do
            for i = 1, COUNT do
                local part = FxPart({
                    Name = "Feather", Material = Enum.Material.Neon, Transparency = 0.15,
                    Size = Vector3.new(1, 0.3, 0.06), Parent = folder,
                })
                Create("SpecialMesh", { MeshType = Enum.MeshType.Sphere, Parent = part })
                feathers[#feathers + 1] = { Part = part, Side = side, T = (i - 1) / (COUNT - 1) }
            end
        end

        local function applyColors()
            local A, B = Palette.GetColors()
            for _, f in ipairs(feathers) do
                f.Part.Color = A:Lerp(B, f.T)
            end
        end
        applyColors()
        cmaid:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(cmaid, applyColors)

        local flap, speedSmooth, lastScale = 0, 0, nil
        cmaid:Give(RunService.RenderStepped:Connect(function(dt)
            if not torso.Parent then return end
            dt = math.min(dt, 0.1)
            local scale = Settings.WingScale / 100
            if scale ~= lastScale then
                lastScale = scale
                for _, f in ipairs(feathers) do
                    f.Length = (3.4 - f.T * 1.6) * scale
                    f.Part.Size = Vector3.new(f.Length, 0.32 * scale, 0.06)
                end
            end
            speedSmooth += (root.AssemblyLinearVelocity.Magnitude - speedSmooth) * ExpAlpha(6, dt)
            local airborne = humanoid.FloorMaterial == Enum.Material.Air
            local rate = airborne and 9 or (2 + math.min(speedSmooth, 20) * 0.15)
            local amp = airborne and 0.45 or 0.12
            flap += dt * rate
            local swing = math.sin(flap) * amp
            local back = torso.CFrame * CFrame.new(0, torso.Size.Y * 0.25, torso.Size.Z / 2 + 0.15)
            for _, f in ipairs(feathers) do
                local s = f.Side
                local base = back * CFrame.new(0.2 * s * scale, 0, 0)
                    * CFrame.Angles(0, -s * (math.rad(28) + swing), 0)
                    * CFrame.Angles(0, 0, s * (math.rad(35) - f.T * math.rad(80)))
                f.Part.CFrame = base * CFrame.new(s * f.Length / 2, 0, 0)
            end
        end))
    end)
end)

local FOG_COLORS = {
    { Name = "White", Color = Color3.fromRGB(235, 238, 245) },
    { Name = "Gray", Color = Color3.fromRGB(150, 155, 165) },
    { Name = "Dark", Color = Color3.fromRGB(30, 30, 38) },
    { Name = "Palette" },
}

Modules.Fog = (function()
    local M = {}
    local maid, atmo, saved, created
    local PROPS = { "Density", "Offset", "Color", "Decay", "Glare", "Haze" }

    local function fogColor()
        local entry = FOG_COLORS[Settings.FogColor]
        if entry.Color then return entry.Color end
        local A = Palette.GetColors()
        return A:Lerp(Color3.fromRGB(128, 128, 128), 0.35)
    end

    function M.Refresh()
        if not atmo then return end
        local d = Settings.FogDensity / 100
        local color = fogColor()
        atmo.Density = 0.15 + d * 0.65
        atmo.Offset = 0
        atmo.Haze = d * 3
        atmo.Glare = 0
        atmo.Color = color
        atmo.Decay = color:Lerp(Color3.new(0, 0, 0), 0.3)
    end

    function M.Enable()
        maid = Maid.new()
        atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo then
            created = false
            saved = {}
            for _, prop in ipairs(PROPS) do saved[prop] = atmo[prop] end
        else
            created = true
            atmo = Create("Atmosphere", { Name = "VX_Fog", Parent = Lighting })
        end
        M.Refresh()
        maid:Give(Palette.Changed.Event:Connect(M.Refresh))
        RainbowTicker(maid, function()
            if not FOG_COLORS[Settings.FogColor].Color then M.Refresh() end
        end)
    end

    function M.Disable()
        if maid then maid:Clean(); maid = nil end
        if atmo then
            if created then
                atmo:Destroy()
            elseif saved then
                for prop, value in pairs(saved) do
                    pcall(function() atmo[prop] = value end)
                end
            end
        end
        atmo, saved = nil, nil
    end
    return M
end)()

local SKY_PRESETS = {
    { Name = "Sky 1", Ids = { 144933338, 144931530, 144933262, 144933244, 144933299, 144931564 } },
    { Name = "Sky 2", Ids = { 2570432999, 2570433005, 2570432998, 2570433000, 2570432997, 2570432996 } },
    { Name = "Night", Ids = { 151165214, 151165197, 151165224, 151165191, 151165206, 151165227 } },
    { Name = "Sky 4", Ids = { 225469345, 225469349, 225469359, 225469364, 225469372, 225469380 } },
    { Name = "Red Sky", Ids = { 1012890, 1012891, 1012887, 1012889, 1012888, 1014449 } },
    { Name = "Sunset", Ids = { 323494035, 323494368, 323494130, 323494252, 323494067, 323493360 } },
}
local SKY_FACES = { "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp" }

local SKY_MODES = { "Starry Night", "Custom Image" }
for _, preset in ipairs(SKY_PRESETS) do SKY_MODES[#SKY_MODES + 1] = preset.Name end

Modules.Sky = (function()
    local M = {}
    local maid
    local LIGHT_PROPS = { "ClockTime", "Brightness", "Ambient", "OutdoorAmbient" }

    local function buildStars(m)
        local folder = m:Give(Create("Folder", { Name = "VX_Stars", Parent = FxFolder }))
        local rng = Random.new(42)
        local stars = {}
        for i = 1, 220 do
            local dir = rng:NextUnitVector()
            dir = Vector3.new(dir.X, math.abs(dir.Y) * 0.9 + 0.1, dir.Z).Unit
            local size = rng:NextNumber(1, 3)
            stars[i] = {
                Part = FxPart({
                    Shape = Enum.PartType.Ball, Material = Enum.Material.Neon,
                    Size = Vector3.new(size, size, size), Parent = folder,
                }),
                Dir = dir, Base = rng:NextNumber(0, 0.3),
                Phase = rng:NextNumber(0, math.pi * 2), Speed = rng:NextNumber(1, 3),
                Tint = rng:NextNumber(),
            }
        end

        local function applyColors()
            local A, B = Palette.GetColors()
            local white = Color3.new(1, 1, 1)
            for _, s in ipairs(stars) do
                s.Part.Color = white:Lerp(A:Lerp(B, s.Tint), 0.45)
            end
        end
        applyColors()
        m:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(m, applyColors)

        local lastCenter, cursor = nil, 0
        m:Give(RunService.RenderStepped:Connect(function()
            local cam = GetCamera()
            if not cam then return end
            local pos = cam.CFrame.Position
            if not lastCenter or (pos - lastCenter).Magnitude > 20 then
                lastCenter = pos
                for _, s in ipairs(stars) do
                    s.Part.CFrame = CFrame.new(pos + s.Dir * 450)
                end
            end
            local t = os.clock()
            for _ = 1, 15 do
                cursor = cursor % #stars + 1
                local s = stars[cursor]
                s.Part.Transparency = s.Base + (math.sin(t * s.Speed + s.Phase) + 1) * 0.25
            end
        end))
    end

    function M.Enable()
        maid = Maid.new()

        local hidden = {}
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:IsA("Sky") then
                hidden[#hidden + 1] = child
                child.Parent = nil
            end
        end
        maid:Give(function()
            for _, sky in ipairs(hidden) do
                pcall(function() sky.Parent = Lighting end)
            end
        end)

        local savedLight = {}
        for _, prop in ipairs(LIGHT_PROPS) do savedLight[prop] = Lighting[prop] end
        maid:Give(function()
            for prop, value in pairs(savedLight) do
                pcall(function() Lighting[prop] = value end)
            end
        end)

        if Settings.SkyMode == 1 then
            maid:Give(Create("Sky", {
                Name = "VX_Sky", StarCount = 5000, CelestialBodiesShown = true, Parent = Lighting,
            }))
            Lighting.ClockTime = 0
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(40, 40, 60)
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 100)
            maid:Give(Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
                if Lighting.ClockTime ~= 0 then Lighting.ClockTime = 0 end
            end))
            buildStars(maid)
        elseif Settings.SkyMode == 2 then
            local id = ResolveImage(Settings.SkyImage)
            local props = { Name = "VX_Sky", StarCount = 0, CelestialBodiesShown = false }
            if id then
                for _, face in ipairs(SKY_FACES) do props[face] = id end
            else
                Notify.Error(T("n_sky_id"), "NX-201", T("n_sky"), 4)
            end
            props.Parent = Lighting
            maid:Give(Create("Sky", props))
            Lighting.ClockTime = 12
        else
            local preset = SKY_PRESETS[math.clamp(Settings.SkyMode - 2, 1, #SKY_PRESETS)]
            local props = { Name = "VX_Sky", StarCount = 3000, CelestialBodiesShown = true }
            for i, face in ipairs(SKY_FACES) do
                props[face] = "rbxassetid://" .. preset.Ids[i]
            end
            props.Parent = Lighting
            maid:Give(Create("Sky", props))
        end
    end

    function M.Disable()
        if maid then maid:Clean(); maid = nil end
    end

    function M.Refresh()
        if not maid then return end
        M.Disable()
        M.Enable()
    end
    return M
end)()

local CROSS_STYLES = { "Dot", "Cross", "Cross + Dot", "Circle", "Circle + Dot" }
local CURSOR_COLORS = { "White", "Palette" }

Modules.Crosshair = (function()
    local M = {}
    local maid, build
    function M.Refresh()
        if build then build() end
    end
    function M.Enable()
        maid = Maid.new()
        local holder = maid:Give(Create("Frame", {
            Name = "Cursor", Size = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1, ZIndex = 100, Parent = ScreenGui,
        }))
        maid:Give(function()
            UserInputService.MouseIconEnabled = true
        end)
        maid:Give(RunService.RenderStepped:Connect(function()
            UserInputService.MouseIconEnabled = false
            local pos
            if UserInputService.MouseEnabled then
                pos = UserInputService:GetMouseLocation()
            else
                local cam = GetCamera()
                pos = cam and cam.ViewportSize / 2 or Vector2.zero
            end
            holder.Position = UDim2.fromOffset(pos.X, pos.Y)
        end))
        local pieces = {}
        local OUTLINE = Color3.new(0, 0, 0)

        local function recolor()
            local c = Settings.CursorColor == 1 and Color3.new(1, 1, 1) or Palette.GetColors()
            for _, p in ipairs(pieces) do
                if p.Ring then
                    p.Ring.Color = c
                else
                    p.Frame.BackgroundColor3 = c
                end
            end
        end

        build = function()
            for _, p in ipairs(pieces) do p.Frame:Destroy() end
            table.clear(pieces)
            local style = Settings.CrossStyle
            local size, thick, gap = Settings.CrossSize, Settings.CrossThick, Settings.CrossGap

            local function bar(w, h, x, y)
                pieces[#pieces + 1] = { Frame = Create("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y),
                    Size = UDim2.fromOffset(w, h), BorderSizePixel = 0, ZIndex = 100, Parent = holder,
                }, { Create("UIStroke", { Color = OUTLINE, Transparency = 0.4, Thickness = 1 }) }) }
            end

            local function dot()
                local d = math.max(thick + 2, 4)
                pieces[#pieces + 1] = { Frame = Create("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(d, d),
                    BorderSizePixel = 0, ZIndex = 100, Parent = holder,
                }, {
                    Corner(UDim.new(1, 0)),
                    Create("UIStroke", { Color = OUTLINE, Transparency = 0.4, Thickness = 1 }),
                }) }
            end

            if style == 1 then
                dot()
            elseif style == 2 or style == 3 then
                local offset = gap + size / 2
                bar(thick, size, 0, -offset)
                bar(thick, size, 0, offset)
                bar(size, thick, -offset, 0)
                bar(size, thick, offset, 0)
                if style == 3 then dot() end
            else
                local diameter = (size + gap) * 2
                local frame = Create("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(diameter, diameter),
                    BackgroundTransparency = 1, ZIndex = 100, Parent = holder,
                }, { Corner(UDim.new(1, 0)) })
                local ring = Create("UIStroke", { Thickness = thick, Parent = frame })
                pieces[#pieces + 1] = { Frame = frame, Ring = ring }
                if style == 5 then dot() end
            end
            recolor()
        end

        build()
        maid:Give(function() build = nil end)
        maid:Give(Palette.Changed.Event:Connect(recolor))
        RainbowTicker(maid, recolor)
    end
    function M.Disable()
        if maid then maid:Clean(); maid = nil end
    end
    return M
end)()

local function FirstPersonHider(cmaid, head, parts)
    local last = nil
    cmaid:Give(RunService.RenderStepped:Connect(function()
        local cam = GetCamera()
        local close = cam ~= nil and head.Parent ~= nil and (cam.CFrame.Position - head.Position).Magnitude < 1.6
        if close ~= last then
            last = close
            for _, part in ipairs(parts) do
                part.LocalTransparencyModifier = close and 1 or 0
            end
        end
    end))
end

Modules.ChinaHat = SimpleModule(function(maid)
    BindCharacter(maid, function(char, cmaid, isAlive)
        local head = char:WaitForChild("Head", 10)
        if not head or not isAlive() then return end
        local folder = cmaid:Give(Create("Folder", { Name = "VX_ChinaHat", Parent = FxFolder }))
        local LAYERS = 22
        local discs, cfs = {}, {}
        for i = 1, LAYERS do
            discs[i] = FxPart({
                Name = "Disc", Shape = Enum.PartType.Cylinder, Material = Enum.Material.Neon,
                Transparency = 0.35, Parent = folder,
            })
        end

        local function applyColors()
            local A, B = Palette.GetColors()
            local white = Color3.new(1, 1, 1)
            for i, d in ipairs(discs) do
                local f = (i - 1) / LAYERS
                d.Color = A:Lerp(B, f):Lerp(white, f * 0.35)
            end
        end
        applyColors()
        cmaid:Give(Palette.Changed.Event:Connect(applyColors))
        RainbowTicker(cmaid, applyColors)
        FirstPersonHider(cmaid, head, discs)

        local lastScale
        cmaid:Give(RunService.RenderStepped:Connect(function()
            if not head.Parent then return end
            local scale = Settings.HatSize / 100
            local radius, height = 1.2 * scale, 0.7 * scale
            local dy = height / LAYERS
            if scale ~= lastScale then
                lastScale = scale
                for i, d in ipairs(discs) do
                    local r = radius * (1 - (i - 1) / LAYERS) + 0.03
                    d.Size = Vector3.new(dy + 0.01, r * 2, r * 2)
                end
            end
            local base = head.CFrame * CFrame.new(0, head.Size.Y / 2 + 0.12, 0)
            for i = 1, LAYERS do
                cfs[i] = base * CFrame.new(0, (i - 1) * dy, 0) * CFrame.Angles(0, 0, math.pi / 2)
            end
            Workspace:BulkMoveTo(discs, cfs, Enum.BulkMoveMode.FireCFrameChanged)
        end))
    end)
end)

local JUMP_STYLES = { "Classic", "Nyxora" }

Modules.JumpCircles = (function()
    local PART_SIZE = 14

    local function surface(position)
        local part = FxPart({
            Name = "VX_JumpCircle", Transparency = 1,
            Size = Vector3.new(PART_SIZE, 0.05, PART_SIZE),
            CFrame = CFrame.new(position + Vector3.new(0, 0.06, 0)),
        })
        local gui = Create("SurfaceGui", {
            Face = Enum.NormalId.Top, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
            PixelsPerStud = 50, LightInfluence = 0, Parent = part,
        })
        return part, gui
    end

    local function classic(position, color)
        local part, gui = surface(position)
        local LIFE, FADE_IN, START, FINISH, ALPHA = 1.5, 0.2, 0.18, 0.5, 0.35
        local grow = TweenInfo.new(LIFE, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local fadeIn = TweenInfo.new(FADE_IN, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local fadeOut = TweenInfo.new(LIFE - FADE_IN, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        for _, layer in ipairs({ { 4, ALPHA }, { 14, ALPHA + 0.45 }, { 28, ALPHA + 0.58 } }) do
            local frame = Create("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(START, START), BackgroundTransparency = 1, Parent = gui,
            }, { Corner(UDim.new(1, 0)) })
            local stroke = Create("UIStroke", {
                Color = color, Thickness = layer[1], Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = frame,
            })
            Tween(frame, grow, { Size = UDim2.fromScale(FINISH, FINISH) })
            Tween(stroke, fadeIn, { Transparency = layer[2] }).Completed:Connect(function()
                Tween(stroke, fadeOut, { Transparency = 1 })
            end)
        end
        part.Parent = FxFolder
        Debris:AddItem(part, LIFE + 0.1)
    end

    local function textRing(position, color)
        local part, gui = surface(position)
        local DUR, FADE_AT = 1.8, 1.0
        local FULL = PART_SIZE * 50
        local C = FULL / 2
        local D_IN, D_OUT = FULL * 0.32, FULL * 0.52
        local fadeOut = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local root = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(FULL, FULL), BackgroundTransparency = 1, Parent = gui,
        })
        local fading = {}

        for _, ring in ipairs({ { D_IN, 2, 0.1 }, { D_IN, 7, 0.78 }, { D_OUT, 2, 0.1 }, { D_OUT, 7, 0.78 } }) do
            local frame = Create("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(ring[1], ring[1]), BackgroundTransparency = 1, Parent = root,
            }, { Corner(UDim.new(1, 0)) })
            fading[#fading + 1] = { Create("UIStroke", {
                Color = color, Thickness = ring[2], Transparency = ring[3],
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = frame,
            }), { Transparency = 1 } }
        end

        local word = "NYXORA  "
        local rMid = (D_IN + D_OUT) / 4
        local fontPx = 34
        local slots = math.floor(2 * math.pi * rMid / (fontPx * 0.95))
        local total = math.max(1, math.floor(slots / #word)) * #word
        for i = 0, total - 1 do
            local ch = word:sub(i % #word + 1, i % #word + 1)
            if ch ~= " " then
                local angle = (i / total) * 2 * math.pi
                fading[#fading + 1] = { Create("TextLabel", {
                    AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(fontPx, fontPx),
                    Position = UDim2.fromOffset(C + rMid * math.sin(angle), C - rMid * math.cos(angle)),
                    Rotation = math.deg(angle), BackgroundTransparency = 1, Text = ch,
                    TextSize = fontPx, Font = Enum.Font.Michroma, TextColor3 = color,
                    TextTransparency = 0.05, TextStrokeColor3 = color, TextStrokeTransparency = 0.8,
                    Parent = root,
                }), { TextTransparency = 1, TextStrokeTransparency = 1 } }
            end
        end

        part.Parent = FxFolder
        task.delay(FADE_AT, function()
            for _, entry in ipairs(fading) do
                if entry[1].Parent then Tween(entry[1], fadeOut, entry[2]) end
            end
        end)
        Debris:AddItem(part, DUR + 0.2)
    end

    return SimpleModule(function(maid)
        BindCharacter(maid, function(char, cmaid, isAlive)
            local humanoid = char:WaitForChild("Humanoid", 10)
            local root = char:WaitForChild("HumanoidRootPart", 10)
            if not humanoid or not root or not isAlive() then return end
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = { char, FxFolder }
            cmaid:Give(humanoid.StateChanged:Connect(function(_, state)
                if state ~= Enum.HumanoidStateType.Jumping then return end
                local hit = Workspace:Raycast(root.Position, Vector3.new(0, -12, 0), params)
                if not hit then return end
                local color = Palette.GetColors()
                if Settings.JumpStyle == 2 then
                    textRing(hit.Position, color)
                else
                    classic(hit.Position, color)
                end
            end))
        end)
    end)
end)()

local CHAMS_MODES = { "ForceField", "Flat", "Rainbow" }

Modules.Chams = (function()
    local M = {}
    local maid

    function M.Enable()
        maid = Maid.new()
        BindCharacter(maid, function(char, cmaid)
            local mode = Settings.ChamsMode
            if mode == 1 then
                local saved = {}
                cmaid:Give(function()
                    for part, st in pairs(saved) do
                        if part.Parent then
                            part.Material = st[1]
                            part.Color = st[2]
                        end
                    end
                end)
                local function apply(part)
                    if not part:IsA("BasePart") or part.Name == "HumanoidRootPart" then return end
                    if not saved[part] then saved[part] = { part.Material, part.Color } end
                    part.Material = Enum.Material.ForceField
                    part.Color = Palette.GetColors()
                end
                for _, d in ipairs(char:GetDescendants()) do apply(d) end
                cmaid:Give(char.DescendantAdded:Connect(apply))
                local function recolor()
                    local A = Palette.GetColors()
                    for part in pairs(saved) do
                        if part.Parent then part.Color = A end
                    end
                end
                cmaid:Give(Palette.Changed.Event:Connect(recolor))
                RainbowTicker(cmaid, recolor)
            else
                local hl = cmaid:Give(Create("Highlight", {
                    Name = "VX_Chams", Adornee = char, DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillTransparency = mode == 2 and 0 or 0.2,
                    OutlineColor = Color3.new(1, 1, 1), OutlineTransparency = mode == 2 and 1 or 0.2,
                    Parent = char,
                }))
                if mode == 2 then
                    local function recolor() hl.FillColor = Palette.GetColors() end
                    recolor()
                    cmaid:Give(Palette.Changed.Event:Connect(recolor))
                    RainbowTicker(cmaid, recolor)
                else
                    local hue = 0
                    cmaid:Give(RunService.Heartbeat:Connect(function(dt)
                        hue = (hue + dt * 0.25) % 1
                        hl.FillColor = Color3.fromHSV(hue, 0.9, 1)
                    end))
                end
            end
        end)
    end

    function M.Disable()
        if maid then maid:Clean(); maid = nil end
    end

    function M.Refresh()
        if not maid then return end
        M.Disable()
        M.Enable()
    end
    return M
end)()

Modules.Rain = (function()
    local M = {}
    local conn, folder
    local MAX, RADIUS, HEIGHT = 300, 34, 30
    local HIDDEN = CFrame.new(0, -1e4, 0)

    function M.Enable()
        if conn then return end
        folder = Create("Folder", { Name = "VX_Rain", Parent = FxFolder })
        local parts, pos = {}, {}
        for i = 1, MAX do
            parts[i] = FxPart({
                Name = "Drop", Material = Enum.Material.Neon, Color = Color3.fromRGB(190, 210, 235),
                Transparency = 0.45, Size = Vector3.new(0.06, 1.6, 0.06), CFrame = HIDDEN, Parent = folder,
            })
        end
        local tilt = CFrame.Angles(0, 0, math.rad(8))
        local list, cfs = {}, {}

        local function spawnAt(c, top)
            return Vector3.new(
                c.X + (math.random() * 2 - 1) * RADIUS,
                top and (c.Y + HEIGHT * (0.5 + math.random() * 0.5)) or (c.Y + math.random() * HEIGHT - 8),
                c.Z + (math.random() * 2 - 1) * RADIUS
            )
        end

        conn = RunService.RenderStepped:Connect(function(dt)
            local cam = GetCamera()
            if not cam then return end
            dt = math.min(dt, 0.1)
            local n = math.floor(MAX * Settings.RainAmount / 100 + 0.5)
            local c = cam.CFrame.Position
            local speed = 55 + Settings.RainAmount * 0.3
            table.clear(list)
            table.clear(cfs)
            for i = 1, MAX do
                local p = pos[i]
                if i <= n then
                    if not p then
                        p = spawnAt(c, false)
                    else
                        p += Vector3.new(speed * 0.14 * dt, -speed * dt, 0)
                        local dx, dz = p.X - c.X, p.Z - c.Z
                        if dx > RADIUS then p -= Vector3.new(2 * RADIUS, 0, 0) elseif dx < -RADIUS then p += Vector3.new(2 * RADIUS, 0, 0) end
                        if dz > RADIUS then p -= Vector3.new(0, 0, 2 * RADIUS) elseif dz < -RADIUS then p += Vector3.new(0, 0, 2 * RADIUS) end
                        if p.Y < c.Y - 10 then p = spawnAt(c, true) end
                    end
                    pos[i] = p
                    list[#list + 1] = parts[i]
                    cfs[#cfs + 1] = CFrame.new(p) * tilt
                elseif p then
                    pos[i] = nil
                    list[#list + 1] = parts[i]
                    cfs[#cfs + 1] = HIDDEN
                end
            end
            if #list > 0 then
                Workspace:BulkMoveTo(list, cfs, Enum.BulkMoveMode.FireCFrameChanged)
            end
        end)
    end

    function M.Disable()
        if conn then conn:Disconnect(); conn = nil end
        if folder then folder:Destroy(); folder = nil end
    end
    return M
end)()

local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end
local LIGHT_PRESETS = {
    { Name = "Realistic", clock = 13.5, bright = 3, ambient = rgb(70, 70, 80), outdoor = rgb(120, 125, 140),
        atmo = { Density = 0.3, Offset = 0.25, Color = rgb(199, 215, 235), Decay = rgb(106, 112, 125), Glare = 0.3, Haze = 1.2 },
        cc = { TintColor = rgb(255, 250, 242), Saturation = 0.12, Contrast = 0.08, Brightness = 0 },
        bloom = { 0.35, 24, 0.95 }, rays = { 0.12, 0.7 } },
    { Name = "Golden Hour", clock = 17.6, bright = 2.5, ambient = rgb(90, 70, 60), outdoor = rgb(140, 110, 90),
        atmo = { Density = 0.38, Offset = 0.3, Color = rgb(255, 200, 150), Decay = rgb(255, 150, 80), Glare = 1, Haze = 2 },
        cc = { TintColor = rgb(255, 232, 205), Saturation = 0.25, Contrast = 0.12, Brightness = 0 },
        bloom = { 0.6, 30, 0.8 }, rays = { 0.3, 0.8 } },
    { Name = "Pink Dusk", clock = 18.4, bright = 1.8, ambient = rgb(80, 60, 90), outdoor = rgb(130, 100, 150),
        atmo = { Density = 0.4, Offset = 0.3, Color = rgb(255, 170, 210), Decay = rgb(200, 110, 190), Glare = 0.6, Haze = 2.4 },
        cc = { TintColor = rgb(255, 225, 245), Saturation = 0.3, Contrast = 0.1, Brightness = 0 },
        bloom = { 0.7, 36, 0.75 }, rays = { 0.2, 0.9 } },
    { Name = "Night Moon", clock = 0.5, bright = 1.2, ambient = rgb(30, 40, 70), outdoor = rgb(50, 65, 110),
        atmo = { Density = 0.25, Offset = 0, Color = rgb(40, 60, 110), Decay = rgb(20, 30, 60), Glare = 0, Haze = 0.5 },
        cc = { TintColor = rgb(200, 215, 255), Saturation = -0.05, Contrast = 0.1, Brightness = 0.02 },
        bloom = { 0.6, 30, 0.8 }, rays = { 0, 0.5 } },
    { Name = "Overcast", clock = 12, bright = 1.6, ambient = rgb(110, 115, 120), outdoor = rgb(150, 155, 160),
        atmo = { Density = 0.55, Offset = 0.1, Color = rgb(170, 175, 182), Decay = rgb(140, 145, 150), Glare = 0, Haze = 4 },
        cc = { TintColor = rgb(235, 240, 245), Saturation = -0.25, Contrast = 0.05, Brightness = 0 },
        bloom = { 0.15, 20, 1 }, rays = { 0, 0.5 } },
    { Name = "Cyberpunk", clock = 21.5, bright = 2.2, ambient = rgb(60, 20, 90), outdoor = rgb(110, 40, 160),
        atmo = { Density = 0.45, Offset = 0.2, Color = rgb(255, 60, 200), Decay = rgb(90, 30, 200), Glare = 0.4, Haze = 3 },
        cc = { TintColor = rgb(255, 215, 255), Saturation = 0.45, Contrast = 0.25, Brightness = 0 },
        bloom = { 1.0, 40, 0.6 }, rays = { 0.1, 0.5 } },
    { Name = "Arctic", clock = 11, bright = 3, ambient = rgb(100, 120, 140), outdoor = rgb(160, 185, 210),
        atmo = { Density = 0.35, Offset = 0.2, Color = rgb(200, 225, 255), Decay = rgb(150, 190, 230), Glare = 0.2, Haze = 1.5 },
        cc = { TintColor = rgb(225, 240, 255), Saturation = -0.05, Contrast = 0.15, Brightness = 0 },
        bloom = { 0.3, 24, 0.95 }, rays = { 0.15, 0.6 } },
    { Name = "Toxic", clock = 16, bright = 2, ambient = rgb(50, 80, 40), outdoor = rgb(90, 140, 60),
        atmo = { Density = 0.5, Offset = 0.2, Color = rgb(160, 230, 80), Decay = rgb(90, 160, 40), Glare = 0.2, Haze = 3.5 },
        cc = { TintColor = rgb(225, 255, 200), Saturation = 0.2, Contrast = 0.15, Brightness = 0 },
        bloom = { 0.5, 30, 0.8 }, rays = { 0.1, 0.6 } },
}

Modules.LightPresets = (function()
    local M = {}
    local state
    local LIGHT_PROPS = { "ClockTime", "Brightness", "Ambient", "OutdoorAmbient" }
    local ATMO_PROPS = { "Density", "Offset", "Color", "Decay", "Glare", "Haze" }
    local SMOOTH = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    local function isOn(id)
        return Features[id] ~= nil and Features[id].Enabled
    end

    local function cancel()
        for _, t in ipairs(state.tweens) do t:Cancel() end
        table.clear(state.tweens)
    end

    local function apply(smooth)
        if not state then return end
        local p = LIGHT_PRESETS[Settings.LightPreset]
        local light = { Brightness = p.bright, Ambient = p.ambient, OutdoorAmbient = p.outdoor }
        if not isOn("Sky") then light.ClockTime = p.clock end
        local targets = {
            { Lighting, light },
            { state.cc, p.cc },
            { state.bloom, { Intensity = p.bloom[1], Size = p.bloom[2], Threshold = p.bloom[3] } },
            { state.rays, { Intensity = p.rays[1], Spread = p.rays[2] } },
        }
        if state.atmo and not isOn("Fog") then
            targets[#targets + 1] = { state.atmo, p.atmo }
        end
        cancel()
        for _, pair in ipairs(targets) do
            if smooth then
                state.tweens[#state.tweens + 1] = Tween(pair[1], SMOOTH, pair[2])
            else
                for k, v in pairs(pair[2]) do pair[1][k] = v end
            end
        end
    end

    function M.Enable()
        if state then return end
        state = { tweens = {}, light = {} }
        for _, prop in ipairs(LIGHT_PROPS) do state.light[prop] = Lighting[prop] end
        local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmo then
            state.atmoSaved = {}
            for _, prop in ipairs(ATMO_PROPS) do state.atmoSaved[prop] = atmo[prop] end
        else
            atmo = Create("Atmosphere", { Name = "VX_LightAtmo", Density = 0, Offset = 0, Haze = 0, Glare = 0, Parent = Lighting })
            state.atmoCreated = true
        end
        state.atmo = atmo
        state.cc = Create("ColorCorrectionEffect", { Name = "VX_LightCC", Parent = Lighting })
        state.bloom = Create("BloomEffect", { Name = "VX_LightBloom", Intensity = 0, Size = 24, Threshold = 1, Parent = Lighting })
        state.rays = Create("SunRaysEffect", { Name = "VX_LightRays", Intensity = 0, Spread = 0.5, Parent = Lighting })
        apply(true)
    end

    function M.Disable()
        if not state then return end
        cancel()
        for prop, value in pairs(state.light) do
            pcall(function() Lighting[prop] = value end)
        end
        if state.atmoCreated then
            pcall(function() state.atmo:Destroy() end)
        elseif state.atmoSaved and state.atmo.Parent then
            for prop, value in pairs(state.atmoSaved) do
                pcall(function() state.atmo[prop] = value end)
            end
        end
        for _, key in ipairs({ "cc", "bloom", "rays" }) do
            pcall(function() state[key]:Destroy() end)
        end
        state = nil
    end

    function M.Refresh()
        apply(true)
    end
    return M
end)()

Modules.CameraSway = (function()
    local M = {}
    local bound = false
    local offset, velocity, roll = Vector3.zero, Vector3.zero, 0

    function M.Enable()
        if bound then return end
        bound = true
        offset, velocity, roll = Vector3.zero, Vector3.zero, 0
        RunService:BindToRenderStep("Nyxora_Sway", Enum.RenderPriority.Camera.Value + 1, function(dt)
            local cam = GetCamera()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not cam or not root then return end
            dt = math.min(dt, 1 / 20)
            local v = root.AssemblyLinearVelocity
            local flat = Vector3.new(v.X, 0, v.Z)
            local target = -flat * (0.09 * Settings.SwayLag / 100)
            local stiff = 55
            local damp = 2 * math.sqrt(stiff) * 0.55
            velocity += ((target - offset) * stiff - velocity * damp) * dt
            offset += velocity * dt
            local lateral = flat:Dot(cam.CFrame.RightVector)
            local targetRoll = math.clamp(-lateral * 0.004 * Settings.SwayRoll / 100, -0.08, 0.08)
            roll += (targetRoll - roll) * ExpAlpha(6, dt)
            cam.CFrame = (cam.CFrame + offset) * CFrame.Angles(0, 0, roll)
        end)
    end

    function M.Disable()
        if not bound then return end
        bound = false
        RunService:UnbindFromRenderStep("Nyxora_Sway")
    end
    return M
end)()

local RESHADE_PRESETS = {
    { Name = "Natural", Exposure = 52, Contrast = 56, Vibrance = 56, Temp = 52, Bloom = 25, Rays = 15, Vignette = 30, Letterbox = false },
    { Name = "Vivid", Exposure = 50, Contrast = 62, Vibrance = 78, Temp = 50, Bloom = 35, Rays = 20, Vignette = 25, Letterbox = false },
    { Name = "Cinematic", Exposure = 46, Contrast = 68, Vibrance = 44, Temp = 44, Bloom = 30, Rays = 15, Vignette = 60, Letterbox = true },
    { Name = "Warm Film", Exposure = 51, Contrast = 58, Vibrance = 55, Temp = 74, Bloom = 40, Rays = 30, Vignette = 50, Letterbox = false },
    { Name = "Noir", Exposure = 48, Contrast = 78, Vibrance = 0, Temp = 50, Bloom = 20, Rays = 0, Vignette = 72, Letterbox = true },
    { Name = "Dreamy", Exposure = 56, Contrast = 44, Vibrance = 62, Temp = 58, Bloom = 82, Rays = 35, Vignette = 35, Letterbox = false },
    { Name = "Cold", Exposure = 48, Contrast = 60, Vibrance = 45, Temp = 24, Bloom = 30, Rays = 10, Vignette = 40, Letterbox = false },
}

local Overlay = Create("ScreenGui", {
    Name = "Nyxora_Overlay", ResetOnSpawn = false, IgnoreGuiInset = true,
    DisplayOrder = -10, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = PlayerGui,
})
Root:Give(Overlay)

Modules.ReShade = (function()
    local M = {}
    local state
    local SNAP = { "ExposureCompensation", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ShadowSoftness" }
    local SMOOTH = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local WARM = Color3.fromRGB(255, 222, 186)
    local COOL = Color3.fromRGB(186, 212, 255)
    local WHITE = Color3.new(1, 1, 1)

    local function centered(v) return (v - 50) / 50 end

    local function tint()
        local t = centered(Settings.RsTemp)
        if t >= 0 then return WHITE:Lerp(WARM, t) end
        return WHITE:Lerp(COOL, -t)
    end

    local function buildOverlay()
        local root = Create("Frame", {
            Name = "ReShade", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = Overlay,
        })
        local edges = {}
        local specs = {
            { UDim2.new(1, 0, 0.32, 0), UDim2.fromScale(0, 0), 90 },
            { UDim2.new(1, 0, 0.32, 0), UDim2.fromScale(0, 0.68), -90 },
            { UDim2.new(0.26, 0, 1, 0), UDim2.fromScale(0, 0), 0 },
            { UDim2.new(0.26, 0, 1, 0), UDim2.fromScale(0.74, 0), 180 },
        }
        for _, spec in ipairs(specs) do
            local frame = Create("Frame", {
                Size = spec[1], Position = spec[2], BorderSizePixel = 0,
                BackgroundColor3 = Color3.new(0, 0, 0), Parent = root,
            })
            local gradient = Create("UIGradient", { Rotation = spec[3], Parent = frame })
            edges[#edges + 1] = gradient
        end
        local bars = {}
        for i, anchor in ipairs({ 0, 1 }) do
            bars[i] = Create("Frame", {
                AnchorPoint = Vector2.new(0, anchor), Position = UDim2.fromScale(0, anchor),
                Size = UDim2.new(1, 0, 0, 0), BorderSizePixel = 0,
                BackgroundColor3 = Color3.new(0, 0, 0), ZIndex = 2, Parent = root,
            })
        end
        return root, edges, bars
    end

    local function cancel()
        for _, t in ipairs(state.tweens) do t:Cancel() end
        table.clear(state.tweens)
    end

    local function play(inst, goal, smooth)
        if smooth then
            local ok, tw = pcall(TweenService.Create, TweenService, inst, SMOOTH, goal)
            if ok then
                tw:Play()
                state.tweens[#state.tweens + 1] = tw
                return
            end
        end
        for key, value in pairs(goal) do
            pcall(function() inst[key] = value end)
        end
    end

    local function apply(smooth)
        if not state then return end
        cancel()
        local bloom = Settings.RsBloom / 100
        local light = {
            ExposureCompensation = centered(Settings.RsExposure) * 0.8,
            EnvironmentSpecularScale = Settings.RsReflect and 1 or state.snap.EnvironmentSpecularScale,
            EnvironmentDiffuseScale = Settings.RsReflect and 1 or state.snap.EnvironmentDiffuseScale,
            ShadowSoftness = Settings.RsSoft and 0.2 or state.snap.ShadowSoftness,
        }
        play(Lighting, light, smooth)
        play(state.cc, {
            Contrast = centered(Settings.RsContrast) * 0.45,
            Saturation = centered(Settings.RsVibrance) * 0.9,
            Brightness = 0,
            TintColor = tint(),
        }, smooth)
        play(state.bloom, { Intensity = bloom * 1.3, Size = 20 + bloom * 26, Threshold = 1 - bloom * 0.3 }, smooth)
        play(state.rays, { Intensity = Settings.RsRays / 100 * 0.4, Spread = 0.75 }, smooth)
        play(state.dof, {
            FarIntensity = Settings.RsDof and 0.16 or 0, NearIntensity = 0,
            FocusDistance = 60, InFocusRadius = 45,
        }, smooth)
        local edgeAlpha = 1 - Settings.RsVignette / 100 * 0.88
        local sequence = NumberSequence.new({
            NumberSequenceKeypoint.new(0, edgeAlpha),
            NumberSequenceKeypoint.new(1, 1),
        })
        for _, gradient in ipairs(state.edges) do
            gradient.Transparency = sequence
        end
        for _, bar in ipairs(state.bars) do
            play(bar, { Size = UDim2.new(1, 0, Settings.RsLetterbox and 0.1 or 0, 0) }, true)
        end
    end

    function M.Enable()
        if state then return end
        state = { tweens = {}, snap = {}, mblur = 0 }
        for _, prop in ipairs(SNAP) do
            pcall(function() state.snap[prop] = Lighting[prop] end)
        end
        state.cc = Create("ColorCorrectionEffect", { Name = "VX_RsColor", Parent = Lighting })
        state.bloom = Create("BloomEffect", { Name = "VX_RsBloom", Intensity = 0, Size = 24, Threshold = 1, Parent = Lighting })
        state.rays = Create("SunRaysEffect", { Name = "VX_RsRays", Intensity = 0, Spread = 0.5, Parent = Lighting })
        state.dof = Create("DepthOfFieldEffect", {
            Name = "VX_RsDepth", FarIntensity = 0, NearIntensity = 0,
            FocusDistance = 100, InFocusRadius = 50, Parent = Lighting,
        })
        state.motion = Create("BlurEffect", { Name = "VX_RsMotion", Size = 0, Parent = Lighting })
        state.root, state.edges, state.bars = buildOverlay()
        state.conn = RunService.RenderStepped:Connect(function(dt)
            local cam = GetCamera()
            if not cam or not state then return end
            local look = cam.CFrame.LookVector
            local target = 0
            if Settings.RsMotion and state.lastLook and dt > 0 then
                local angle = math.acos(math.clamp(look:Dot(state.lastLook), -1, 1))
                target = math.clamp(angle / dt * 2.5, 0, 12)
            end
            state.lastLook = look
            state.mblur += (target - state.mblur) * ExpAlpha(12, dt)
            state.motion.Size = state.mblur
        end)
        apply(true)
    end

    function M.Disable()
        if not state then return end
        cancel()
        state.conn:Disconnect()
        for prop, value in pairs(state.snap) do
            pcall(function() Lighting[prop] = value end)
        end
        for _, key in ipairs({ "cc", "bloom", "rays", "dof", "motion", "root" }) do
            pcall(function() state[key]:Destroy() end)
        end
        state = nil
    end

    function M.Refresh(smooth)
        apply(smooth ~= false)
    end
    return M
end)()
Modules.FpsBoost = (function()
    local M = {}
    local maid, saved
    local token = 0
    local EFFECTS = { ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true }

    local function remember(inst, prop)
        local rec = saved[inst]
        if not rec then
            rec = {}
            saved[inst] = rec
        end
        if rec[prop] == nil then rec[prop] = inst[prop] end
    end

    local function setProp(inst, prop, value)
        local ok = pcall(function()
            if inst[prop] ~= value then
                remember(inst, prop)
                inst[prop] = value
            end
        end)
        return ok
    end

    local function skip(inst)
        if inst:IsDescendantOf(FxFolder) then return true end
        local char = LocalPlayer.Character
        return char ~= nil and inst:IsDescendantOf(char)
    end

    local function process(inst)
        if not saved or skip(inst) then return end
        if inst:IsA("BasePart") then
            if inst:IsA("Terrain") then return end
            if Settings.BoostMaterials then
                setProp(inst, "Material", Enum.Material.SmoothPlastic)
                setProp(inst, "MaterialVariant", "")
                setProp(inst, "Reflectance", 0)
            end
            if Settings.BoostShadows then
                setProp(inst, "CastShadow", false)
            end
        elseif inst:IsA("Decal") or inst:IsA("Texture") then
            if Settings.BoostTextures then setProp(inst, "Transparency", 1) end
        elseif EFFECTS[inst.ClassName] then
            if Settings.BoostEffects then setProp(inst, "Enabled", false) end
        elseif inst:IsA("Explosion") then
            if Settings.BoostEffects then pcall(function() inst.Visible = false end) end
        end
    end

    local function processLighting(child)
        if Settings.BoostEffects and child:IsA("PostEffect") and child.Name:sub(1, 3) ~= "VX_" then
            setProp(child, "Enabled", false)
        end
    end

    function M.Enable()
        if maid then return end
        maid = Maid.new()
        saved = setmetatable({}, { __mode = "k" })
        token += 1
        local mine = token

        if Settings.BoostShadows then setProp(Lighting, "GlobalShadows", false) end
        for _, child in ipairs(Lighting:GetChildren()) do processLighting(child) end
        maid:Give(Lighting.ChildAdded:Connect(processLighting))

        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain and Settings.BoostEffects then
            setProp(terrain, "WaterWaveSize", 0)
            setProp(terrain, "WaterWaveSpeed", 0)
            setProp(terrain, "WaterReflectance", 0)
            setProp(terrain, "Decoration", false)
        end
        if Settings.BoostMaterials then
            pcall(function()
                local rendering = settings().Rendering
                setProp(rendering, "QualityLevel", Enum.QualityLevel.Level01)
            end)
        end

        maid:Give(Workspace.DescendantAdded:Connect(process))
        task.spawn(function()
            for i, d in ipairs(Workspace:GetDescendants()) do
                if token ~= mine then return end
                process(d)
                if i % 800 == 0 then task.wait() end
            end
        end)
    end

    function M.Disable()
        token += 1
        if maid then
            maid:Clean()
            maid = nil
        end
        if saved then
            local restore = saved
            saved = nil
            for inst, rec in pairs(restore) do
                for prop, value in pairs(rec) do
                    pcall(function() inst[prop] = value end)
                end
            end
        end
    end

    function M.Refresh()
        if not maid then return end
        M.Disable()
        M.Enable()
    end
    return M
end)()

local BADGE_MODES = { "None", "Verified", "Premium", "Verified + Premium" }

local Presence = { Users = {}, Changed = Instance.new("BindableEvent") }
Root:Give(Presence.Changed)

local function HttpRequest()
    local candidates = {
        type(syn) == "table" and syn.request or nil,
        type(http) == "table" and http.request or nil,
        type(fluxus) == "table" and fluxus.request or nil,
        http_request,
        request,
    }
    for _, fn in ipairs(candidates) do
        if type(fn) == "function" then return fn end
    end
    return nil
end

local function PresenceJobId()
    local id = game.JobId
    if id == nil or id == "" then id = "studio-" .. tostring(game.PlaceId) end
    return (id:gsub("[^%w_-]", ""):sub(1, 64))
end

local function PresenceCall(path, visible)
    local req = HttpRequest()
    local base = Trim(Settings.PresenceUrl):gsub("/+$", "")
    if not req or base == "" then return nil end
    local ok, res = pcall(req, {
        Url = base .. path,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["x-nyxora-key"] = CONFIG.PresenceKey,
        },
        Body = HttpService:JSONEncode({
            userId = LocalPlayer.UserId,
            jobId = PresenceJobId(),
            visible = visible,
        }),
    })
    if not ok or type(res) ~= "table" then return nil end
    local code = tonumber(res.StatusCode or res.Status or 0) or 0
    if code ~= 200 or type(res.Body) ~= "string" then return nil end
    local okJson, data = pcall(HttpService.JSONDecode, HttpService, res.Body)
    return okJson and type(data) == "table" and data or nil
end

local function DrawVerified(parent, order)
    local badge = Create("Frame", {
        LayoutOrder = order, Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(0, 162, 255), Parent = parent,
    }, { Corner(UDim.new(1, 0)) })
    Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(4.9, 7.8),
        Size = UDim2.fromOffset(4, 2), Rotation = 45, BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = badge,
    }, { Corner(UDim.new(1, 0)) })
    Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(8.4, 6.8),
        Size = UDim2.fromOffset(7, 2), Rotation = -45, BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = badge,
    }, { Corner(UDim.new(1, 0)) })
end

local function DrawPremium(parent, order)
    local badge = Create("Frame", {
        LayoutOrder = order, Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Parent = parent,
    }, { Corner(UDim.new(0, 4)) })
    Create("UIStroke", { Thickness = 1.6, Color = Color3.new(1, 1, 1), Parent = badge })
    Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(6, 6), BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = badge,
    }, { Corner(UDim.new(0, 1)) })
end

local function DrawNyxora(parent, order)
    local holder = Create("Frame", {
        LayoutOrder = order, Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Parent = parent,
    })
    local gem = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(9, 9), Rotation = 45, BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = holder,
    }, { Corner(UDim.new(0, 2)) })
    Create("UIGradient", { Rotation = -45, Color = ColorSequence.new(THEME.AccentSoft, THEME.SwitchOn), Parent = gem })
end

Modules.PlayerList = (function()
    local M = {}
    local maid, panel, scroll, countLabel
    local rows = {}
    local shown = true
    local coreWas = nil

    local function setCore(enabled)
        for _ = 1, 10 do
            local ok = pcall(function()
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, enabled)
            end)
            if ok then return end
            task.wait(0.5)
        end
    end

    local function badgesFor(player)
        local verified, premium = false, false
        pcall(function() verified = player.HasVerifiedBadge == true end)
        pcall(function() premium = player.MembershipType == Enum.MembershipType.Premium end)
        if player == LocalPlayer then
            local mode = Settings.OwnBadge
            if mode == 2 or mode == 4 then verified = true end
            if mode == 3 or mode == 4 then premium = true end
        end
        local nyxora = Presence.Users[player.UserId] == true
        if player == LocalPlayer and Settings.PresenceOn and Settings.PresenceShare then nyxora = true end
        return verified, premium, nyxora
    end

    local function paintBadges(row, player)
        for _, child in ipairs(row.Badges:GetChildren()) do
            if child:IsA("GuiObject") then child:Destroy() end
        end
        local verified, premium, nyxora = badgesFor(player)
        if verified then DrawVerified(row.Badges, 1) end
        if premium then DrawPremium(row.Badges, 2) end
        if nyxora then DrawNyxora(row.Badges, 3) end
        row.Nyxora = nyxora
    end

    local function resort()
        local list = {}
        for player in pairs(rows) do list[#list + 1] = player end
        table.sort(list, function(a, b)
            if a == LocalPlayer then return true end
            if b == LocalPlayer then return false end
            local an, bn = rows[a].Nyxora == true, rows[b].Nyxora == true
            if an ~= bn then return an end
            return a.DisplayName:lower() < b.DisplayName:lower()
        end)
        for i, player in ipairs(list) do
            rows[player].Frame.LayoutOrder = i
        end
        countLabel.Text = string.format("%d / %d", #list, Players.MaxPlayers)
    end

    local function addRow(player)
        if rows[player] or not scroll then return end
        local me = player == LocalPlayer
        local frame = Create("Frame", {
            Name = "Row", Size = UDim2.new(1, 0, 0, 42), BorderSizePixel = 0,
            BackgroundColor3 = me and THEME.GlassOn or THEME.Glass, Parent = scroll,
        }, { Corner(UDim.new(0, 10)) })

        local avatar = Create("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 7, 0.5, 0),
            Size = UDim2.fromOffset(30, 30), BorderSizePixel = 0, BackgroundColor3 = THEME.GlassDeep,
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=48&h=48", Parent = frame,
        }, { Corner(UDim.new(1, 0)) })
        if me then
            local ring = Create("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), Parent = avatar })
            Create("UIGradient", { Rotation = 45, Color = ColorSequence.new(THEME.AccentSoft, THEME.SwitchOn), Parent = ring })
        end

        local line = Create("Frame", {
            Position = UDim2.fromOffset(45, 6), Size = UDim2.new(1, -95, 0, 17),
            BackgroundTransparency = 1, ClipsDescendants = true, Parent = frame,
        }, {
            Create("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4),
            }),
        })
        Create("TextLabel", {
            LayoutOrder = 0, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X, FontFace = F.SemiBold, TextSize = 13,
            TextColor3 = THEME.Text, Text = player.DisplayName, Parent = line,
        })
        local badges = Create("Frame", {
            LayoutOrder = 1, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X, Parent = line,
        }, {
            Create("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3),
            }),
        })

        Create("TextLabel", {
            Position = UDim2.fromOffset(45, 23), Size = UDim2.new(1, -95, 0, 14), BackgroundTransparency = 1,
            FontFace = F.Regular, TextSize = 11, TextColor3 = THEME.Muted,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            Text = "@" .. player.Name, Parent = frame,
        })

        if me then
            Create("TextLabel", {
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(0, 20), AutomaticSize = Enum.AutomaticSize.X, BorderSizePixel = 0,
                BackgroundColor3 = THEME.GlassDeep, FontFace = F.Bold, TextSize = 11,
                TextColor3 = THEME.AccentSoft, Text = T("pl_you"), Parent = frame,
            }, {
                Corner(UDim.new(1, 0)),
                Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }),
            })
        end

        rows[player] = { Frame = frame, Badges = badges }
        paintBadges(rows[player], player)
    end

    local function removeRow(player)
        local row = rows[player]
        if row then
            row.Frame:Destroy()
            rows[player] = nil
        end
    end

    function M.Refresh()
        if not maid then return end
        for player, row in pairs(rows) do paintBadges(row, player) end
        resort()
    end

    local function setShown(state)
        shown = state
        if not panel then return end
        Tween(panel, TI.Medium, {
            Position = state and UDim2.new(1, -14, 0, 14) or UDim2.new(1, 300, 0, 14),
        })
    end

    local function presenceLoop(token)
        local warned = false
        while maid and maid.Token == token do
            if Settings.PresenceOn then
                if not HttpRequest() then
                    if not warned then
                        warned = true
                        Notify.Error(T("n_nohttp"), "NX-401", T("n_net"), 5)
                    end
                elseif Trim(Settings.PresenceUrl) ~= "" then
                    local data = PresenceCall("/presence", Settings.PresenceShare)
                    if maid == nil or maid.Token ~= token then break end
                    if data and type(data.users) == "table" then
                        warned = false
                        table.clear(Presence.Users)
                        for _, id in ipairs(data.users) do
                            local n = tonumber(id)
                            if n then Presence.Users[n] = true end
                        end
                        Presence.Changed:Fire()
                    elseif not warned then
                        warned = true
                        Notify.Error(T("n_server"), "NX-402", T("n_net"), 4)
                    end
                end
            elseif next(Presence.Users) then
                table.clear(Presence.Users)
                Presence.Changed:Fire()
            end
            for _ = 1, 30 do
                if not maid or maid.Token ~= token or Presence.Poke then break end
                task.wait(1)
            end
            Presence.Poke = false
        end
    end

    function M.Enable()
        if maid then return end
        maid = Maid.new()
        maid.Token = {}
        shown = true

        panel = maid:Give(Create("Frame", {
            Name = "PlayerList", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 300, 0, 14),
            Size = UDim2.fromOffset(270, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0, BackgroundColor3 = THEME.Background, ZIndex = 8, Parent = ScreenGui,
        }, {
            Corner(UDim.new(0, 14)),
            Create("UIPadding", {
                PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
            }),
            Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) }),
        }))
        local stroke = Create("UIStroke", { Thickness = 1.2, Transparency = 0.15, Color = Color3.new(1, 1, 1), Parent = panel })
        Create("UIGradient", { Rotation = 45, Color = ColorSequence.new(THEME.AccentSoft, THEME.Stroke), Parent = stroke })

        local head = Create("Frame", {
            LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Parent = panel,
        }, { Create("UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }) })
        Create("TextLabel", {
            BackgroundTransparency = 1, Size = UDim2.new(0.6, 0, 1, 0), FontFace = F.Bold, TextSize = 14,
            TextColor3 = THEME.Text, TextXAlignment = Enum.TextXAlignment.Left, Text = T("pl_title"), Parent = head,
        })
        countLabel = Create("TextLabel", {
            AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), BackgroundTransparency = 1,
            Size = UDim2.new(0.4, 0, 1, 0), FontFace = F.SemiBold, TextSize = 12, TextColor3 = THEME.AccentSoft,
            TextXAlignment = Enum.TextXAlignment.Right, Text = "", Parent = head,
        })

        scroll = Create("ScrollingFrame", {
            LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
            CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
            ScrollBarImageColor3 = THEME.Accent, ScrollingDirection = Enum.ScrollingDirection.Y, Parent = panel,
        })
        local layout = Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = scroll })
        local function fit()
            local cam = GetCamera()
            local maxH = cam and cam.ViewportSize.Y * 0.6 or 360
            scroll.Size = UDim2.new(1, 0, 0, math.min(layout.AbsoluteContentSize.Y, maxH))
        end
        maid:Give(layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(fit))

        for _, player in ipairs(Players:GetPlayers()) do addRow(player) end
        resort()
        fit()
        maid:Give(Players.PlayerAdded:Connect(function(player) addRow(player); resort() end))
        maid:Give(Players.PlayerRemoving:Connect(function(player) removeRow(player); resort() end))
        maid:Give(Presence.Changed.Event:Connect(M.Refresh))
        maid:Give(UserInputService.InputBegan:Connect(function(input, processed)
            if processed or input.KeyCode ~= Enum.KeyCode.Tab then return end
            setShown(not shown)
        end))

        task.spawn(setCore, false)
        maid:Give(function()
            task.spawn(setCore, true)
        end)
        maid:Give(function()
            table.clear(rows)
            scroll, countLabel, panel = nil, nil, nil
            if next(Presence.Users) then
                table.clear(Presence.Users)
            end
            if Settings.PresenceOn and Trim(Settings.PresenceUrl) ~= "" then
                task.spawn(PresenceCall, "/leave", false)
            end
        end)

        setShown(true)
        task.spawn(presenceLoop, maid.Token)
    end

    function M.Disable()
        if maid then
            local m = maid
            maid = nil
            m:Clean()
        end
    end

    function M.Poke()
        Presence.Poke = true
        M.Refresh()
    end
    return M
end)()

local ActiveHooks = {}

local function ActiveCount()
    local n = 0
    for _, feature in pairs(Features) do
        if feature.Enabled then n += 1 end
    end
    return n
end

local function FireActive()
    local n = ActiveCount()
    for _, fn in ipairs(ActiveHooks) do pcall(fn, n) end
end

local function RefreshModule(id, ...)
    local module, feature = Modules[id], Features[id]
    if module and module.Refresh and feature and feature.Enabled then
        local ok, err = pcall(module.Refresh, ...)
        if not ok then warn("[Nyxora] " .. id .. ": " .. tostring(err)) end
    end
end

local function SetFeature(id, enabled, silent)
    local feature = Features[id]
    local module = Modules[id]
    if not feature or not module or feature.Enabled == enabled then return false end

    local ok, err = pcall(enabled and module.Enable or module.Disable)
    if not ok then
        warn("[Nyxora] " .. id .. ": " .. tostring(err))
        if enabled then pcall(module.Disable) end
        if feature.UI then feature.UI.Set(feature.Enabled) end
        Notify.Error(string.format(T(enabled and "n_fail_on" or "n_fail_off"), T(feature.Name)), "NX-101", T("n_module"))
        return false
    end

    feature.Enabled = enabled
    Settings.Enabled[id] = enabled or nil
    Config.Save()
    if feature.UI then feature.UI.Set(enabled) end
    FireActive()

    if not silent then
        Notify.Info(string.format(T(enabled and "n_on" or "n_off"), T(feature.Name)), T(feature.Section), 3)
    end
    return true
end

local function DisableAll()
    for id, feature in pairs(Features) do
        if feature.Enabled then SetFeature(id, false, true) end
    end
    Notify.Info(T("n_all_off"), T("n_system"))
end

local Menu = { IsOpen = false, Locked = false }
local Binding = false
local lastDrag = 0

local function PointInside(gui, point)
    local pos, size = gui.AbsolutePosition, gui.AbsoluteSize
    return point.X >= pos.X and point.X <= pos.X + size.X and point.Y >= pos.Y and point.Y <= pos.Y + size.Y
end

local function Gradient(parent, rotation, keyA, keyB)
    local g = Create("UIGradient", { Rotation = rotation or 0, Parent = parent })
    local function paint()
        g.Color = ColorSequence.new(THEME[keyA], THEME[keyB])
    end
    paint()
    OnTheme(paint)
    return g
end

local function MakeIcon(kind, parent)
    local holder = Create("Frame", {
        Name = "Icon", Size = UDim2.fromOffset(18, 18), BackgroundTransparency = 1, Parent = parent,
    })
    local fills, strokes = {}, {}
    local function fill(props, round)
        props.BorderSizePixel = 0
        props.Parent = holder
        props.AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5)
        local f = Create("Frame", props, { Corner(round or UDim.new(1, 0)) })
        fills[#fills + 1] = f
        return f
    end
    local function ring(size, pos, thickness, round)
        local f = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = pos, Size = size,
            BackgroundTransparency = 1, Parent = holder,
        }, { Corner(round or UDim.new(1, 0)) })
        strokes[#strokes + 1] = Create("UIStroke", { Thickness = thickness or 1.6, Parent = f })
        return f
    end

    if kind == "player" then
        fill({ Position = UDim2.fromOffset(9, 5), Size = UDim2.fromOffset(7, 7) })
        fill({ Position = UDim2.fromOffset(9, 14), Size = UDim2.fromOffset(13, 7) }, UDim.new(0, 4))
    elseif kind == "world" then
        ring(UDim2.fromOffset(15, 15), UDim2.fromOffset(9, 9), 1.6)
        ring(UDim2.fromOffset(6, 15), UDim2.fromOffset(9, 9), 1.4)
        fill({ Position = UDim2.fromOffset(9, 9), Size = UDim2.fromOffset(15, 1.6) })
    elseif kind == "graphics" then
        fill({ Position = UDim2.fromOffset(8, 10), Size = UDim2.fromOffset(9, 9), Rotation = 45 }, UDim.new(0, 2))
        fill({ Position = UDim2.fromOffset(15, 4), Size = UDim2.fromOffset(4, 4), Rotation = 45 }, UDim.new(0, 1))
        fill({ Position = UDim2.fromOffset(15, 15), Size = UDim2.fromOffset(3, 3), Rotation = 45 }, UDim.new(0, 1))
    elseif kind == "camera" then
        ring(UDim2.fromOffset(16, 11), UDim2.fromOffset(9, 10), 1.6, UDim.new(0, 3))
        fill({ Position = UDim2.fromOffset(9, 10), Size = UDim2.fromOffset(5, 5) })
        fill({ Position = UDim2.fromOffset(6, 3.5), Size = UDim2.fromOffset(5, 3) }, UDim.new(0, 1))
    else
        ring(UDim2.fromOffset(11, 11), UDim2.fromOffset(9, 9), 2)
        fill({ Position = UDim2.fromOffset(9, 9), Size = UDim2.fromOffset(4, 4) })
        for i = 0, 3 do
            local angle = i * math.pi / 2
            fill({
                Position = UDim2.fromOffset(9 + math.cos(angle) * 7.5, 9 + math.sin(angle) * 7.5),
                Size = UDim2.fromOffset(3, 3), Rotation = math.deg(angle),
            }, UDim.new(0, 1))
        end
    end

    return holder, function(color, info)
        for _, f in ipairs(fills) do Tween(f, info or TI.Fast, { BackgroundColor3 = color }) end
        for _, s in ipairs(strokes) do Tween(s, info or TI.Fast, { Color = color }) end
    end
end

local Window = Create("Frame", {
    Name = "Window", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
    Visible = false, ZIndex = 1, Parent = ScreenGui,
})

local Dim = Create("TextButton", {
    Name = "Dim", Text = "", AutoButtonColor = false,
    BackgroundColor3 = Color3.fromRGB(4, 3, 8), BackgroundTransparency = 1,
    BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Parent = Window,
})

local MenuBlur = Root:Give(Create("BlurEffect", { Name = "VX_MenuBlur", Size = 0, Enabled = false, Parent = Lighting }))

local MainFrame = Create("Frame", {
    Name = "MainFrame", AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.MenuWidth, CONFIG.MenuHeight),
    BackgroundTransparency = 1, Active = true, Parent = Window,
})

local MainScale = Create("UIScale", { Scale = 0.94, Parent = MainFrame })

local Shadow = Create("CanvasGroup", {
    Name = "Shadow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 10),
    Size = UDim2.new(1, 90, 1, 90), BackgroundTransparency = 1, GroupTransparency = 1, Parent = MainFrame,
})
for i = 1, 6 do
    Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -90 + i * 13, 1, -90 + i * 13), BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.84 + i * 0.022,
        Parent = Shadow,
    }, { Corner(UDim.new(0, 18 + i * 5)) })
end

local Body = Create("CanvasGroup", {
    Name = "Body", Size = UDim2.fromScale(1, 1), BorderSizePixel = 0,
    GroupTransparency = 1, Active = true, Parent = MainFrame,
}, { Corner(UDim.new(0, 18)) })
Th(Body, { BackgroundColor3 = "Background" })

do
    local glowA = Th(Create("Frame", {
        Name = "GlowA", Size = UDim2.fromScale(0.75, 0.7), BorderSizePixel = 0, Parent = Body,
    }, {
        Create("UIGradient", {
            Rotation = 35,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.72), NumberSequenceKeypoint.new(0.55, 0.95), NumberSequenceKeypoint.new(1, 1),
            }),
        }),
    }), { BackgroundColor3 = "Accent" })
    glowA.ZIndex = 0
    local glowB = Th(Create("Frame", {
        Name = "GlowB", AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1),
        Size = UDim2.fromScale(0.7, 0.7), BorderSizePixel = 0, Parent = Body,
    }, {
        Create("UIGradient", {
            Rotation = -145,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.82), NumberSequenceKeypoint.new(0.6, 0.97), NumberSequenceKeypoint.new(1, 1),
            }),
        }),
    }), { BackgroundColor3 = "SwitchOn" })
    glowB.ZIndex = 0
end

local Outline = Create("Frame", {
    Name = "Outline", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
    ZIndex = 5, Parent = MainFrame,
}, { Corner(UDim.new(0, 18)) })
local OutlineStroke = Create("UIStroke", { Thickness = 1.2, Transparency = 1, Color = Color3.new(1, 1, 1), Parent = Outline })
Gradient(OutlineStroke, 45, "AccentSoft", "Stroke")

local Header = Create("Frame", {
    Name = "Header", BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 72), Active = true, Parent = Body,
})

MakeLogo(Header, 0, 36).Position = UDim2.fromOffset(20, 18)

do
    local title = Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(66, 14),
        Size = UDim2.new(0, 200, 0, 26), FontFace = F.Black, TextSize = 23,
        TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Color3.new(1, 1, 1),
        Text = string.upper(CONFIG.MenuTitle), Parent = Header,
    })
    Gradient(title, 0, "Text", "AccentSoft")

    local pill = Create("Frame", {
        Position = UDim2.fromOffset(66, 43), Size = UDim2.fromOffset(0, 18),
        AutomaticSize = Enum.AutomaticSize.X, BorderSizePixel = 0, Parent = Header,
    }, {
        Corner(UDim.new(1, 0)),
        Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 9) }),
        Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6),
        }),
    })
    Th(pill, { BackgroundColor3 = "GlassDeep" })
    Th(Create("Frame", {
        LayoutOrder = 1, Size = UDim2.fromOffset(6, 6), BorderSizePixel = 0, Parent = pill,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "SwitchOn" })
    Th(Create("TextLabel", {
        LayoutOrder = 2, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X, FontFace = F.SemiBold, TextSize = 11,
        Text = CONFIG.Credit, Parent = pill,
    }), { TextColor3 = "AccentSoft" })
end

local SearchBox
do
    local box = Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -62, 0, 36),
        Size = UDim2.fromOffset(210, 36), BorderSizePixel = 0, Parent = Header,
    }, { Corner(UDim.new(0, 10)) })
    Th(box, { BackgroundColor3 = "GlassDeep" })
    local stroke = Th(Create("UIStroke", { Thickness = 1, Transparency = 0.5, Parent = box }), { Color = "Stroke" })
    local lens = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(19, 17),
        Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, Parent = box,
    }, { Corner(UDim.new(1, 0)) })
    Th(Create("UIStroke", { Thickness = 1.6, Parent = lens }), { Color = "Muted" })
    Th(Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(25, 23),
        Size = UDim2.fromOffset(5, 1.8), Rotation = 45, BorderSizePixel = 0, Parent = box,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "Muted" })
    SearchBox = Create("TextBox", {
        Position = UDim2.fromOffset(36, 0), Size = UDim2.new(1, -46, 1, 0), BackgroundTransparency = 1,
        ClearTextOnFocus = false, FontFace = F.Medium, TextSize = 13, Text = "",
        TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true, Parent = box,
    })
    Loc(SearchBox, "search", "PlaceholderText")
    Th(SearchBox, { TextColor3 = "Text", PlaceholderColor3 = "Muted" })
    SearchBox.Focused:Connect(function()
        Tween(stroke, TI.Fast, { Color = THEME.Accent, Transparency = 0 })
    end)
    SearchBox.FocusLost:Connect(function()
        Tween(stroke, TI.Fast, { Color = THEME.Stroke, Transparency = 0.5 })
    end)
end

local CloseBtn = Create("TextButton", {
    Name = "CloseBtn", AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -16, 0, 36), Size = UDim2.fromOffset(36, 36),
    BorderSizePixel = 0, BackgroundTransparency = 0, AutoButtonColor = false,
    Text = "", ZIndex = 3, Parent = Header,
}, { Corner(UDim.new(0, 10)) })
Th(CloseBtn, { BackgroundColor3 = "GlassDeep" })
local CloseBars = {}
for _, rot in ipairs({ 45, -45 }) do
    CloseBars[#CloseBars + 1] = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(14, 2), Rotation = rot, BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, Parent = CloseBtn,
    }, { Corner(UDim.new(1, 0)) })
end
CloseBtn.MouseEnter:Connect(function()
    Tween(CloseBtn, TI.Fast, { BackgroundColor3 = THEME.Error })
end)
CloseBtn.MouseLeave:Connect(function()
    Tween(CloseBtn, TI.Fast, { BackgroundColor3 = THEME.GlassDeep })
end)

do
    local line = Create("Frame", {
        Position = UDim2.fromOffset(0, 72), Size = UDim2.new(1, 0, 0, 1),
        BorderSizePixel = 0, Parent = Body,
    }, {
        Create("UIGradient", {
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.45),
                NumberSequenceKeypoint.new(0.7, 0.45), NumberSequenceKeypoint.new(1, 1),
            }),
        }),
    })
    Th(line, { BackgroundColor3 = "Stroke" })
end

local Sidebar = Create("Frame", {
    Name = "Sidebar", Position = UDim2.fromOffset(14, 86),
    Size = UDim2.new(0, 170, 1, -100), BorderSizePixel = 0, Parent = Body,
}, { Corner(UDim.new(0, 14)) })
Th(Sidebar, { BackgroundColor3 = "GlassDeep" })
Th(Create("UIStroke", { Thickness = 1, Transparency = 0.6, Parent = Sidebar }), { Color = "Stroke" })

local TabList = Create("Frame", {
    Name = "Tabs", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -64), Parent = Sidebar,
}, {
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
    }),
    Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4) }),
})

do
    local footer = Create("Frame", {
        Name = "Footer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 8, 1, -8),
        Size = UDim2.new(1, -16, 0, 50), BorderSizePixel = 0, Parent = Sidebar,
    }, { Corner(UDim.new(0, 12)) })
    Th(footer, { BackgroundColor3 = "Glass" })

    local avatar = Create("ImageLabel", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0),
        Size = UDim2.fromOffset(34, 34), BorderSizePixel = 0, Image = "", Parent = footer,
    }, { Corner(UDim.new(1, 0)) })
    Th(avatar, { BackgroundColor3 = "GlassDeep" })
    local avatarRing = Create("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), Parent = avatar })
    Gradient(avatarRing, 45, "AccentSoft", "SwitchOn")
    task.spawn(function()
        local ok, image = pcall(function()
            return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and image and avatar.Parent then avatar.Image = image end
    end)

    Th(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(50, 8),
        Size = UDim2.new(1, -56, 0, 16), FontFace = F.SemiBold, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Text = CONFIG.UseDisplayName and LocalPlayer.DisplayName or LocalPlayer.Name, Parent = footer,
    }), { TextColor3 = "Text" })

    local dot = Th(Create("Frame", {
        Position = UDim2.fromOffset(50, 31), Size = UDim2.fromOffset(6, 6),
        BorderSizePixel = 0, Parent = footer,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "SwitchOn" })
    local activeLabel = Th(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(61, 26),
        Size = UDim2.new(1, -66, 0, 16), FontFace = F.Medium, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, Text = "", Parent = footer,
    }), { TextColor3 = "AccentSoft" })
    local function render(n)
        n = n or ActiveCount()
        activeLabel.Text = string.format(T("active"), n)
        dot.BackgroundTransparency = n > 0 and 0 or 0.7
    end
    render(0)
    ActiveHooks[#ActiveHooks + 1] = render
    OnLang(function() render() end)
end

local TABS = { "tab_player", "tab_world", "tab_graphics", "tab_camera", "tab_settings" }
local TAB_ICONS = { "player", "world", "graphics", "camera", "settings" }
local TAB_SUBTITLES = { "pg_player", "pg_world", "pg_graphics", "pg_camera", "pg_settings" }
local TabButtons = {}
local TabFrames = {}
local PageEmpty = {}
local CurrentTab = 0

local function PaintTabs(instant)
    local info = instant and TI.Instant or TI.Fast
    for i, tab in ipairs(TabButtons) do
        local active = i == CurrentTab
        Tween(tab.Pill, info, { BackgroundTransparency = active and 0.72 or (tab.Hover and 0.9 or 1) })
        Tween(tab.Bar, info, { Size = UDim2.fromOffset(3, active and 20 or 0) })
        Tween(tab.Label, info, { TextColor3 = active and THEME.Text or THEME.Muted })
        tab.PaintIcon(active and THEME.AccentSoft or THEME.Muted, info)
    end
end
OnTheme(PaintTabs)

for i, tabKey in ipairs(TABS) do
    local btn = Create("TextButton", {
        Name = tabKey, LayoutOrder = i, Size = UDim2.new(1, 0, 0, 42),
        BorderSizePixel = 0, BackgroundTransparency = 1,
        AutoButtonColor = false, Text = "", Parent = TabList,
    })
    local pill = Create("Frame", {
        Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = btn,
    }, { Corner(UDim.new(0, 10)) })
    Gradient(pill, 0, "Accent", "SwitchOn")

    local bar = Th(Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(3, 0), BorderSizePixel = 0, ZIndex = 2, Parent = btn,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "AccentSoft" })

    local icon, paintIcon = MakeIcon(TAB_ICONS[i], btn)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Position = UDim2.new(0, 14, 0.5, 0)
    icon.ZIndex = 2

    local label = Loc(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(42, 0),
        Size = UDim2.new(1, -46, 1, 0), FontFace = F.SemiBold, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = THEME.Muted, ZIndex = 2, Parent = btn,
    }), tabKey)

    local tab = { Button = btn, Pill = pill, Bar = bar, Label = label, PaintIcon = paintIcon, Hover = false }
    TabButtons[i] = tab
    btn.MouseEnter:Connect(function() tab.Hover = true; PaintTabs() end)
    btn.MouseLeave:Connect(function() tab.Hover = false; PaintTabs() end)
end

local ContentArea = Create("Frame", {
    Name = "Content", Position = UDim2.fromOffset(198, 86),
    Size = UDim2.new(1, -212, 1, -100), BackgroundTransparency = 1,
    ClipsDescendants = true, Parent = Body,
})

for i = 1, #TABS do
    local page = Create("ScrollingFrame", {
        Name = "Tab_" .. i, Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarThickness = 3, ScrollBarImageTransparency = 0.3,
        Visible = false, Parent = ContentArea,
    }, {
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 7) }),
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 1), PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 1), PaddingRight = UDim.new(0, 10),
        }),
    })
    Th(page, { ScrollBarImageColor3 = "Accent" })
    TabFrames[i] = page

    local head = Create("Frame", {
        Name = "PageHeader", LayoutOrder = 0, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 46), Parent = page,
    })
    Th(Loc(Create("TextLabel", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), FontFace = F.Bold, TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = head,
    }), TABS[i]), { TextColor3 = "Text" })
    Th(Loc(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 27), Size = UDim2.new(1, 0, 0, 16),
        FontFace = F.Medium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = head,
    }), TAB_SUBTITLES[i]), { TextColor3 = "Muted" })

    PageEmpty[i] = Th(Loc(Create("TextLabel", {
        Name = "Empty", LayoutOrder = 100000, BackgroundTransparency = 1, Visible = false,
        Size = UDim2.new(1, 0, 0, 60), FontFace = F.Medium, TextSize = 13, Parent = page,
    }), "none_found"), { TextColor3 = "Muted" })
end

local function SelectTab(index)
    if index == CurrentTab then return end
    CurrentTab = index
    for i, page in ipairs(TabFrames) do
        if i == index then
            page.Visible = true
            page.Position = UDim2.fromOffset(0, 14)
            Tween(page, TI.Medium, { Position = UDim2.fromOffset(0, 0) })
        else
            page.Visible = false
        end
    end
    PaintTabs()
end

for i, tab in ipairs(TabButtons) do
    tab.Button.MouseButton1Click:Connect(function() SelectTab(i) end)
end

local function ApplySearch()
    local q = Trim(SearchBox.Text):lower()
    local firstHit
    for ti, page in ipairs(TabFrames) do
        local hits = 0
        for _, child in ipairs(page:GetChildren()) do
            local kind = child:GetAttribute("Kind")
            if kind == "Section" then
                child.Visible = q == ""
            elseif kind == "Item" then
                local key = child:GetAttribute("SearchKey")
                local match = q == "" or (key ~= nil and T(key):lower():find(q, 1, true) ~= nil)
                child.Visible = match
                if match and q ~= "" then hits += 1 end
            end
        end
        PageEmpty[ti].Visible = q ~= "" and hits == 0
        if hits > 0 and not firstHit then firstHit = ti end
    end
    if q ~= "" and firstHit and PageEmpty[CurrentTab].Visible then
        SelectTab(firstHit)
    end
end
SearchBox:GetPropertyChangedSignal("Text"):Connect(ApplySearch)
OnLang(ApplySearch)

do
    local dragging = false
    local dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        if PointInside(SearchBox.Parent, input.Position) or PointInside(CloseBtn, input.Position) then
            return
        end
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        local conn
        conn = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                lastDrag = os.clock()
                conn:Disconnect()
            end
        end)
    end)
    Root:Give(UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        local delta = input.Position - dragStart
        if delta.Magnitude > 2 then lastDrag = os.clock() end
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end))
end

local Orders = {}

local function TargetOf(target)
    if type(target) == "number" then return TabFrames[target] end
    return target
end

local function NextOrder(target)
    local parent = TargetOf(target)
    Orders[parent] = (Orders[parent] or 0) + 1
    return Orders[parent], parent
end

local function Tag(inst, target, key)
    if type(target) == "number" then
        inst:SetAttribute("Kind", "Item")
        inst:SetAttribute("SearchKey", key)
    end
end

local function NewRow(target, className, height)
    local order, parent = NextOrder(target)
    local row = Create(className, {
        Name = "Row", LayoutOrder = order, Size = UDim2.new(1, 0, 0, height),
        BorderSizePixel = 0, Parent = parent,
    }, { Corner(UDim.new(0, 12)) })
    if className == "TextButton" then
        row.Text = ""
        row.AutoButtonColor = false
    end
    Th(row, { BackgroundColor3 = "Glass" })

    local stroke = Create("UIStroke", {
        Color = THEME.Stroke, Thickness = 1, Transparency = 0.6,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = row,
    })
    local hovered = false
    row.MouseEnter:Connect(function()
        hovered = true
        Tween(stroke, TI.Fast, { Color = THEME.Accent, Transparency = 0.1 })
    end)
    row.MouseLeave:Connect(function()
        hovered = false
        Tween(stroke, TI.Fast, { Color = THEME.Stroke, Transparency = 0.6 })
    end)
    OnTheme(function()
        Tween(stroke, TI.Medium, { Color = hovered and THEME.Accent or THEME.Stroke })
    end)
    return row
end

local function RowText(row, nameKey, descKey, rightInset, leftInset)
    leftInset = leftInset or 16
    local hasDesc = descKey ~= nil and descKey ~= ""
    Th(Loc(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(leftInset, hasDesc and 9 or 0),
        Size = UDim2.new(1, -(leftInset + rightInset), 0, hasDesc and 18 or row.Size.Y.Offset),
        FontFace = F.SemiBold, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = row,
    }), nameKey), { TextColor3 = "Text" })
    if hasDesc then
        Th(Loc(Create("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.fromOffset(leftInset, 28),
            Size = UDim2.new(1, -(leftInset + rightInset), 0, 14),
            FontFace = F.Regular, TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = row,
        }), descKey), { TextColor3 = "Muted" })
    end
end

local function AddSection(target, key)
    local order, parent = NextOrder(target)
    local holder = Create("Frame", {
        Name = "Section", LayoutOrder = order, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 26), Parent = parent,
    })
    holder:SetAttribute("Kind", type(target) == "number" and "Section" or nil)
    Gradient(Create("Frame", {
        AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 2, 1, -4),
        Size = UDim2.fromOffset(3, 11), BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = holder,
    }, { Corner(UDim.new(1, 0)) }), 90, "AccentSoft", "SwitchOn")
    Th(Loc(Create("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -12, 1, -2),
        FontFace = F.Bold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
        Parent = holder,
    }), key), { TextColor3 = "Muted" })
end

local function MakeGroup(target)
    local order, parent = NextOrder(target)
    return Create("Frame", {
        Name = "Group", LayoutOrder = order, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = parent,
    }, {
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0) }),
    })
end

local function MakeDrawer(group)
    local order = NextOrder(group)
    local clip = Create("Frame", {
        Name = "Drawer", LayoutOrder = order, BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0), ClipsDescendants = true, Parent = group,
    })
    local inner = Create("Frame", {
        Name = "Inner", BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = clip,
    }, {
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) }),
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 1),
        }),
    })
    Gradient(Create("Frame", {
        Name = "Guide", Position = UDim2.fromOffset(7, 10), Size = UDim2.new(0, 2, 1, -14),
        BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.3, Parent = clip,
    }, { Corner(UDim.new(1, 0)) }), 90, "Accent", "Stroke")

    local drawer = { Open = false, Inner = inner }
    function drawer.Set(open, instant)
        drawer.Open = open
        local h = open and inner.AbsoluteSize.Y or 0
        Tween(clip, instant and TI.Instant or TI.Medium, { Size = UDim2.new(1, 0, 0, h) })
    end
    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        if drawer.Open then
            clip.Size = UDim2.new(1, 0, 0, inner.AbsoluteSize.Y)
        end
    end)
    return drawer
end

local function DotsButton(row, onClick)
    local btn = Create("TextButton", {
        Name = "Dots", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -66, 0.5, 0),
        Size = UDim2.fromOffset(30, 30), BackgroundTransparency = 1, BorderSizePixel = 0,
        AutoButtonColor = false, Text = "", ZIndex = 3, Parent = row,
    })
    local holder = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(18, 4), BackgroundTransparency = 1, ZIndex = 3, Parent = btn,
    })
    local dots = {}
    for i = 0, 2 do
        dots[#dots + 1] = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, (i - 1) * 6, 0.5, 0),
            Size = UDim2.fromOffset(4, 4), BorderSizePixel = 0, BackgroundColor3 = THEME.Muted,
            ZIndex = 3, Parent = holder,
        }, { Corner(UDim.new(1, 0)) })
    end
    local open, hovered = false, false
    local function paint()
        Tween(holder, TI.Medium, { Rotation = open and 90 or 0 })
        local color = open and THEME.AccentSoft or (hovered and THEME.Text or THEME.Muted)
        for _, d in ipairs(dots) do
            Tween(d, TI.Fast, { BackgroundColor3 = color })
        end
    end
    OnTheme(paint)
    btn.MouseEnter:Connect(function() hovered = true; paint() end)
    btn.MouseLeave:Connect(function() hovered = false; paint() end)
    btn.MouseButton1Click:Connect(function()
        onClick(not open)
    end)
    return function(state)
        open = state
        paint()
    end
end

local function SwitchVisual(parent, position)
    local track = Create("Frame", {
        Name = "Switch", AnchorPoint = Vector2.new(1, 0.5), Position = position,
        Size = UDim2.fromOffset(44, 24), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = parent,
    }, { Corner(UDim.new(1, 0)) })
    local gradient = Create("UIGradient", { Rotation = 0, Parent = track })
    local knob = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.fromOffset(18, 18), BackgroundColor3 = THEME.Knob,
        BorderSizePixel = 0, Parent = track,
    }, {
        Corner(UDim.new(1, 0)),
        Create("UIStroke", { Color = Color3.new(0, 0, 0), Transparency = 0.75, Thickness = 1 }),
    })
    return function(state, instant)
        local info = instant and TI.Instant or TI.Fast
        Tween(knob, info, { Position = state and UDim2.new(0, 23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0) })
        if state then
            gradient.Color = ColorSequence.new(THEME.AccentSoft, THEME.SwitchOn)
        else
            gradient.Color = ColorSequence.new(THEME.SwitchOff, THEME.SwitchOff)
        end
    end
end

local function AddSwitch(target, nameKey, descKey, get, set, withMenu, isFeature)
    local group, drawer
    local rowTarget = target
    if withMenu then
        group = MakeGroup(target)
        rowTarget = group
        Tag(group, target, nameKey)
    end

    local row = NewRow(rowTarget, "TextButton", descKey and 54 or 46)
    if not withMenu then Tag(row, target, nameKey) end
    RowText(row, nameKey, descKey, withMenu and 108 or 74, isFeature and 32 or 16)

    local status
    if isFeature then
        status = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 18, 0.5, 0),
            Size = UDim2.fromOffset(8, 8), BorderSizePixel = 0, Parent = row,
        }, { Corner(UDim.new(1, 0)) })
        Create("UIStroke", { Thickness = 3, Transparency = 1, Parent = status })
    end

    local paintSwitch = SwitchVisual(row, UDim2.new(1, -14, 0.5, 0))

    local function paint(state, instant)
        local info = instant and TI.Instant or TI.Fast
        paintSwitch(state, instant)
        Tween(row, info, { BackgroundColor3 = state and THEME.GlassOn or THEME.Glass })
        if status then
            Tween(status, info, { BackgroundColor3 = state and THEME.AccentSoft or THEME.SwitchOff })
            Tween(status.UIStroke, info, { Color = THEME.SwitchOn, Transparency = state and 0.6 or 1 })
        end
    end

    paint(get(), true)
    OnTheme(function() paint(get()) end)

    row.MouseButton1Click:Connect(function()
        set(not get())
        paint(get())
    end)
    row.MouseButton2Click:Connect(function()
        if drawer then drawer.Set(not drawer.Open) end
    end)

    if withMenu then
        drawer = MakeDrawer(group)
        drawer.Set(false, true)
        local setDots = DotsButton(row, function(open) drawer.Set(open) end)
        local setDrawer = drawer.Set
        function drawer.Set(open, instant)
            setDrawer(open, instant)
            setDots(open)
        end
    end

    return function() paint(get()) end, drawer and drawer.Inner, paint
end

local function AddToggle(target, id, nameKey, descKey, withMenu)
    local section = type(target) == "number" and TABS[target] or "tab_settings"
    local feature = RegisterFeature(id, nameKey, section)
    local _, options, paint = AddSwitch(target, nameKey, descKey,
        function() return feature.Enabled end,
        function(value) SetFeature(id, value) end,
        withMenu, true)
    feature.UI = { Set = paint }
    return options
end

local function AddSettingSwitch(target, nameKey, descKey, key, after)
    return (AddSwitch(target, nameKey, descKey,
        function() return Settings[key] end,
        function(value)
            Settings[key] = value
            Config.Save()
            if after then pcall(after, value) end
        end))
end

local function AddSlider(target, nameKey, descKey, min, max, get, onChange, fmt)
    local row = NewRow(target, "Frame", descKey and 64 or 54)
    Tag(row, target, nameKey)
    local trackY = descKey and 48 or 38
    RowText(row, nameKey, descKey, 90)
    if not descKey then
        for _, child in ipairs(row:GetChildren()) do
            if child:IsA("TextLabel") then
                child.Size = UDim2.new(1, -106, 0, 18)
                child.Position = UDim2.fromOffset(16, 9)
            end
        end
    end

    local valueLabel = Th(Create("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 8),
        Size = UDim2.fromOffset(0, 20), AutomaticSize = Enum.AutomaticSize.X, BorderSizePixel = 0,
        FontFace = F.Bold, TextSize = 12, Text = "", Parent = row,
    }, {
        Corner(UDim.new(1, 0)),
        Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }),
    }), { TextColor3 = "AccentSoft", BackgroundColor3 = "GlassDeep" })

    local track = Th(Create("Frame", {
        Position = UDim2.fromOffset(16, trackY), Size = UDim2.new(1, -32, 0, 6),
        BorderSizePixel = 0, Parent = row,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "SwitchOff" })

    local fill = Create("Frame", {
        Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = track,
    }, { Corner(UDim.new(1, 0)) })
    Gradient(fill, 0, "SwitchOn", "AccentSoft")

    local knob = Th(Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(14, 14), BorderSizePixel = 0, ZIndex = 2, Parent = track,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "Knob" })
    local knobRing = Th(Create("UIStroke", { Thickness = 2, Transparency = 0.2, Parent = knob }), { Color = "SwitchOn" })

    local hit = Create("TextButton", {
        BackgroundTransparency = 1, Text = "",
        Position = UDim2.fromOffset(8, trackY - 12), Size = UDim2.new(1, -16, 0, 28),
        ZIndex = 3, Parent = row,
    })

    local current = get()
    local function setValue(v, fire)
        v = math.clamp(v, min, max)
        local alpha = (v - min) / (max - min)
        fill.Size = UDim2.fromScale(alpha, 1)
        knob.Position = UDim2.fromScale(alpha, 0.5)
        valueLabel.Text = fmt and fmt(v) or tostring(v)
        if fire and v ~= current then
            current = v
            pcall(onChange, v)
        end
    end
    setValue(current, false)

    local dragging = false
    local function fromX(x)
        local a = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
        setValue(math.floor(min + a * (max - min) + 0.5), true)
    end

    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Tween(knob, TI.Fast, { Size = UDim2.fromOffset(18, 18) })
            Tween(knobRing, TI.Fast, { Thickness = 4, Transparency = 0.5 })
            fromX(input.Position.X)
        end
    end)

    Root:Give(UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            fromX(input.Position.X)
        end
    end))

    Root:Give(UserInputService.InputEnded:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            Tween(knob, TI.Fast, { Size = UDim2.fromOffset(14, 14) })
            Tween(knobRing, TI.Fast, { Thickness = 2, Transparency = 0.2 })
            Config.Save()
        end
    end))

    return function()
        current = get()
        setValue(current, false)
    end
end

local function PillButton(row, width)
    local btn = Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(width or 148, 32), BorderSizePixel = 0, AutoButtonColor = false,
        FontFace = F.SemiBold, TextSize = 12, Text = "",
        TextTruncate = Enum.TextTruncate.AtEnd, Parent = row,
    }, { Corner(UDim.new(0, 9)) })
    Th(btn, { BackgroundColor3 = "GlassDeep", TextColor3 = "AccentSoft" })
    Th(Create("UIStroke", {
        Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = btn,
    }), { Color = "Stroke" })
    return btn
end

local function AddCycle(target, nameKey, descKey, options, get, onChange)
    local row = NewRow(target, "Frame", descKey and 54 or 48)
    Tag(row, target, nameKey)
    RowText(row, nameKey, descKey, 166)

    local btn = PillButton(row)
    local function render()
        btn.Text = "<   " .. T(options[get()]) .. "   >"
    end
    render()
    OnLang(render)

    local function step(dir)
        local nextIndex = (get() - 1 + dir) % #options + 1
        pcall(onChange, nextIndex)
        render()
        btn.BackgroundColor3 = THEME.SwitchOn
        Tween(btn, TI.Slow, { BackgroundColor3 = THEME.GlassDeep })
        Config.Save()
    end

    btn.MouseButton1Click:Connect(function() step(1) end)
    btn.MouseButton2Click:Connect(function() step(-1) end)
end

local function AddKeybind(target, nameKey, descKey, get, set)
    local row = NewRow(target, "Frame", 54)
    Tag(row, target, nameKey)
    RowText(row, nameKey, descKey, 166)

    local btn = PillButton(row)
    btn.FontFace = F.Bold
    btn.Text = get()

    btn.MouseButton1Click:Connect(function()
        if Binding then return end
        Binding = true
        btn.Text = T("key_press")
        Tween(btn, TI.Fast, { BackgroundColor3 = THEME.SwitchOn })
        local conn
        conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            conn:Disconnect()
            if input.KeyCode ~= Enum.KeyCode.Escape then
                set(input.KeyCode.Name)
                Config.Save()
            end
            btn.Text = get()
            Tween(btn, TI.Slow, { BackgroundColor3 = THEME.GlassDeep })
            task.defer(function() Binding = false end)
        end)
        Root:Give(conn)
    end)
end

local function AddInput(target, nameKey, descKey, placeholderKey, get, set)
    local row = NewRow(target, "Frame", 54)
    Tag(row, target, nameKey)
    RowText(row, nameKey, descKey, 206)

    local box = Create("TextBox", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(188, 32), BorderSizePixel = 0, ClearTextOnFocus = false,
        ClipsDescendants = true, FontFace = F.Medium, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Text = get(), Parent = row,
    }, {
        Corner(UDim.new(0, 9)),
        Create("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }),
    })
    Loc(box, placeholderKey or "", "PlaceholderText")
    Th(box, { BackgroundColor3 = "GlassDeep", TextColor3 = "Text", PlaceholderColor3 = "Muted" })

    local focusStroke = Th(Create("UIStroke", {
        Thickness = 1, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = box,
    }), { Color = "Stroke" })

    box.Focused:Connect(function()
        Tween(focusStroke, TI.Fast, { Color = THEME.Accent, Transparency = 0 })
    end)
    box.FocusLost:Connect(function()
        Tween(focusStroke, TI.Fast, { Color = THEME.Stroke, Transparency = 0.5 })
        local text = Trim(box.Text)
        box.Text = text
        if text ~= get() then
            set(text)
            Config.Save()
        end
    end)
end

local function NameList(list)
    local names = {}
    for _, item in ipairs(list) do names[#names + 1] = item.Name end
    return names
end

local function Pct(v) return v .. "%" end
local function Px(v) return v .. " px" end
local function Signed(v)
    local d = v - 50
    return (d > 0 and "+" or "") .. d
end
local LANGS = { "English", "Русский" }
local LANG_CODES = { "en", "ru" }

AddSection(1, "sec_character")
AddToggle(1, "Aura", "f_aura", "d_aura")
AddToggle(1, "OrbitAura", "f_orbit", "d_orbit")
AddToggle(1, "Trails", "f_trails", "d_trails")
do
    local o = AddToggle(1, "Chams", "f_chams", "d_chams", true)
    AddCycle(o, "o_mode", nil, CHAMS_MODES,
        function() return Settings.ChamsMode end,
        function(i) Settings.ChamsMode = i; RefreshModule("Chams") end)
end
do
    local o = AddToggle(1, "JumpCircles", "f_jump", "d_jump", true)
    AddCycle(o, "o_style", nil, JUMP_STYLES,
        function() return Settings.JumpStyle end,
        function(i) Settings.JumpStyle = i end)
end

AddSection(1, "sec_head")
do
    local o = AddToggle(1, "ChinaHat", "f_hat", "d_hat", true)
    AddSlider(o, "o_size", nil, 50, 200,
        function() return Settings.HatSize end,
        function(v) Settings.HatSize = v end, Pct)
end
AddToggle(1, "Headless", "f_headless", "d_headless")

AddSection(1, "sec_body")
do
    local o = AddToggle(1, "Wings", "f_wings", "d_wings", true)
    AddSlider(o, "o_size", nil, 50, 150,
        function() return Settings.WingScale end,
        function(v) Settings.WingScale = v end, Pct)
end
AddToggle(1, "Korblox", "f_korblox", "d_korblox")

AddSection(1, "sec_list")
do
    local o = AddToggle(1, "PlayerList", "f_plist", "d_plist", true)
    local function poke() Modules.PlayerList.Poke() end
    AddCycle(o, "o_badge", nil, BADGE_MODES,
        function() return Settings.OwnBadge end,
        function(i) Settings.OwnBadge = i; RefreshModule("PlayerList") end)
    AddSettingSwitch(o, "o_network", "o_network_d", "PresenceOn", poke)
    AddSettingSwitch(o, "o_share", "o_share_d", "PresenceShare", poke)
    AddInput(o, "o_server", nil, "ph_server",
        function() return Settings.PresenceUrl end,
        function(text) Settings.PresenceUrl = text; poke() end)
end

AddSection(2, "sec_weather")
AddToggle(2, "Snow", "f_snow", "d_snow")
do
    local o = AddToggle(2, "Rain", "f_rain", "d_rain", true)
    AddSlider(o, "o_amount", nil, 5, 100,
        function() return Settings.RainAmount end,
        function(v) Settings.RainAmount = v end, Pct)
end
do
    local o = AddToggle(2, "Fog", "f_fog", "d_fog", true)
    AddSlider(o, "o_density", nil, 5, 100,
        function() return Settings.FogDensity end,
        function(v) Settings.FogDensity = v; RefreshModule("Fog") end, Pct)
    AddCycle(o, "o_color", nil, NameList(FOG_COLORS),
        function() return Settings.FogColor end,
        function(i) Settings.FogColor = i; RefreshModule("Fog") end)
end

AddSection(2, "sec_sky")
do
    local o = AddToggle(2, "Sky", "f_sky", "d_sky", true)
    AddCycle(o, "o_sky", nil, SKY_MODES,
        function() return Settings.SkyMode end,
        function(i) Settings.SkyMode = i; RefreshModule("Sky") end)
    AddInput(o, "o_image", "o_image_d", "ph_image",
        function() return Settings.SkyImage end,
        function(text)
            Settings.SkyImage = text
            if Settings.SkyMode == 2 then RefreshModule("Sky") end
        end)
end
do
    local o = AddToggle(2, "LightPresets", "f_light", "d_light", true)
    AddCycle(o, "o_preset", nil, NameList(LIGHT_PRESETS),
        function() return Settings.LightPreset end,
        function(i) Settings.LightPreset = i; RefreshModule("LightPresets") end)
end

AddSection(3, "sec_shaders")
do
    local o = AddToggle(3, "ReShade", "f_reshade", "d_reshade", true)
    local syncers = {}
    local function live() RefreshModule("ReShade", false) end
    AddCycle(o, "o_preset", nil, NameList(RESHADE_PRESETS),
        function() return Settings.RsPreset end,
        function(i)
            Settings.RsPreset = i
            local p = RESHADE_PRESETS[i]
            Settings.RsExposure, Settings.RsContrast, Settings.RsVibrance = p.Exposure, p.Contrast, p.Vibrance
            Settings.RsTemp, Settings.RsBloom, Settings.RsRays = p.Temp, p.Bloom, p.Rays
            Settings.RsVignette, Settings.RsLetterbox = p.Vignette, p.Letterbox
            for _, sync in ipairs(syncers) do sync() end
            RefreshModule("ReShade")
        end)
    local function slider(key, settingKey, fmt)
        syncers[#syncers + 1] = AddSlider(o, key, nil, 0, 100,
            function() return Settings[settingKey] end,
            function(v) Settings[settingKey] = v; live() end, fmt)
    end
    slider("o_exposure", "RsExposure", Signed)
    slider("o_contrast", "RsContrast", Signed)
    slider("o_vibrance", "RsVibrance", Signed)
    slider("o_temp", "RsTemp", Signed)
    slider("o_bloom", "RsBloom", Pct)
    slider("o_rays", "RsRays", Pct)
    slider("o_vignette", "RsVignette", Pct)
    syncers[#syncers + 1] = AddSettingSwitch(o, "o_letterbox", "o_letterbox_d", "RsLetterbox", function() RefreshModule("ReShade") end)
    AddSettingSwitch(o, "o_dof", nil, "RsDof", function() RefreshModule("ReShade") end)
    AddSettingSwitch(o, "o_reflect", nil, "RsReflect", function() RefreshModule("ReShade") end)
    AddSettingSwitch(o, "o_soft", nil, "RsSoft", function() RefreshModule("ReShade") end)
    AddSettingSwitch(o, "o_motion", nil, "RsMotion")
end

AddSection(3, "sec_perf")
do
    local o = AddToggle(3, "FpsBoost", "f_boost", "d_boost", true)
    AddSettingSwitch(o, "o_materials", nil, "BoostMaterials", function() RefreshModule("FpsBoost") end)
    AddSettingSwitch(o, "o_textures", nil, "BoostTextures", function() RefreshModule("FpsBoost") end)
    AddSettingSwitch(o, "o_effects", nil, "BoostEffects", function() RefreshModule("FpsBoost") end)
    AddSettingSwitch(o, "o_shadows", nil, "BoostShadows", function() RefreshModule("FpsBoost") end)
end

AddSection(4, "sec_view")
do
    local o = AddToggle(4, "Fov", "f_fov", "d_fov", true)
    AddSlider(o, "o_value", nil, 40, 120,
        function() return Settings.Fov end,
        function(v) Settings.Fov = v end)
end
do
    local o = AddToggle(4, "Stretch", "f_stretch", "d_stretch", true)
    AddSlider(o, "o_strength", nil, 50, 100,
        function() return math.floor(Settings.StretchRes * 100 + 0.5) end,
        function(v) Settings.StretchRes = v / 100 end,
        function(v) return string.format("%.2f", v / 100) end)
end
do
    local o = AddToggle(4, "CameraSway", "f_sway", "d_sway", true)
    AddSlider(o, "o_lag", nil, 0, 100,
        function() return Settings.SwayLag end,
        function(v) Settings.SwayLag = v end, Pct)
    AddSlider(o, "o_roll", nil, 0, 100,
        function() return Settings.SwayRoll end,
        function(v) Settings.SwayRoll = v end, Pct)
end

AddSection(4, "sec_cursor")
do
    local o = AddToggle(4, "Crosshair", "f_cursor", "d_cursor", true)
    AddCycle(o, "o_style", nil, CROSS_STYLES,
        function() return Settings.CrossStyle end,
        function(i) Settings.CrossStyle = i; RefreshModule("Crosshair") end)
    AddCycle(o, "o_color", nil, CURSOR_COLORS,
        function() return Settings.CursorColor end,
        function(i) Settings.CursorColor = i; RefreshModule("Crosshair") end)
    AddSlider(o, "o_size", nil, 2, 40,
        function() return Settings.CrossSize end,
        function(v) Settings.CrossSize = v; RefreshModule("Crosshair") end, Px)
    AddSlider(o, "o_thick", nil, 1, 6,
        function() return Settings.CrossThick end,
        function(v) Settings.CrossThick = v; RefreshModule("Crosshair") end, Px)
    AddSlider(o, "o_gap", nil, 0, 20,
        function() return Settings.CrossGap end,
        function(v) Settings.CrossGap = v; RefreshModule("Crosshair") end, Px)
end

AddSection(5, "sec_interface")
AddCycle(5, "s_lang", "s_lang_d", LANGS,
    function() return table.find(LANG_CODES, Settings.Lang) or 1 end,
    function(i)
        Settings.Lang = LANG_CODES[i]
        ApplyLang()
        Notify.Info(T("n_lang"), CONFIG.ProjectName, 2)
    end)
AddCycle(5, "s_skin", "s_skin_d", NameList(UI_SKINS),
    function() return Settings.UiSkin end,
    function(i) ApplySkin(i) end)
AddCycle(5, "s_palette", "s_palette_d", NameList(Palette.Schemes),
    function() return Palette.Index end,
    function(i)
        Palette.Index = i
        Settings.Palette = i
        Palette.Changed:Fire()
    end)
AddKeybind(5, "s_key", "s_key_d",
    function() return Settings.MenuKey end,
    function(key) Settings.MenuKey = key end)
AddSettingSwitch(5, "s_notify", "s_notify_d", "Notifications")

local Popup = { Open = false }
do
    local frame = Create("Frame", {
        Name = "WatermarkMenu", AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 62), Size = UDim2.fromOffset(230, 0),
        AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0,
        Visible = false, ZIndex = 30, Parent = ScreenGui,
    }, {
        Corner(UDim.new(0, 14)),
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
        }),
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) }),
    })
    Th(frame, { BackgroundColor3 = "Background" })
    local stroke = Create("UIStroke", { Thickness = 1.2, Transparency = 0.1, Color = Color3.new(1, 1, 1), Parent = frame })
    Gradient(stroke, 45, "AccentSoft", "Stroke")
    local scale = Create("UIScale", { Scale = 0.92, Parent = frame })
    local order = 0
    local function nextOrder()
        order += 1
        return order
    end

    local function header(key)
        Th(Loc(Create("TextLabel", {
            LayoutOrder = nextOrder(), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22),
            FontFace = F.Bold, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = frame,
        }, { Create("UIPadding", { PaddingLeft = UDim.new(0, 8) }) }), key), { TextColor3 = "Muted" })
    end

    local function item(key, danger)
        local btn = Create("TextButton", {
            LayoutOrder = nextOrder(), Size = UDim2.new(1, 0, 0, 34), BorderSizePixel = 0,
            BackgroundTransparency = 1, AutoButtonColor = false, Text = "", Parent = frame,
        }, { Corner(UDim.new(0, 9)) })
        Th(btn, { BackgroundColor3 = danger and "Error" or "Glass" })
        Th(Loc(Create("TextLabel", {
            BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -60, 1, 0),
            FontFace = F.SemiBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
            Parent = btn,
        }), key), { TextColor3 = danger and "Error" or "Text" })
        btn.MouseEnter:Connect(function() Tween(btn, TI.Fast, { BackgroundTransparency = danger and 0.8 or 0 }) end)
        btn.MouseLeave:Connect(function() Tween(btn, TI.Fast, { BackgroundTransparency = 1 }) end)
        return btn
    end

    local function switchItem(key, settingKey)
        local btn = item(key)
        local paint = SwitchVisual(btn, UDim2.new(1, -8, 0.5, 0))
        btn.Switch.Size = UDim2.fromOffset(36, 20)
        local knob = btn.Switch:FindFirstChildWhichIsA("Frame")
        knob.Size = UDim2.fromOffset(14, 14)
        local function render(instant)
            paint(Settings[settingKey], instant)
            Tween(knob, instant and TI.Instant or TI.Fast, {
                Position = Settings[settingKey] and UDim2.new(0, 19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
            })
        end
        render(true)
        OnTheme(function() render() end)
        btn.MouseButton1Click:Connect(function()
            Settings[settingKey] = not Settings[settingKey]
            render()
            Watermark.Refresh()
            Config.Save()
        end)
    end

    local function divider()
        Th(Create("Frame", {
            LayoutOrder = nextOrder(), Size = UDim2.new(1, 0, 0, 1),
            BorderSizePixel = 0, BackgroundTransparency = 0.4, Parent = frame,
        }), { BackgroundColor3 = "Stroke" })
    end

    header("p_watermark")
    switchItem("p_fps", "WmFps")
    switchItem("p_ping", "WmPing")
    switchItem("p_nick", "WmNick")
    divider()
    item("p_disable").MouseButton1Click:Connect(function()
        Popup.Close()
        DisableAll()
    end)
    item("p_unload", true).MouseButton1Click:Connect(function()
        Popup.Close()
        Unload(true)
    end)

    function Popup.Show()
        if Popup.Open then return end
        Popup.Open = true
        local wm = Watermark.Frame
        local x = wm.AbsolutePosition.X + wm.AbsoluteSize.X / 2
        local y = wm.AbsolutePosition.Y + wm.AbsoluteSize.Y + 16
        frame.Position = UDim2.fromOffset(x, y - 8)
        frame.Visible = true
        scale.Scale = 0.92
        Tween(scale, TI.Medium, { Scale = 1 })
        Tween(frame, TI.Medium, { Position = UDim2.fromOffset(x, y) })
    end

    function Popup.Close()
        if not Popup.Open then return end
        Popup.Open = false
        Tween(scale, TI.Fast, { Scale = 0.92 }).Completed:Connect(function()
            if not Popup.Open then frame.Visible = false end
        end)
    end

    function Popup.Toggle()
        if Popup.Open then Popup.Close() else Popup.Show() end
    end

    Root:Give(UserInputService.InputBegan:Connect(function(input)
        if not Popup.Open then return end
        local t = input.UserInputType
        if t ~= Enum.UserInputType.MouseButton1 and t ~= Enum.UserInputType.MouseButton2 and t ~= Enum.UserInputType.Touch then
            return
        end
        local point = Vector2.new(input.Position.X, input.Position.Y)
        if PointInside(frame, point) or PointInside(Watermark.Frame, point) then return end
        Popup.Close()
    end))
end

local function FitScale()
    local cam = GetCamera()
    local viewport = cam and cam.ViewportSize or Vector2.new(1920, 1080)
    return math.clamp(math.min(
        (viewport.X - 32) / CONFIG.MenuWidth,
        (viewport.Y - 32) / CONFIG.MenuHeight
    ), 0.5, 1)
end

function Menu.Open()
    if Menu.IsOpen then return end
    Menu.IsOpen = true
    Popup.Close()
    Watermark.Suppress(true)
    Window.Visible = true
    MenuBlur.Enabled = true
    local target = FitScale()
    MainScale.Scale = target * 0.94
    Tween(Dim, TI.Medium, { BackgroundTransparency = 0.4 })
    Tween(MenuBlur, TI.Medium, { Size = 20 })
    Tween(Body, TI.Medium, { GroupTransparency = 0 })
    Tween(Shadow, TI.Medium, { GroupTransparency = 0 })
    Tween(OutlineStroke, TI.Medium, { Transparency = 0.15 })
    Tween(MainScale, TI.Medium, { Scale = target })
end

function Menu.Close()
    if not Menu.IsOpen then return end
    Menu.IsOpen = false
    Watermark.Suppress(false)
    local tw = Tween(Body, TI.Fast, { GroupTransparency = 1 })
    Tween(Shadow, TI.Fast, { GroupTransparency = 1 })
    Tween(Dim, TI.Fast, { BackgroundTransparency = 1 })
    Tween(MenuBlur, TI.Fast, { Size = 0 })
    Tween(OutlineStroke, TI.Fast, { Transparency = 1 })
    Tween(MainScale, TI.Fast, { Scale = FitScale() * 0.94 })
    tw.Completed:Connect(function()
        if not Menu.IsOpen then
            Window.Visible = false
            MenuBlur.Enabled = false
        end
    end)
end

function Menu.Toggle()
    if Menu.Locked then
        Notify.Info(T("n_wait"), T("n_loading"), 2)
        return
    end
    if Menu.IsOpen then Menu.Close() else Menu.Open() end
end

CloseBtn.MouseButton1Click:Connect(Menu.Close)
Dim.MouseButton1Click:Connect(function()
    if os.clock() - lastDrag < 0.3 then return end
    if PointInside(MainFrame, UserInputService:GetMouseLocation()) then return end
    Menu.Close()
end)
Watermark.OnClick = Menu.Toggle
Watermark.OnContext = function()
    if not Menu.Locked then Popup.Toggle() end
end

local LoaderGui

local function RunLoader(onDone)
    LoaderGui = Create("ScreenGui", {
        Name = "Nyxora_Loader", IgnoreGuiInset = true, ResetOnSpawn = false,
        DisplayOrder = 2000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = PlayerGui,
    })
    local backdrop = Create("TextButton", {
        Size = UDim2.fromScale(1, 1), Text = "", AutoButtonColor = false, Modal = true,
        BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(6, 5, 10), BackgroundTransparency = 1,
        Parent = LoaderGui,
    })
    local blur = Create("BlurEffect", { Name = "VX_LoaderBlur", Size = 0, Parent = Lighting })

    local glow = Create("CanvasGroup", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46),
        Size = UDim2.fromOffset(560, 560), BackgroundTransparency = 1, GroupTransparency = 1, Parent = LoaderGui,
    })
    for i = 1, 5 do
        Th(Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(i / 5, i / 5), BorderSizePixel = 0,
            BackgroundTransparency = 0.82 + i * 0.03, Parent = glow,
        }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "Accent" })
    end

    local card = Create("CanvasGroup", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(380, 300), BackgroundTransparency = 1, GroupTransparency = 1, Parent = LoaderGui,
    })
    local cardScale = Create("UIScale", { Scale = 0.94, Parent = card })

    local logoHolder = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 70),
        Size = UDim2.fromOffset(120, 120), BackgroundTransparency = 1, Parent = card,
    })
    local logo = MakeLogo(logoHolder, 0, 58, "Background")
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.Position = UDim2.fromScale(0.5, 0.5)
    local logoScale = Create("UIScale", { Parent = logo })

    local pulse = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(80, 80), BackgroundTransparency = 1, Parent = logoHolder,
    }, { Corner(UDim.new(1, 0)) })
    local pulseStroke = Th(Create("UIStroke", { Thickness = 2, Parent = pulse }), { Color = "AccentSoft" })

    local orbiters = {}
    for i = 1, 3 do
        orbiters[i] = Th(Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(7 - i, 7 - i),
            BorderSizePixel = 0, Parent = logoHolder,
        }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = i == 1 and "AccentSoft" or "SwitchOn" })
    end

    local title = Create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 140),
        Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, FontFace = F.Black, TextSize = 34,
        TextColor3 = Color3.new(1, 1, 1), Text = string.upper(CONFIG.ProjectName), Parent = card,
    })
    Gradient(title, 0, "Text", "AccentSoft")

    local status = Th(Create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 190),
        Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, FontFace = F.Medium, TextSize = 13,
        Text = T("l_first"), Parent = card,
    }), { TextColor3 = "Muted" })

    local track = Th(Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 222),
        Size = UDim2.fromOffset(280, 6), BorderSizePixel = 0, Parent = card,
    }, { Corner(UDim.new(1, 0)) }), { BackgroundColor3 = "SwitchOff" })
    local fill = Create("Frame", {
        Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = track,
    }, { Corner(UDim.new(1, 0)) })
    Gradient(fill, 0, "SwitchOn", "AccentSoft")
    local shine = Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(10, 10),
        BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = fill,
    }, { Corner(UDim.new(1, 0)) })

    local percent = Th(Create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 238),
        Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, FontFace = F.Bold, TextSize = 12,
        Text = "0%", Parent = card,
    }), { TextColor3 = "AccentSoft" })

    Th(Create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -24),
        Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, FontFace = F.SemiBold, TextSize = 12,
        Text = CONFIG.Credit, Parent = LoaderGui,
    }), { TextColor3 = "Muted" })

    local animConn = RunService.RenderStepped:Connect(function()
        local t = os.clock()
        logoScale.Scale = 1 + math.sin(t * 2.4) * 0.05
        local phase = (t % 1.4) / 1.4
        pulse.Size = UDim2.fromOffset(70 + phase * 60, 70 + phase * 60)
        pulseStroke.Transparency = 0.15 + phase * 0.85
        for i, orb in ipairs(orbiters) do
            local angle = t * 2.2 - (i - 1) * 0.35
            orb.Position = UDim2.new(0.5, math.cos(angle) * 46, 0.5, math.sin(angle) * 46)
        end
    end)

    local shown = 0
    local function setProgress(target)
        shown += (target - shown) * 0.18
        fill.Size = UDim2.fromScale(math.clamp(shown, 0, 1), 1)
        percent.Text = math.floor(math.clamp(shown, 0, 1) * 100 + 0.5) .. "%"
    end

    task.spawn(function()
        Tween(backdrop, TI.Slow, { BackgroundTransparency = 0.04 })
        Tween(blur, TI.Slow, { Size = 24 })
        Tween(glow, TI.Slow, { GroupTransparency = 0 })
        Tween(card, TI.Slow, { GroupTransparency = 0 })
        Tween(cardScale, TI.Slow, { Scale = 1 })
        task.wait(0.6)

        status.Text = T("l_assets")
        local assets = {
            "rbxassetid://101851696", "rbxassetid://101851254",
            "rbxasset://textures/particles/smoke_main.dds",
        }
        for _, preset in ipairs(SKY_PRESETS) do
            for _, id in ipairs(preset.Ids) do assets[#assets + 1] = "rbxassetid://" .. id end
        end
        local total, done, finished = #assets, 0, false
        task.spawn(function()
            pcall(ContentProvider.PreloadAsync, ContentProvider, assets, function()
                done += 1
            end)
            finished = true
        end)
        local started = os.clock()
        while true do
            local target = (finished and 1 or done / total) * 0.82
            setProgress(target)
            if (finished and shown > 0.81) or os.clock() - started > 15 then break end
            task.wait()
        end

        status.Text = T("l_verify")
        local ids = {}
        for id in pairs(Modules) do ids[#ids + 1] = id end
        table.sort(ids)
        for i, id in ipairs(ids) do
            local module = Modules[id]
            if type(module.Enable) ~= "function" or type(module.Disable) ~= "function" then
                warn("[Nyxora] module " .. id .. " is incomplete")
            end
            local target = 0.82 + i / #ids * 0.16
            for _ = 1, 2 do
                setProgress(target)
                task.wait()
            end
        end

        status.Text = T("l_start")
        for _ = 1, 20 do
            setProgress(1)
            task.wait()
        end
        status.Text = T("l_done")
        task.wait(0.25)

        Tween(card, TI.Medium, { GroupTransparency = 1 })
        Tween(cardScale, TI.Medium, { Scale = 1.05 })
        Tween(glow, TI.Medium, { GroupTransparency = 1 })
        Tween(blur, TI.Medium, { Size = 0 })
        Tween(backdrop, TI.Medium, { BackgroundTransparency = 1 })
        task.wait(0.4)
        animConn:Disconnect()
        blur:Destroy()
        if LoaderGui then
            LoaderGui:Destroy()
            LoaderGui = nil
        end
        onDone()
    end)
end

local unloaded = false
Unload = function(graceful)
    if unloaded then return end
    unloaded = true

    if graceful then
        Menu.Locked = true
        Menu.Close()
        Popup.Close()
        Watermark.SetVisible(false)
        task.wait(0.4)
    end

    for id, feature in pairs(Features) do
        if feature.Enabled and Modules[id] then
            pcall(Modules[id].Disable)
            feature.Enabled = false
        end
    end

    Root:Clean()
    pcall(function() Palette.Changed:Destroy() end)
    pcall(function() ScreenGui:Destroy() end)
    pcall(function() FxFolder:Destroy() end)
    if LoaderGui then pcall(function() LoaderGui:Destroy() end) end
    local loaderBlur = Lighting:FindFirstChild("VX_LoaderBlur")
    if loaderBlur then loaderBlur:Destroy() end
    UserInputService.MouseIconEnabled = true

    if _G.Nyxora and _G.Nyxora.Unload == Unload then
        _G.Nyxora = nil
    end
end

_G.Nyxora = {
    Notify = Notify,
    Menu = Menu,
    SetFeature = SetFeature,
    Settings = Settings,
    Unload = Unload,
}

Root:Give(UserInputService.InputBegan:Connect(function(input, processed)
    if processed or Binding then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode.Name == Settings.MenuKey or input.KeyCode == Enum.KeyCode.Insert then
        Menu.Toggle()
    end
end))

SelectTab(1)
PaintTabs(true)

local function Start()
    Menu.Locked = false
    Watermark.SetVisible(true)

    local toRestore = {}
    for id, on in pairs(Settings.Enabled) do
        if on then toRestore[#toRestore + 1] = id end
    end
    Settings.Enabled = {}
    local restored = 0
    for _, id in ipairs(toRestore) do
        if SetFeature(id, true, true) then restored += 1 end
    end
    FireActive()

    local loadText = string.format(T("n_loaded"), Settings.MenuKey)
    if restored > 0 then
        loadText = loadText .. string.format(T("n_restored"), restored)
    end
    Notify.Info(loadText, T("n_ready"))

    if CONFIG.OpenMenuOnStart then
        Menu.Open()
    end
end

local needLoader = _G.NyxoraBuild ~= CONFIG.Build and Settings.LoadedBuild ~= CONFIG.Build
if needLoader then
    Menu.Locked = true
    RunLoader(function()
        _G.NyxoraBuild = CONFIG.Build
        Settings.LoadedBuild = CONFIG.Build
        Config.Save()
        if not unloaded then Start() end
    end)
else
    _G.NyxoraBuild = CONFIG.Build
    Start()
end
