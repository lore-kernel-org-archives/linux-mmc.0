From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: block: Enable runtime pm for mmc blkdevice
Date: Tue, 5 Mar 2013 09:39:22 +0800
Message-ID: <CAPDyKFq8q_WmZAdQf_VjS6qYD+MH-QyPJARNV=bj4CKOr_M7Tw@mail.gmail.com>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
	<1362142035-8403-4-git-send-email-ulf.hansson@stericsson.com>
	<5134A61D.9040001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:63175 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab3CEBjY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Mar 2013 20:39:24 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so4456371lbo.28
        for <linux-mmc@vger.kernel.org>; Mon, 04 Mar 2013 17:39:22 -0800 (PST)
In-Reply-To: <5134A61D.9040001@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 4 March 2013 21:48, Asutosh Das <asutoshd@codeaurora.org> wrote:
> On 3/1/2013 6:17 PM, Ulf Hansson wrote:
>>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>> By using runtime autosuspend, the power save operations can be done
>> when request inactivity occurs for a certain time. Right now the
>> selected timeout value is set to 3 s.
>>
>> Moreover, when the blk device is being suspended, we make sure the device
>> will be runtime resumed. The reason for doing this is that we what the
>> host suspend sequence to be unaware of any runtime power save operations,
>> so it can just handle the suspend as the device is fully powerered from a
>> runtime perspective.
>>
>> This patch is preparing to make it possible to move BKOPS handling into
>> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>> accomplished.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>   drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>   1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 5bab73b..89d1c39 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/capability.h>
>>   #include <linux/compat.h>
>> +#include <linux/pm_runtime.h>
>>     #include <linux/mmc/ioctl.h>
>>   #include <linux/mmc/card.h>
>> @@ -222,6 +223,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
>>         md = mmc_blk_get(dev_to_disk(dev));
>>         card = md->queue.card;
>>   +     pm_runtime_get_sync(&card->dev);
>>         mmc_claim_host(card->host);
>>         ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
>> @@ -234,6 +236,8 @@ static ssize_t power_ro_lock_store(struct device *dev,
>>                 card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>>         mmc_release_host(card->host);
>> +       pm_runtime_mark_last_busy(&card->dev);
>> +       pm_runtime_put_autosuspend(&card->dev);
>>         if (!ret) {
>>                 pr_info("%s: Locking boot partition ro until next power
>> on\n",
>> @@ -492,6 +496,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
>> *bdev,
>>         mrq.cmd = &cmd;
>>   +     pm_runtime_get_sync(&card->dev);
>>         mmc_claim_host(card->host);
>>         err = mmc_blk_part_switch(card, md);
>> @@ -560,6 +565,8 @@ static int mmc_blk_ioctl_cmd(struct block_device
>> *bdev,
>>     cmd_rel_host:
>>         mmc_release_host(card->host);
>> +       pm_runtime_mark_last_busy(&card->dev);
>> +       pm_runtime_put_autosuspend(&card->dev);
>>     cmd_done:
>>         mmc_blk_put(md);
>> @@ -1894,9 +1901,11 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>> struct request *req)
>>         struct mmc_host *host = card->host;
>>         unsigned long flags;
>>   -     if (req && !mq->mqrq_prev->req)
>> +       if (req && !mq->mqrq_prev->req) {
>> +               pm_runtime_get_sync(&card->dev);
>>                 /* claim host only for the first request */
>>                 mmc_claim_host(card->host);
>> +       }
>>         ret = mmc_blk_part_switch(card, md);
>>         if (ret) {
>> @@ -1932,9 +1941,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>> struct request *req)
>>         }
>>     out:
>> -       if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
>> +       if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) {
>>                 /* release host only when there are no more requests */
>>                 mmc_release_host(card->host);
>> +               pm_runtime_mark_last_busy(&card->dev);
>> +               pm_runtime_put_autosuspend(&card->dev);
>> +       }
>> +
>>         return ret;
>>   }
>>   @@ -2331,6 +2344,12 @@ static int mmc_blk_probe(struct mmc_card *card)
>>                 if (mmc_add_disk(part_md))
>>                         goto out;
>>         }
>> +
>> +       pm_runtime_set_active(&card->dev);
>> +       pm_runtime_set_autosuspend_delay(&card->dev, 3000);
>> +       pm_runtime_use_autosuspend(&card->dev);
>> +       pm_runtime_enable(&card->dev);
>> +
>>         return 0;
>>      out:
>> @@ -2344,9 +2363,12 @@ static void mmc_blk_remove(struct mmc_card *card)
>>         struct mmc_blk_data *md = mmc_get_drvdata(card);
>>         mmc_blk_remove_parts(card, md);
>> +       pm_runtime_get_sync(&card->dev);
>>         mmc_claim_host(card->host);
>>         mmc_blk_part_switch(card, md);
>>         mmc_release_host(card->host);
>> +       pm_runtime_disable(&card->dev);
>> +       pm_runtime_put_noidle(&card->dev);
>>         mmc_blk_remove_req(md);
>>         mmc_set_drvdata(card, NULL);
>>   }
>> @@ -2358,6 +2380,7 @@ static int mmc_blk_suspend(struct mmc_card *card)
>>         struct mmc_blk_data *md = mmc_get_drvdata(card);
>>         if (md) {
>> +               pm_runtime_get_sync(&card->dev);
>>                 mmc_queue_suspend(&md->queue);
>>                 list_for_each_entry(part_md, &md->part, part) {
>>                         mmc_queue_suspend(&part_md->queue);
>> @@ -2381,6 +2404,7 @@ static int mmc_blk_resume(struct mmc_card *card)
>>                 list_for_each_entry(part_md, &md->part, part) {
>>                         mmc_queue_resume(&part_md->queue);
>>                 }
>> +               pm_runtime_put(&card->dev);
>>         }
>>         return 0;
>>   }
>

