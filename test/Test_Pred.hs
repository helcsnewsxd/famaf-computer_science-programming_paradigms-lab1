import Test.HUnit
import Pred
import Dibujo

-- Para poder utilizar este TEST, se debe ejecutar con el siguiente comando:
-- ghc test/Test_Pred.hs src/Pred.hs src/Dibujo.hs && test/Test_Pred
-- y además comentar las líneas 4 a 23 de Dibujo.sh (lo que oculta la implementación del módulo Dibujo)

testPred :: Test
testPred = test [
  -- Tests para cambiar
  cambiar (==1) (const (figura 2)) (figura 1) ~?= figura 2,
  cambiar (==1) (const (figura 2)) (figura 3) ~?= figura 3,
  cambiar (==1) (\x -> if x == 1 then figura 2 else figura 3) (apilar 1 1 (figura 1) (figura 1)) ~?= apilar 1 1 (figura 2) (figura 2),
  cambiar (==1) (\x -> if x == 1 then figura 2 else figura 3) (apilar 1 1 (figura 2) (figura 1)) ~?= apilar 1 1 (figura 2) (figura 2),

  -- Tests para anyDib
  anyDib (==1) (figura 2) ~?= False,
  anyDib (==1) (figura 1) ~?= True,
  anyDib (==1) (juntar 1 1 (figura 2) (figura 3)) ~?= False,
  anyDib (==1) (juntar 1 1 (figura 1) (figura 3)) ~?= True,

  -- Tests para allDib
  allDib (==1) (figura 2) ~?= False,
  allDib (==1) (figura 1) ~?= True,
  allDib (==1) (juntar 1 1 (figura 2) (figura 3)) ~?= False,
  allDib (==1) (juntar 1 1 (figura 1) (figura 1)) ~?= True,

  -- Tests para andP
  andP (==1) (==2) 1 ~?= False,
  andP (==1) (==1) 1 ~?= True,
  andP (==1) (==2) 2 ~?= False,
  andP (==1) (==1) 2 ~?= False,

  -- Tests para orP
  orP (==1) (==2) 1 ~?= True,
  orP (==1) (==2) 2 ~?= True,
  orP (==2) (==3) 1 ~?= False,
  orP (==2) (==3) 2 ~?= True
  ]

main :: IO Counts
main = runTestTT testPred
