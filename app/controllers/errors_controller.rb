class ErrorsController < ApplicationController
    layout 'error'

  def not_found
  end

  def internal_error
  end

  def unprocessable_entity
  end
end
