require 'spec_helper'

describe TasksController, type: :controller do
  describe "GET show" do
    let(:task) { Task.create(title: "Walk the dog") }

    it "renders :show" do
      get :show, id: task.id
      expect(response).to render_template(:show)
    end

    it "assigns requested task to @task" do
      get :show, id: task.id
      # Assigns @task to eq task that we defined on line 5
      assigns(:task).should eq(task)
    end
  end

  # $ bundle exec rspec spec/controllers/tasks_controller_spec.rb:20
  describe "GET new" do
    it "renders :new" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new Task to @task" do
      get :new
      assigns(:task).should be_a_new(Task) # confirm that @task = Task.new
    end
  end

  describe "POST create" do
    context "valid attributes" do
      it "creates task" do
        # When I post to the create action, change Task.count by 1, aka add 1 to the tasks db
        expect{
          post :create, task: { title: "Walk the dog" }
        }.to change(Task, :count).by(1)
      end

      it "redirects to :show" do
        post :create, task: { title: "Walk the dog" }
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "invalid attributes" do
      it "does not create task" do
        expect{
          post :create, task: { title: "" }
        }.to_not change(Task, :count)
      end

      it "re-renders :new" do
        post :create, task: { title: "" }
        expect(response).to render_template(:new)
      end
    end
  end
end
