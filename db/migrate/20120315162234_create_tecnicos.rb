class CreateTecnicos < ActiveRecord::Migration
  def change
    create_table :tecnicos do |t|
      t.string :nome
      t.string :cpf

      t.timestamps
    end
  end
end
