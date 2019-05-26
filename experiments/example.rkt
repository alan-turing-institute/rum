#lang racket/base

(provide example-raw)

(define example-raw
  '#hasheq((@odata.context
          .
          "https://graph.microsoft.com/v1.0/$metadata#Collection(microsoft.graph.scheduleInformation)")
         (value
          .
          (#hasheq((availabilityView . "00000022222002202200")
                   (scheduleId . "margarethamilton@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "GUARD Project Meeting (Alan, Weisi) "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "DSSG Risk Analysis & Mitigation Viability"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Nico/Lukasz"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "1:1 James/ Tim"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location
                              .
                              "https://turing-uk.zoom.us/j/450074077 Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Turing <> OAI catch up re Margot visit"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Margaret Hamilton Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Turing Cambridge MSA"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((@odata.type
                                      .
                                      "#microsoft.graph.customTimeZone")
                                     (bias . 480)
                                     (daylightOffset
                                      .
                                      #hasheq((dayOccurrence . 2)
                                              (dayOfWeek . "sunday")
                                              (daylightBias . -60)
                                              (month . 3)
                                              (time . "02:00:00.0000000")
                                              (year . 0)))
                                     (name . "Customized Time Zone")
                                     (standardOffset
                                      .
                                      #hasheq((dayOccurrence . 1)
                                              (dayOfWeek . "sunday")
                                              (month . 11)
                                              (time . "02:00:00.0000000")
                                              (year . 0))))))))
           #hasheq((availabilityView . "20000022002022222000")
                   (scheduleId . "augusta@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T07:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T07:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "d"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Augusta Ada Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Dong Seminar"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Augusta Ada Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "BA meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:10:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Augusta Ada Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "TADS Ioannis"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Augusta Ada Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:15:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Whitaker Lab meeting"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "GMT Standard Time"))))))
           #hasheq((availabilityView . "00000222220022222000")
                   (scheduleId . "lovelace@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Lovelace Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "LWM Je-S catch up"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Lovelace Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "BA/IAG meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Lovelace Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:15:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Nesta Collective Intelligence Grants "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:15:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Lovelace Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Donna/Emmanouil"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Lovelace Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "UKCRIC:Turing training options"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "GMT Standard Time"))))))
           #hasheq((availabilityView . "00002202222222222200")
                   (scheduleId . "ursulafranklin@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Ursula Franklin Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Process planning"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:45:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Ursula Franklin Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:31:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Booked on screen"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Ursula Franklin Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "workable demo"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location
                              .
                              "https://turing-uk.zoom.us/j/908033886; Ursula Franklin Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "UK Repro FLOSS working group"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #t)
                             (location . "")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Private Appointment"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((@odata.type
                                      .
                                      "#microsoft.graph.customTimeZone")
                                     (bias . 480)
                                     (daylightOffset
                                      .
                                      #hasheq((dayOccurrence . 2)
                                              (dayOfWeek . "sunday")
                                              (daylightBias . -60)
                                              (month . 3)
                                              (time . "02:00:00.0000000")
                                              (year . 0)))
                                     (name . "Customized Time Zone")
                                     (standardOffset
                                      .
                                      #hasheq((dayOccurrence . 1)
                                              (dayOfWeek . "sunday")
                                              (month . 11)
                                              (time . "02:00:00.0000000")
                                              (year . 0))))))))
           #hasheq((availabilityView . "00000222222222202200")
                   (scheduleId . "florencenightingale@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "James Hetherington "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Khanisa Riaz "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:16:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Booked on screen"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Shital Desai "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Dong Nguyen "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Florence Nightingale Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Shital Desai "))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((@odata.type
                                      .
                                      "#microsoft.graph.customTimeZone")
                                     (bias . 480)
                                     (daylightOffset
                                      .
                                      #hasheq((dayOccurrence . 2)
                                              (dayOfWeek . "sunday")
                                              (daylightBias . -60)
                                              (month . 3)
                                              (time . "02:00:00.0000000")
                                              (year . 0)))
                                     (name . "Customized Time Zone")
                                     (standardOffset
                                      .
                                      #hasheq((dayOccurrence . 1)
                                              (dayOfWeek . "sunday")
                                              (month . 11)
                                              (time . "02:00:00.0000000")
                                              (year . 0))))))))
           #hasheq((availabilityView . "00222200220220222222")
                   (scheduleId . "davidblackwell@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T08:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Hack on dodo specification for distance measures"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Lab meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Discuss GCHQ sub-agreement update"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Discuss MoD contract"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room (GB)")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Chat about time series analysis"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "MAPS challenge meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "NLP Reading Group"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T17:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "David Blackwell Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "NLP Reading Group"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "Pacific Standard Time"))))))
           #hasheq((availabilityView . "00000222222222222200")
                   (scheduleId . "jackgood@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Jack Good Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Visiting Researcher - CRM Data"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:21:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Jack Good Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Booked on screen"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #t)
                             (location . "")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Private Appointment"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Jack Good Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "AIDA T"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Jack Good Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "AIDA M"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((@odata.type
                                      .
                                      "#microsoft.graph.customTimeZone")
                                     (bias . 480)
                                     (daylightOffset
                                      .
                                      #hasheq((dayOccurrence . 2)
                                              (dayOfWeek . "sunday")
                                              (daylightBias . -60)
                                              (month . 3)
                                              (time . "02:00:00.0000000")
                                              (year . 0)))
                                     (name . "Customized Time Zone")
                                     (standardOffset
                                      .
                                      #hasheq((dayOccurrence . 1)
                                              (dayOfWeek . "sunday")
                                              (month . 11)
                                              (time . "02:00:00.0000000")
                                              (year . 0))))))))
           #hasheq((availabilityView . "00022222222222222200")
                   (scheduleId . "maryshelley@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location
                              .
                              "Isaac Asimov Meeting Room; Mary Shelley Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T08:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Leadership & Management Development Programme, Module 1 – Introduction to Programme and Leadership"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "GMT Standard Time"))))))
           #hasheq((availabilityView . "00022222222222222200")
                   (scheduleId . "isaacasimov@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location
                              .
                              "Isaac Asimov Meeting Room; Mary Shelley Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T08:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Leadership & Management Development Programme, Module 1 – Introduction to Programme and Leadership"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "GMT Standard Time"))))))
           #hasheq((availabilityView . "00002222200222222200")
                   (scheduleId . "ace@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Mark Briers/Sebastian Vollmer "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Niv-Adriano"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:45:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "e-Atlas webspace meeting/call"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "DSG comms weekly catch up"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Amit/Donna catch-up"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "ACE Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Skype with Theo + Kangrui"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((@odata.type
                                      .
                                      "#microsoft.graph.customTimeZone")
                                     (bias . 480)
                                     (daylightOffset
                                      .
                                      #hasheq((dayOccurrence . 2)
                                              (dayOfWeek . "sunday")
                                              (daylightBias . -60)
                                              (month . 3)
                                              (time . "02:00:00.0000000")
                                              (year . 0)))
                                     (name . "Customized Time Zone")
                                     (standardOffset
                                      .
                                      #hasheq((dayOccurrence . 1)
                                              (dayOfWeek . "sunday")
                                              (month . 11)
                                              (time . "02:00:00.0000000")
                                              (year . 0))))))))
           #hasheq((availabilityView . "22222222202222200000")
                   (scheduleId . "banburismus@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Banburismus  Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T07:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Niv-Adriano"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Banburismus")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T09:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Student drop in sessions"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Banburismus  Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject
                              .
                              "Reproducible research champions catch-up"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Banburismus")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Objective setting"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "Pacific Standard Time"))))))
           #hasheq((availabilityView . "00222222000222220000")
                   (scheduleId . "delilah@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #t)
                             (location . "")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T08:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Private Appointment"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Delilah Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Meeting with Becky Inkster "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Delilah Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T13:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Mental Health - Networks "))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Delilah Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T14:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "PhD meeting"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "Pacific Standard Time"))))))
           #hasheq((availabilityView . "00022222202222222200")
                   (scheduleId . "turingery@turing.ac.uk")
                   (scheduleItems
                    .
                    (#hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Turingery Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T08:30:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "BinderHub meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T11:30:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location . "Turingery Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T10:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Sam Cohen's meeting"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #t)
                             (location . "")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T12:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "Private Appointment"))
                     #hasheq((end
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T16:00:00.0000000")
                                      (timeZone . "UTC")))
                             (isPrivate . #f)
                             (location
                              .
                              "Alan Turing Institute; Turingery Meeting Room")
                             (start
                              .
                              #hasheq((dateTime
                                       .
                                       "2019-05-16T15:00:00.0000000")
                                      (timeZone . "UTC")))
                             (status . "busy")
                             (subject . "CDEI / Turing meeting"))))
                   (workingHours
                    .
                    #hasheq((daysOfWeek
                             .
                             ("monday"
                              "tuesday"
                              "wednesday"
                              "thursday"
                              "friday"))
                            (endTime . "17:00:00.0000000")
                            (startTime . "08:00:00.0000000")
                            (timeZone
                             .
                             #hasheq((name . "Pacific Standard Time"))))))))))




