module Verbalize
  class Result
    def initialize(outcome:, value:)
      @outcome = outcome
      @value   = value
    end

    attr_reader :outcome, :value

    def succeeded?
      !failed?
    end

    def failed?
      outcome == :error
    end

    def to_ary
      [outcome, value]
    end
  end
end
