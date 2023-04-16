import Test.HUnit
import Dibujo

-- Para poder utilizar este TEST, se debe ejecutar con el siguiente comando:
-- ghc test/Test_Dibujo.hs src/Dibujo.hs && test/Test_Dibujo
-- y además comentar las líneas 4 a 24 de Dibujo.sh (lo que oculta la implementación del módulo Dibujo)

-- Tipos de figuras
data Fig = Rectangulo | Circulo | Triangulo | Cuadrado | Cono deriving (Eq, Show)

-- Test figura
test_figura = TestCase (assertEqual "figura" (Figura Rectangulo) (figura Rectangulo))

-- Test rotar
test_rotar = TestCase (assertEqual "rotar" (Rotar (Figura Rectangulo)) (rotar (Figura Rectangulo)))
test_rotar1 = TestCase (assertEqual "rotar1" (Rotar (Rotar (Figura Rectangulo))) (rotar (rotar (Figura Rectangulo))))
test_rotar2 = TestCase (assertEqual "rotar2" (Rotar (Rotar (Rotar (Figura Rectangulo)))) (rotar (rotar (rotar (Figura Rectangulo)))))

-- Test espejar
test_espejar = TestCase (assertEqual "espejar" (Espejar (Figura Rectangulo)) (espejar (Figura Rectangulo)))
test_espejar1 = TestCase (assertEqual "espejar1" (Espejar (Espejar (Figura Rectangulo))) (espejar (espejar (Figura Rectangulo))))
test_espejar2 = TestCase (assertEqual "espejar2" (Espejar (Espejar (Espejar (Figura Rectangulo)))) (espejar (espejar (espejar (Figura Rectangulo)))))

-- Test rot45
test_rot45 = TestCase (assertEqual "rot45" (Rot45 (Figura Rectangulo)) (rot45 (Figura Rectangulo)))
test_rot451 = TestCase (assertEqual "rot451" (Rot45 (Rot45 (Figura Rectangulo))) (rot45 (rot45 (Figura Rectangulo))))
test_rot452 = TestCase (assertEqual "rot452" (Rot45 (Rot45 (Rot45 (Figura Rectangulo)))) (rot45 (rot45 (rot45 (Figura Rectangulo)))))

-- Test escalar
test_escalar = TestCase (assertEqual "escalar" (Escalar 2 2 (Figura Rectangulo)) (escalar 2 2 (Figura Rectangulo)))
test_escalar1 = TestCase (assertEqual "escalar1" (Escalar 2 2 (Escalar 2 2 (Figura Rectangulo))) (escalar 2 2 (escalar 2 2 (Figura Rectangulo))))
test_escalar2 = TestCase (assertEqual "escalar2" (Escalar 2 2 (Escalar 2 2 (Escalar 2 2 (Figura Rectangulo)))) (escalar 2 2 (escalar 2 2 (escalar 2 2 (Figura Rectangulo)))))

