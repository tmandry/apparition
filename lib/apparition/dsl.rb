module Apparition
  module DSL
    def visit(url)
      Apparition.current_session.driver.visit(url)
    end
  end
end
