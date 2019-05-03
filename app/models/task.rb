class Task < ApplicationRecord
    # 検証前に名前が入っていない場合の処理を実行
    # before_validation :set_nameless_name

    validates :name, presence: true
    validates :name, length: { maximum: 30}
    validate :validate_name_not_including_commma


    private
    def validate_name_not_including_commma
        errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    end

    def set_nameless_name
        self.name = '名前なし' if name.blank?
    end
end
