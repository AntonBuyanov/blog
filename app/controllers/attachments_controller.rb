class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  def destroy
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge if current_user.author?(@image.record)
  end
end
