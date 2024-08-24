USE BlogPlatformDB
GO

SELECT TOP 5 *
FROM BlogPosts
ORDER BY create_at DESC;

---=======================
DELETE FROM BlogPosts
WHERE post_id = 34;


--=======================
INSERT INTO
BlogPosts
(author_id, category_id, post_title, post_content, is_premium, create_at)
VALUES
(203, 8, 'Exploring Serverless Architectures', 'Serverless computing is transforming the way we build and deploy applications. In this article, we delve into the benefits and challenges of serverless architectures and how they can help you scale your applications effortlessly.', 1, GETDATE());

