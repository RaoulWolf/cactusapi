
# test .check_structure_identifier()

expect_false(
  cactusapi:::.check_structure_identifier(NA)
)

expect_false(
  cactusapi:::.check_structure_identifier(NULL)
)

expect_false(
  cactusapi:::.check_structure_identifier(c("a", "b"))
)

expect_true(
  cactusapi:::.check_structure_identifier("caffeine")
)

# test .check_representation()

expect_false(
  cactusapi:::.check_representation(NA)
)

expect_false(
  cactusapi:::.check_representation(NULL)
)

expect_false(
  cactusapi:::.check_representation(c("inchi", "inchikey"))
)

expect_false(
  cactusapi:::.check_representation("something")
)

expect_true(
  cactusapi:::.check_representation("inchi")
)

# test get_representation()

expect_equal(
  get_representation(NA, "StdInChI"),
  NA_character_
)

expect_equal(
  get_representation("caffeine", "something"),
  NA_character_
)

expect_equal(
  length(get_representation("50-00-0", "Names")),
  148L
)
