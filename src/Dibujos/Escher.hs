module Dibujos.Escher
  ( escherConf,
  )
where

import Dibujo (Dibujo, figura, rotar, rot45, r180, r270, ciclar, cuarteto, (.-.), (///), apilar, juntar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture, blue, color, line, pictures, red, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla (grilla)
import Interp (Conf (..), interp)

-- Tipo de dato de Escher (vacio o no)
type Escher = Bool

-- El dibujoU.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = rot45 (r180 (ciclar p))

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = rot45 ((.-.) p (r270 p))

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina n f | n == 1 = cuarteto (figura False) (figura False) (figura False) (dibujoU f)
            | otherwise = cuarteto (esquina (n-1) f) (lado (n-1) f) (rot45 (lado (n-1) f)) (dibujoU f)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado n f | n == 1 = cuarteto (figura False) (figura False) (rot45 f) f
         | otherwise = cuarteto (lado (n-1) f) (lado (n-1) f) (rot45 f) f

-- Por suerte no tenemos que poner el tipo!
-- nonet(p, q, r,
--       s, t, u,
--       v, w, x) =
--          above(1, 2,
--            beside(1, 2, p, beside(1, 1, q, r)),
--            above(1, 1,
--              beside(1, 2, s, beside(1, 1, t, u)),
--              beside(1, 2, v, beside(1, 1, w, x))
--            )
--          )
nonet p q r s t u v w x = 
  apilar 1 2
    (juntar 1 2 p ((///) q r))
    ((.-.)
      (juntar 1 2 s ((///) t u))
      (juntar 1 2 v ((///) w x))
    )

-- El dibujo de Escher:
-- squarelimit =
--    nonet(corner, side, rot(rot(rot(corner)))
--            rot(side), u, rot(rot(rot(side))),
--            rot(corner), rot(rot(side)), rot(rot(corner))
--    )
-- ES LO PUESTO EN EL PDF DEL TRABAJO, ADAPTAR A ESCHER
escher :: Int -> Escher -> Dibujo Escher
escher n p = 
  nonet
    (esquina n dp) (lado n dp) (r270 (esquina n dp))
    (rotar (lado n dp)) (dibujoU dp) (r270 (lado n dp))
    (rotar (esquina n dp)) (r180 (lado n dp)) (r180 (esquina n dp))
  where
    dp = figura p

-- Configuración del dibujo de Escher
escherConf :: Conf
escherConf =
  Conf
    { name = "Escher"
      -- FALTA COMPLETAR
    }