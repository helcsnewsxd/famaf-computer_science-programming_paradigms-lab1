module Dibujos.Escher
  ( escherConf,
  )
where

import Dibujo (Dibujo, figura, rotar, rot45, r180, r270, ciclar, cuarteto, (.-.), (///), apilar, juntar)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture (Blank), blue, color, line, pictures, red, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla (grilla)
import Interp (Conf (..), interp)

-- Tipo de dato de Escher (vacio o no)
type Escher = Bool

p :: Dibujo Escher
p = figura True

-- El dibujoU.
dibujoU :: Dibujo Escher
dibujoU = rot45 (r180 (ciclar p))

-- El dibujo t.
dibujoT :: Dibujo Escher
dibujoT = rot45 ((.-.) p (r270 p))

dibujoV = ciclar $ rotar dibujoT

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher
esquina 1 = cuarteto (figura False) (figura False) (figura False) dibujoU
esquina n = cuarteto (esquina (n-1)) (lado (n-1)) (rot45 (lado (n-1))) dibujoU

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher
lado 1 = cuarteto (figura False) (figura False) (rot45 dibujoT) dibujoT
lado n = cuarteto (lado (n-1)) (lado (n-1)) (rot45 dibujoT) dibujoT

-- Arreglo de 9 en grilla
nonet p q r s t u v w x = 
  apilar 1 2
    (juntar 1 2 p ((///) q r))
    ((.-.)
      (juntar 1 2 s ((///) t u))
      (juntar 1 2 v ((///) w x))
    )

-- El dibujo de Escher:
squarelimit :: Int -> Dibujo Escher
squarelimit n = 
  nonet
    (esquina n) (lado n) (r270 (esquina n))
    (rotar (lado n )) dibujoU  (r270 (lado n ))
    (rotar (esquina n )) (r180 (lado n )) (r180 (esquina n ))


interpBas :: Output Escher
interpBas False x y z = Blank
interpBas True x y z = Blank -- Cambiar esto para que dibujo un triangulo o un pecesito

-- Configuración del dibujo de Escher
escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = interp interpBas (squarelimit 2)
    }
