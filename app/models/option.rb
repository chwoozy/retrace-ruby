class Option < ApplicationRecord

    GETUSERS = "/getusers".freeze
    GETTODOS = "/gettodos".freeze
    GETPHOTOS = "/getphotos".freeze
    GETPOSTS = "/getposts".freeze
    GETCOMMENTS = "/getcomments".freeze
    GETALBUMS = "/getalbums".freeze
    SLOWREQUEST = "/slowrequest".freeze
    BADWEBREQUEST = "/badwebrequest".freeze
    API_CALLS = [GETUSERS, GETTODOS, GETPHOTOS, GETPOSTS, GETCOMMENTS, GETALBUMS, SLOWREQUEST, BADWEBREQUEST]
  end