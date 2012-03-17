class CreateVersoes < ActiveRecord::Migration
  def change
    create_table :versoes do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
