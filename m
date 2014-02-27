From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: SDIO driver return -ENOSYS behaviour change?
Date: Thu, 27 Feb 2014 14:05:33 +0100
Message-ID: <CAPDyKFpcJ5T9QXbFzZnu4fdgfjsTntfrtS=mo=5Wb_uJa7iMbw@mail.gmail.com>
References: <530F0118.2010501@intel.com>
	<CAPDyKFrZAAVfFcaFx7o3TWMikWx7TvSPW_AuV1VsiuQF656uXg@mail.gmail.com>
	<530F20E5.9000107@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46929 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaB0NFe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 08:05:34 -0500
Received: by mail-qc0-f178.google.com with SMTP id i8so3223777qcq.9
        for <linux-mmc@vger.kernel.org>; Thu, 27 Feb 2014 05:05:33 -0800 (PST)
In-Reply-To: <530F20E5.9000107@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 27 February 2014 12:26, Aaron Lu <aaron.lu@intel.com> wrote:
> On 02/27/2014 06:18 PM, Ulf Hansson wrote:
>> On 27 February 2014 10:10, Aaron Lu <aaron.lu@intel.com> wrote:
>>> Hi Ulf,
>>>
>>> I was tracking some SDIO suspend problem and came across this. As Neil
>>> mentioned here:
>>> http://lkml.org/lkml/2012/3/25/20
>>> Quote:
>>> "
>>> SDIO (and possible MMC in general) has a protocol where the suspend
>>>  method can return -ENOSYS and this means "There is no point in suspending,
>>>  just turn me off".
>>> "
>>>
>>> It seems that the following commit:
>>>
>>> commit 810caddba42a54fe5db4e2664757a9a334ba359c
>>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>>> Date:   Mon Jun 10 17:03:37 2013 +0200
>>>
>>>     mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
>>>
>>> Changed this behaviour?
>>
>> I realized I changed the behaviour to not cover for sdio func drivers,
>> that actually implements the pm callbacks - but do return -ENOSYS in
>> them. That wasn't obvious when looking at the code back then, sorry!
>
> Never mind, this behaviour change doesn't cause my problems but knowing
> whether this behaviour should be kept affects how I'm going to solve my
> problem.

So let's aim for the a proper solution instead of a quick hack.

Although apparently mwifiex, libertas and btmrvl_sdio (bluetooth) may
return -ENOSYS from the respective system supend callbacks, thus
expecting the card to be removed. Currently this won't happen, but
instead the suspend will be aborted, which is really bad.

I believe those driver's suspend callback should be fixed to not
return -ENOSYS. Returning 0 will, when MMC_PM_KEEP_POWER is not set,
power off the card similar what's done when removing the card - that
should be perfectly fine. Do note that the sdio func driver then
should expect the resume callback to invoked, instead of being
_probed_ at the next system resume.

>
> My problem is that, after the following commit:
>
> commit eed222aca8d077af3600b651176f6fd04d95cce1
> Author: Aaron Lu <aaron.lu@intel.com>
> Date:   Tue Mar 5 11:24:52 2013 +0800
>
>     mmc: sdio: bind acpi with sdio function device
>
> The SDIO function that has an ACPI node associated with will have the
> pm_domain assigned, which breaks the intention that during SDIO function
> device suspend phase nothing should be done by having a dummy BUS layer
> callback. The existence of the pm_domain for the SDIO function device
> will make its function driver's suspend callback gets called now. The
> end result is the function driver's suspend callback is called twice.

Why is the sdio bus ignored?

Are you saying the power domain is using the pm_generic_suspend for or
from it's ->suspend callback? If so, that could be the problem!?

>
> To solve this problem, I was wondering why SDIO function device has this
> 'special' requirement that nothing should be done at its own device
> suspend phase but instead, relies on its suspend callback gets called in
> its parent device's suspend callback. And then I realized the reason is
> for the special handling of -ENOSYS.

That's to my understanding not the only reason.

I think it's more a matter of having a controlled suspend sequence.
The mmc core are not able to serve any new SDIO requests while it is
suspended, therefore it tells the sdio func driver about when it safe
to send request - using it's PM callbacks.

You could debate whether that actually should be done though the PM
callbacks, or by some other SDIO specific callbacks. Haven't thought
it through completely yet.

>
> So if we could get rid of the -ENOSYS, my problem could be easily solved
> by deleting some lines in current code(the calling of function driver's
> suspend callback in mmc_sdio_suspend and the dummy system suspend/resume
> callback for SDIO bus). Buf if the behaviour has to be kept, I'll
> probably need to remove the pm_domain for the device and do some
> additional ACPI handing in mmc_sdio_suspend/resume for the function
> device.
>

So we have two different issues to address here.

Removing the option for sdio func drivers to return -ENOSYS from their
suspend callback - has already be done, though by my mistake. Anyway,
this won't solve your problem.

Additionally, I don't like putting this option back, since it's not
possible to remove the card in that path. Still we could handle
-ENOSYS and OK error and decide to power off the card. On the other
hand, we could instead fix the sdio func drivers, that should be quite
easy I think.

>>
>> There are no solution to this problem in the mmc core right now, since
>> we can't remove the card while we have reach the state when the
>> suspend callback is being invoked.
>>
>> Instead, the sdio func driver shall not implement the PM callbacks at
>> all. That behaviour means the mmc core will remove the card, but now
>> it's done a in an earlier phase of the system suspend when we are
>> still able to remove it.
>
> The libertas suspend callback is doing different things depending on
> different conditions - sometime it will enable wakeup capability and
> sometime it will want the mmc core to remove the device entirely by
> retuning -ENOSYS, so it may not be that easy by just deleting the
> callback, but I don't know for sure.

I had a look, the callback must remains.

As, stated - fix the suspend callback to not return -ENOSYS.

Kind regards
Uffe


>
> Thanks,
> Aaron
