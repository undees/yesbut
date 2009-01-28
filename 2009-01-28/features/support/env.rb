require 'spec/expectations'

After do
  @doc.close if @doc
end
