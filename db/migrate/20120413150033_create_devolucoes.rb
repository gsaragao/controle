class CreateDevolucoes < ActiveRecord::Migration
  def change
    create_table :devolucoes do |t|
      t.date :data_devolucao
      t.string :os_devolucao
      t.references :destino
      t.text :observacao
      t.references :movimentacao
      t.timestamps
    end
    add_index :devolucoes, :movimentacao_id
  end
end