-- Test apilar
test_apilar = TestCase (assertEqual "apilar" (Apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)))
test_apilar1 = TestCase (assertEqual "apilar1" (Apilar 2 2 (Apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (apilar 2 2 (apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_apilar2 = TestCase (assertEqual "apilar2" (Apilar 2 2 (Apilar 2 2 (Apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) (apilar 2 2 (apilar 2 2 (apilar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test juntar
test_juntar = TestCase (assertEqual "juntar" (Juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)))
test_juntar1 = TestCase (assertEqual "juntar1" (Juntar 2 2 (Juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (juntar 2 2 (juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_juntar2 = TestCase (assertEqual "juntar2" (Juntar 2 2 (Juntar 2 2 (Juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) (juntar 2 2 (juntar 2 2 (juntar 2 2 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test encimar
test_encimar = TestCase (assertEqual "encimar" (Encimar (Figura Rectangulo) (Figura Rectangulo)) (encimar (Figura Rectangulo) (Figura Rectangulo)))
test_encimar1 = TestCase (assertEqual "encimar1" (Encimar (Encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (encimar (encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_encimar2 = TestCase (assertEqual "encimar2" (Encimar (Encimar (Encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) (encimar (encimar (encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test r180
test_r180 = TestCase (assertEqual "r180" (Rotar (Rotar (Figura Rectangulo))) (r180 (Figura Rectangulo)))
test_r1801 = TestCase (assertEqual "r1801" (Rotar (Rotar (Rotar (Rotar (Figura Rectangulo))))) (r180 (r180 (Figura Rectangulo))))
test_r1802 = TestCase (assertEqual "r1802" (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Figura Rectangulo))))))) (r180 (r180 (r180 (Figura Rectangulo)))))

-- Test r270
test_r270 = TestCase (assertEqual "r270" (Rotar (Rotar (Rotar (Figura Rectangulo)))) (r270 (Figura Rectangulo)))
test_r2701 = TestCase (assertEqual "r2701" (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Figura Rectangulo))))))) (r270 (r270 (Figura Rectangulo))))
test_r2702 = TestCase (assertEqual "r2702" (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Rotar (Figura Rectangulo)))))))))) (r270 (r270 (r270 (Figura Rectangulo)))))

-- Test (.-.)
test_apilar_sin_escalar = TestCase (assertEqual "apilar sin escalar" (Apilar 1 1 (Figura Rectangulo) (Figura Rectangulo)) ((.-.) (Figura Rectangulo) (Figura Rectangulo)))
test_apilar_sin_escalar1 = TestCase (assertEqual "apilar sin escalar1" (Apilar 1 1 (Apilar 1 1 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) ((.-.) ((.-.) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_apilar_sin_escalar2 = TestCase (assertEqual "apilar sin escalar2" (Apilar 1 1 (Apilar 1 1 (Apilar 1 1 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) ((.-.) ((.-.) ((.-.) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test (///)
test_juntar_sin_escalar = TestCase (assertEqual "juntar sin escalar" (Juntar 1 1 (Figura Rectangulo) (Figura Rectangulo)) ((///) (Figura Rectangulo) (Figura Rectangulo)))
test_juntar_sin_escalar1 = TestCase (assertEqual "juntar sin escalar1" (Juntar 1 1 (Juntar 1 1 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) ((///) ((///) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_juntar_sin_escalar2 = TestCase (assertEqual "juntar sin escalar2" (Juntar 1 1 (Juntar 1 1 (Juntar 1 1 (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) ((///) ((///) ((///) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test (^^^)
test_encimar_0 = TestCase (assertEqual "encimar_0" (Encimar (Figura Rectangulo) (Figura Rectangulo)) ((^^^) (Figura Rectangulo) (Figura Rectangulo)))
test_encimar_1 = TestCase (assertEqual "encimar_1" (Encimar (Encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) ((^^^) ((^^^) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)))
test_encimar_2 = TestCase (assertEqual "encimar_2" (Encimar (Encimar (Encimar (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)) ((^^^) ((^^^) ((^^^) (Figura Rectangulo) (Figura Rectangulo)) (Figura Rectangulo)) (Figura Rectangulo)))

-- Test cuarteto
test_cuarteto = TestCase (assertEqual "cuarteto" (Apilar 1 1 (Juntar 1 1 (Figura Rectangulo) (Figura Triangulo)) (Juntar 1 1 (Figura Circulo) (Figura Cono))) (cuarteto (Figura Rectangulo) (Figura Triangulo) (Figura Circulo) (Figura Cono)))

-- Test encimar4
test_encimar4_0 = TestCase (assertEqual "encimar4_0" (Encimar (Rotar (Rotar (Rotar (Figura Rectangulo)))) (Encimar (Rotar (Rotar (Figura Rectangulo))) (Encimar (Rotar (Figura Rectangulo)) (Figura Rectangulo)))) (encimar4 (Figura Rectangulo)))

-- Test ciclar
test_ciclar_0 = TestCase (assertEqual "ciclar_0" (Apilar 1 1 (Juntar 1 1 (Figura Rectangulo) (Rotar (Figura Rectangulo))) (Juntar 1 1 (Rotar (Rotar (Figura Rectangulo))) (Rotar (Rotar (Rotar (Figura Rectangulo)))))) (ciclar (Figura Rectangulo)))

-- Test mezclando las anteriores
test_mezcla0 = TestCase (assertEqual "mezcla0" (Apilar 1 1 (Juntar 1 1 (Figura Rectangulo) (Rotar (Figura Rectangulo))) (Juntar 1 1 (Rotar (Rotar (Figura Rectangulo))) (Rotar (Rotar (Rotar (Figura Rectangulo)))))) (ciclar (figura Rectangulo)))
test_mezcla1 = TestCase (assertEqual "mezcla1" (Rotar (Encimar (Juntar 1 0.5 (Figura Rectangulo) (Figura Triangulo)) (Rotar (Figura Cuadrado)))) (rotar (encimar (juntar 1 0.5 (figura Rectangulo) (figura Triangulo)) (rotar (figura Cuadrado)))))
test_mezcla2 = TestCase (assertEqual "mezcla2" (Encimar (Juntar 1 0.5 (Figura Rectangulo) (Figura Triangulo)) (Rotar (Figura Cuadrado))) (encimar (juntar 1 0.5 (figura Rectangulo) (figura Triangulo)) (rotar (figura Cuadrado))))
test_mezcla3 = TestCase (assertEqual "mezcla3" (Apilar 1 0.5 (Figura Rectangulo) (Figura Triangulo)) (apilar 1 0.5 (figura Rectangulo) (figura Triangulo)))
test_mezcla4 = TestCase (assertEqual "mezcla4" (Juntar 1 0.5 (Figura Rectangulo) (Figura Triangulo)) (juntar 1 0.5 (figura Rectangulo) (figura Triangulo)))
test_mezcla5 = TestCase (assertEqual "mezcla5" (Rotar (Figura Rectangulo)) (rotar (figura Rectangulo)))
test_mezcla6 = TestCase (assertEqual "mezcla6" (Escalar 0.5 0.8 (Figura Rectangulo)) (escalar 0.5 0.8 (figura Rectangulo)))

-- Test de foldDib
test_fold_dib1 = TestCase (assertEqual "test_fold_dib1" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Figura 1)))
test_fold_dib2 = TestCase (assertEqual "test_fold_dib2" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Rotar (Figura 1))))
test_fold_dib3 = TestCase (assertEqual "test_fold_dib3" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Espejar (Figura 1))))
test_fold_dib4 = TestCase (assertEqual "test_fold_dib4" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Rot45 (Figura 1))))
test_fold_dib5 = TestCase (assertEqual "test_fold_dib5" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Juntar 1 1 (Figura 1) (Figura 2))))
test_fold_dib6 = TestCase (assertEqual "test_fold_dib6" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Apilar 1 1 (Figura 1) (Figura 2))))
test_fold_dib7 = TestCase (assertEqual "test_fold_dib7" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (\_ _ a -> a) (+) (Encimar (Figura 1) (Figura 2))))

-- Test de mapDib
test_map_dib1 = TestCase (assertEqual "test_map_dib1" (Figura 1) (mapDib figura (Figura 1)))
test_map_dib2 = TestCase (assertEqual "test_map_dib2" (Rotar (Figura 1)) (mapDib figura (Rotar (Figura 1))))
test_map_dib3 = TestCase (assertEqual "test_map_dib3" (Espejar (Figura 1)) (mapDib figura (Espejar (Figura 1))))
test_map_dib4 = TestCase (assertEqual "test_map_dib4" (Rot45 (Figura 1)) (mapDib figura (Rot45 (Figura 1))))
test_map_dib5 = TestCase (assertEqual "test_map_dib5" (Juntar 1 2 (Figura 1) (Figura 4)) (mapDib (\a -> figura (a*a)) (Juntar 1 2 (Figura 1) (Figura 2))))
test_map_dib6 = TestCase (assertEqual "test_map_dib6" (Apilar 1 2 (Figura 1) (Figura 4)) (mapDib (\a -> figura (a*a)) (Apilar 1 2 (Figura 1) (Figura 2))))
test_map_dib7 = TestCase (assertEqual "test_map_dib7" (Encimar (Figura 2) (Figura 6)) (mapDib (\a -> figura (a*a+a)) (Encimar (Figura 1) (Figura 2))))

-- Test figuras
test_figuras1 = TestCase (assertEqual "test_figuras1" [1] (figuras (Figura 1)))
test_figuras2 = TestCase (assertEqual "test_figuras2" [1] (figuras (Rotar (Figura 1))))
test_figuras3 = TestCase (assertEqual "test_figuras3" [1] (figuras (Espejar (Figura 1))))
test_figuras4 = TestCase (assertEqual "test_figuras4" [1] (figuras (Rot45 (Figura 1))))
test_figuras5 = TestCase (assertEqual "test_figuras5" [1,2] (figuras (Juntar 1 2 (Figura 1) (Figura 2))))
test_figuras6 = TestCase (assertEqual "test_figuras6" [1,2] (figuras (Apilar 1 2 (Figura 1) (Figura 2))))
test_figuras7 = TestCase (assertEqual "test_figuras7" [1,2] (figuras (Encimar (Figura 1) (Figura 2))))

-- Ejecutar TODOS los casos de prueba
tests = TestList [TestLabel "test_figura" test_figura,
                  TestLabel "test_rotar" test_rotar,
                    TestLabel "test_rotar1" test_rotar1,
                    TestLabel "test_rotar2" test_rotar2,
                  TestLabel "test_espejar" test_espejar,
                    TestLabel "test_espejar1" test_espejar1,
                    TestLabel "test_espejar2" test_espejar2,
                  TestLabel "test_rot45" test_rot45,
                    TestLabel "test_rot451" test_rot451,
                    TestLabel "test_rot452" test_rot452,
                  TestLabel "test_escalar" test_escalar,
                    TestLabel "test_escalar1" test_escalar1,
                    TestLabel "test_escalar2" test_escalar2,
                  TestLabel "test_apilar" test_apilar,
                    TestLabel "test_apilar1" test_apilar1,
                    TestLabel "test_apilar2" test_apilar2,
                  TestLabel "test_juntar" test_juntar,
                    TestLabel "test_juntar1" test_juntar1,
                    TestLabel "test_juntar2" test_juntar2,
                  TestLabel "test_encimar" test_encimar,
                    TestLabel "test_encimar1" test_encimar1,
                    TestLabel "test_encimar2" test_encimar2,
                  TestLabel "test_r180" test_r180,
                    TestLabel "test_r1801" test_r1801,
                    TestLabel "test_r1802" test_r1802,
                  TestLabel "test_r270" test_r270,
                    TestLabel "test_r2701" test_r2701,
                    TestLabel "test_r2702" test_r2702,
                  TestLabel "test_apilar_sin_escalar" test_apilar_sin_escalar,
                    TestLabel "test_apilar_sin_escalar1" test_apilar_sin_escalar1,
                    TestLabel "test_apilar_sin_escalar2" test_apilar_sin_escalar2,
                  TestLabel "test_juntar_sin_escalar" test_juntar_sin_escalar,
                    TestLabel "test_juntar_sin_escalar1" test_juntar_sin_escalar1,
                    TestLabel "test_juntar_sin_escalar2" test_juntar_sin_escalar2,
                  TestLabel "test_encimar_0" test_encimar_0,
                    TestLabel "test_encimar_1" test_encimar_1,
                    TestLabel "test_encimar_2" test_encimar_2,
                  TestLabel "test_cuarteto" test_cuarteto,
                  TestLabel "test_encimar4_0" test_encimar4_0,
                  TestLabel "test_ciclar_0" test_ciclar_0,
                  TestLabel "test_mezcla0" test_mezcla0,
                    TestLabel "test_mezcla1" test_mezcla1,
                    TestLabel "test_mezcla2" test_mezcla2,
                    TestLabel "test_mezcla3" test_mezcla3,
                    TestLabel "test_mezcla4" test_mezcla4,
                    TestLabel "test_mezcla5" test_mezcla5,
                    TestLabel "test_mezcla6" test_mezcla6,
                  TestLabel "test_fold_dib1" test_fold_dib1,
                    TestLabel "test_fold_dib2" test_fold_dib2,
                    TestLabel "test_fold_dib3" test_fold_dib3,
                    TestLabel "test_fold_dib4" test_fold_dib4,
                    TestLabel "test_fold_dib5" test_fold_dib5,
                    TestLabel "test_fold_dib6" test_fold_dib6,
                    TestLabel "test_fold_dib7" test_fold_dib7,
                  TestLabel "test_map_dib1" test_map_dib1,
                    TestLabel "test_map_dib2" test_map_dib2,
                    TestLabel "test_map_dib3" test_map_dib3,
                    TestLabel "test_map_dib4" test_map_dib4,
                    TestLabel "test_map_dib5" test_map_dib5,
                    TestLabel "test_map_dib6" test_map_dib6,
                    TestLabel "test_map_dib7" test_map_dib7,
                  TestLabel "test_figuras1" test_figuras1,
                    TestLabel "test_figuras2" test_figuras2,
                    TestLabel "test_figuras3" test_figuras3,
                    TestLabel "test_figuras4" test_figuras4,
                    TestLabel "test_figuras5" test_figuras5,
                    TestLabel "test_figuras6" test_figuras6,
                    TestLabel "test_figuras7" test_figuras7]

main = runTestTT tests