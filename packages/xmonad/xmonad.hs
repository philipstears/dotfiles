import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Config.Gnome

main = xmonad $ gnomeConfig
                { manageHook = manageDocks <+> manageHook gnomeConfig
                , layoutHook = noBorders $ avoidStruts $ layoutHook gnomeConfig
                , keys = keys def -- Naff off gnome, I want default bindings
                , modMask = mod4Mask
                , startupHook = do

                    -- Make Java Swing Apps work
                    setWMName "LG3D"

                    spawn "/bin/sh ~/.xmonad/startup-hook"
                    startupHook gnomeConfig
                }

