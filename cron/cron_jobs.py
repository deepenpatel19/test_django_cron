from django_cron import CronJobBase, Schedule


class CronJobTest(CronJobBase):
    RUN_EVERY_MINS = 1
    schedule = Schedule(run_every_mins=RUN_EVERY_MINS)
    code = 'CronJobTest'

    def do(self):
        print("running cron job test function every minute.")
