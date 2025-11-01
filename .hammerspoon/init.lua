local targetAppName = "Ghostty" -- e.g., "Notes"
local lastFocusedWindow = nil

-- Applications to include for auto-maximize behavior
local includedApps = {
    "Ghostty",
    "kitty",
    "iTerm2",
	"Slack",
    "Code",
    "Visual Studio Code",
    "Xcode",
    "Chrome"
}

-- Function to check if an app should be auto-maximized
local function shouldAutoMaximizeApp(appName)
    for _, includedApp in ipairs(includedApps) do
        if appName == includedApp then
            return true
        end
    end
    return false
end

-- Window filter to handle new windows
local windowFilter = hs.window.filter.new()
windowFilter:subscribe(hs.window.filter.windowCreated, function(window)
    if window then
        -- Get the application name
        local app = window:application()
        if app then
            local appName = app:name()
            
            -- Only auto-maximize for included applications
            if not shouldAutoMaximizeApp(appName) then
                return
            end
        end
        
        -- Get the screen the window is on
        local screen = window:screen()
        if screen then
            -- Get screen frame and apply 5px margin
            local screenFrame = screen:frame()
            local targetFrame = {
                x = screenFrame.x + 5,
                y = screenFrame.y + 5,
                w = screenFrame.w - 10,
                h = screenFrame.h - 10
            }
            
            -- Set the window frame with a small delay to ensure the window is ready
            hs.timer.doAfter(0.5, function()
                -- Check if window still exists by trying to get its frame
                local success, currentFrame = pcall(function() return window:frame() end)
                if success and currentFrame then
                    -- window:setFrame(targetFrame)
					window:setFrame(screenFrame)
                end
            end)
        end
    end
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "G", function()
	local targetApp = hs.application.get(targetAppName)
	local frontmostWindow = hs.window.frontmostWindow()

	if targetApp and targetApp:isFrontmost() then
		if lastFocusedWindow and lastFocusedWindow:id() ~= frontmostWindow:id() then
			lastFocusedWindow:focus()
		end
	else
		lastFocusedWindow = frontmostWindow
		if targetApp then
			local win = targetApp:mainWindow()
			if win then
				win:focus()
			end
		else
			hs.application.launchOrFocus(targetAppName)
		end
	end
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "D", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local currentScreen = win:screen()
	local nextScreen = currentScreen:next()

	local windows = hs.window.orderedWindows()
	for _, w in ipairs(windows) do
		if w:screen() == nextScreen then
			w:focus()
			return
		end
	end
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "F", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local currentScreen = win:screen()
	local screens = hs.screen.allScreens()

	-- Find the index of the current screen
	local currentIndex
	for i, screen in ipairs(screens) do
		if screen == currentScreen then
			currentIndex = i
			break
		end
	end

	-- Compute previous screen (wrap around)
	local prevIndex = currentIndex - 1
	if prevIndex < 1 then
		prevIndex = #screens
	end
	local prevScreen = screens[prevIndex]

	-- Focus the frontmost window on the previous screen
	local windows = hs.window.orderedWindows()
	for _, w in ipairs(windows) do
		if w:screen() == prevScreen then
			w:focus()
			return
		end
	end
end)