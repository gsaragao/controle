class AddForeignKeyToRetiradas < ActiveRecord::Migration
  def change
    add_foreign_key(:retiradas, :versoes)
    add_foreign_key(:retiradas, :modelos)
    add_foreign_key(:retiradas, :tecnicos)
    add_foreign_key(:retiradas, :movimentacoes)
  end
end
