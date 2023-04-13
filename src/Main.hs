module Main (main) where

import Dibujos.Grilla (grillaConf)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Feo (feoConf)
import Dibujos.Escher (escherConf)
import Dibujos.EscherPeces (escherPecesConf)
import Interp (Conf (name), initial)
import System.Console.GetOpt (ArgDescr (..), ArgOrder (..), OptDescr (..), getOpt)
import System.Environment (getArgs)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf, escherConf, grillaConf, escherPecesConf]

size = 900

-- Dibuja el dibujo n
-- Busca el dibujo
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
  putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n =
  if n == name c
    then initial c size
    else initial' cs n

dibSelect :: IO ()
dibSelect = do
  putStrLn "Dibujos disponibles:"
  putDibujos configs
  putStrLn "Escriba el nombre del dibujo que quiere ver: "
  n <- getLine
  case confSearch configs n of
    Nothing -> putStrLn "Ese dibujo no existe" >> dibSelect
    Just c -> initial c size
  where
    putDibujos [] = return ()
    putDibujos (c : cs) = putStrLn (name c) >> putDibujos cs
    confSearch (c : cs) n = if n == name c then return c else confSearch cs n
    confSearch [] _ = Nothing

-- el primer argumento es el nombre del dibujo
main :: IO ()
main = do
  args <- getArgs
  if not (null args) then initial' configs $ head args else if not (null configs) then dibSelect else putStrLn "No hay dibujos disponibles"
