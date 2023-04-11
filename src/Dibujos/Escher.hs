module Dibujos.Escher
  ( escherConf,
  )
where

import Dibujo (Dibujo, encimar4, apilar, juntar, cuarteto, espejar, encimar, figura, rotar, rot45, r180, r270)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture (Blank), blue, color, line, pictures, red, white, polygon)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla (grilla)
import Interp (Conf (..), interp)

-- Tipo de dato de Escher (vacio o no)
type Escher = Bool

-- Tipos de dibujos base

base :: Dibujo Escher
base = figura True

rbase :: Dibujo Escher
rbase = espejar $ rot45 base

vbase :: Dibujo Escher
vbase = figura False

-- El dibujoU.
dibujoU :: Dibujo Escher
dibujoU = encimar4 rbase

-- El dibujo t.
dibujoT :: Dibujo Escher
dibujoT = encimar base $ encimar base2 base3
  where
    base2 = espejar $ rot45 base
    base3 = r270 base2
  

-- Esquina con nivel de detalle en base a la figura base.
esquina :: Int -> Dibujo Escher
esquina n | n==0 = cuarteto vbase vbase vbase dibujoU
          | otherwise = cuarteto (esquina (n-1)) (lado (n-1)) (rotar (lado (n-1))) dibujoU

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher
lado n | n==0 = cuarteto vbase vbase (rotar dibujoT) dibujoT
      | otherwise = cuarteto (lado (n-1)) (lado (n-1)) (rotar dibujoT) dibujoT
-- Arreglo de 9 en grilla
nonet p q r s t u v w x = grilla [[p, q, r], 
                                  [s, t, u], 
                                  [v, w, x]]

-- El dibujo de Escher:
escher :: Int -> Dibujo Escher
escher n =
  nonet
    (esquina n) (lado n) (r270 (esquina n))
    (rotar (lado n )) dibujoU  (r270 (lado n ))
    (rotar (esquina n )) (r180 (lado n )) (r180 (esquina n ))


interpBas :: Output Escher
interpBas False x y z = Blank
interpBas True a b c = pictures [line $ triangulo a b c, cara a b c]
  where
    triangulo a b c = map (a V.+) [zero, c, b, zero]
    cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

dibujito :: Dibujo Escher
dibujito = escher 5

-- Configuración del dibujo de Escher
escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = interp interpBas dibujito
    }
