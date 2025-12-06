--===== UFO HUB X • Language Select Panel (Grid + A V2 Settings – Refined) =====
-- LocalScript (StarterPlayerScripts / StarterGui)

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer

------------------------------------------------------------
-- GLOBAL STATE (ภาษาที่ใช้ตอนนี้)
------------------------------------------------------------
_G.UFOX_LANG = _G.UFOX_LANG or {}
local LANG_STATE = _G.UFOX_LANG

-- key ภาษา
local ORDER = { "EN", "TH", "BR", "VN", "ID", "PH" }

-- ชื่อประเทศ/ภาษาแต่ละตัว (base)
local BASE_NAMES = {
    EN = "English",
    TH = "Thai",
    BR = "Brazil",
    VN = "Vietnam",
    ID = "Indonesia",
    PH = "Philippines",
}

-- แปลชื่อแต่ละประเทศ ตามภาษาของ UI
local NAME_I18N = {
    EN = {
        EN = "English",
        TH = "Thai",
        BR = "Brazil",
        VN = "Vietnam",
        ID = "Indonesia",
        PH = "Philippines",
    },
    TH = {
        EN = "อังกฤษ",
        TH = "ไทย",
        BR = "บราซิล",
        VN = "เวียดนาม",
        ID = "อินโดนีเซีย",
        PH = "ฟิลิปปินส์",
    },
    BR = {
        EN = "Inglês",
        TH = "Tailandês",
        BR = "Brasil",
        VN = "Vietnã",
        ID = "Indonésia",
        PH = "Filipinas",
    },
    VN = {
        EN = "Tiếng Anh",
        TH = "Tiếng Thái",
        BR = "Brazil",
        VN = "Việt Nam",
        ID = "Indonesia",
        PH = "Philippines",
    },
    ID = {
        EN = "Inggris",
        TH = "Thailand",
        BR = "Brasil",
        VN = "Vietnam",
        ID = "Indonesia",
        PH = "Filipina",
    },
    PH = {
        EN = "Ingles",
        TH = "Thai",
        BR = "Brazil",
        VN = "Vietnam",
        ID = "Indonesia",
        PH = "Pilipinas",
    },
}

-- ปุ่มในแผง Settings (A V2) ให้ใช้ชื่ออะไรในแต่ละภาษา UI
local UI_LANG_LABEL = {
    EN = {
        EN = "English",
        TH = "Thai",
        BR = "Brazilian Portuguese",
        VN = "Vietnamese",
        ID = "Indonesian",
        PH = "Filipino",
        TITLE = "UI Language",
        CONFIRM = "Confirm",
        SEARCH = "🔍 Search Language",
    },
    TH = {
        EN = "อังกฤษ",
        TH = "ไทย",
        BR = "โปรตุเกส (บราซิล)",
        VN = "เวียดนาม",
        ID = "อินโดนีเซีย",
        PH = "ฟิลิปปินส์",
        TITLE = "ภาษาของเมนู",
        CONFIRM = "ยืนยัน",
        SEARCH = "🔍 ค้นหาภาษา",
    },
    BR = {
        EN = "Inglês",
        TH = "Tailandês",
        BR = "Português (Brasil)",
        VN = "Vietnamita",
        ID = "Indonésio",
        PH = "Filipino",
        TITLE = "Idioma da Interface",
        CONFIRM = "Confirmar",
        SEARCH = "🔍 Buscar idioma",
    },
    VN = {
        EN = "Tiếng Anh",
        TH = "Tiếng Thái",
        BR = "Tiếng Bồ Đào Nha (Brazil)",
        VN = "Tiếng Việt",
        ID = "Tiếng Indonesia",
        PH = "Tiếng Philippines",
        TITLE = "Ngôn ngữ giao diện",
        CONFIRM = "Xác nhận",
        SEARCH = "🔍 Tìm ngôn ngữ",
    },
    ID = {
        EN = "Inggris",
        TH = "Thailand",
        BR = "Portugis (Brasil)",
        VN = "Vietnam",
        ID = "Indonesia",
        PH = "Filipina",
        TITLE = "Bahasa Antarmuka",
        CONFIRM = "Konfirmasi",
        SEARCH = "🔍 Cari bahasa",
    },
    PH = {
        EN = "Ingles",
        TH = "Thai",
        BR = "Portuges (Brazil)",
        VN = "Vietnam",
        ID = "Indonesia",
        PH = "Pilipino",
        TITLE = "UI Language",
        CONFIRM = "Kumpirma",
        SEARCH = "🔍 Hanapin ang wika",
    },
}

