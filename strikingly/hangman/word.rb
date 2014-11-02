class Word
  def initialize w
    @r = {}
    w.chars.each_with_index do |c, i|
      if @r[c]
        @r[c] << ",#{i}"
      else
        @r[c] = "#{c}#{i}"
      end
    end
  end

  def indices c
    @r[c]
  end
end