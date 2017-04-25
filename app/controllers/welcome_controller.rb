class WelcomeController < ApplicationController
    layout 'landingpage'
    def index
        flash[:notice] = '欢迎来到Job-Hunting！'
     end

    def aboutus; end

    def contactus; end

    def cooperatewithus; end
end
