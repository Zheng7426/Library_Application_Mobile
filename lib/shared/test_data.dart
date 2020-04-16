library library_application_mobile.test_data;


List<Map<String, dynamic>> bookData = [
  // hardcover non-fiction
  {
    "id": 0,
    "title": 'The Mamba Mentality',
    "author": 'Kobe Bryant',
    "summary":
        'Various skills and techniques used on the court by the late Los Angeles Lakers player.',
    "genre": 'hardcover-nonfiction',
    "isbn": '9780374201234',
  },
  {
    "id": 1,
    "title": 'Becoming',
    "author": 'Michelle Obama',
    "summary":
        'The former first lady describes how she balanced work, family and her husband’s political ascent.',
    "genre": 'hardcover-nonfiction',
    "isbn": '9783641227326',
  },
  {
    "id": 2,
    "title": 'Lady in Waiting',
    "author": 'Anne Glenconner',
    "summary":
        'A memoir that provides a look into the royal family by a lady-in-waiting to Princess Margaret.',
    "genre": 'hardcover-nonfiction',
    "isbn": '9780306846359',
  },
  {
    "id": 3,
    "title": 'The Office',
    "author": 'Andy Greene',
    "summary":
        'An oral history of the sitcom from its beginnings on the BBC through its nine-season run on American network TV.',
    "genre": 'hardcover-nonfiction',
    "isbn": '9781524744991',
  },
  {
    "id": 4,
    "title": 'Unknown Valor',
    "author": 'Martha MacCallum',
    "summary":
        'The Fox News anchor weaves stories of combat veterans who fought during World War II.',
    "genre": 'hardcover-nonfiction',
    "isbn": '9780062853875',
  },
  // Animals
  {
    "id": 5,
    "title": 'H Is For Hawk',
    "author": 'Helen Macdonald',
    "summary":
        'A grief-stricken British woman decides to raise a goshawk, a fierce bird that is notoriously difficult to tame.',
    "genre": 'animals',
    "isbn": '9781448130726',
  },
  {
    "id": 6,
    "title": 'The Genius of Birds',
    "author": 'Jennifer Ackerman',
    "summary":
        'Research reveals that many birds rival primates and even humans in their complex forms of intelligence.',
    "genre": 'animals',
    "isbn": '9780399563126',
  },
  {
    "id": 7,
    "title": 'The Soul of An Octopus',
    "author": 'Sy Montgomery',
    "summary":
        'The complex intelligence, emotional capacities, playfulness and spirit of the octopus, by a naturalist who counts several as friends.',
    "genre": 'animals',
    "isbn": '9781622316168',
  },
  {
    "id": 8,
    "title": 'A Street Cat Named Bob',
    "author": 'James Bowen',
    "summary":
        'A London busker befriends an injured cat, and the two become inseparable.',
    "genre": 'animals',
    "isbn": '9781250029478',
  },
  {
    "id": 9,
    "title": 'The Lion In The Living Room',
    "author": 'Abigail Tucker',
    "summary":
        'The evolutionary science, natural history and biology of house cats.',
    "genre": 'animals',
    "isbn": '9781501154478',
  },
  //Hardcover Fiction
  {
    "id": 10,
    "title": 'The Glass Hotel',
    "author": 'Emily St John Mandel',
    "summary":
        'Years after an international Ponzi scheme falls apart, one of its victims investigates the disappearance of a woman from a container ship.',
    "genre": 'hardcover-fiction',
    "isbn": '9780525521150',
  },
  {
    "id": 11,
    "title": 'In Five Years',
    "author": 'Rebecca Serle',
    "summary":
        'A Manhattan lawyer finds herself confronting a vision she had when elements of it come to life on schedule.',
    "genre": 'hardcover-fiction',
    "isbn": '9781982137465',
  },
  {
    "id": 12,
    "title": 'My Dark Vanessa',
    "author": 'Kate Elizabeth Russell',
    "summary":
        'A woman re-evaluates the relationship she had at age 15 with her 42-year-old English teacher 17 years ago.',
    "genre": 'hardcover-fiction',
    "isbn": '9780062941527',
  },
  {
    "id": 13,
    "title": 'The Silent Patient',
    "author": 'Alex Michaelides',
    "summary":
        'Theo Faber looks into the mystery of a famous painter who stops speaking after shooting her husband.',
    "genre": 'hardcover-fiction',
    "isbn": '9781250301710',
  },
  {
    "id": 14,
    "title": 'The Boy From The Woods',
    "author": 'Harlan Coben',
    "summary":
        'When a girl goes missing, a private investigator’s feral childhood becomes an asset in the search.',
    "genre": 'hardcover-fiction',
    "isbn": '9781473567221',
  },
];

Map<String, dynamic> currentUserJson = {
  "id": 2,
  "name": "Ken",
  "email": "kts@kts.com",
  "employee_number": "",
  "eomployee_role": false,
  "user_role": true,
};

Map<String, dynamic> favoriteBookListJson = {
  "user_id": 2,
  "book_list": [3, 5, 7, 9],
};

Map<String, dynamic> bookCommentListJson = {
  "book_id": 2,
  "comments": [
    {
      "title":"good book",
      "note":"A book I will recommend to everyone!"
    },
    {
      "title":"good book+1",
      "note":"A book I will recommend to everyone too!"
    }
  ]
};

