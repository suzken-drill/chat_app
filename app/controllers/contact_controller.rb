class ContactController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to root_path, notice: "お問い合わせが正常に送信されました"
    else
      flash.now[:error] = "お問い合わせの送信に失敗しました"
      render action: "new"
    end
  end

  def confirm
    @contact = Contact.new(contact_params)
    unless @contact.valid?
      flash.now[:error] = "入力内容に誤りがあります"
      return render action: "new"
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:email, :message)
    end
end
