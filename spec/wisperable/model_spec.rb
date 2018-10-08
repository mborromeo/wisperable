require 'spec_helper'

describe Wisperable::Model do

  describe '#broadcast_after_created' do
    it 'broadcast event if enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable events: [:created]
      end

      todo = Todo.new(body: 'todo')
      expect(todo).to receive(:broadcast).with('todo_created', todo)
      todo.save!
    end

    it 'wont broadcast event if not enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable
      end

      todo = Todo.new(body: 'todo')
      expect(todo).to_not receive(:broadcast).with('todo_created', todo)
      todo.save!
    end
  end

  describe '#broadcast_after_updated' do
    it 'broadcast event if enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable events: [:updated]
      end

      todo = Todo.create(body: 'todo')
      expect(todo).to receive(:broadcast).with('todo_updated', todo, body: ['todo', 'todo updated'])
      todo.body = 'todo updated'
      todo.save!
    end

    it 'wont broadcast event if not enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable
      end

      todo = Todo.create(body: 'todo')
      expect(todo).to_not receive(:broadcast).with('todo_updated', todo, body: ['todo', 'todo updated'])
      todo.body = 'todo updated'
      todo.save!
    end
  end

  describe '#broadcast_after_destroyed' do
    it 'broadcast event if enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable events: [:destroyed]
      end

      todo = Todo.create(body: 'todo')
      expect(todo).to receive(:broadcast).with('todo_destroyed', todo.attributes)
      todo.destroy
    end

    it 'wont broadcast event if not enabled' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable
      end

      todo = Todo.create(body: 'todo')
      expect(todo).to_not receive(:broadcast).with('todo_destroyed', todo.attributes)
      todo.destroy
    end
  end

  describe '#publish_key' do
    it 'changes the broadcasting key' do

      class Todo < ActiveRecord::Base
        include Wisperable::Model
        wisperable events: [:created], publish_key: 'task'
      end

      todo = Todo.new(body: 'todo')
      expect(todo).to receive(:broadcast).with('task_created', todo)
      todo.save!
    end
  end
end