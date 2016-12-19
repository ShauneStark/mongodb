defmodule MONGOBATCHTest do
  use ExUnit.Case
  import MONGOBATCH
  doctest MONGOBATCH

  test "Execute unordered batch writes" do
    # Define write document
    writedocument = %{
      collection: "mycollection",
      writes: [
        %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
        %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
        %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
        %BatchUpdateDocument{q: %{c: ""}, u: %{"$set" => %{a: 99, b: 199, c: "I'm a new entry!"}}, multi: false, upsert: false},
        %BatchUpdateDocument{q: %{c: ""}, u: %{"$set" => %{a: 99, b: 199, c: "I'm a new entry!"}}, multi: false, upsert: false},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchDeleteDocument{q: %{a: 10}, limit: 1},
        %BatchInsertDocument{document: %{a: 2, b: 4, c: "2"}},
        %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
        %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
        %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
        %BatchDeleteDocument{q: %{a: 4}, limit: 1},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
        %BatchUpdateDocument{q: %{c: "4"}, u: %{"$set" => %{a: 22, b: 222, c: "I'm a brand new entry!"}}, multi: false, upsert: true},
        %BatchDeleteDocument{q: %{a: 5}, limit: 1},
        %BatchDeleteDocument{q: %{a: 99}, limit: 1}
      ],
      writeConcern: %{
        w: 1
      },
      ordered: false
    }
    {:ok, mpid} = Mongo.start_link(database: "test")
    results = MONGOBATCH.batchwrite(mpid, writedocument)
    IO.puts("Test Results:")
    IO.inspect(results)
    assert(length(results.deleteresults) == 10)
    assert(length(results.insertresults) == 16)
    assert(length(results.updateresults) == 7)
  end

  # test "Execute ordered batch writes" do
  #   # Define write document
  #   writedocument = %{
  #     collection: "mycollection",
  #     writes: [
  #       %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
  #       %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
  #       %BatchInsertDocument{document: %{a: 1, b: 2, c: ""}},
  #       %BatchUpdateDocument{q: %{c: ""}, u: %{"$set" => %{a: 99, b: 199, c: "I'm a new entry!"}}, multi: false, upsert: false},
  #       %BatchUpdateDocument{q: %{c: ""}, u: %{"$set" => %{a: 99, b: 199, c: "I'm a new entry!"}}, multi: false, upsert: false},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 10}, limit: 1},
  #       %BatchInsertDocument{document: %{a: 2, b: 4, c: "2"}},
  #       %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
  #       %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
  #       %BatchUpdateDocument{q: %{c: "3"}, u: %{"$set" => %{a: 11, b: 111, c: "I'm an entry!"}}, multi: false, upsert: true},
  #       %BatchDeleteDocument{q: %{a: 4}, limit: 1},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchInsertDocument{document: %{a: 3, b: 6, c: "3"}},
  #       %BatchUpdateDocument{q: %{c: "4"}, u: %{"$set" => %{a: 22, b: 222, c: "I'm a brand new entry!"}}, multi: false, upsert: true},
  #       %BatchDeleteDocument{q: %{a: 5}, limit: 1},
  #       %BatchDeleteDocument{q: %{a: 99}, limit: 1}
  #     ],
  #     writeConcern: %{
  #       w: 1
  #     },
  #     ordered: true
  #   }
  #   results = batchwrite(writedocument)
  #   assert(length(results) == 39)
  # end
end