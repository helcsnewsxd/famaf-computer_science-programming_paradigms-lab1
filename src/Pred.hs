module Pred
  ( Pred,
    cambiar,
    anyDib,
    allDib,
    orP,
    andP,
  )
where

-- Importo las funciones y datos de Dibujo.hs
import Dibujo (Dibujo, figura, foldDib)

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred TriOCuat` que devuelve `True` cuando la
-- figura es `Triangulo`.
type Pred a = a -> Bool

-- Dado un predicado sobre figuras básicas, cambiar todas las que satisfacen
-- el predicado por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Figura x))` rota
-- todos los triángulos.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar = undefined

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib = undefined

-- Todas las básicas satisfacen el predicado.
-- Se aplica la función f_pred en cada Figura del Dibujo a
-- Las demás funciones lambda se encargan de hacer el and correspondiente
-- para chequear que se cumpla en TODAS las figuras
allDib :: Pred a -> Dibujo a -> Bool
allDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a&&b) (\ _ _ a b -> a&&b) (&&)

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP = undefined

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP = undefined

