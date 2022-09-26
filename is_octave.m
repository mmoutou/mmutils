function r = is_octave()
% r = is_octave() : Octave version, ONLY if we are running octave
% see https://stackoverflow.com/questions/2246579/how-do-i-detect-if-im-running-matlab-or-octave
  persistent x;
  if (isempty (x))
    x = exist ('OCTAVE_VERSION', 'builtin');
  end
  r = x;

return;
