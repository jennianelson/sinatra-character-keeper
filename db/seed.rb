jennianelson = User.create(username: "smallsy", email: "smallsy@gmail.com", password: "smallsypassword")

jennianelson_characters = jennianelson.characters.create([
  {name: "Auri", description: "Kvothe's friend who lives underground", book:"Kingskiller Chronicles"}, {name: "Dumbledore", description: "master wizard and headmaster of Hogwarts", book: "Harry Potter Series"}, {name: "Smeagol, A.K.A. Gollum", description: "Man who found The One Ring, giving him unnaturally long life in the caverns underground", book: "The Hobbit, The Lord of the Rings"}
  ])

larges = User.create(username: "larges", email: "larges@gmail.com", password: "largespassword")

larges_characters = larges.characters.create([
  {name: "Darth Vader", description: "The emperor's muscle", book: "Star Wars"}, {name: "Dean Moriarity", description: "friend of Sal Paradise", book: "On the Road"}
  ])
