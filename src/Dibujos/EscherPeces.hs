module Dibujos.EscherPeces
  ( escherPecesConf,
  )
where

import Dibujo (Dibujo, encimar4, apilar, juntar, cuarteto, espejar, encimar, figura, rotar, rot45, r180, r270)
import FloatingPic (Output, half, zero)
import Graphics.Gloss (Picture (Blank), blue, color, line, pictures, red, white, polygon, translate)
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
dibujoT = encimar base $ encimar rbase (r270 rbase)
  
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
    (rotar (lado n)) dibujoU  (r270 (lado n))
    (rotar (esquina n)) (r180 (lado n)) (r180 (esquina n))


interpBas :: Output Escher
interpBas False x y z = Blank
interpBas True a b c = pictures [cara , ojos, cola, agua]
  where
    triangulo x w h = map (x V.+) [zero, h, w]
    cara = polygon $ triangulo (a V.+ half c) (half b) (half c)
    ojo1 = color white $ polygon $ triangulo (a V.+ (2/3 V.* c) V.+ (1/20 V.*b)) (1/20 V.* b) (0.1 V.* c V.- (1/30 V.* b))
    ojo2 = uncurry translate (1/20 V.* b V.+ 1/20 V.* c) ojo1
    ojos = pictures [ojo1, ojo2]
    cola = polygon $ map (a V.+) [half b V.+ half c, 18/20 V.* b, b V.+ 2/20 V.*c]
    offizq = 1/4 V.* (zero V.- b V.+ c)
    lado = half b V.+ half c
    rect = line $ map ((a V.+ 1/4 V.* c) V.+) [offizq, zero, lado, lado V.+ offizq, offizq]
    agua = pictures [rect, olas 4]
    linealado = [zero, lado]
    olas :: Int -> Picture
    olas n = pictures $ map line $ zipWith (\m line -> map ((a V.+ 1/4 V.* c) V.+ (m/(fromIntegral n +1)) V.* offizq V.+) line ) [1.. fromIntegral n] $ replicate n linealado

-- Configuración del dibujo de Escher
escherPecesConf :: Conf
escherPecesConf =
  Conf
    { name = "EscherPeces",
      pic = interp interpBas (escher 5)
      -- pic = interp interpBas $ figura True
    }
