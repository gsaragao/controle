# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120413163004) do

  create_table "enderecos", :force => true do |t|
    t.string   "descricao"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "modelos", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimentacoes", :force => true do |t|
    t.integer  "nid"
    t.integer  "version"
    t.integer  "ativo"
    t.integer  "tecnico_id"
    t.date     "data_movimentacao"
    t.string   "serie"
    t.string   "patrimonio"
    t.integer  "versao_id"
    t.integer  "modelo_id"
    t.date     "data_entrada"
    t.integer  "status"
    t.string   "ordem_servico"
    t.date     "data_relatorio"
    t.string   "codigo_fiscal"
    t.date     "data_nota_fiscal"
    t.string   "nota_fiscal"
    t.string   "nfe"
    t.text     "observacao"
    t.string   "termo_file_name"
    t.string   "termo_content_type"
    t.integer  "termo_file_size"
    t.datetime "termo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movimentacoes", ["modelo_id"], :name => "index_movimentacoes_on_modelo_id"
  add_index "movimentacoes", ["tecnico_id"], :name => "index_movimentacoes_on_tecnico_id"
  add_index "movimentacoes", ["versao_id"], :name => "index_movimentacoes_on_versao_id"

  create_table "retiradas", :force => true do |t|
    t.string   "nfe_saida"
    t.date     "data_retirada"
    t.string   "os_saida"
    t.string   "nfe_referencia"
    t.integer  "operacao"
    t.string   "serie"
    t.string   "patrimonio"
    t.integer  "versao_id"
    t.integer  "modelo_id"
    t.integer  "tecnico_id"
    t.date     "data_instalacao"
    t.string   "ordem_servico"
    t.text     "observacao"
    t.integer  "origem_id"
    t.integer  "destino_id"
    t.integer  "movimentacao_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "retiradas", ["destino_id"], :name => "retiradas_destino_id_fk"
  add_index "retiradas", ["modelo_id"], :name => "index_retiradas_on_modelo_id"
  add_index "retiradas", ["movimentacao_id"], :name => "index_retiradas_on_movimentacao_id"
  add_index "retiradas", ["origem_id"], :name => "retiradas_origem_id_fk"
  add_index "retiradas", ["tecnico_id"], :name => "index_retiradas_on_tecnico_id"
  add_index "retiradas", ["versao_id"], :name => "index_retiradas_on_versao_id"

  create_table "tecnicos", :force => true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versoes", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "movimentacoes", "modelos", :name => "movimentacoes_modelo_id_fk"
  add_foreign_key "movimentacoes", "tecnicos", :name => "movimentacoes_tecnico_id_fk"
  add_foreign_key "movimentacoes", "versoes", :name => "movimentacoes_versao_id_fk"

  add_foreign_key "retiradas", "enderecos", :name => "retiradas_destino_id_fk", :column => "destino_id"
  add_foreign_key "retiradas", "enderecos", :name => "retiradas_origem_id_fk", :column => "origem_id"
  add_foreign_key "retiradas", "modelos", :name => "retiradas_modelo_id_fk"
  add_foreign_key "retiradas", "movimentacoes", :name => "retiradas_movimentacao_id_fk"
  add_foreign_key "retiradas", "tecnicos", :name => "retiradas_tecnico_id_fk"
  add_foreign_key "retiradas", "versoes", :name => "retiradas_versao_id_fk"

end
