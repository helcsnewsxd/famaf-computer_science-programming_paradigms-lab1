module Dibujos.Grilla (grillaConf)
where

import Dibujo (Dibujo, figura, rotar, rot45, r180, r270, ciclar, cuarteto, (.-.), (///), apilar, juntar, encimar, espejar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture (Blank), blue, color, line, pictures, red, white, polygon, text, translate, scale)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla (grilla)
import Interp (Conf (..), interp)


type Basica = (Int, Int)

-- Construimos una grilla de tamanio arbitrario
dibujoGrilla' n = map makeRow [0,1..n]
  where
  makeRow x = map (figura . (x,)) [0,1..n]

dibujoGrilla = grilla $ dibujoGrilla' 7

interpBas :: Output Basica
interpBas tupla (x, y) _ _ =  translate x y $ scale 0.15 0.15 $ text $ show tupla

grillaConf :: Conf
grillaConf =
  Conf
    { name = "Grilla",
      pic = interp interpBas dibujoGrilla
    }

