-- Users Table (required for FKs)
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE,
  created_at TIMESTAMP DEFAULT now()
);

-- Conversation Threads
CREATE TABLE conversation_threads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  title TEXT,
  created_at TIMESTAMP DEFAULT now()
);

-- Messages
CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  thread_id UUID REFERENCES conversation_threads(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  role TEXT CHECK (role IN ('user', 'bodhi', 'system')),
  content TEXT,
  deleted BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT now()
);

-- Memory Points
CREATE TABLE memory_points (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id UUID REFERENCES memory_points(id) ON DELETE CASCADE,
  message_id UUID REFERENCES messages(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  vector VECTOR(1536),
  importance_score FLOAT DEFAULT 0,
  summary TEXT,
  created_at TIMESTAMP DEFAULT now()
);

-- Optional: Deleted Memory Log (if needed for audit)
CREATE TABLE memory_cleanup_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  memory_point_id UUID,
  deleted_at TIMESTAMP DEFAULT now()
);
