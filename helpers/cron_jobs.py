from django_cron import CronJobBase, Schedule


class CronJobTest(CronJobBase):
    RUN_EVERY_MINS = 180
    schedule = Schedule(run_every_mins=RUN_EVERY_MINS)
    code = 'QUESTION_PROFICIENCY_LEVEL_UPDATE'

    def do(self):
        print("running cron job test function every minute.")
