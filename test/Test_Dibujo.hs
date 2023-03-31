import Test.HUnit
import Dibujo

-- Para poder utilizar este TEST, se debe ejecutar con el siguiente comando:
-- ghc test/Test_Dibujo.hs src/Dibujo.hs -package HUnit && test/Test_Dibujo
-- y además comentar las líneas 2 a 21 de Dibujo.sh (lo que oculta la implementación del módulo Dibujo)

-- Casos de prueba para la función figura
testFigura1 = TestCase (assertEqual "figura 1" (Figura 1) (figura 1))
testFigura2 = TestCase (assertEqual "figura 'a'" (Figura 'a') (figura 'a'))

-- Casos de prueba para la función rotar
testRotar1 = TestCase (assertEqual "rotar (figura 1)" (Rotar (Figura 1)) (rotar (Figura 1)))
testRotar2 = TestCase (assertEqual "rotar (Rotar (Figura 'a'))" (Rotar (Rotar (Figura 'a'))) (rotar (Rotar (Figura 'a'))))

-- Casos de prueba para la función espejar
testEspejar1 = TestCase (assertEqual "espejar (figura 1)" (Espejar (Figura 1)) (espejar (Figura 1)))
testEspejar2 = TestCase (assertEqual "espejar (Rotar (Figura 'a'))" (Espejar (Rotar (Figura 'a'))) (espejar (Rotar (Figura 'a'))))

-- Casos de prueba para la función rot45
testRot45_1 = TestCase (assertEqual "rot45 (figura 1)" (Rot45 (Figura 1)) (rot45 (Figura 1)))
testRot45_2 = TestCase (assertEqual "rot45 (Rotar (Figura 'a'))" (Rot45 (Rotar (Figura 'a'))) (rot45 (Rotar (Figura 'a'))))

-- Casos de prueba para la función apilar
testApilar1 = TestCase (assertEqual "apilar 1 2 (figura 1) (figura 2)" (Apilar 1 2 (Figura 1) (Figura 2)) (apilar 1 2 (Figura 1) (Figura 2)))
testApilar2 = TestCase (assertEqual "apilar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))" (Apilar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))) (apilar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))))

-- Casos de prueba para la función juntar
testJuntar1 = TestCase (assertEqual "juntar 1 2 (figura 1) (figura 2)" (Juntar 1 2 (Figura 1) (Figura 2)) (juntar 1 2 (Figura 1) (Figura 2)))
testJuntar2 = TestCase (assertEqual "juntar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))" (Juntar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))) (juntar 0.5 0.5 (Rotar (Figura 1)) (Espejar (Figura 2))))

-- Casos de prueba para la función encimar
testEncimar1 = TestCase (assertEqual "encimar (figura 1) (figura 2)" (Encimar (Figura 1) (Figura 2)) (encimar (Figura 1) (Figura 2)))
testEncimar2 = TestCase (assertEqual "encimar (Rotar (Figura 1)) (Espejar (Figura 2))" (Encimar (Rotar (Figura 1)) (Espejar (Figura 2))) (encimar (Rotar (Figura 1)) (Espejar (Figura 2))))

-- Casos de prueba para la función comp
testComp1 = TestCase (assertEqual "comp (+1) 1 1" 2 (comp (+1) 1 1))
testComp2 = TestCase (assertEqual "comp (+1) 1 2" 3 (comp (+1) 1 2))

-- Casos de prueba para la función r180
testR180_1 = TestCase (assertEqual "r180 (figura 1)" (Rotar (Rotar (Figura 1))) (r180 (Figura 1)))
testR180_2 = TestCase (assertEqual "r180 (Rotar (Figura 1))" (Rotar (Rotar (Rotar (Figura 1)))) (r180 (Rotar (Figura 1))))

-- Casos de prueba para la función r270
testR270_1 = TestCase (assertEqual "r270 (figura 1)" (Rotar (Rotar (Rotar (Figura 1)))) (r270 (Figura 1)))
testR270_2 = TestCase (assertEqual "r270 (Rotar (Figura 1))" (Rotar (Rotar (Rotar (Rotar (Figura 1))))) (r270 (Rotar (Figura 1))))

