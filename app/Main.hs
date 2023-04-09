module Main (main) where

import Data.Maybe (fromMaybe)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Feo (feoConf)
import Interp (Conf (name), initial)
import System.Console.GetOpt (ArgDescr (..), ArgOrder (..), OptDescr (..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf]

-- Dibuja el dibujo n
-- Busca el dibujo
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
  putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n =
  if n == name c
    then initial c 400
    else initial' cs n

-- el primer argumento es el nombre del dibujo
main :: IO ()
main = do
  args <- getArgs
  initial' configs $ head args
