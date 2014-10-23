require 'spec_helper'

describe TasksController, type: :controller do
  describe "GET show" do
    let(:task) { FactoryGirl.create(:task, title: "Walk the dog") }

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
          post :create, task: FactoryGirl.attributes_for(:task)
        }.to change(Task, :count).by(1)
      end

      it "redirects to :show" do
        post :create, task: FactoryGirl.attributes_for(:task)
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "invalid attributes" do
      it "does not create task" do
        expect{
          post :create, task: FactoryGirl.attributes_for(:task, title: "")
        }.to_not change(Task, :count)
      end

      it "re-renders :new" do
        post :create, task: FactoryGirl.attributes_for(:task, title: "")
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET index" do
    before { Task.destroy_all }

    let(:first_task) { FactoryGirl.create(:task, title: "Walk the dog") }
    let(:second_task) { FactoryGirl.create(:task, title: "Buy groceries") }

    it "renders :index" do
      get :index
      expect(response).to render_template(:index)
    end

    # It should assign @tasks equal to all Tasks
    it "assigns all tasks to @tasks as an array" do
      get :index
      assigns(:tasks).should eq([first_task, second_task]) # May be reversed order
      # Behind the scenes, this will test: @tasks == [ { id: 1, title: "Walk the dog" }, { id: 2, title: "Buy groceries"} ]
    end
  end

  describe "GET edit" do
    let(:task) { FactoryGirl.create(:task) }

    it "renders :edit" do
      get :edit, id: task.id
      expect(response).to render_template(:edit)
    end

    it "assigns requested task to @task" do
      get :edit, id: task.id
      assigns(:task).should eq(task)
    end
  end

  describe "PUT update" do
    let(:task) { FactoryGirl.create(:task, title: "Do the dishes") }

    context "valid attributes" do
      # it changes @task's attributes
      it "changes @task's attributes" do
        # 1. Make a change to @task in the background
        put :update, id: task.id, task: FactoryGirl.attributes_for(:task, title: "Walk the dog")
        # 2. Refresh the data
        task.reload
        # 3. Test that @task (older version) isn't the same as @task (newer version)
        expect(task.title).to eq("Walk the dog")
      end

      it "redirects to :show" do
        put :update, id: task.id, task: FactoryGirl.attributes_for(:task, title: "Walk the dog")
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "invalid attributes" do
      it "does not change @task's attributes" do
        put :update, id: task.id, task: { title: "" } # Now invalid w/blank title
        task.reload
        expect(task.title).to eq("Do the dishes")
      end

      it "re-renders :edit" do
        put :update, id: task.id, task: { title: "" } # Now invalid w/blank title
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    let!(:task) { Task.create(title: "Walk the dog") }

    it "deletes the requested task" do
      expect{
        delete :destroy, id: task.id
      }.to change(Task, :count).by(-1)
    end

    it "redirects to :index" do
      delete :destroy, id: task.id
      expect(response).to redirect_to(tasks_path)
    end
  end
end

# /tasks/5 -- I want to only see the info for task w/id of 5 -- @task -- talking about a single task, useful in a show
# /tasks -- @tasks = Task.all
# Task is a class, TR --> User, GroceryList
# DB table is tasks table
# Task model, TasksController, 
# /tasks/3, /tasks/17
