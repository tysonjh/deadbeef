import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
      {
      modMask = mod4Mask
      , manageHook = manageDocks <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 50
        }
      } `additionalKeys`
        [
        ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
        ]
