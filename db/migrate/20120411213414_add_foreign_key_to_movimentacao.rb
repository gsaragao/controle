class AddForeignKeyToMovimentacao < ActiveRecord::Migration
  def change
    add_foreign_key(:movimentacoes, :versoes)
    add_foreign_key(:movimentacoes, :modelos)
    add_foreign_key(:movimentacoes, :tecnicos)
  end
end
