require '../lib/qc'

qc = Qc.new

Shoes.app do

  background "#FFFFFF"
  stack(margin: 15) do
    @project_title = banner
    @project_title.text = "QC8538 Interface demo"
    @project_by = para
    @project_by.text = "by Crunch Technologies"
  end

  # stack(margin: 15) do
    flow(margin: 15) do
      para "Channel: "
      @channel_list = list_box
      @channel_list.items = []
      @channel_list.items = qc.get_channel_list
    end
    flow(margin: 15) do
      flow(margin: 10) do
        para "Keyword: "
        @keyword_list = list_box
        @keyword_list.items = []
        @keyword_list.items = qc.get_keyword_list
        @keyword_list.change {
          if @keyword_list.text != "Select one"
            @command_list.items = qc.get_command_list(@keyword_list.text)
          else
            @command_list.items = []
          end
        }
      end

      flow(margin: 10) do
        para "Command: "
        @command_list = list_box
        @command_list.items = []
        @command_list.change {
          if @command_list.text != "Select one"
            @parameter_list.items = qc.get_parameter_list(@keyword_list.text, @command_list.text)
          else
            @parameter_list.items = []
          end
        }
      end

      flow(margin: 10) do
        para "Parameter: "
        @parameter_list = list_box
        @parameter_list.items = []
      end

      @send_instruction = button "Send configuration"
      @instruction_sent = para 
      @send_instruction.click{
        if @parameter_list.text != "" and @parameter_list.text != "Select one"
          @instruction_sent.text = qc.send_instruction(@keyword_list.text, @channel_list.text, @command_list.text, @parameter_list.text)
        end
      }
    end

  # end

end