-- First, let's see what vote types currently exist
-- SELECT DISTINCT vote_type FROM votes;

-- Update any existing votes to use the new format BEFORE changing constraint
UPDATE votes SET vote_type = 'upvote' WHERE vote_type = 'up';
UPDATE votes SET vote_type = 'downvote' WHERE vote_type = 'down';

-- Handle any other potential variations
UPDATE votes SET vote_type = 'upvote' WHERE vote_type ILIKE 'upvote%';
UPDATE votes SET vote_type = 'downvote' WHERE vote_type ILIKE 'downvote%';

-- Remove the old constraint
ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_vote_type_check;

-- Add the new constraint with correct vote types
ALTER TABLE votes ADD CONSTRAINT votes_vote_type_check 
    CHECK (vote_type::text = ANY (ARRAY['upvote'::character varying::text, 'downvote'::character varying::text]));

-- Reset vote counts in reviews table since votes table is empty
UPDATE reviews SET upvotes = 0, downvotes = 0;

-- Reset vote counts in comments table since votes table is empty
UPDATE comments SET upvotes = 0, downvotes = 0;

-- Verify the constraint works
-- SELECT vote_type, COUNT(*) FROM votes GROUP BY vote_type;
-- Verify vote counts are reset
-- SELECT 'reviews' as table_name, SUM(upvotes) as total_upvotes, SUM(downvotes) as total_downvotes FROM reviews
-- UNION ALL
-- SELECT 'comments' as table_name, SUM(upvotes) as total_upvotes, SUM(downvotes) as total_downvotes FROM comments;
