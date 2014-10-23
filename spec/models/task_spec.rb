require 'spec_helper'

describe Task do
  let(:user) { FactoryGirl.create(:user) }
  before { @task = user.tasks.create(title: "Walk the dog") }

  subject { @task }

  it { should respond_to(:completed) }
  it { should respond_to(:title) }
  it { should respond_to(:user) }     # @task.user --> hash of the owner of the task
  it { should respond_to(:user_id) }  # @task.user_id --> user's id 3 
  it { should be_valid }

  describe "validations" do
    describe "title" do
      describe "not present" do
        before { @task.title = " " }
        it { should_not be_valid }
      end

      describe "too short" do
        before { @task.title = "a" * 2 }
        it { should_not be_valid }
      end

      describe "too long" do
        before { @task.title = "a" * 255 }
        it { should_not be_valid }
      end
    end

    describe "completed" do
      it "false by default" do
        new_task = user.tasks.new(title: "Any working title")
        expect(new_task.completed).to eq(false)
      end
    end

    describe "due_at" do
      it "has default of current day" do
        new_task = user.tasks.create(title: "Anything goes here")
        expect(new_task.due_at).to eq(Date.today)
      end

      it "uses selected date if selected" do
        selected_date = 2.weeks.from_now.to_date
        new_task = user.tasks.create(title: "Future task", due_at: selected_date)
        expect(new_task.due_at).to eq(selected_date)
      end
    end

    describe "user_id" do
      context "not present" do
        before { @task.user_id = nil }
        it { should_not be_valid }
      end
    end
  end
end
