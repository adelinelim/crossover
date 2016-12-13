class Services::CalculateOrder
  def self.calculate_order_total(order)
    order.try(:order_lines).try(:sum, :total_price) || 0
  end
end
