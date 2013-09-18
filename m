From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH V2] mmc:core: Avoid useless detecting task when card is
 busy
Date: Wed, 18 Sep 2013 11:52:15 +0800
Message-ID: <5239236F.1090208@freescale.com>
References: <1379408612-5098-1-git-send-email-Haijun.Zhang@freescale.com> <CAPDyKFpim0GsVynFgauS3Ebdo48-QhKdaAUPxP+Pp5Zoqxp0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:21164
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292Ab3IRDwW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Sep 2013 23:52:22 -0400
In-Reply-To: <CAPDyKFpim0GsVynFgauS3Ebdo48-QhKdaAUPxP+Pp5Zoqxp0dw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>, scottwood@freescale.com, X.Xie@freescale.com


=E4=BA=8E 2013/9/17 21:21, Ulf Hansson =E5=86=99=E9=81=93:
> Hi Haijun,
>
> On 17 September 2013 11:03, Haijun Zhang <Haijun.Zhang@freescale.com>=
 wrote:
>> When card is in cpu polling mode to detect card present. Card detect=
ing
>> task will be scheduled about once every second. When card is busy in=
 large
>> file transfer, detecting task will be hang and call trace will be pr=
ompt.
>> When handling the request, CMD13 is always followed by every command=
 when
>> it was complete. So assume that card is present to avoid this duplic=
ate
>> detecting. Only polling card when card is free to reduce conflict wi=
th
>> data transfer.
>>
>> <7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
>> INFO: task kworker/u:1:12 blocked for more than 120 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mes=
sage.
>> kworker/u:1     D 00000000     0    12      2 0x00000000
>> Call Trace:
>> [ee06dd50] [44042028] 0x44042028
>> (unreliable)
>> [ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
>> [ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4
>>
>> [ee06dea0] [c04dd898] schedule+0x30/0xbc
>>
>> [ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c
>>
>> [ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0
>>
>> [ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
>> [ee06df40] [c00661cc] process_one_work+0x140/0x3e0
>>
>> [ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
>> [ee06dfb0] [c006bf10] kthread+0x7c/0x80
>>
>> [ee06dff0] [c000de58] kernel_thread+0x4c/0x68
>> <7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>> changes for V2:
>>          - Add card detecting once the last request is done.
>>
>>   drivers/mmc/card/block.c | 28 ++++++++++++++++++++++++++--
>>   drivers/mmc/core/core.c  |  5 +++++
>>   drivers/mmc/core/mmc.c   |  3 ++-
>>   drivers/mmc/core/sd.c    |  3 ++-
>>   drivers/mmc/core/sdio.c  |  3 ++-
>>   5 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 1a3163f..f280320 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1960,9 +1960,20 @@ static int mmc_blk_issue_rq(struct mmc_queue =
*mq, struct request *req)
>>          struct mmc_host *host =3D card->host;
>>          unsigned long flags;
>>
>> -       if (req && !mq->mqrq_prev->req)
>> +       if (req && !mq->mqrq_prev->req) {
>> +               /*
>> +                * When we are here, card polling task will be block=
ed.
>> +                * So disable it to void this useless schedule.
> "avoid"
:-)
>> +                */
>> +               if (host->caps & MMC_CAP_NEEDS_POLL) {
>> +                       spin_lock_irqsave(&host->lock, flags);
>> +                       host->rescan_disable =3D 1;
>> +                       spin_unlock_irqrestore(&host->lock, flags);
> I believe you need to add "cancel_delayed_work_sync(&host->detect)" w=
ell!?
>
> Do note, that I am not confident sure that cancel_delayed_work_sync i=
s
> safe to run this from this context. What about the scenario were the
When we are here the current task is still running,
Invoke cancel_delayed_work_sync here will cause the task hang.
> detect work is just about to remove a card then will be waiting for
> the block queue to close, which then waits for the
> cancel_delayed_work_sync to end. :-)
Let me confirm whether I understand what you mean.
You worried about the remove task is block by the block queue. This=20
patch changed the priority of remove task?
There several scenario here:
a . schedule detect work( HZ )
b . block work queue
c . schedule detect work immediately ( 0 )
d. detect remove task running
1. a->b->c->d
2. a->d->b->c->b->c->d
3. a->b->b->c->b->c->b->d

So if step 'd' is really running is depend on the followed task 'b'.

Or, I miss something else? Hope to make this clear.:-)
>
>
>> +               }
>> +
>>                  /* claim host only for the first request */
>>                  mmc_get_card(card);
>> +       }
>>
>>          ret =3D mmc_blk_part_switch(card, md);
>>          if (ret) {
>> @@ -1999,7 +2010,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
mq, struct request *req)
>>
>>   out:
>>          if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
>> -            (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
>> +            (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
>>                  /*
>>                   * Release host when there are no more requests
>>                   * and after special request(discard, flush) is don=
e.
>> @@ -2007,6 +2018,19 @@ out:
>>                   * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>>                   */
>>                  mmc_put_card(card);
>> +
>> +               /*
>> +                * Detecting card status immediately in case card be=
ing
>> +                * removed just after the request is complete.
>> +                */
>> +               if (host->caps & MMC_CAP_NEEDS_POLL) {
>> +                       spin_lock_irqsave(&host->lock, flags);
>> +                       host->rescan_disable =3D 0;
>> +                       spin_unlock_irqrestore(&host->lock, flags);
>> +                       mmc_detect_change(host, 0);
>> +               }
>> +       }
>> +
>>          return ret;
>>   }
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index b9b9fb6..2831c03 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -925,15 +925,20 @@ EXPORT_SYMBOL(__mmc_claim_host);
>>    */
>>   int mmc_try_claim_host(struct mmc_host *host)
>>   {
>> +       struct mmc_card *card;
>>          int claimed_host =3D 0;
>>          unsigned long flags;
>>
>> +       card =3D host->card;
>> +       pm_runtime_get_sync(&card->dev);
> Nope, this wont work. pm_runtime_get_sync can trigger an
> mmc_claim_host, thus this entire function is not "non-blocking" any
> more.
I missed this. so this check should be invoked before schedule detect w=
ork.
>
> Could and option be to just do a best effort? Skipping the try_claim
> entirely -  maybe?
You mean just to check the card status without hold the task? or rewrit=
e=20
another
function like: non_block_claim_host?
>
>> +
>>          spin_lock_irqsave(&host->lock, flags);
>>          if (!host->claimed || host->claimer =3D=3D current) {
>>                  host->claimed =3D 1;
>>                  host->claimer =3D current;
>>                  host->claim_cnt +=3D 1;
>>                  claimed_host =3D 1;
>> +               set_current_state(TASK_RUNNING);
>>          }
>>          spin_unlock_irqrestore(&host->lock, flags);
>>          if (host->ops->enable && claimed_host && host->claim_cnt =3D=
=3D 1)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 6d02012..90e5555 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1447,7 +1447,8 @@ static void mmc_detect(struct mmc_host *host)
>>          BUG_ON(!host);
>>          BUG_ON(!host->card);
>>
>> -       mmc_get_card(host->card);
>> +       if (!mmc_try_claim_host(host))
>> +               return;
>>
>>          /*
>>           * Just check if our card has been removed.
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 5e8823d..7dfb24d 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1045,7 +1045,8 @@ static void mmc_sd_detect(struct mmc_host *hos=
t)
>>          BUG_ON(!host);
>>          BUG_ON(!host->card);
>>
>> -       mmc_get_card(host->card);
>> +       if (!mmc_try_claim_host(host))
>> +               return;
>>
>>          /*
>>           * Just check if our card has been removed.
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 80d89cff..e0cabf5 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -875,7 +875,8 @@ static void mmc_sdio_detect(struct mmc_host *hos=
t)
>>                  }
>>          }
>>
>> -       mmc_claim_host(host);
>> +       if (!mmc_try_claim_host(host))
>> +               return;
>>
>>          /*
>>           * Just check if our card has been removed.
>> --
>> 1.8.0
>>
>>
> Kind regards
> Ulf Hansson
>

--=20
Thanks & Regards
Haijun.


