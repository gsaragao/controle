class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :descricao
      t.integer :tipo
      t.timestamps
    end
  end
end
