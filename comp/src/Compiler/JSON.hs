{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns      #-}

-- Module      : Compiler.JSON
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Compiler.JSON where

import           Compiler.Types
import           Control.Error
import           Data.Bifunctor
import           Data.ByteString      (ByteString)
import qualified Data.ByteString.Lazy as LBS
import           Data.Function        (on)
import           Data.Jason
import           Data.Jason.Types
import           Data.List
import qualified Data.Text.Lazy       as LText

decodeObject :: Monad m => ByteString -> Compiler m Object
decodeObject = either (Control.Error.left . LText.pack) return
    . eitherDecode'
    . LBS.fromStrict

parseObject :: (Monad m, FromJSON a) => Object -> Compiler m a
parseObject = hoistEither . first LText.pack . parseEither parseJSON . Object

mergeObjects :: [Object] -> Object
mergeObjects = foldl' go mempty
  where
    go :: Object -> Object -> Object
    go (unObject -> a) (unObject -> b) = mkObject (assoc value a b)

    value :: Value -> Value -> Value
    value l r =
        case (l, r) of
            (Object x, Object y) -> Object (x `go` y)
            (_,        _)        -> l

    assoc :: Eq k => (v -> v -> v) -> [(k, v)] -> [(k, v)] -> [(k, v)]
    assoc f xs ys = unionBy ((==) `on` fst) (map g xs) ys
      where
        g (k, x) | Just y <- lookup k ys = (k, f x y)
                 | otherwise             = (k, x)
