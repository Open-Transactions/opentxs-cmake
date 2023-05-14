# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(
  otcommon_file_to_hex
  FILE_NAME
  OUTPUT_VARIABLE
)
  file(
    READ
    "${FILE_NAME}"
    HEX_CONTENTS
    HEX
  )
  string(
    REGEX
      MATCHALL
      "([A-Za-z0-9][A-Za-z0-9])"
      SEPARATED_HEX
      "${HEX_CONTENTS}"
  )
  list(
    JOIN
    SEPARATED_HEX
    ", 0x"
    FORMATTED_HEX
  )
  string(
    PREPEND
    FORMATTED_HEX
    "0x"
  )
  string(LENGTH "${FORMATTED_HEX}" FORMATTED_LENGTH)
  set(HEX_LINES "")
  set(POSITION 0)
  set(COLUMN_COUNT 12)
  math(
    EXPR
    INCREMENT
    "${COLUMN_COUNT} * 6"
  )

  while(
    FORMATTED_LENGTH
    GREATER
    0
  )
    string(
      SUBSTRING
        "${FORMATTED_HEX}"
        "${POSITION}"
        "${INCREMENT}"
        HEX_LINE
    )
    list(
      APPEND
      HEX_LINES
      "${HEX_LINE}"
    )
    math(
      EXPR
      FORMATTED_LENGTH
      "${FORMATTED_LENGTH} - ${INCREMENT}"
    )
    math(
      EXPR
      POSITION
      "${POSITION} + ${INCREMENT}"
    )
  endwhile()

  list(
    JOIN
    HEX_LINES
    "\n"
    FINAL_HEX
  )

  set("${OUTPUT_VARIABLE}"
      "${FINAL_HEX}"
      PARENT_SCOPE
  )
endfunction()
