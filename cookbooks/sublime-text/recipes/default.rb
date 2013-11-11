Hotel.find(66).check_ins.find_in_batches do |group|
	group.each { |c| c.destroy }
end


CashCloseout.where(hotel_id: 66).where("created_at < ?", 1.days.ago.beginning_of_day)
CashCounterTransaction.where(hotel_id: 66).where("created_at < ?", 1.days.ago.beginning_of_day)