class CreateRetiradas < ActiveRecord::Migration
  def change
    create_table :retiradas do |t|
      t.string :nfe_saida
      t.date :data_retirada
      t.string :os_saida
      t.string :nfe_referencia
      t.integer :operacao
      t.string :serie
      t.string :patrimonio
      t.references :versao
      t.references :modelo
      t.references :tecnico
      t.date :data_instalacao
      t.string :ordem_servico
      t.text :observacao
      t.integer :origem_id
      t.integer :destino_id
      t.references :movimentacao

      t.timestamps
    end
    add_index :retiradas, :versao_id
    add_index :retiradas, :modelo_id
    add_index :retiradas, :tecnico_id
    add_index :retiradas, :movimentacao_id
    add_foreign_key(:retiradas, :versoes)
    add_foreign_key(:retiradas, :modelos)
    add_foreign_key(:retiradas, :tecnicos)
    add_foreign_key(:retiradas, :movimentacoes)
    add_foreign_key(:retiradas, :enderecos, :column => 'origem_id')
    add_foreign_key(:retiradas, :enderecos, :column => 'destino_id')
  end
end