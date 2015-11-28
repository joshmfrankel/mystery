class Baby < Human
  include Parent::FatherConcerns
  include Parent::MotherConcerns
  include GrandParent::Concerns

  belongs_to :family
  has_one :mother
  has_one :father

  BAD_NAMES = ['Jermajesty', 'Abcde', 'North West', 'Hashtag'] # Just no...

  validates :name,    uniqueness: true, exclusion: BAD_NAMES
  validates :arms,    numericality: { equal_to: 2 }
  validates :legs,    numericality: { equal_to: 2 }
  validates :fingers, numericality: { equal_to: 10 }
  validates :toes,    numericality: { equal_to: 10 }
  validates :tail,    numericality: { equal_to: 0 }

  before_create :prepare_parents!, :announce, :set_privacy_level
  after_create  :celebrate!, :rest

  def prepare_parents!
    Breathe.continue
    PregnancyBook.collection.read_all
    Shopping.buy %w(Clothing Diapers Toys Stroller Crib)
    PregnancyClass.enroll
    Finance.organize
  end

  def announce
    self.due_date = 'June 9th'
    @recipients = family + friends + colleagues
    mail(to: @recipients, subject: "We're pregnant!")
  end

  def celebrate!
    self.birthday = Time.now
    Family << self
  end

  protected

  def set_privacy_level
    Discretion.set_gender_reveal            = :at_birth
    Listening.set_unwarranted_advice_level  = :selective
  end

  private

  def rest
    return unless Family.can_sleep?
    Family.rest
  end
end

