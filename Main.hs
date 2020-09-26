import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

import qualified Args as A
import Alps (alpsFootprint, tecFootprint)
import Mx (mxFootprint)
import Atreus
import Keyboard
import Promicro

cmToPx = 37.79527559055118

switchFootprint :: A.KeyswitchName -> Footprint
switchFootprint A.Tec = tecFootprint
switchFootprint A.Alps = alpsFootprint
switchFootprint A.Mx = mxFootprint

keyboardFromName :: A.KeyboardName -> Keyboard
keyboardFromName A.Nammu = atreus
keyboardFromName A.Utu = orthoAtreus

drawProject :: A.Options -> Diagram B
drawProject o = d # scale cmToPx # op
  where kb = keyboardFromName . A.name $ o
        switch = switchFootprint . A.keyswitch $ o
        d = drawKeyboard switch kb
        op = if A.right o then reflectX else id

main :: IO ()
main = mainWith drawProject
