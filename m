From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Sun, 5 Feb 2017 09:43:37 +0800
Message-ID: <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:42091 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdBEBoG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Feb 2017 20:44:06 -0500
In-Reply-To: <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Uri Yanai <uri.yanai@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>

On 2017/2/2 20:49, Ulf Hansson wrote:
> + Adrian, Shawn-Lin, Jaehoon, Ritesh
>
> On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
>> In case of Runtime Suspend, check the device BKOPS level.
>> Return –EBUSY if device need more time to complete its internal BKOPS.
>>
>> Changes in v2:
>> - return –EBUSY instead of delaying suspend
>> - remove define EXT_CSD_BKOPS_LEVEL_1
>>
>> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
>> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>> ---
>>  drivers/mmc/core/mmc.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f70f6a1..211b726 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1942,7 +1942,8 @@ static void mmc_detect(struct mmc_host *host)
>>         }
>>  }
>>
>> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>> +       bool is_runtime_pm)
>>  {
>>         int err = 0;
>>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>> @@ -1954,6 +1955,24 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>                 goto out;
>>
>>         if (mmc_card_doing_bkops(host->card)) {
>> +               if (is_runtime_pm && host->card->ext_csd.auto_bkops_en) {
>
> This don't work. Primarily because mmc_card_doing_bkops(host->card)
> don't ever return true, unless manual BKOPS is enabled.
>
> I think you need to start with checking if *auto* BKOPS is enabled,
> then you can continue to read the BKOPS status to find out whether you
> should return -EBUSY.
>
>> +                       err = mmc_read_bkops_status(host->card);
>> +                       if (err) {
>> +                               pr_err("%s: error %d reading BKOPS Status\n",
>> +                                               mmc_hostname(host), err);
>> +                               goto out;
>> +                       }
>> +
>> +                       if (host->card->ext_csd.raw_bkops_status >=
>> +                                       EXT_CSD_BKOPS_LEVEL_2) {
>> +                               /*
>> +                                * We don’t allow Runtime Suspend while device
>> +                                * still needs time to complete internal BKOPS
>> +                                */
>
> Hmm.
>
> Shouldn't we abort (return -EBUSY) also in the system PM suspend case
> and not only for runtime PM suspend?

I would rather we don't abort runtime PM, but do it for system PM
instead. What we do for runtime PM is just for saving power for
our hosts including manipulating clock and genpd etc.. Thus we don't
touch any power-supply for eMMC. If so, it could still be possible
for eMMC firmware to work on doing bkops in rpm context.

>
> I think we need to discuss this with some other mmc folkz as well,
> looping in Adrian, Shawn, Jaehoon and Ritesh.
>
> Of course, unless we are being clever, in could mean that the system
> will never enter system PM suspend state, due to a bad behaving eMMC
> always reporting EXT_CSD_BKOPS_LEVEL_2. So we need to be careful here.
>

We don't have enough data to support this hypothesis but if it does
happen, it seems we should allow more time for the bad behaving eMMC
to do bkops.


> Now, assume we may want to abort in the system PM suspend case as
> well, then we consider to avoid the "Opportunistic sleep" from
> hammering us with new system PM suspend attempts. That can be avoided
> by activating a wakeup source (aka wakelock), via calling
> pm_wakeup_event(), using the struct device for the mmc_card as the
> parameter.

I was trying to figure out could we reuse "keep-power-in-suspend" policy
for eMMC as well.

If the power-supply(aka vmmc/vqmmc) couldn't be controlled by mmc
core for reasons:
a) it's fixed and couldn't be turn off actually, then we shouldn't
abort the system PM as we treat it as rpm case.
b) dt folkz forget to add them for mmc node, so the power-supply won't
be off during system PM that we don't need to abort the system PM as
well.

If the power-supply could be controlled by mmc core, things would be a
little complex from my mind. Two possible ideas then:
c) we avoid to enter the system PM by whatever methods, for instace,
by calling pm_wakeup_event or simply returning -EBUSY. OR
d) keep the power-supply and register a wakeup timer. So the system PM
could still go on and later the system wakeup to check should we remove
the power-supply then as we know there is no more access for eMMC
during the period of suspend and we expect it's also enough for eMMC
firmware to finish critical bkops.

Always we need some tradeoff to balance the perf & power :)

>
>> +                               err = -EBUSY;
>> +                               goto out;
>> +                       }
>> +               }
>>                 err = mmc_stop_bkops(host->card);
>>                 if (err)
>>                         goto out;
>> @@ -1987,7 +2006,7 @@ static int mmc_suspend(struct mmc_host *host)
>>  {
>>         int err;
>>
>> -       err = _mmc_suspend(host, true);
>> +       err = _mmc_suspend(host, true, false);
>>         if (!err) {
>>                 pm_runtime_disable(&host->card->dev);
>>                 pm_runtime_set_suspended(&host->card->dev);
>> @@ -2034,7 +2053,7 @@ static int mmc_shutdown(struct mmc_host *host)
>>                 err = _mmc_resume(host);
>>
>>         if (!err)
>> -               err = _mmc_suspend(host, false);
>> +               err = _mmc_suspend(host, false, false);
>>
>>         return err;
>>  }
>> @@ -2058,7 +2077,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
>>         if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>>                 return 0;
>>
>> -       err = _mmc_suspend(host, true);
>> +       err = _mmc_suspend(host, true, true);
>>         if (err)
>>                 pr_err("%s: error %d doing aggressive suspend\n",
>>                         mmc_hostname(host), err);
>> --
>> 1.9.1
>>
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

