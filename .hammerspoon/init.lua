local targetAppName = "Ghostty" -- e.g., "Notes"
local lastFocusedWindow = nil

-- Applications to include for auto-maximize behavior
local autoFillApps = {
	"Ghostty",
	"kitty",
	"iTerm2",
	"Slack",
	"Code",
	"Xcode",
	"Chrome",
}

-- Function to check if an app should be auto-maximized
local function shouldAutoFill(appName)
	for _, includedApp in ipairs(autoFillApps) do
		if appName == includedApp then
			return true
		end
	end
	return false
end

local autoFill = function(window)
	if window then
		-- Get the application name
		local app = window:application()
		if app then
			local appName = app:name()

			-- Only auto-maximize for included applications
			if not shouldAutoFill(appName) then
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
				h = screenFrame.h - 10,
			}

			-- Set the window frame with a small delay to ensure the window is ready
			hs.timer.doAfter(0.5, function()
				-- Check if window still exists by trying to get its frame
				local success, currentFrame = pcall(function()
					return window:frame()
				end)
				if success and currentFrame then
					-- window:setFrame(targetFrame)
					window:setFrame(screenFrame)
				end
			end)
		end
	end
end

local quakeTerminal = function()
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
end

local function orderedScreens()
	local screens = hs.screen.allScreens()

	table.sort(screens, function(a, b)
		local af = a:frame()
		local bf = b:frame()

		if af.y == bf.y then
			return af.x < bf.x
		end

		return af.y < bf.y
	end)

	return screens
end

-- Dedicated filter that spans ALL Mission Control Spaces. This is required when
-- "Displays have separate Spaces" is on, otherwise windows living on other
-- monitors' spaces are invisible to the default (current-space-only) filter.
local screenFilter = hs.window.filter.new(true):setCurrentSpace(nil)

-- Remember the last window focused on each screen, so that jumping to a monitor
-- restores focus to the window you were actually using there. Global focus/z
-- order is unreliable across separate Spaces and gets corrupted when an app has
-- windows on several monitors (focusing one raises them all).
local lastFocusedByScreen = {}

screenFilter:subscribe(hs.window.filter.windowFocused, function(w)
	local screen = w:screen()
	if screen and w:isStandard() then
		lastFocusedByScreen[screen:id()] = w
	end
end)

-- Standard windows currently living on the given screen.
local function windowsOnScreen(screen)
	local result = {}
	for _, w in ipairs(screenFilter:getWindows()) do
		if w:isStandard() and w:screen():id() == screen:id() then
			result[#result + 1] = w
		end
	end
	return result
end

-- Focus a specific window reliably, even when its app has another window on a
-- different monitor's Space. Plain window:focus() activates the app and lets
-- macOS pick the app's "main" window (often on another monitor), so we force
-- this exact window to become main/focused via the accessibility API.
local function focusWindow(w)
	-- Some apps (notably Chrome) revert our focus request ~1 runloop after we
	-- write it, restoring their own "active" window when the app is activated —
	-- badly across separate Spaces with windows on several monitors. So we assert
	-- the focus, then RE-assert it shortly after, to get the last word.
	local function assertFocus()
		pcall(function()
			local winElem = hs.axuielement.windowElement(w)
			if winElem then
				winElem:performAction("AXRaise")
				winElem:setAttributeValue("AXMain", true)
				winElem:setAttributeValue("AXFocused", true)
			end
			local appElem = hs.axuielement.applicationElement(w:application())
			if appElem then
				appElem:setAttributeValue("AXFrontmost", true)
			end
		end)
	end

	assertFocus()
	hs.timer.doAfter(0.1, assertFocus)
end

-- Focus the last window used on the given screen, falling back to any window on
-- it. Returns false when the screen has no focusable window.
local function focusScreen(screen)
	local windows = windowsOnScreen(screen)
	if #windows == 0 then
		return false
	end

	local tracked = lastFocusedByScreen[screen:id()]
	local trackedId = tracked and tracked:id()
	local target = windows[1]
	for _, w in ipairs(windows) do
		if trackedId and w:id() == trackedId then
			target = w
			break
		end
	end

	focusWindow(target)
	return true
end

local function focusMonitor(delta)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screens = orderedScreens()
	if #screens < 2 then
		return
	end

	local currentIndex
	for i, screen in ipairs(screens) do
		if screen:id() == win:screen():id() then
			currentIndex = i
			break
		end
	end
	if not currentIndex then
		return
	end

	-- Walk monitors in the requested direction, wrapping around and skipping the
	-- current one, until we find a monitor that has a focusable window.
	for step = 1, #screens - 1 do
		local index = ((currentIndex - 1 + delta * step) % #screens) + 1
		if focusScreen(screens[index]) then
			return
		end
	end
end

local focusPrevMonitor = function()
	focusMonitor(-1)
end

local focusNextMonitor = function()
	focusMonitor(1)
end

local function moveMonitor(delta)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screens = orderedScreens()
	local current = win:screen()

	for i, screen in ipairs(screens) do
		if screen:id() == current:id() then
			local nextIndex = ((i - 1 + delta) % #screens) + 1
			win:moveToScreen(screens[nextIndex])
			return
		end
	end
end

local movePrevMonitor = function()
	moveMonitor(-1)
end

local moveNextMonitor = function()
	moveMonitor(1)
end

-- AutoFill
local windowFilter = hs.window.filter.new()
windowFilter:subscribe(hs.window.filter.windowCreated, autoFill)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "tab", quakeTerminal)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "D", focusPrevMonitor)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "F", focusNextMonitor)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "E", movePrevMonitor)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "R", moveNextMonitor)
