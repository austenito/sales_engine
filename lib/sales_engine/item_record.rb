module SalesEngine
  module ItemRecord
    def items 
      items = []
      Database.instance.db.execute("select * from items") do |row|
        id = row[0].to_i
        name = row[1]
        description = row[2]
        unit_price = row[3].to_f
        merchant_id = row[4].to_i
        created_at = row[5]
        updated_at = row[6]
        items << Item.new(id, name, description, unit_price, 
                          merchant_id, created_at, updated_at)
      end
      items
    end

    def most_revenue(total_items)
      invoice_items_array = []
      query = "SELECT item_id, SUM(quantity * unit_price) as sum 
            FROM invoice_items
            INNER JOIN invoices ON invoice_items.invoice_id = invoices.id
            INNER JOIN transactions on invoices.id = transactions.invoice_id
            AND transactions.result LIKE 'success'
            GROUP BY item_id
            ORDER BY sum DESC"

      items = []
      Database.instance.db.execute(query)  do |row| 
        if items.length < total_items
          items << Item.find_by_id(row[0])
        else
          break
        end
      end
      items
    end

    def most_items(total_items)
      invoice_items_array = []
      query = "SELECT item_id, SUM(quantity) as sum FROM invoice_items
            INNER JOIN invoices ON invoice_items.invoice_id = invoices.id
            INNER JOIN transactions on invoices.id = transactions.invoice_id
            AND transactions.result LIKE 'success'
            GROUP BY item_id
            ORDER BY sum DESC"

      items = []
      Database.instance.db.execute(query)  do |row| 
        if items.length < total_items
          items << Item.find_by_id(row[0])
        else
          break
        end
      end
      items
    end

    private

    def create_item(row)
      id = row[0].to_i
      name = row[1]
      description = row[2]
      unit_price = row[3].to_f
      merchant_id = row[4].to_i
      created_at = row[5]
      updated_at = row[6]
      Item.new(id, name, description, unit_price, merchant_id, 
               created_at, updated_at)
    end
  end
end
