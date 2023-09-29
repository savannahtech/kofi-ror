## #1

Requests to Acme's API are timing out after 15 seconds. After some investigation in production, they've identified that the `User#count_hits` method's response time is around 500ms and is called 50 times per second (on average).

Answer:

1. Cache the count_hits method on the user instance i.e cached_count_hits
2. We can also add an index on created_at coulmn of hits table to improve the db search time
   since the search is done on the created_at column
3. We handle updating the user quota on background job

## #2

Users in Australia are complaining they still get some “over quota” errors from the API after their quota resets at the beginning of the month and after a few hours it resolves itself. A user provided the following access logs:

Answer:

1. This is a timezone issue. The host server is on a DateTime with a
   different timezone other than Austrailia.

   Since we exclusively deal with dates without timezones should introduce a timezone field on the user model.
   This will allow
