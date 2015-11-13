require 'google_translate/result_parser'

class Request < ActiveRecord::Base
  def translate
    if self.language == "hp"
      hippoize
      return
    end
    translator = GoogleTranslate.new
    tmp = translator.translate("en", self.language, self.body)
    result_parser = ResultParser.new(tmp)
    self.result = result_parser.translation
  end

  def hippoize
    tokenizer = Tokenizer::Tokenizer.new(:en)
    tokenizer.tokenize(self.body)
    self.result = tokenizer
                  .tokenize(self.body)
                  .map do |word|
                    if word !~ /[a-z0-9]/
                      # Punctuation or something.
                      word
                    else
                      L33tify.process(word).reverse
                    end
                  end
                  .inject do |a, e|
                    a += " " if e =~ /["a-zA-Z0-9]\z/
                    a += e
                  end
  end

  before_create :translate
end
