function [ textureId, imgDims ] = imgLookup(keyIdx, fnameLookupTbl, textureLookupTbl)
% Supplies the texture and image dimensions of an image. 
%
% Looks up what texture `keyIdx` corresponds to, taking it for a simple index
% in `fnameLookupTbl`. (The middle step is looking up what texture ID a picture
% identified by its path corresponds to.)
%
% Assumes a `fnameLookupTbl` has a list of image filenames. If
% `textureLookupTbl` is provided, it is assumed it was created by
% `loadTexturesFromConfig` and is up-to-date. If not, an error is thrown, as
% `imgLookup` does not have a pointer to the currently open Screen it would
% need to create the texture on its own.
%
% Args:
%   keyIdx: A key index
%   fnameLookupTbl: A table composed of image filenames to draw from
%   textureLookupTbl: A table composed of image textures
%
% Returns:
%   2-element tuple containing
%
%   - **textureId**: An image specific texture ID
%   - **imgDims**: The specific image dimensions
%
% Warning: 
%   There is no enforcement of image paths being supplied as absolute paths.

  img = fnameLookupTbl{keyIdx};

  if exist('textureLookupTbl', 'var') && isa(textureLookupTbl, 'containers.Map')
    % Re-use texture made by `loadTexturesFromConfig`
    try % FIXME: This is lazy. Check with strcmp(img, keys(textureLookupTbl))
      textureStruct = textureLookupTbl(img);
      textureId = textureStruct.textureId;
      imgDims = textureStruct.dims;
    catch
      error(['Texture lookup table did not contain %s. Check that you are' ...
        ' generating textures correctly.'], img);
    end
  else
    % Generate texture from scratch
    error(['Textures not provided in the correct format. Generate a ' ...
      'texture lookup table with extractImagesFromConfig.']);
  end
end
