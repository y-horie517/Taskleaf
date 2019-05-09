class Task < ApplicationRecord
    has_one_attached :image

    # 検証前に名前が入っていない場合の処理を実行
    # before_validation :set_nameless_name
    validates :name, presence: true
    validates :name, length: { maximum: 30}
    validate :validate_name_not_including_commma

    belongs_to :user

    scope :recent, -> {order(created_at: :desc)}

    def self.csv_attributes
        # csvデータにどの属性をどの順番で出力するかをcsv_attributesというクラスメソッドから得られるように定義
        ["name", "description", "created_at", "updated_at"]
    end

    def self.generate_csv
        # CSVデータの文字列を生成。このメソッドの戻り値になる
        CSV.generate(headers: true) do |csv|
            # 一行目としてヘッダを出力（属性名）
            csv << csv_attributes
            # 全タスクを取得し、1レコードごとにCSV出力
            all.each do |task|
                csv << csv_attributes.map{|attr| task.send(attr)}
            end
        end
    end

    # fileという引数でアップされたファイルの内容にアクセスするためのオブジェクトを受け取ります
    def self.import(file)
        # 一行目はヘッダとして無視する
        CSV.foreach(file.path, headers: true) do |row|
            # newはTask.newと同じ
            task = new
            # to_hashメソッドでデータをハッシュ形式に変換
            # *の部分はcsv_attributesメソッドの戻り値の配列の中身をそれぞれ引数にしている
            task.attributes = row.to_hash.slice(*csv_attributes)
            task.save!
        end
    end

    private
    def validate_name_not_including_commma
        errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    end

    def set_nameless_name
        self.name = '名前なし' if name.blank?
    end

    def self.ransackable_attributes(auth_object = nil)
        %w[name created_at]
    end
    
    def self.ransackable_associations(auth_object = nil)
        []
    end
end
