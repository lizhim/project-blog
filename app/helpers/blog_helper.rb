module BlogHelper
  def fetch_category_count(category)
    category_name=[]
    category = Categroy.where(sort: category)
    category.each do |c|
      if c.article_id != nil
        category_name.push(c)
      end
    end
    return category_name.length
  end

end
