From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Fri, 3 Feb 2017 15:03:38 +0530
Message-ID: <dc423c8d-ae55-2437-9f6e-b099a68c9d59@codeaurora.org>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdBCJdq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 04:33:46 -0500
In-Reply-To: <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On 2/2/2017 6:19 PM, Ulf Hansson wrote:
> + Adrian, Shawn-Lin, Jaehoon, Ritesh
>
> On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
>> In case of Runtime Suspend, check the device BKOPS level.
>> Return –EBUSY if device need more time to complete its internal BKOPS.
Do we need to abort the runtime suspend at all even though we are using 
CMD5?

 From what I understood from the spec is as follows - (please correct me 
if I am wrong) -
CMD7 -> CMD5 -> Busy line de-asserted by device(means autobkops 
execution is complete) -> Enter sleep mode.

Is the above understanding correct? In that case we may not need to 
abort the runtime suspend right?
Since CMD5 completion should ensure that background operation execution 
is complete (until then the busy line will be kept asserted).

Opinion?


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

My opinion - Auto bkops generally is meant for device to autonomously 
initiate the background transfer whenever the device is idle -> in such 
cases, we expect the device to keep it's autobkops exception level under 
control.
In that case will it be good idea to abort the suspend as well?

Off-course unless we would like to cover a case where device is not idle 
at all and during this heavy device usage suspend is getting triggered 
manually - which gives no time for device to do auto-bkops
Please correct me if my understanding is wrong?


>
> I think we need to discuss this with some other mmc folkz as well,
> looping in Adrian, Shawn, Jaehoon and Ritesh.
Thanks :)

>
> Of course, unless we are being clever, in could mean that the system
> will never enter system PM suspend state, due to a bad behaving eMMC
> always reporting EXT_CSD_BKOPS_LEVEL_2. So we need to be careful here.
>
> Now, assume we may want to abort in the system PM suspend case as
> well, then we consider to avoid the "Opportunistic sleep" from
> hammering us with new system PM suspend attempts. That can be avoided
> by activating a wakeup source (aka wakelock), via calling
> pm_wakeup_event(), using the struct device for the mmc_card as the
> parameter.
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
