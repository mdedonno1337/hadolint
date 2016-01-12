module Syntax where

import Data.ByteString.Char8 (ByteString)

type Image = String
type Tag = String
type Port = Integer
type Directory = String

data BaseImage
  = UntaggedImage Image
  | TaggedImage Image Tag
  | DigestedImage Image ByteString
  deriving (Eq, Ord, Show)

type Dockerfile = [InstructionPos]
type Source = String
type Destination = String
type Arguments = [String]
type Pairs = [(String, String)]

data Instruction
  = From BaseImage
  | Add Source Destination
  | User String
  | Label Pairs
  | Stopsignal String
  | Copy Source Destination
  | Run Arguments
  | Cmd Arguments
  | Workdir Directory
  | Expose [Port]
  | Volume String
  | Entrypoint Arguments
  | Maintainer String
  | Env Pairs
  | Arg String
  | Comment String
  | OnBuild Instruction
  deriving (Eq, Ord, Show)

type Linenumber = Int
-- additional location information about an instruction
-- required for creating good check messages
data InstructionPos = InstructionPos Instruction Linenumber deriving (Show)

instruction :: InstructionPos -> Instruction
instruction (InstructionPos i _ ) = i
