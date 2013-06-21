module Apparition
  module DSL
    def visit(path)
      Apparition.current_session.visit(path)
    end

    def save_screenshot(path)
      Apparition.current_session.save_screenshot(path)
    end
  end
end
