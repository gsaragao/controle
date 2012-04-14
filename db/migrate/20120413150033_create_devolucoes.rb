class CreateDevolucoes < ActiveRecord::Migration
  def change
    create_table :devolucoes do |t|
      t.date :data_devolucao
      t.string :os_devolucao
      t.integer :origem_id
      t.integer :destino_id
      t.text :observacao
      t.references :movimentacao
      t.timestamps
    end
    add_index :devolucoes, :movimentacao_id
    add_foreign_key(:devolucoes, :enderecos, :column => 'origem_id')
    add_foreign_key(:devolucoes, :enderecos, :column => 'destino_id')
  end
end
