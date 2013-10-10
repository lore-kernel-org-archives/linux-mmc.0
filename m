From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: Use autosuspend when applicable at runtime idle
Date: Thu, 10 Oct 2013 18:00:46 +0200
Message-ID: <CAPDyKFqnY9rrwgsQmFFu04oSDCtb7GN264sj7wdJs_t6CpOFKw@mail.gmail.com>
References: <1381399307-21534-3-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.44L0.1310101035230.1307-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1310101035230.1307-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 October 2013 16:45, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 10 Oct 2013, Ulf Hansson wrote:
>
>> Typically the runtime idle function is triggered after resume and
>> probe. Instead of immediately requesting the device to go into
>> in-active state we make use of the autosuspend, if we have enabled
>> it earlier.
>>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/bus.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index cdca8a7..7f0e900 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -205,6 +205,12 @@ static int mmc_runtime_resume(struct device *dev)
>>
>>  static int mmc_runtime_idle(struct device *dev)
>>  {
>> +     if (pm_runtime_autosuspend_used(dev)) {
>> +             pm_runtime_mark_last_busy(dev);
>> +             pm_runtime_autosuspend(dev);
>> +             return -EBUSY;
>> +     }
>> +
>>       return 0;
>>  }
>

Hi Alan,

Thanks for response!

> I would greatly prefer to see the core rpm_idle() routine changed
> instead.  Currently the last line says:
>
>         return retval ? retval : rpm_suspend(dev, rpmflags);
>
> The second argument to rpm_suspend should be rpmflags | RPM_AUTO.  That
> way, if the runtime-idle callback returns 0, we will automatically do
> either a normal suspend or an autosuspend, whichever is appropriate.

I know you guys, Mika and Rafael had a discussion around this feature
a few month ago. Were thinking of you sending this response. :-)

At that time, Rafael suggested to go ahead using similar method as I
implemented here, which is also what Mika proposed for
drivers/i2c/busses/i2c-designware-platdrv.c, not sure he finally sent
a formal patch though.

Anyway, just wanted us all to be aligned on the best way forward. I am
also in favour of fixing this in the  runtime PM core. How do you
think we shall handle drivers that not have the runtime_idle
callbacks? I guess we want to use the RPM_AUTO flag here as well?

>
> As an added benefit, with this change there's no need to add the
> pm_runtime_autosuspend_used() function.

In my patch I am also checking if I should update the last busy mark,
do you mean it should be okay to do this even if not needed?

>
> Alan Stern
>

Kind regards
Ulf Hansson
