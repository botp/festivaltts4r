#
# Ruby Interface to festival tts system
#
# Requires festivaltts and lame.
# Must be run in a UNIX environment.
#
# You can found more information in my english blog http://spejman-on-rails.blogspot.com 
# or in the spanish one http://spejman.blogspot.com 
#
# Work done by Sergio Espeja (http://www.sergioespeja.com)
#
# It is free software, and may be redistributed under GPL license.
# Copyright (c) 2007 Sergio Espeja


class String
  
  # Outputs the speech generated with festival tts and the string itself.
  # Can handle two options:
  # - text --> speech given text instead of the string itself.
  # - language --> speech language desired (festival voices for given languages are required )  
  def to_speech(params={})  
    text = params[:text] || self
    language = "--language " + params[:language] if params[:language]
    system("echo \"#{text.to_s}\" | festival --tts #{language}")
  end
  
  # Creates a file with name "filename" and with the generated with festival tts, the string itself and lame.
  # Can handle one options:
  # - text --> speech given text instead of the string itself.  
  def to_mp3(filename, params={})
    text = params[:text] || self
    raise "to_mp3 language option still not implemented" if params[:language]
    system("echo \"#{text.to_s}\" | text2wave | lame --alt-preset cbr 16 -a --resample 11 --lowpass 5 --athtype 2 -X3 - > #{filename} 2> /dev/null")
  end
  
end