# Example class to show we can create our own model objects; they do not require
# any database access/ ActiveRecord inheritance to work!
def Hello

  # short way
  attr_accessor :hello_message

  # long way
  #def hello_message
  #  @hello_message
  #end

  #def hello_message=(message)
  #  @hello_message = message
  #end

end
