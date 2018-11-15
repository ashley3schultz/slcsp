class Session

    def update_rates
        Plan.get_plans
        new_file = []
        csv = CSV.read('slcsp.csv', headers: true)
        csv.each_with_index do |row, i|
            area = find_rate_area(row['zipcode'])
            plans = area[:id].size == 1 ? find_plans(area) : []
            row['rate'] = plans.sort[1].to_f if plans.size > 1
            row['zipcode'] = row['zipcode'].to_i
            new_file << row
            puts row
        end
        CSV.open('new_slcsp.csv', 'wb') do |csv| 
            csv << ["zipcode","rate"]
            new_file.each { |row| csv << row }
        end
        puts "Checkout your new file named: new_slcsp.csv"
    end 

    def find_rate_area(zip)
        area = {:id => [], :st => []}
        csv_zips = File.read('zips.csv')
        csv = CSV.parse(csv_zips, :headers => true)
        csv.each do |row|
            if row['zipcode'] == zip
                area[:id] << row['rate_area'] 
                area[:st] << row['state'] 
            end
        end 
        area
    end

    def find_plans(area)
        id = area[:id].first
        st = area[:st].first
        plans = []
        Plan.all.each do |plan| 
            plans << plan.rate.to_f if plan.area == id && plan.state == st && !plans.include?(plan.rate)
        end
        plans
    end
    
end