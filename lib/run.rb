require "sinatra"
require "sinatra/reloader"

status = "Waiting for command..."
msg = ""

def caesar_cipher(string, shift)
	alphabet = ("a".."z").to_a
	new_word = []
	string_array = string.scan(/./)

	string_array.each do |letter|
		if alphabet.include?(letter)
			new_letter = (alphabet.index(letter) + shift) % alphabet.length
			new_word << alphabet[new_letter]
		else
			new_word << letter
		end
	end
	new_word.join("")
end

def check_input(string, shift)
	if string != "" && shift > 0
		return true
	else
		return false
	end
end

get '/' do
	word = params["word"]
	shift = params["shift"].to_i
	if check_input(word, shift)
		status = "Ready to go!"
		msg = caesar_cipher(word, shift)
	else
		status = "Error!"
		msg = "There's an error! Aborting mission!"
	end
	
	erb :index, :locals => {:status => status, :msg => msg}
end