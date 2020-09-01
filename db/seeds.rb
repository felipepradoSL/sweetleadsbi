

connection = ActiveRecord::Base.connection
connection.execute("TRUNCATE reports")

