class Blog::CategoriesController < BlogController

  def show
    @category = BlogCategory.find(params[:id])
    if !params[:page].blank? && params[:page].to_i == 1
      return permanent_redirect_to(blog_category_url(@category))
    end
    @blog_posts = @category.posts.live.includes(:comments, :categories).paginate({
      :page => params[:page],
      :per_page => RefinerySetting.find_or_set(:blog_posts_per_page, 10)
    })
  end

end
