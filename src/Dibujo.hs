{-# LANGUAGE LambdaCase #-}

module Dibujo
  ( Dibujo,
    figura,
    rotar,
    espejar,
    rot45,
    apilar,
    juntar,
    encimar,
    r180,
    r270,
    (.-.),
    (///),
    (^^^),
    cuarteto,
    encimar4,
    ciclar,
    foldDib,
    mapDib,
    figuras,
  )
where

{-
Gramática de las figuras:
<Dibujo> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig>
    | Juntar <Float> <Float> <Fig> <Fig>
    | Encimar <Fig> <Fig>
-}

data Dibujo a
  = Figura a
  | Rotar (Dibujo a)
  | Espejar (Dibujo a)
  | Rot45 (Dibujo a)
  | Apilar Float Float (Dibujo a) (Dibujo a)
  | Juntar Float Float (Dibujo a) (Dibujo a)
  | Encimar (Dibujo a) (Dibujo a)
  deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Construcción de dibujo. Abstraen los constructores.

figura :: a -> Dibujo a
figura = Figura

rotar :: Dibujo a -> Dibujo a
rotar = Rotar

espejar :: Dibujo a -> Dibujo a
espejar = Espejar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar = Juntar

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar

comp :: (a -> a) -> Int -> a -> a
comp f 1 x = f x
comp f n x = comp f (n-1) (f x)

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 = comp rotar 2

r270 :: Dibujo a -> Dibujo a
r270 = comp rotar 3

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
(.-.) = apilar

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
(///) = juntar

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = encimar

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto p q r s = (.-.) 1 1 ((///) 1 1 p q) ((///) 1 1 r s) 

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 p = (^^^) (r270 p) ((^^^) (r180 p) ((^^^) (comp rotar 1 p) p ))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar p = cuarteto p (comp rotar 1 p) (r180 p) (r270 p)

-- Estructura general para la semántica (a no asustarse). Ayuda:
-- pensar en foldr y las definiciones de Intro a la lógica
foldDib ::
  (a -> b) ->
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b
foldDib = undefined

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
-- mapDib f (Figura a) = f a --> VER DE RESOLVER
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar p1 p2 a b) = Apilar p1 p2 (mapDib f a) (mapDib f b)
mapDib f (Juntar p1 p2 a b) = Juntar p1 p2 (mapDib f a) (mapDib f b)
mapDib f (Encimar a b) = Encimar (mapDib f a) (mapDib f b)

-- Junta todas las figuras básicas de un dibujo.
figuras = undefined
