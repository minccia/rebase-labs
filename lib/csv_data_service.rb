require 'csv'

class CSVDataService 
  def self.parse_csv(relative_path)
    rows = CSV.read(relative_path, col_sep: ';')
  
    columns = rows.shift
  
    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end
end