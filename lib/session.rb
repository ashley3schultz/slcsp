class Session

    attr_accessor :zipcode, :metal_level, :rate_area, :rate, :plans

    def initialize 
        @plans = []
    end

    def call 
        set_zipcode
        # set_level
        # set_rate_area
        # find_plans
        # set_rate
        # print_plan
    end


    def set_zipcode
        puts "Please enter a zipcode"
        @zipcode = gets.strip
    end

    def set_level
        puts "Please enter a 'gold', 'silver', 'bronze'"
        @metal_level = gets.strip
    end

    def set_rate_area
        csv_zips = File.read('zips.csv')
        csv = CSV.parse(csv_zips, :headers => true)
        csv.each do |row| 
            @rate_area = row[:rate_area] if row[:zipcode] == @zipcode
        end 
    end

    def find_plans
        csv_plans = File.read('plans.csv')
        csv = CSV.parse(csv_plans, :headers => true)
        csv.each do |row| 
            @plans << row[:rate] if row[:rate_area] == @rate_area && row[:metal_level] == @metal_level
        end
    end 

    def set_rate
        @rate = self.all.sort[-2] || nil
    end

    def print_plan
        puts "#{@zipcode}, #{@rate}"
    end
end


