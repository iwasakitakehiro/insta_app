class NotificationsController < ApplicationController
  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    #通知を全削除
      @notifications = current_user.passive_notifications
      @notifications.each do |notification|
        notification.destroy
      end
    redirect_to notifications_path
  end
end
