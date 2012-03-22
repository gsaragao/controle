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

ActiveRecord::Schema.define(:version => 20120316143842) do

  create_table "destinos", :force => true do |t|
    t.string   "descricao"
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
    t.string   "ativo"
    t.integer  "tecnico_id"
    t.date     "data_movimentacao"
    t.string   "serie"
    t.string   "patrimonio"
    t.integer  "versao_id"
    t.integer  "modelo_id"
    t.date     "data_entrada"
    t.integer   "status"
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
    t.string   "retirado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movimentacoes", ["modelo_id"], :name => "index_movimentacoes_on_modelo_id"
  add_index "movimentacoes", ["tecnico_id"], :name => "index_movimentacoes_on_tecnico_id"
  add_index "movimentacoes", ["versao_id"], :name => "index_movimentacoes_on_versao_id"

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

end
