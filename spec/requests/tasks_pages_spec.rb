require 'spec_helper'

describe "tasks" do

  subject { page }

  describe "show page GET /tasks/:id" do
    let(:my_task) { Task.create(title: "Do the dishes") }

    # Visit the show page /tasks/5 -- a single task
    before { visit task_path(my_task.id) }

    # Will see if the title is set correctly
    it { should have_title("Todo | Show Task") }

    # Will see if the headers are set correctly
    it { should have_selector('h1', "I need to...") }
    it { should have_selector('p', my_task.title) }
  end

  describe "new page GET /tasks/new" do
    # Visit the new page
    before { visit new_task_path }

    # Test that it has the correct title and header
    it { should have_title("Todo | New Task") }
    it { should have_selector('h1', "New Task") }

    # Test the create action
    describe "create POST /tasks" do

      let(:submit) { "Save" }

      # Valid info
        # Fill in forms
        # Click submit --> Creates a new task, redirects to show page
      context "valid information" do
        before do
          # visit new_task_path
          fill_in "Title",      with: "Walk the dog"
          check 'task_completed'
          fill_in "Due at",     with: 2.weeks.from_now.to_date
        end

        it "creates task" do
          # Click submit
          # Check that a new task was saved
          expect { click_button submit }.to change(Task, :count).by(1)
        end

        # # BEFORE -- read: errors
        # it "redirects to :show" do
        #   # Click submit
        #   click_button submit
        #   # Check for redirect
        #   it { should have_title("Todo | Show Task") }
        #   it { should have_selector('p', "Walk the dog") }
        # end

        describe "after submission" do
          before { click_button submit }

          # Redirect to :show
          it { should have_title("Todo | Show Task") }
          it { should have_selector('p', "Walk the dog") }
        end
      end

      # Invalid info
        # Do not fill in forms
        # Click submit --> Does not create a new task, re-renders page with error messages
      context "invalid information" do
        it "does not create task" do
          # Since we require a non-empty title, simply clicking submit without filling in the form
          # will attempt to create an invalid task
          expect { click_button submit }.not_to change(Task, :count)
        end

        # # BEFORE -- read: errors
        # it "re-renders :new with errors" do
        #   before { click_button submit }

        #   it { should have_title('Todo | New Task') }
        #   it { should have_content('error') }
        # end

        # AFTER -- fixed
        describe "after submission" do
          before { click_button submit }

          # re-renders :new with errors
          it { should have_title('Todo | New Task') }
          it { should have_content('error') }
        end
      end
    end
  end
end