-- ให้ค่าเริ่มต้น (ถ้าไม่มี)
LANG_STATE.ui   = LANG_STATE.ui   or "EN"  -- ภาษาของ UI
LANG_STATE.game = LANG_STATE.game or "EN"  -- ภาษาที่เลือกใช้ในเกม

local currentUILang     = LANG_STATE.ui
local selectedGameLang  = LANG_STATE.game

------------------------------------------------------------
-- THEME + HELPERS
------------------------------------------------------------
local THEME = {
    GREEN      = Color3.fromRGB(25,255,125),
    GREEN_DARK = Color3.fromRGB(0,120,60),
    RED        = Color3.fromRGB(255,40,40),
    WHITE      = Color3.fromRGB(255,255,255),
    BLACK      = Color3.fromRGB(0,0,0),
    DARK       = Color3.fromRGB(12,12,12),
}

local function corner(ui, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 12)
    c.Parent = ui
end

local function stroke(ui, th, col, trans)
    local s = Instance.new("UIStroke")
    s.Thickness = th or 2.2
    s.Color = col or THEME.GREEN
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Transparency = trans or 0
    s.Parent = ui
    return s
end

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$","%1"))
end

------------------------------------------------------------
-- ROOT GUI
------------------------------------------------------------
local playerGui = lp:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "UFOX_LanguageSelect"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

------------------------------------------------------------
-- MAIN PANEL (ดำ + ขอบเขียว ปรับให้เนียนขึ้น)
------------------------------------------------------------
local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = gui
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0.62, 0, 0.52, 0)
main.BackgroundColor3 = THEME.DARK
main.BorderSizePixel = 0
corner(main, 18)
local mainStroke = stroke(main, 3, THEME.GREEN_DARK, 0.1)

-- เส้นเรืองด้านในให้ดูสวยขึ้น
local innerBorder = Instance.new("Frame")
innerBorder.Parent = main
innerBorder.BackgroundTransparency = 1
innerBorder.BorderSizePixel = 0
innerBorder.Size = UDim2.new(1,-8,1,-8)
innerBorder.Position = UDim2.new(0,4,0,4)
corner(innerBorder, 16)
stroke(innerBorder, 2, THEME.GREEN, 0)

-- แถบด้านบน (ไว้ติดปุ่มเขียว/แดง)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Parent = main
topBar.BackgroundTransparency = 1
topBar.Size = UDim2.new(1, -24, 0, 26)
topBar.Position = UDim2.new(0, 12, 0, 10)

-- ปุ่มปิด (แดง)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Parent = topBar
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.Position = UDim2.new(1, 0, 0, 0)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.BackgroundColor3 = THEME.RED
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = THEME.WHITE
corner(closeBtn, 5)

-- ปุ่มตั้งค่าภาษา UI (พื้นดำ + ฟันเฟือง)
local settingsBtn = Instance.new("TextButton")
settingsBtn.Name = "Settings"
settingsBtn.Parent = topBar
settingsBtn.AnchorPoint = Vector2.new(1, 0)
settingsBtn.Position = UDim2.new(1, -30, 0, 0)
settingsBtn.Size = UDim2.new(0, 24, 0, 24)
settingsBtn.BackgroundColor3 = THEME.BLACK
settingsBtn.BorderSizePixel = 0
settingsBtn.Text = "⚙"
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 16
settingsBtn.TextColor3 = THEME.WHITE
corner(settingsBtn, 5)
local settingsStroke = stroke(settingsBtn, 1.6, THEME.GREEN_DARK, 0.4)

local function updateSettingsVisual(isOpen)
    if isOpen then
        settingsStroke.Color        = THEME.GREEN
        settingsStroke.Thickness    = 2.2
        settingsStroke.Transparency = 0
    else
        settingsStroke.Color        = THEME.GREEN_DARK
        settingsStroke.Thickness    = 1.6
        settingsStroke.Transparency = 0.4
    end
end
updateSettingsVisual(false)

------------------------------------------------------------
-- GRID 6 ช่อง (ธง + ชื่อประเทศ) – จัดตรงกลางสวย ๆ
------------------------------------------------------------
local gridHolder = Instance.new("Frame")
gridHolder.Name  = "GridHolder"
gridHolder.Parent = main
gridHolder.BackgroundTransparency = 1
gridHolder.AnchorPoint = Vector2.new(0.5, 0.5)
gridHolder.Position = UDim2.new(0.5, 0, 0.48, 0)
gridHolder.Size = UDim2.new(0.9, 0, 0.55, 0)

