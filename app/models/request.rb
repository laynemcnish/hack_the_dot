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
    self.result = "MRAWR!"
  end

  before_create :translate
end
