class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  layout 'home', only: [:home]

  def home
  end

  def business
    @bookings = Booking.all
    @yachts = Yacht.all
  end

  def income
    @weekly_income = Income.where('user_id = ? AND date >= ? AND date <= ?', current_user, Date.today.beginning_of_week, Date.today.end_of_week).sum(:amount)
    @monthly_income = Income.where('user_id = ? AND date >= ? AND date <= ?', current_user, Date.today.beginning_of_month, Date.today.end_of_month).sum(:amount)
    @yearly_income = Income.where('user_id = ? AND date >= ? AND date <= ?', current_user, Date.today.beginning_of_year, Date.today.end_of_year).sum(:amount)
  end

  def calendar
      # Scope your query to the dates being shown:
    start_date = if params.has_key?(:start_date)
                   Date.parse(params.fetch(:start_date))
                 else
                   Date.today
                 end
      # For a monthly view:
    @bookings = Booking.where(check_in: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
