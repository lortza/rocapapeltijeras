require "rocapapeltijeras/version"
require "rocapapeltijeras/asci_art"

module RocaPapelTijeras
  def self.hello
    puts "hello"
    puts AsciiArt::TITLE
  end
end
