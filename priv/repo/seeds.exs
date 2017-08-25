# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Blog.Repo.delete_all Blog.Accounts.User 

Blog.Accounts.create_user(%{
  username: "User A",
  email: "secretemail1@email.com",
  token: "useratoken"
})

Blog.Accounts.create_user(%{
  username: "User B",
  email: "secretemail2@email.com",
  token: "userbtoken"
})