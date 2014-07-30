require 'spec_helper'

describe UserPresenter do
  let(:user_attrs)do
    { email: 'impossible_is@a_dare.com',
      first_name: 'Muhammad',
      last_name: 'Ali',
      birthdate: Date.new(1942, 1, 17),
      height: 191,
      weight: 107,
      activity_x: 2,
      lean_mass: 90
    }
  end
  let(:the_greatest) { build(:user, user_attrs) }
  let(:the_greatest_presenter) { UserPresenter.new(the_greatest) }

  describe '#attributes' do
    it 'returns a hash of symbolized ivars and their values' do
      expect(the_greatest_presenter.attributes).to eq user_attrs
    end
  end

  describe '#initialize' do
    it 'assigns attributes based on the given user' do
      the_greatest_presenter = UserPresenter.new(the_greatest)
      the_greatest_presenter.attributes.each do |attr, val|
        expect(val).to eq user_attrs[attr]
      end
    end
  end
end
#
