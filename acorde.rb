require 'music-utils'
require 'pry'

class Acorde
  def self.display
  end
end

class GuitarArm
  def self.display
    # hmm
    <<-MSG.gsub(/^ {12}/,'')
    MSG
  end
end

binding.pry

MusicUtils::Scales.methods

puts "hi"