local gridLayout = Instance.new("UIGridLayout")
gridLayout.Parent = gridHolder
gridLayout.CellPadding = UDim2.new(0, 24, 0, 18)
gridLayout.CellSize    = UDim2.new(1/3 - 0.05, 0, 0.5 - 0.08, 0)
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gridLayout.VerticalAlignment   = Enum.VerticalAlignment.Center

local cardMap = {}  -- langKey -> data

for _, key in ipairs(ORDER) do
    local card = Instance.new("Frame")
    card.Name = "Card_" .. key
    card.Parent = gridHolder
    card.BackgroundTransparency = 1
    card.BorderSizePixel = 0

    -- ปุ่มคลิกทั้งการ์ด
    local hit = Instance.new("TextButton")
    hit.Name = "Hit"
    hit.Parent = card
    hit.BackgroundTransparency = 1
    hit.BorderSizePixel = 0
    hit.Size = UDim2.new(1, 0, 1, 0)
    hit.Text = ""
    hit.AutoButtonColor = false

    -- กรอบธง (ขาว) ด้านบน – ใช้รูปธงเต็มพื้นที่
    local flagFrame = Instance.new("Frame")
    flagFrame.Name = "FlagFrame"
    flagFrame.Parent = card
    flagFrame.AnchorPoint = Vector2.new(0.5, 0)
    flagFrame.Position = UDim2.new(0.5, 0, 0, 0)
    flagFrame.Size = UDim2.new(1, 0, 0.7, 0)
    flagFrame.BackgroundColor3 = THEME.WHITE
    flagFrame.BorderSizePixel = 0
    corner(flagFrame, 8)

    local flagImage = Instance.new("ImageLabel")
    flagImage.Name = "Flag"
    flagImage.Parent = flagFrame
    flagImage.BackgroundTransparency = 1
    flagImage.Size = UDim2.new(1, -6, 1, -6)
    flagImage.Position = UDim2.new(0, 3, 0, 3)
    flagImage.ScaleType = Enum.ScaleType.Fit
    flagImage.Image = ""  -- << ใส่ rbxassetid:// ของธงแต่ละประเทศเองทีหลัง

    local flagStroke = stroke(flagFrame, 0, THEME.GREEN)

    -- ชื่อประเทศด้านล่าง
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.Parent = card
    nameLabel.AnchorPoint = Vector2.new(0.5, 1)
    nameLabel.Position = UDim2.new(0.5, 0, 1, 0)
    nameLabel.Size = UDim2.new(1, 0, 0.35, -4)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = THEME.WHITE
    nameLabel.TextWrapped = true
    nameLabel.TextYAlignment = Enum.TextYAlignment.Center

    cardMap[key] = {
        card   = card,
        hit    = hit,
        flag   = flagFrame,
        stroke = flagStroke,
        name   = nameLabel,
    }
end

------------------------------------------------------------
-- ปุ่ม Confirm (ดำ + ขอบเขียวเรืองแสง)
------------------------------------------------------------
local confirmBtn = Instance.new("TextButton")
confirmBtn.Name = "Confirm"
confirmBtn.Parent = main
confirmBtn.AnchorPoint = Vector2.new(0.5, 1)
confirmBtn.Position = UDim2.new(0.5, 0, 1, -18)
confirmBtn.Size = UDim2.new(0, 170, 0, 40)
confirmBtn.BackgroundColor3 = THEME.BLACK
confirmBtn.BorderSizePixel  = 0
confirmBtn.Font = Enum.Font.GothamBold
confirmBtn.TextSize = 16
confirmBtn.TextColor3 = THEME.WHITE
corner(confirmBtn, 10)
local confirmStroke = stroke(confirmBtn, 2.2, THEME.GREEN, 0)

------------------------------------------------------------
-- การอัปเดต UI (ชื่อประเทศ + selection)
------------------------------------------------------------
local function refreshCountryLabels()
    local uiLang = currentUILang
    local map = NAME_I18N[uiLang] or NAME_I18N["EN"]
    for _, key in ipairs(ORDER) do
        local data = cardMap[key]
        if data then
            local txt = (map and map[key]) or BASE_NAMES[key] or key
            data.name.Text = txt
        end
    end

    local labelMap = UI_LANG_LABEL[uiLang] or UI_LANG_LABEL["EN"]
    confirmBtn.Text = labelMap.CONFIRM or "Confirm"
