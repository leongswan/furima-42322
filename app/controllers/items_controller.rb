class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold!, only: %i[edit update]

  def redirect_if_sold!
    redirect_to root_path, alert: '売却済みのため編集できません' if @item.sold?
  end

  def index
    @items = Item.with_attached_image.includes(:order).order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '商品情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品を削除しました。'
    else
      redirect_to item_path(@item), alert: '削除に失敗しました。'
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: '権限がありません。' unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :delivery_fee_id,
      :area_id, :shipping_day_id, :price, :image
    )
  end
end
