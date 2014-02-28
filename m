From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: SDIO driver return -ENOSYS behaviour change?
Date: Fri, 28 Feb 2014 10:37:58 +0800
Message-ID: <530FF686.2080901@intel.com>
References: <530F0118.2010501@intel.com>	<CAPDyKFrZAAVfFcaFx7o3TWMikWx7TvSPW_AuV1VsiuQF656uXg@mail.gmail.com>	<530F20E5.9000107@intel.com> <CAPDyKFpcJ5T9QXbFzZnu4fdgfjsTntfrtS=mo=5Wb_uJa7iMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpcJ5T9QXbFzZnu4fdgfjsTntfrtS=mo=5Wb_uJa7iMbw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 02/27/2014 09:05 PM, Ulf Hansson wrote:
> On 27 February 2014 12:26, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 02/27/2014 06:18 PM, Ulf Hansson wrote:
>>> On 27 February 2014 10:10, Aaron Lu <aaron.lu@intel.com> wrote:
>>>> Hi Ulf,
>>>>
>>>> I was tracking some SDIO suspend problem and came across this. As Neil
>>>> mentioned here:
>>>> http://lkml.org/lkml/2012/3/25/20
>>>> Quote:
>>>> "
>>>> SDIO (and possible MMC in general) has a protocol where the suspend
>>>>  method can return -ENOSYS and this means "There is no point in suspending,
>>>>  just turn me off".
>>>> "
>>>>
>>>> It seems that the following commit:
>>>>
>>>> commit 810caddba42a54fe5db4e2664757a9a334ba359c
>>>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Date:   Mon Jun 10 17:03:37 2013 +0200
>>>>
>>>>     mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
>>>>
>>>> Changed this behaviour?
>>>
>>> I realized I changed the behaviour to not cover for sdio func drivers,
>>> that actually implements the pm callbacks - but do return -ENOSYS in
>>> them. That wasn't obvious when looking at the code back then, sorry!
>>
>> Never mind, this behaviour change doesn't cause my problems but knowing
>> whether this behaviour should be kept affects how I'm going to solve my
>> problem.
> 
> So let's aim for the a proper solution instead of a quick hack.

OK.

> 
> Although apparently mwifiex, libertas and btmrvl_sdio (bluetooth) may
> return -ENOSYS from the respective system supend callbacks, thus
> expecting the card to be removed. Currently this won't happen, but
> instead the suspend will be aborted, which is really bad.
> 
> I believe those driver's suspend callback should be fixed to not
> return -ENOSYS. Returning 0 will, when MMC_PM_KEEP_POWER is not set,
> power off the card similar what's done when removing the card - that
> should be perfectly fine. Do note that the sdio func driver then
> should expect the resume callback to invoked, instead of being
> _probed_ at the next system resume.

Good to know this.

> 
>>
>> My problem is that, after the following commit:
>>
>> commit eed222aca8d077af3600b651176f6fd04d95cce1
>> Author: Aaron Lu <aaron.lu@intel.com>
>> Date:   Tue Mar 5 11:24:52 2013 +0800
>>
>>     mmc: sdio: bind acpi with sdio function device
>>
>> The SDIO function that has an ACPI node associated with will have the
>> pm_domain assigned, which breaks the intention that during SDIO function
>> device suspend phase nothing should be done by having a dummy BUS layer
>> callback. The existence of the pm_domain for the SDIO function device
>> will make its function driver's suspend callback gets called now. The
>> end result is the function driver's suspend callback is called twice.
> 
> Why is the sdio bus ignored?

In __device_suspend, if pm_domain is set, the suspend callback is
fetched there, no matter if there is a suspend callback defined in the
pm_domain or not. In ACPI PM domain's case, the suspend callback is
NULL, so the driver's suspend callback is used then.

I consulted Rafael whether adding a NULL check before goto Run is OK
like the following shows:

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1b41fca3d65a..506583d84ed4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1160,7 +1160,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-		goto Run;
+		if (callback)
+			goto Run;
 	}
 
 	if (dev->type && dev->type->pm) {

And Rafael said that would introduce regressions elsewhere, so it's a no
go.

> 
> Are you saying the power domain is using the pm_generic_suspend for or
> from it's ->suspend callback? If so, that could be the problem!?
> 
>>
>> To solve this problem, I was wondering why SDIO function device has this
>> 'special' requirement that nothing should be done at its own device
>> suspend phase but instead, relies on its suspend callback gets called in
>> its parent device's suspend callback. And then I realized the reason is
>> for the special handling of -ENOSYS.
> 
> That's to my understanding not the only reason.
> 
> I think it's more a matter of having a controlled suspend sequence.
> The mmc core are not able to serve any new SDIO requests while it is
> suspended, therefore it tells the sdio func driver about when it safe
> to send request - using it's PM callbacks.

Does this mean after the function device is suspended from PM core's
pespective, the mmc core will still send some requests to the function
device? I did see one such request, disable_width, get sent after the
function driver's suspend callback is invoked, don't know if there are
others.

>From the mmc_sdio_suspend function I can see two things are done:
1 function device driver's suspend callback is called;
2 optionally disable_width and power off the card according to some flags.

So once we fixed the -ENOSYS problem, can we have the function device
run its own suspend callback and have the mmc_sdio_suspend just did the
disable_width and power off thing?

> 
> You could debate whether that actually should be done though the PM
> callbacks, or by some other SDIO specific callbacks. Haven't thought
> it through completely yet.
> 
>>
>> So if we could get rid of the -ENOSYS, my problem could be easily solved
>> by deleting some lines in current code(the calling of function driver's
>> suspend callback in mmc_sdio_suspend and the dummy system suspend/resume
>> callback for SDIO bus). Buf if the behaviour has to be kept, I'll
>> probably need to remove the pm_domain for the device and do some
>> additional ACPI handing in mmc_sdio_suspend/resume for the function
>> device.
>>
> 
> So we have two different issues to address here.
> 
> Removing the option for sdio func drivers to return -ENOSYS from their
> suspend callback - has already be done, though by my mistake. Anyway,
> this won't solve your problem.
> 
> Additionally, I don't like putting this option back, since it's not
> possible to remove the card in that path. Still we could handle
> -ENOSYS and OK error and decide to power off the card. On the other
> hand, we could instead fix the sdio func drivers, that should be quite
> easy I think.
> 
>>>
>>> There are no solution to this problem in the mmc core right now, since
>>> we can't remove the card while we have reach the state when the
>>> suspend callback is being invoked.
>>>
>>> Instead, the sdio func driver shall not implement the PM callbacks at
>>> all. That behaviour means the mmc core will remove the card, but now
>>> it's done a in an earlier phase of the system suspend when we are
>>> still able to remove it.
>>
>> The libertas suspend callback is doing different things depending on
>> different conditions - sometime it will enable wakeup capability and
>> sometime it will want the mmc core to remove the device entirely by
>> retuning -ENOSYS, so it may not be that easy by just deleting the
>> callback, but I don't know for sure.
> 
> I had a look, the callback must remains.
> 
> As, stated - fix the suspend callback to not return -ENOSYS.

OK, I see, I'll try to come up with a patch for this, thanks for the
suggestion!

-Aaron

> 
> Kind regards
> Uffe
> 
> 
>>
>> Thanks,
>> Aaron

