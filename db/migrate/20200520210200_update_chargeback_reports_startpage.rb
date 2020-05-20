class UpdateChargebackReportsStartpage < ActiveRecord::Migration[5.2]
  class User < ActiveRecord::Base
    serialize :settings, Hash
  end

  def up
    say_with_time 'Updating starting page for users who had chargeback reports set' do
      User.select(:id, :settings).each do |user|
        if user.settings&.dig(:display, :startpage) == 'chargeback_reports/explorer'
          user.update!(:settings => user.settings.deep_merge(:display => {:startpage => 'chargeback_report/show_list'}))
        end
      end
    end
  end

  def down
    say_with_time 'Updating starting page for users who had non-explorer chargeback reports pages set' do
      User.select(:id, :settings).each do |user|
        if user.settings&.dig(:display, :startpage) == 'chargeback_report/show_list'
          user.update!(:settings => user.settings.deep_merge(:display => {:startpage => 'chargeback_reports/explorer'}))
        end
      end
    end
  end
end
