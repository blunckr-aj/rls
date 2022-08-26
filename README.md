# README

This is a proof of concept for using Postgres row-level security as a
multi-tenant model using a very simple rails app.

You will need two different postgres users, one with admin access that can run
migrations and set permissions, the other is the app user, which will have
limited permissions on some tables. Log in to postgres as your regular user and
run:

```
create user rls_user with login;
grant connect on rls_development to rls_user;
```

Now, migrations need to be run with:

```
DATABASE_USER=[your regular user] rails db:migrate
```

Now you can start rails, log in and create a store, click a button to select it,
then create albums which are automatically associated to the store, and only
visible when it is selected.
