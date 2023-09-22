module Library where
import PdePreludat

f :: Ord a1 => a1 -> (a2 -> a1) -> (a3, [a2]) -> Bool
f h p = any (<h) . map p . snd 