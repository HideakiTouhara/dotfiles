-- 外部ディスプレイ切断→再接続時にウィンドウ配置を自動復元する
-- 仕組み:
--   1. 外部ディスプレイ接続中、30秒ごと+スリープ直前にウィンドウ位置を記録
--   2. 画面構成が変わって外部ディスプレイが戻ってきたら、少し待ってから復元

local savedFrames = {}   -- winId -> frame
local savedCount = 0

local function externalPresent()
  return #hs.screen.allScreens() > 1
end

local function saveLayout()
  if not externalPresent() then return end
  local frames = {}
  local n = 0
  for _, win in ipairs(hs.window.visibleWindows()) do
    if win:isStandard() then
      frames[win:id()] = win:frame()
      n = n + 1
    end
  end
  if n > 0 then
    savedFrames = frames
    savedCount = n
  end
end

local function restoreLayout()
  if savedCount == 0 then return end
  local restored = 0
  for _, win in ipairs(hs.window.visibleWindows()) do
    local f = savedFrames[win:id()]
    if f and win:isStandard() then
      win:setFrame(f)
      restored = restored + 1
    end
  end
  if restored > 0 then
    hs.alert.show("ウィンドウ配置を復元 (" .. restored .. "枚)")
  end
end

-- 定期保存(外部ディスプレイがある間だけ)
saveTimer = hs.timer.doEvery(30, saveLayout)

-- スリープ直前にも保存(直近の移動を取りこぼさない)
sleepWatcher = hs.caffeinate.watcher.new(function(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    saveLayout()
  end
end)
sleepWatcher:start()

-- 画面構成の変化を監視: 外部ディスプレイが戻ったら復元
-- (macOS側の再配置が落ち着くまで5秒待ってから実行)
screenWatcher = hs.screen.watcher.new(function()
  if externalPresent() then
    hs.timer.doAfter(5, restoreLayout)
  end
end)
screenWatcher:start()

-- 手動復元用ホットキー(念のため): Ctrl+Option+Cmd+R
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "r", restoreLayout)

hs.alert.show("Hammerspoon: ウィンドウ復元 有効")
