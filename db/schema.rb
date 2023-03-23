# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_223_014_824) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'analyses', force: :cascade do |t|
    t.json 'report'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'video_id'
    t.index ['video_id'], name: 'index_analyses_on_video_id'
  end

  create_table 'passwordless_sessions', force: :cascade do |t|
    t.string 'authenticatable_type'
    t.integer 'authenticatable_id'
    t.datetime 'timeout_at', precision: nil, null: false
    t.datetime 'expires_at', precision: nil, null: false
    t.datetime 'claimed_at', precision: nil
    t.text 'user_agent', null: false
    t.string 'remote_addr', null: false
    t.string 'token', null: false
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.index %w[authenticatable_type authenticatable_id], name: 'authenticatable'
  end

  create_table 'players', force: :cascade do |t|
    t.string 'name'
    t.integer 'number'
    t.string 'position'
    t.string 'year'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'practice_videos', force: :cascade do |t|
    t.string 'filename'
    t.string 'video_name'
    t.datetime 'video_create_date', precision: nil
    t.string 'description'
    t.datetime 'video_upload_date', precision: nil
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.float 'length'
  end

  create_table 'route_instances', force: :cascade do |t|
    t.integer 'player_id'
    t.string 'route_name'
    t.string 'play_name'
    t.string 'timestamp_start'
    t.string 'timestamp_end'
    t.integer 'success'
    t.string 'practice_id'
    t.date 'date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'name'
    t.string 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'videos', force: :cascade do |t|
    t.string 'video_path'
    t.string 'thumbnail_path'
    t.string 'resolution'
    t.integer 'size'
    t.integer 'duration'
    t.float 'frame_rate'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'visions', force: :cascade do |t|
    t.json 'report'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'video_id'
    t.index ['video_id'], name: 'index_visions_on_video_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'analyses', 'videos'
  add_foreign_key 'visions', 'videos'
end
