# Intrepidus
*deep sleep in deep space, our submission for NASA Space Apps 2020*

Intrepidus is the optimal companion for an astronaut in space. Simply enter details like whether you are a morning or night person, the times you will dock and undock at the International Space Station, and your console shifts and Intrepidus will generate a personalised sleep schedule, meal plans and daily exercise plans for you in seconds!

## Instructions
Flutter SDK and a mobile application simulator of your choice is needed to run the application. Once this is done, clone this repository, navigate to the sleep_shifting_scheduler folder and type "flutter run" in your terminal and the application should start running. We use Firebase as back-end to store data from the application.

## Simple Algorithm for Sleep Shift Schedule
1. A morning person's optimal sleep schedule is from 22:00 - 5:00, while an evening person's optimal sleep schedule is 2:00 - 9:00.
2. The International Space Station follows GMT+0 for the timezone.
3. The initial sleep schedule is set to the start of the optimal sleep schedule time + the offset time difference from GMT+0. For example, if the the astronaut takes off at a location with GMT+6 and this person is a morning person, this means that the initial sleep schedule for this person will be set from 04:00 - 11:00.
4. If docking occurs before the start of the initial sleep schedule, the initial sleep schedule will start on the same day. If after, the initial sleep schedule starts the next day.
5. If a collision occurs, i.e., the astronaut docks whilst they are supposed to be sleeping, we check the offset...
6. The sleep schedule will be shifted by 1 hour each day until the optimal sleep schedule is achieved.
7. If a collision occurs with the console shift schedule, then...
8. If an astronaut chooses to take melatonin, then the optimal time to take is is 2 hours before they sleep.
9. For meal times, breakfast is set to 1 hour after an astronaut wakes up, dinner is set to 3 hours before a person is supposed to sleep and lunch is set to 6 hours before dinner.
10. If meal times collide with console shift schedules, then we will move the meal time to before or after the shift schedule...
11. Exercise will be conducted twice a day for 30 minutes each day and usually 1 to 2 hours after breakfast and lunch.
