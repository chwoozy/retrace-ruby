class AddSsecProcedure < ActiveRecord::Migration[6.1]
  def up
    sql = "CREATE PROCEDURE Ssec_proc() BEGIN SELECT * FROM products; END"
    execute sql
  end

  def down 
    execute("DROP PROCEDURE IF EXISTS Ssec_proc")
  end 
end
