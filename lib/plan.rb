class Plan
    
    attr_accessor :state, :rate, :area
    @@all = []

    def initialize(state, rate, area)
        self.state = state
        self.rate = rate 
        self.area = area
        @@all << self
    end

    def self.all 
        @@all
    end

    def self.get_plans
        csv_plans = File.read('plans.csv')
        csv = CSV.parse(csv_plans, :headers => true)
        csv.each do |row| 
            if row['metal_level'] == "Silver"
                self.new(row['state'], row['rate'], row['rate_area'])
            end
        end
    end 
end
