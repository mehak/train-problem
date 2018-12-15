(defun train-pass (a-speed b-speed distance)
  "Calculates when 2 trains will pass each other, given train a's speed,
  train b's speed and the distance between both trains.  Initial function
  assumes they start at their terminal speed (the speed given).
  TODO: take train's acceleration and terminal speed"
  (/ distance
     (+ a-speed b-speed)))
