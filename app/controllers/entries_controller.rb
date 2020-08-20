class EntriesController < ApplicationController
    def create
        @new_entry = Entry.new(entry_params)
        authorize @new_entry
        @new_entry.user = current_user
        @new_entry.request = Request.find(params[:request_id])
        if @new_entry.save
           redirect_to request_path(@new_entry.request, anchor: "entry-#{@new_entry.id}")
        else
           render 'requests/show'
        end
    end

    def entry_params
        params.require(:entry).permit(:body)
    end
end
