
# 2019-06-96 rum 0.1.0

First public release, lacking in documentation and testing, but
functional. Important limitations:

  - Availabilities are shown only for the current date

  - Availabilities are shown for 30-minute intervals between 8am and 6pm local
    time

  - The authentication token is not cached so a re-authentication is required
    for each invocation; and the user is required to copy a short token from the
    terminal to a browser
