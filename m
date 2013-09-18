From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc:core: Avoid useless detecting task when card is busy
Date: Wed, 18 Sep 2013 10:10:42 +0200
Message-ID: <CAPDyKFo4-hcQbn6sAk0ZaOoER2=J6HLqWcwUzFVBx_vY6ATQNQ@mail.gmail.com>
References: <1379408612-5098-1-git-send-email-Haijun.Zhang@freescale.com>
	<CAPDyKFpim0GsVynFgauS3Ebdo48-QhKdaAUPxP+Pp5Zoqxp0dw@mail.gmail.com>
	<5239236F.1090208@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:48914 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3IRIKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Sep 2013 04:10:43 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so5081925veb.39
        for <linux-mmc@vger.kernel.org>; Wed, 18 Sep 2013 01:10:42 -0700 (PDT)
In-Reply-To: <5239236F.1090208@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun <b42677@freescale.com>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>, scottwood@freescale.com, X.Xie@freescale.com

On 18 September 2013 05:52, Zhang Haijun <b42677@freescale.com> wrote:
>
> =E4=BA=8E 2013/9/17 21:21, Ulf Hansson =E5=86=99=E9=81=93:
>
>> Hi Haijun,
>>
>> On 17 September 2013 11:03, Haijun Zhang <Haijun.Zhang@freescale.com=
>
>> wrote:
>>>
>>> When card is in cpu polling mode to detect card present. Card detec=
ting
>>> task will be scheduled about once every second. When card is busy i=
n
>>> large
>>> file transfer, detecting task will be hang and call trace will be p=
rompt.
>>> When handling the request, CMD13 is always followed by every comman=
d when
>>> it was complete. So assume that card is present to avoid this dupli=
cate
>>> detecting. Only polling card when card is free to reduce conflict w=
ith
>>> data transfer.
>>>
>>> <7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
>>> INFO: task kworker/u:1:12 blocked for more than 120 seconds.
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
>>> kworker/u:1     D 00000000     0    12      2 0x00000000
>>> Call Trace:
>>> [ee06dd50] [44042028] 0x44042028
>>> (unreliable)
>>> [ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
>>> [ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4
>>>
>>> [ee06dea0] [c04dd898] schedule+0x30/0xbc
>>>
>>> [ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c
>>>
>>> [ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0
>>>
>>> [ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
>>> [ee06df40] [c00661cc] process_one_work+0x140/0x3e0
>>>
>>> [ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
>>> [ee06dfb0] [c006bf10] kthread+0x7c/0x80
>>>
>>> [ee06dff0] [c000de58] kernel_thread+0x4c/0x68
>>> <7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>>>
>>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>>> ---
>>> changes for V2:
>>>          - Add card detecting once the last request is done.
>>>
>>>   drivers/mmc/card/block.c | 28 ++++++++++++++++++++++++++--
>>>   drivers/mmc/core/core.c  |  5 +++++
>>>   drivers/mmc/core/mmc.c   |  3 ++-
>>>   drivers/mmc/core/sd.c    |  3 ++-
>>>   drivers/mmc/core/sdio.c  |  3 ++-
>>>   5 files changed, 37 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 1a3163f..f280320 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1960,9 +1960,20 @@ static int mmc_blk_issue_rq(struct mmc_queue=
 *mq,
>>> struct request *req)
>>>          struct mmc_host *host =3D card->host;
>>>          unsigned long flags;
>>>
>>> -       if (req && !mq->mqrq_prev->req)
>>> +       if (req && !mq->mqrq_prev->req) {
>>> +               /*
>>> +                * When we are here, card polling task will be bloc=
ked.
>>> +                * So disable it to void this useless schedule.
>>
>> "avoid"
>
> :-)
>
>>> +                */
>>> +               if (host->caps & MMC_CAP_NEEDS_POLL) {
>>> +                       spin_lock_irqsave(&host->lock, flags);
>>> +                       host->rescan_disable =3D 1;
>>> +                       spin_unlock_irqrestore(&host->lock, flags);
>>
>> I believe you need to add "cancel_delayed_work_sync(&host->detect)" =
well!?
>>
>> Do note, that I am not confident sure that cancel_delayed_work_sync =
is
>> safe to run this from this context. What about the scenario were the
>
> When we are here the current task is still running,
> Invoke cancel_delayed_work_sync here will cause the task hang.
>
>> detect work is just about to remove a card then will be waiting for
>> the block queue to close, which then waits for the
>> cancel_delayed_work_sync to end. :-)
>
> Let me confirm whether I understand what you mean.
> You worried about the remove task is block by the block queue. This p=
atch
> changed the priority of remove task?
> There several scenario here:
> a . schedule detect work( HZ )
> b . block work queue
> c . schedule detect work immediately ( 0 )
> d. detect remove task running
> 1. a->b->c->d
> 2. a->d->b->c->b->c->d
> 3. a->b->b->c->b->c->b->d
>
> So if step 'd' is really running is depend on the followed task 'b'.
>
> Or, I miss something else? Hope to make this clear.:-)
>
>>
>>
>>> +               }
>>> +
>>>                  /* claim host only for the first request */
>>>                  mmc_get_card(card);
>>> +       }
>>>
>>>          ret =3D mmc_blk_part_switch(card, md);
>>>          if (ret) {
>>> @@ -1999,7 +2010,7 @@ static int mmc_blk_issue_rq(struct mmc_queue =
*mq,
>>> struct request *req)
>>>
>>>   out:
>>>          if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
>>> -            (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
>>> +            (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
>>>                  /*
>>>                   * Release host when there are no more requests
>>>                   * and after special request(discard, flush) is do=
ne.
>>> @@ -2007,6 +2018,19 @@ out:
>>>                   * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>>>                   */
>>>                  mmc_put_card(card);
>>> +
>>> +               /*
>>> +                * Detecting card status immediately in case card b=
eing
>>> +                * removed just after the request is complete.
>>> +                */
>>> +               if (host->caps & MMC_CAP_NEEDS_POLL) {
>>> +                       spin_lock_irqsave(&host->lock, flags);
>>> +                       host->rescan_disable =3D 0;
>>> +                       spin_unlock_irqrestore(&host->lock, flags);
>>> +                       mmc_detect_change(host, 0);
>>> +               }
>>> +       }
>>> +
>>>          return ret;
>>>   }
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index b9b9fb6..2831c03 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -925,15 +925,20 @@ EXPORT_SYMBOL(__mmc_claim_host);
>>>    */
>>>   int mmc_try_claim_host(struct mmc_host *host)
>>>   {
>>> +       struct mmc_card *card;
>>>          int claimed_host =3D 0;
>>>          unsigned long flags;
>>>
>>> +       card =3D host->card;
>>> +       pm_runtime_get_sync(&card->dev);
>>
>> Nope, this wont work. pm_runtime_get_sync can trigger an
>> mmc_claim_host, thus this entire function is not "non-blocking" any
>> more.
>
> I missed this. so this check should be invoked before schedule detect=
 work.

Not sure how you mean? It is the task executing the detect work that
need to be able to claim the host in a non-blocking manner, right?

>
>>
>> Could and option be to just do a best effort? Skipping the try_claim
>> entirely -  maybe?
>
> You mean just to check the card status without hold the task? or rewr=
ite
> another
> function like: non_block_claim_host?

I mean you can leave the code as is, before this patch, for
drivers/mmc/core/* and only rely on the fix you done in the
drivers/mmc/card/block.c. It wont be perfect but still better. :-)
That is what I thought of, unless we can fix this without breaking
something else.

Kind regards
Ulf Hansson

>
>>
>>> +
>>>          spin_lock_irqsave(&host->lock, flags);
>>>          if (!host->claimed || host->claimer =3D=3D current) {
>>>                  host->claimed =3D 1;
>>>                  host->claimer =3D current;
>>>                  host->claim_cnt +=3D 1;
>>>                  claimed_host =3D 1;
>>> +               set_current_state(TASK_RUNNING);
>>>          }
>>>          spin_unlock_irqrestore(&host->lock, flags);
>>>          if (host->ops->enable && claimed_host && host->claim_cnt =3D=
=3D 1)
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 6d02012..90e5555 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1447,7 +1447,8 @@ static void mmc_detect(struct mmc_host *host)
>>>          BUG_ON(!host);
>>>          BUG_ON(!host->card);
>>>
>>> -       mmc_get_card(host->card);
>>> +       if (!mmc_try_claim_host(host))
>>> +               return;
>>>
>>>          /*
>>>           * Just check if our card has been removed.
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index 5e8823d..7dfb24d 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -1045,7 +1045,8 @@ static void mmc_sd_detect(struct mmc_host *ho=
st)
>>>          BUG_ON(!host);
>>>          BUG_ON(!host->card);
>>>
>>> -       mmc_get_card(host->card);
>>> +       if (!mmc_try_claim_host(host))
>>> +               return;
>>>
>>>          /*
>>>           * Just check if our card has been removed.
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>> index 80d89cff..e0cabf5 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -875,7 +875,8 @@ static void mmc_sdio_detect(struct mmc_host *ho=
st)
>>>                  }
>>>          }
>>>
>>> -       mmc_claim_host(host);
>>> +       if (!mmc_try_claim_host(host))
>>> +               return;
>>>
>>>          /*
>>>           * Just check if our card has been removed.
>>> --
>>> 1.8.0
>>>
>>>
>> Kind regards
>> Ulf Hansson
>>
>
> --
> Thanks & Regards
> Haijun.
>
>