end

local function refreshSelection()
    for _, key in ipairs(ORDER) do
        local data = cardMap[key]
        if data then
            if key == selectedGameLang then
                data.stroke.Thickness = 3
                data.stroke.Color = THEME.GREEN
                data.stroke.Transparency = 0
            else
                data.stroke.Thickness = 0
                data.stroke.Transparency = 1
            end
        end
    end
end

refreshCountryLabels()
refreshSelection()

------------------------------------------------------------
-- คลิกเลือกภาษาเกม (กดธง)
------------------------------------------------------------
for key, data in pairs(cardMap) do
    data.hit.MouseButton1Click:Connect(function()
        selectedGameLang = key
        refreshSelection()
    end)
end

------------------------------------------------------------
-- ปุ่ม Confirm: เซฟภาษาเกม + ปิด UI
------------------------------------------------------------
confirmBtn.MouseButton1Click:Connect(function()
    LANG_STATE.game = selectedGameLang
    LANG_STATE.ui   = currentUILang
    print("[UFO HUB X] Game Language =", selectedGameLang, "UI Language =", currentUILang)
    gui.Enabled = false
end)

------------------------------------------------------------
-- ปุ่ม Close: ปิดโดยไม่เปลี่ยนค่า
------------------------------------------------------------
closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

------------------------------------------------------------
-- แผง Settings (Model A V2 style เต็มระบบ) สำหรับเปลี่ยนภาษาของ UI
------------------------------------------------------------
local settingsOverlay
local settingsConn

local function closeSettings()
    if settingsConn then
        settingsConn:Disconnect()
        settingsConn = nil
    end
    if settingsOverlay then
        settingsOverlay:Destroy()
        settingsOverlay = nil
    end
    updateSettingsVisual(false)
end

