-- Modulo de interpretacion

module Interp
  ( interp,
    Conf (..),
    interpConf,
    initial,
  )
where

import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid, half, zero)
import Graphics.Gloss (Display (InWindow), Picture, Vector, color, display, makeColorI, pictures, translate, white)

-- Interpretación de un dibujo
-- formulas sacadas del enunciado
-- Le permite al usuario interpretar dibujos cuando el solo sabe interpretar sus figuras basicas
-- El problema es como combinar floating pics devueltas por llamadas recursivas dependiendo del caso recursivo
-- Como no tenemos acceso constructores, tenemos que usar foldDib
-- No entiendo las formulas geometricas, solo las copie del enunciado :D
interp :: Output a -> Output (Dibujo a)
interp interpBas = foldDib interpBas interpRot interpEsp interpRot45 interpApil interpJuntar interpEncim

interpRot :: FloatingPic -> FloatingPic
interpRot fp x w h = fp (x V.+ w) h (zero V.- w)

interpEsp :: FloatingPic -> FloatingPic
interpEsp fp x w = fp (x V.+ w) (zero V.- w)

interpRot45 :: FloatingPic -> FloatingPic
interpRot45 fp x w h = fp (x V.+ half (w V.+ h)) (half (w V.+ h)) (half (h V.- w))

interpApil :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpApil n m fp gp x w h = pictures [fp (x V.+ h') w (r V.* h), gp x w h']
  where
    r' = n / (m + n)
    r = m / (m + n)
    h' = r' V.* h

interpJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
-- Esta formula de juntar(particularmente como calcula los anchos) hace que 
-- n se corresponda con la segunda imagen en vez de con la primera, y lo mismo con m y la primera
interpJuntar n m fp gp x w h = pictures [fp x w' h, gp (x V.+ w') (r' V.* w) h]
  where
    r' = n / (m + n)
    r = m / (m + n)
    w' = r V.* w

interpEncim :: FloatingPic -> FloatingPic -> FloatingPic
interpEncim fp gp x w h = pictures [fp x w h, gp x w h]

-- Configuración de la interpretación
-- Basicamente un dibujo
data Conf = Conf
  { name :: String,
    pic :: FloatingPic
  }

interpConf :: Conf -> Float -> Float -> Picture
--  Tres puntos que marcan un cuadrilatero(siempre sera un paralelogramo)
--  NO NECESARIAMENTE el dibujo sea un cuadrilatero, solo el espacio que lo contiene
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
  where
    -- argumento magico que no se usa: y
    --               |
    --               v
    withGrid p x y = translate (-size / 2) (-size / 2) $ pictures [p, greyGrid x]
    grey = makeColorI 120 120 120 120
    greyGrid x = color grey $ grid (ceiling $ size / 10) (0, 0) x 10