-- Casos de prueba para la función (.-.)
testPunto_1 = TestCase (assertEqual "figura 1 .-. figura 2" (Apilar 1 1 (Figura 1) (Figura 2)) (figura 1 .-. figura 2))
testPunto_2 = TestCase (assertEqual "figura 1 .-. Rotar (Figura 2)" (Apilar 1 1 (Figura 1) (Rotar (Figura 2))) (figura 1 .-. Rotar (Figura 2)))

-- Casos de prueba para la función (///)
testBarra_1 = TestCase (assertEqual "figura 1 /// figura 2" (Juntar 1 1 (Figura 1) (Figura 2)) (figura 1 /// figura 2))
testBarra_2 = TestCase (assertEqual "figura 1 /// Rotar (Figura 2)" (Juntar 1 1 (Figura 1) (Rotar (Figura 2))) (figura 1 /// Rotar (Figura 2)))

-- Casos de prueba para la función (^^^)
testCircunflejo_1 = TestCase (assertEqual "figura 1 ^^^ figura 2" (Encimar (Figura 1) (Figura 2)) (figura 1 ^^^ figura 2))
testCircunflejo_2 = TestCase (assertEqual "figura 1 ^^^ Rotar (Figura 2)" (Encimar (Figura 1) (Rotar (Figura 2))) (figura 1 ^^^ Rotar (Figura 2)))

-- Casos de prueba para la función cuarteto
testCuarteto1 = TestCase (assertEqual "cuarteto (figura 1) (figura 2) (figura 3) (figura 4)" (Apilar 1 1 (Juntar 1 1 (Figura 1) (Figura 2)) (Juntar 1 1 (Figura 3) (Figura 4))) (cuarteto (figura 1) (figura 2) (figura 3) (figura 4)))
testCuarteto2 = TestCase (assertEqual "cuarteto (Rotar (Figura 1)) (Espejar (Figura 2)) (Rotar (Espejar (Figura 3))) (Espejar (Rotar (Figura 4)))" (Apilar 1 1 (Juntar 1 1 (Rotar (Figura 1)) (Espejar (Figura 2))) (Juntar 1 1 (Rotar (Espejar (Figura 3))) (Espejar (Rotar (Figura 4))))) (cuarteto (Rotar (Figura 1)) (Espejar (Figura 2)) (Rotar (Espejar (Figura 3))) (Espejar (Rotar (Figura 4)))))

-- Casos de prueba para la función encimar4
testEncimar41 = TestCase (assertEqual "encimar4 (figura 1)" (Encimar (Rotar (Rotar (Rotar (Figura 1)))) (Encimar (Rotar (Rotar (Figura 1))) (Encimar (Rotar (Figura 1)) (Figura 1)))) (encimar4 (figura 1)))
testEncimar42 = TestCase (assertEqual "encimar4 (Rotar (Figura 1))" (Encimar (Rotar (Rotar (Rotar (Rotar (Figura 1))))) (Encimar (Rotar (Rotar (Rotar (Figura 1)))) (Encimar (Rotar (Rotar (Figura 1))) (Rotar (Figura 1))))) (encimar4 (Rotar (Figura 1))))

-- Casos de prueba para la función ciclar
testCiclar1 = TestCase (assertEqual "ciclar (figura 1)" (Apilar 1.0 1.0 (Juntar 1.0 1.0 (Figura 1) (Rotar (Figura 1))) (Juntar 1.0 1.0 (Rotar (Rotar (Figura 1))) (Rotar (Rotar (Rotar (Figura 1)))))) (ciclar (figura 1)))
testCiclar2 = TestCase (assertEqual "ciclar (Rotar (Figura 1))" (Apilar 1.0 1.0 (Juntar 1.0 1.0 (Rotar (Figura 1)) (Rotar (Rotar (Figura 1)))) (Juntar 1.0 1.0 (Rotar (Rotar (Rotar (Figura 1)))) (Rotar (Rotar (Rotar (Rotar (Figura 1))))))) (ciclar (Rotar (Figura 1))))

-- Casos de prueba para la función foldDib
testFoldDib1 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (figura 1)" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Figura 1)))
testFoldDib2 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Rotar (Figura 1))" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Rotar (Figura 1))))
testFoldDib3 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Espejar (Figura 1))" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Espejar (Figura 1))))
testFoldDib4 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Rot45 (Figura 1))" 1 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Rot45 (Figura 1))))
testFoldDib5 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Juntar 1 1 (Figura 1) (Figura 2))" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Juntar 1 1 (Figura 1) (Figura 2))))
testFoldDib6 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Apilar 1 1 (Figura 1) (Figura 2))" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Apilar 1 1 (Figura 1) (Figura 2))))
testFoldDib7 = TestCase (assertEqual "foldDib id id id id (_ _ a b -> a+b) (_ _ a b -> a+b) (+) (Encimar (Figura 1) (Figura 2))" 3 (foldDib id id id id (\_ _ a b -> a+b) (\_ _ a b -> a+b) (+) (Encimar (Figura 1) (Figura 2))))

