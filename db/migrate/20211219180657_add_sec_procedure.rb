class AddSecProcedure < ActiveRecord::Migration[6.1]
  def up
    sql = "CREATE PROCEDURE 5sec_proc() BEGIN SELECT * FROM products; DO SLEEP(5); END"
    execute sql
  end

  def down 
    execute("DROP PROCEDURE IF EXISTS 5sec_proc")
  end 
end
