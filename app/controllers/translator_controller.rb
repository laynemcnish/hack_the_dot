class TranslatorController < ApplicationController

  def index
    @german = German.new
    @hippo = Hippo.new
  end

  def english_to_german
    German.translate(params[:english])
  end

  def german_to_hippo
    Hippo.translate(params[:hippo])
  end
end