Hi Asutosh,


> Hi Ulf
> Currently, I am implementing a patch that facilitates each device to manage
> is runtime pm on its own.
> I am using the parent-child relationship that is already established in the
> mmc stack for this implementation. In this case,
> mmc_card is a child of mmc_host which is in turn is the child of
> platform-device.
> The following contexts exist which would have to invoke get_sync and
> put_sync on the mmc_card device:
> 1. mmcqd
> 2. bkops
> 3. mmc_rescan
>
> The get_sync on card device would resume all the 3 devices starting from the
> platform-device and the put-sync would suspend all the 3 devices starting
> from the card-device.
> pm_auto_suspend/pm_schedule_suspend may be used to trigger the suspend from
> the above contexts.
> I believe this would simplify the runtime pm functionality.
>
> I can put up the patch for review in a couple of days.
>
> Please let me know your opinion about this approach.

No, I don't think this is way of doing it. I will try to elaborate a
bit with the approach I took in my patchset and why.

First of all, the host platform device must be kept separate (no
parent/child and not the same bus) from the card device. There is many
reason to why, but within this context (runtime pm point of view), the
host must be able to handle it's runtime pm resources completely
separate from the blk device (card device) runtime resources. More
precisely and from a BKOPS point of view; while doing BKOPS the host
platform device must still be able to enter runtime power save states.

I realize that in your case, you are doing mmc_suspend|resume_host in
your host drivers runtime callbacks, which is kind of a very special
case, though worth to consider of course. There are two solutions to
enable the option for this functionality. In both cases a host caps
flag will be needed to enable this.

1.
In mmc bus_ops runtime callback, do a pm_runtime_get_sync("host plf
device"), and vice verse in the runtime resume callback. This will
prevent the host driver from entering runtime power save sate while
for example doing BKOPS, thus preventing your host driver from doing
mmc_suspend_host while BKOPS is running.

2.
Move mmc_suspend|resume_host from your host runtime callbacks, into
the bus_ops runtime callbacks. Typically, when no BKOPS is needed
mmc_suspend_host can be done.

What are you thoughts around this?

Kind regards
Ulf Hansson


>
> --
> Thanks
> Asutosh
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
