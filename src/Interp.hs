-- Modulo de interpretacion

module Interp
  ( interp,
    Conf (..),
    interpConf,
    initial,
  )
where

import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid)
import Graphics.Gloss (Display (InWindow), Picture, color, display, makeColorI, pictures, translate, white)

-- Interpretación de un dibujo
-- formulas sacadas del enunciado
interp :: Output a -> Output (Dibujo a)
interp = undefined

-- Configuración de la interpretación
-- Basicamente un dibujo
data Conf = Conf
  { name :: String,
    pic :: FloatingPic
  }

interpConf :: Conf -> Float -> Float -> Picture
interpConf (Conf _ p) x y = p (0, 0) (x, 0) (0, y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
    -- argumento magico que no se usa: y
    --               |
    --               v
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, greyGrid x]
        grey = makeColorI 120 120 120 120
        greyGrid x = color grey $ grid (ceiling $ size / 10) (0, 0) x 10
