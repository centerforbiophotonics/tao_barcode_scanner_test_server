class TaoController < ApplicationController
  def workshops
    render :json => File.read(Rails.root.join("app/views/tao/dummy.json"))
  end

  def attend
    # render :json => {status: "fail"}
    render :json => {status: "success"}
  end
end
