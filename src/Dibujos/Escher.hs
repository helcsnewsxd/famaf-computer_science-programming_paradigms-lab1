module Dibujos.Escher
  ( escherConf,
  )
where

import Dibujo (Dibujo, figura, rotar, rot45, r180, r270, ciclar, cuarteto, (.-.), (///), apilar, juntar, encimar, espejar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture (Blank), blue, color, line, pictures, red, white, polygon)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla (grilla)
import Interp (Conf (..), interp)

-- Tipo de dato de Escher (vacio o no)
type Escher = Bool

p :: Dibujo Escher
p = figura True

-- El dibujoU.
dibujoU :: Dibujo Escher
dibujoU = ciclar p2
  where p2 = espejar $ rot45 p

-- El dibujo t.
dibujoT :: Dibujo Escher
-- dibujoT = encimar p $ encimar (r270 (rot45 p)) $ espejar $ rot45 p
dibujoT = encimar p $ encimar p2 p3
  where
    p2 = espejar $ rot45 p
    p3 = r270 p2

dibujoV = ciclar $ rotar dibujoT

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher
esquina 0 = cuarteto (figura False) (figura False) (figura False) dibujoU
esquina n = cuarteto (esquina (n-1)) (lado (n-1)) (rot45 (lado (n-1))) dibujoU

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher
lado 0 = cuarteto (figura False) (figura False) (rot45 dibujoT) dibujoT
lado n = cuarteto (lado (n-1)) (lado (n-1)) (rot45 dibujoT) dibujoT

-- Arreglo de 9 en grilla
-- nonet p q r s t u v w x = 
--   apilar 1 2
--     (juntar 1 2 p ((///) q r))
--     ((.-.)
--       (juntar 1 2 s ((///) t u))
--       (juntar 1 2 v ((///) w x))
--     )
nonet p q r s t u v w x = grilla [[p, q, r], [s, t, u], [v, w, x]]

-- El dibujo de Escher:
squarelimit :: Int -> Dibujo Escher
squarelimit n = 
  nonet
    (esquina n) (lado n) (r270 (esquina n))
    (rotar (lado n )) dibujoU  (r270 (lado n ))
    (rotar (esquina n )) (r180 (lado n )) (r180 (esquina n ))


interpBas :: Output Escher
interpBas False x y z = Blank
-- interpBas true a b c = polygon $ triangulo a b c
--   where
--     triangulo a b c = map (a V.+) [zero, c, b, zero]
interpBas True a b c = pictures [line $ triangulo a b c, cara a b c]
  where
    triangulo a b c = map (a V.+) [zero, c, b, zero]
    cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

dibujito = squarelimit 1
-- dibujito = encimar p $ r180 p
-- dibujito = dibujoV

-- Configuración del dibujo de Escher
escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = interp interpBas dibujito
      -- pic = interp interpBas (figura True)
    }
