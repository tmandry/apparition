module Apparition
  module DSL
    def visit(path)
      Apparition.current_session.visit(path)
    end
  end
end
