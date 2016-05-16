class MessagesController < ApplicationController
    # 各アクションの前後に任意の処理を実行できる
    before_action :set_message, only: [:edit, :update, :destroy]  # :editと:updateの前だけ:set_messageを実行する

    def index
        @message = Message.new
        
        # messageをすべて取得する
        @messages = Message.all
    end
    
    def create
        @message = Message.new(message_params)
        if @message.save
            redirect_to root_path, notice: 'メッセージを保存しました'
        else
            # メッセージの保存に失敗した時
            @messages = Message.all
            flash.now[:alert] = "メッセージの保存に失敗しました。"
            render 'index'
        end
    end

    def edit
    end

    def update
        if @message.update(message_params)  # 更新処理
            # 保存に成功した場合はトップページへリダイレクト
            redirect_to root_path, notice: 'メッセージを編集しました'
        else
            # 保存に失敗した場合は編集画面へ戻す
            render 'edit'
        end
    end

    def destroy
        @message.destroy
        redirect_to root_path, notice: 'メッセージを削除しました'
    end


    private
    def message_params
        # 引数チェック
        # paramsに:messageがあって、キーが:nameと:bodyの値だけ受け取る
        params.require(:message).permit(:name, :body, :age)
    end

    def set_message
        @message = Message.find(params[:id])
    end
    ## ここまで
end
