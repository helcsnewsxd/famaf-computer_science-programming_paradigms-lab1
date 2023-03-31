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

-- La función cambiar recorre recursivamente todo el dibujo usando la función foldDib.
-- A medida que va recorriendo, genera un nuevo dibujo, cambiando aquellas figuras básicas que
-- cumplan con el pred_a con la función f. Como se genera un nuevo dibujo, se usa f_rot, f_esp, etc
-- para construir el nuevo dibujo con las figuras básicas cambiadas (o no, según corresponda)
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar pred_a f = foldDib f_fig f_rot f_esp f_rot45 f_apil f_junt f_encim
  where -- where sirve para definir las variables que se usan arriba
    f_fig a = if pred_a a then f a else figura a -- si se cumple pred_a, se transforma la figura básica
    f_rot = rotar                                -- si no se cumple, se deja la figura a
    f_esp = espejar
    f_rot45 = rot45
    f_apil = apilar
    f_junt = juntar
    f_encim = encimar

-- Alguna básica satisface el predicado.
-- Análogo al funcionamiento de allDib, se aplica f_pred en cada figura del Dibujo a.
-- Las funciones lambda se encargan de hacer el or correspondiente para chequear que
-- se cumpla en TODAS las figuras
anyDib :: Pred a -> Dibujo a -> Bool
anyDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a||b) (\ _ _ a b -> a||b) (||)

-- Todas las básicas satisfacen el predicado.
-- Se aplica la función f_pred en cada Figura del Dibujo a
-- Las demás funciones lambda se encargan de hacer el and correspondiente
-- para chequear que se cumpla en TODAS las figuras
allDib :: Pred a -> Dibujo a -> Bool
allDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a&&b) (\ _ _ a b -> a&&b) (&&)

-- Los dos predicados se cumplen para el elemento recibido.
-- andP :: Pred a -> Pred a -> a -> Bool
andP :: Pred a -> Pred a -> Pred a
andP pred_a pred_b e = pred_a e && pred_b e

-- Algún predicado se cumple para el elemento recibido.
-- orP :: Pred a -> Pred a -> a -> Bool
orP :: Pred a -> Pred a -> Pred a
orP pred_a pred_b e = pred_a e || pred_b e