-- Casos de prueba para la función mapDib
testMapDib1 = TestCase (assertEqual "mapDib figura (figura 1)" (Figura 1) (mapDib figura (Figura 1)))
testMapDib2 = TestCase (assertEqual "mapDib figura (Rotar (Figura 1))" (Rotar (Figura 1)) (mapDib figura (Rotar (Figura 1))))
testMapDib3 = TestCase (assertEqual "mapDib figura (Espejar (Figura 1))" (Espejar (Figura 1)) (mapDib figura (Espejar (Figura 1))))
testMapDib4 = TestCase (assertEqual "mapDib figura (Rot45 (Figura 1))" (Rot45 (Figura 1)) (mapDib figura (Rot45 (Figura 1))))
testMapDib5 = TestCase (assertEqual "mapDib (a -> a*a) (Juntar 1 2 (Figura 1) (Figura 2))" (Juntar 1 2 (Figura 1) (Figura 4)) (mapDib (\a -> figura (a*a)) (Juntar 1 2 (Figura 1) (Figura 2))))
testMapDib6 = TestCase (assertEqual "mapDib (a -> a*a) (Apilar 1 2 (Figura 1) (Figura 2))" (Apilar 1 2 (Figura 1) (Figura 4)) (mapDib (\a -> figura (a*a)) (Apilar 1 2 (Figura 1) (Figura 2))))
testMapDib7 = TestCase (assertEqual "mapDib (a -> a*a+a) (Encimar (Figura 1) (Figura 2))" (Encimar (Figura 2) (Figura 6)) (mapDib (\a -> figura (a*a+a)) (Encimar (Figura 1) (Figura 2))))

-- Casos de prueba para la función figuras
testFiguras1 = TestCase (assertEqual "figuras (figura 1)" [1] (figuras (Figura 1)))
testFiguras2 = TestCase (assertEqual "figuras (Rotar (Figura 1))" [1] (figuras (Rotar (Figura 1))))
testFiguras3 = TestCase (assertEqual "figuras (Espejar (Figura 1))" [1] (figuras (Espejar (Figura 1))))
testFiguras4 = TestCase (assertEqual "figuras (Rot45 (Figura 1))" [1] (figuras (Rot45 (Figura 1))))
testFiguras5 = TestCase (assertEqual "figuras (Juntar 1 2 (Figura 1) (Figura 2))" [1,2] (figuras (Juntar 1 2 (Figura 1) (Figura 2))))
testFiguras6 = TestCase (assertEqual "figuras (Apilar 1 2 (Figura 1) (Figura 2))" [1,2] (figuras (Apilar 1 2 (Figura 1) (Figura 2))))
testFiguras7 = TestCase (assertEqual "figuras (Encimar (Figura 1) (Figura 2))" [1,2] (figuras (Encimar (Figura 1) (Figura 2))))

runTest = runTestTT $ TestList [testFigura1, testFigura2, testRotar1, testRotar2, testEspejar1, testEspejar2, testRot45_1, testRot45_2, testApilar1, testApilar2, testEncimar1, testEncimar2, testComp1, testComp2, testR180_1, testR180_2, testR270_1, testR270_2, testPunto_1, testPunto_2, testBarra_1, testBarra_2, testCircunflejo_1, testCircunflejo_2, testCuarteto1, testCuarteto2, testEncimar41, testEncimar42, testCiclar1, testCiclar2, testFoldDib1, testFoldDib2, testFoldDib3, testFoldDib4, testFoldDib5, testFoldDib6, testFoldDib7, testMapDib1, testMapDib2, testMapDib3, testMapDib4, testMapDib5, testMapDib6, testMapDib7, testFiguras1, testFiguras2, testFiguras3, testFiguras4, testFiguras5, testFiguras6, testFiguras7]

-- Ejecutar los casos de prueba
main = runTest