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
import Dibujo

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred TriOCuat` que devuelve `True` cuando la
-- figura es `Triangulo`.
type Pred a = a -> Bool

-- cambia todas las figuras de un dibujo aplicandoles la función que se pasa como argumento siempre
-- y cuando se cumpla el predicado
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar pred_a f = mapDib f_fig
  where
    f_fig a = if pred_a a then f a else figura a

-- Alguna básica satisface el predicado.
-- Análogo al funcionamiento de allDib, se aplica f_pred en cada figura del Dibujo a.
-- Las funciones lambda se encargan de hacer el or correspondiente para chequear que
-- se cumpla en TODAS las figuras
anyDib :: Pred a -> Dibujo a -> Bool
anyDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a||b) (\ _ _ a b -> a||b) (\ _ _ a -> a) (||)

-- Todas las básicas satisfacen el predicado.
-- Se aplica la función f_pred en cada Figura del Dibujo a
-- Las demás funciones lambda se encargan de hacer el and correspondiente
-- para chequear que se cumpla en TODAS las figuras
allDib :: Pred a -> Dibujo a -> Bool
allDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a&&b) (\ _ _ a b -> a&&b) (\ _ _ a -> a) (&&)

-- Los dos predicados se cumplen para el elemento recibido.
-- andP :: Pred a -> Pred a -> a -> Bool
andP :: Pred a -> Pred a -> Pred a
andP pred_a pred_b e = pred_a e && pred_b e

-- Algún predicado se cumple para el elemento recibido.
-- orP :: Pred a -> Pred a -> a -> Bool
orP :: Pred a -> Pred a -> Pred a
orP pred_a pred_b e = pred_a e || pred_b e