local function openSettings()
    closeSettings()
    updateSettingsVisual(true)

    settingsOverlay = Instance.new("Frame")
    settingsOverlay.Name = "SettingsOverlay"
    settingsOverlay.Parent = gui
    settingsOverlay.BackgroundTransparency = 1
    settingsOverlay.Size = UDim2.new(1, 0, 1, 0)

    local panel = Instance.new("Frame")
    panel.Name = "Panel"
    panel.Parent = settingsOverlay
    panel.AnchorPoint = Vector2.new(1, 0.5)
    panel.Position = UDim2.new(1, -20, 0.5, 0)
    panel.Size = UDim2.new(0, 260, 0.55, 0)
    panel.BackgroundColor3 = THEME.BLACK
    panel.BorderSizePixel  = 0
    corner(panel, 18)
    stroke(panel, 2.4, THEME.GREEN)

    local body = Instance.new("Frame")
    body.Parent = panel
    body.BackgroundTransparency = 1
    body.Size = UDim2.new(1, -10, 1, -10)
    body.Position = UDim2.new(0, 5, 0, 5)

    local uiLangMap = UI_LANG_LABEL[currentUILang] or UI_LANG_LABEL["EN"]

    local title = Instance.new("TextLabel")
    title.Parent = body
    title.Size = UDim2.new(1, -8, 0, 24)
    title.Position = UDim2.new(0, 4, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = THEME.WHITE
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = uiLangMap.TITLE or "UI Language"

    -- Search (A V2)
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchBox"
    searchBox.Parent = body
    searchBox.BackgroundColor3 = THEME.BLACK
    searchBox.ClearTextOnFocus = false
    searchBox.Font = Enum.Font.GothamBold
    searchBox.TextSize = 14
    searchBox.TextColor3 = THEME.WHITE
    searchBox.PlaceholderText = uiLangMap.SEARCH or "🔍 Search"
    searchBox.TextXAlignment = Enum.TextXAlignment.Center
    searchBox.Text = ""
    searchBox.Size = UDim2.new(1, -8, 0, 30)
    searchBox.Position = UDim2.new(0, 4, 0, 26)
    corner(searchBox, 10)
    local sbStroke = stroke(searchBox, 1.8, THEME.GREEN_DARK, 0.3)

    -- List (A V2 glow buttons)
    local list = Instance.new("ScrollingFrame")
    list.Parent = body
    list.BackgroundColor3 = THEME.BLACK
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 0
    list.Position = UDim2.new(0, 4, 0, 26 + 30 + 8)
    list.Size = UDim2.new(1, -8, 1, -(26 + 30 + 12))
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.ScrollingDirection = Enum.ScrollingDirection.Y
    list.ClipsDescendants = true

    local layout = Instance.new("UIListLayout")
    layout.Parent = list
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding")
    pad.Parent = list
    pad.PaddingTop = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)
    pad.PaddingLeft = UDim.new(0, 4)
    pad.PaddingRight = UDim.new(0, 4)

    local locking = false
    list:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if locking then return end
        locking = true
        local p = list.CanvasPosition
        if p.X ~= 0 then
            list.CanvasPosition = Vector2.new(0, p.Y)
        end
        locking = false
    end)

    local langButtons = {}

    local function refreshOverlaySelection()
        for code, info in pairs(langButtons) do
            local on = (code == currentUILang)
            if on then
                info.stroke.Color        = THEME.GREEN
                info.stroke.Thickness    = 2.4
                info.stroke.Transparency = 0
                info.glow.Visible        = true
            else
                info.stroke.Color        = THEME.GREEN_DARK
                info.stroke.Thickness    = 1.6
                info.stroke.Transparency = 0.4
                info.glow.Visible        = false
            end
        end
    end

    local function applyOverlayLanguageTexts()
        uiLangMap = UI_LANG_LABEL[currentUILang] or UI_LANG_LABEL["EN"]
        title.Text = uiLangMap.TITLE or "UI Language"
        searchBox.PlaceholderText = uiLangMap.SEARCH or "🔍 Search"
        for code, info in pairs(langButtons) do
            info.btn.Text = uiLangMap[code] or BASE_NAMES[code] or code
        end
        refreshCountryLabels()
    end

    local function makeOption(langKey)
        local btn = Instance.new("TextButton")
        btn.Name = "Lang_" .. langKey
        btn.Parent = list
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = THEME.BLACK
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.TextColor3 = THEME.WHITE
        btn.TextXAlignment = Enum.TextXAlignment.Center
        btn.TextYAlignment = Enum.TextYAlignment.Center
        btn.Text = uiLangMap[langKey] or BASE_NAMES[langKey] or langKey
        corner(btn, 10)

        local st = stroke(btn, 1.6, THEME.GREEN_DARK, 0.4)

        local glow = Instance.new("Frame")
        glow.Name = "GlowBar"
        glow.Parent = btn
        glow.BackgroundColor3 = THEME.GREEN
        glow.BorderSizePixel = 0
        glow.Size = UDim2.new(0, 3, 1, 0)
        glow.Position = UDim2.new(0, 0, 0, 0)

        langButtons[langKey] = {
            btn   = btn,
            stroke= st,
            glow  = glow,
        }

        btn.MouseButton1Click:Connect(function()
            currentUILang = langKey
            LANG_STATE.ui = currentUILang
            applyOverlayLanguageTexts()
            refreshOverlaySelection()
        end)
    end

    for _, key in ipairs(ORDER) do
        makeOption(key)
    end

    applyOverlayLanguageTexts()
    refreshOverlaySelection()

    -- Search function
    local function applySearch()
        local q = string.lower(trim(searchBox.Text or ""))
        for code, info in pairs(langButtons) do
            local txt = string.lower(info.btn.Text or "")
            local match = (q == "" or string.find(txt, q, 1, true) ~= nil)
            info.btn.Visible = match
        end
        list.CanvasPosition = Vector2.new(0, 0)
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)

    searchBox.Focused:Connect(function()
        sbStroke.Color = THEME.GREEN
        sbStroke.Transparency = 0
    end)
    searchBox.FocusLost:Connect(function()
        sbStroke.Color = THEME.GREEN_DARK
        sbStroke.Transparency = 0.3
    end)

    -- ปิดเมื่อคลิกนอก panel
    settingsConn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        if not settingsOverlay or not settingsOverlay.Parent then
            closeSettings()
            return
        end

        local pos = input.Position
        local p0  = panel.AbsolutePosition
        local sz  = panel.AbsoluteSize
        local inside =
            pos.X >= p0.X and pos.X <= p0.X + sz.X and
            pos.Y >= p0.Y and pos.Y <= p0.Y + sz.Y

        if not inside then
            closeSettings()
        end
    end)
end

settingsBtn.MouseButton1Click:Connect(function()
    if settingsOverlay then
        closeSettings()
    else
        openSettings()
    end
end)
