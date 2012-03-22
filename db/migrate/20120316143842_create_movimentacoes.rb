class CreateMovimentacoes < ActiveRecord::Migration
  def change
    create_table :movimentacoes do |t|
      t.integer :nid
      t.integer :version
      t.string :ativo
      t.references :tecnico
      t.date :data_movimentacao
      t.string :serie
      t.string :patrimonio
      t.references :versao
      t.references :modelo
      t.date :data_entrada
      t.integer :status
      t.string :ordem_servico
      t.date :data_relatorio
      t.string :codigo_fiscal
      t.date :data_nota_fiscal
      t.string :nota_fiscal
      t.string :nfe
      t.text :observacao
      t.string :termo_file_name
      t.string :termo_content_type
      t.integer :termo_file_size
      t.datetime :termo_updated_at
      t.string :retirado
      t.timestamps
    end
    add_index :movimentacoes, :tecnico_id
    add_index :movimentacoes, :versao_id
    add_index :movimentacoes, :modelo_id
  end
end
