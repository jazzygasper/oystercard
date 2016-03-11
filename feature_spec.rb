require './lib/oystercard'

oystercard = Oystercard.new(Journey)

oystercard.top_up(60)
oystercard.touch_in("Kings Cross")
oystercard.touch_out("The Moon")
p oystercard.journeys
