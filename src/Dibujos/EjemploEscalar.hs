module Dibujos.EjemploEscalar
  ( ejemploEscalarConf,
  )
where

import Dibujo (Dibujo, figura, escalar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (line, pictures, polygon, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Interp (Conf (..), interp)

type Basica = ()

ejemplo :: Dibujo Basica
ejemplo = escalar (1/3) (1/2) $ figura ()

interpBas :: Output Basica
interpBas () a b c = pictures [line $ triangulo a b c, cara a b c]
  where
    triangulo a b c = map (a V.+) [zero, c, b, zero]
    cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

ejemploEscalarConf :: Conf
ejemploEscalarConf =
  Conf
    { name = "EjemploEscalar",
      pic = interp interpBas ejemplo
    }
