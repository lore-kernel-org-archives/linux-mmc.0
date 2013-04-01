From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 3/3] mmc: block: Enable runtime pm for mmc blkdevice
Date: Mon, 01 Apr 2013 13:58:06 +0530
Message-ID: <51594516.40703@codeaurora.org>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com> <1362142035-8403-4-git-send-email-ulf.hansson@stericsson.com> <5134A61D.9040001@codeaurora.org> <CAPDyKFq8q_WmZAdQf_VjS6qYD+MH-QyPJARNV=bj4CKOr_M7Tw@mail.gmail.com> <513633A1.1040401@codeaurora.org> <CAPDyKFrC8DD-T=4rzQpuxz6tAcNgvkanSC71_wKzRbhhMk2Ryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:40322 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758475Ab3DAI2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Apr 2013 04:28:11 -0400
In-Reply-To: <CAPDyKFrC8DD-T=4rzQpuxz6tAcNgvkanSC71_wKzRbhhMk2Ryg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 3/6/2013 12:27 PM, Ulf Hansson wrote:
> On 6 March 2013 02:04, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> On 3/5/2013 7:09 AM, Ulf Hansson wrote:
>>> On 4 March 2013 21:48, Asutosh Das <asutoshd@codeaurora.org> wrote:
>>>> On 3/1/2013 6:17 PM, Ulf Hansson wrote:
>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>
>>>>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>>>>> By using runtime autosuspend, the power save operations can be done
>>>>> when request inactivity occurs for a certain time. Right now the
>>>>> selected timeout value is set to 3 s.
>>>>>
>>>>> Moreover, when the blk device is being suspended, we make sure the
>>>>> device
>>>>> will be runtime resumed. The reason for doing this is that we what the
>>>>> host suspend sequence to be unaware of any runtime power save
>>>>> operations,
>>>>> so it can just handle the suspend as the device is fully powerered from
>>>>> a
>>>>> runtime perspective.
>>>>>
>>>>> This patch is preparing to make it possible to move BKOPS handling into
>>>>> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>>>>> accomplished.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>     drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>>>     1 file changed, 26 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index 5bab73b..89d1c39 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -34,6 +34,7 @@
>>>>>     #include <linux/delay.h>
>>>>>     #include <linux/capability.h>
>>>>>     #include <linux/compat.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>       #include <linux/mmc/ioctl.h>
>>>>>     #include <linux/mmc/card.h>
>>>>> @@ -222,6 +223,7 @@ static ssize_t power_ro_lock_store(struct device
>>>>> *dev,
>>>>>           md = mmc_blk_get(dev_to_disk(dev));
>>>>>           card = md->queue.card;
>>>>>     +     pm_runtime_get_sync(&card->dev);
>>>>>           mmc_claim_host(card->host);
>>>>>           ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
>>>>> @@ -234,6 +236,8 @@ static ssize_t power_ro_lock_store(struct device
>>>>> *dev,
>>>>>                   card->ext_csd.boot_ro_lock |=
>>>>> EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>>>>>           mmc_release_host(card->host);
>>>>> +       pm_runtime_mark_last_busy(&card->dev);
>>>>> +       pm_runtime_put_autosuspend(&card->dev);
>>>>>           if (!ret) {
>>>>>                   pr_info("%s: Locking boot partition ro until next power
>>>>> on\n",
>>>>> @@ -492,6 +496,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
>>>>> *bdev,
>>>>>           mrq.cmd = &cmd;
>>>>>     +     pm_runtime_get_sync(&card->dev);
>>>>>           mmc_claim_host(card->host);
>>>>>           err = mmc_blk_part_switch(card, md);
>>>>> @@ -560,6 +565,8 @@ static int mmc_blk_ioctl_cmd(struct block_device
>>>>> *bdev,
>>>>>       cmd_rel_host:
>>>>>           mmc_release_host(card->host);
>>>>> +       pm_runtime_mark_last_busy(&card->dev);
>>>>> +       pm_runtime_put_autosuspend(&card->dev);
>>>>>       cmd_done:
>>>>>           mmc_blk_put(md);
>>>>> @@ -1894,9 +1901,11 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>>>>> struct request *req)
>>>>>           struct mmc_host *host = card->host;
>>>>>           unsigned long flags;
>>>>>     -     if (req && !mq->mqrq_prev->req)
>>>>> +       if (req && !mq->mqrq_prev->req) {
>>>>> +               pm_runtime_get_sync(&card->dev);
>>>>>                   /* claim host only for the first request */
>>>>>                   mmc_claim_host(card->host);
>>>>> +       }
>>>>>           ret = mmc_blk_part_switch(card, md);
>>>>>           if (ret) {
>>>>> @@ -1932,9 +1941,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>>>>> struct request *req)
>>>>>           }
>>>>>       out:
>>>>> -       if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
>>>>> +       if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) {
>>>>>                   /* release host only when there are no more requests */
>>>>>                   mmc_release_host(card->host);
>>>>> +               pm_runtime_mark_last_busy(&card->dev);
>>>>> +               pm_runtime_put_autosuspend(&card->dev);
>>>>> +       }
>>>>> +
>>>>>           return ret;
>>>>>     }
>>>>>     @@ -2331,6 +2344,12 @@ static int mmc_blk_probe(struct mmc_card
>>>>> *card)
>>>>>                   if (mmc_add_disk(part_md))
>>>>>                           goto out;
>>>>>           }
>>>>> +
>>>>> +       pm_runtime_set_active(&card->dev);
>>>>> +       pm_runtime_set_autosuspend_delay(&card->dev, 3000);
>>>>> +       pm_runtime_use_autosuspend(&card->dev);
>>>>> +       pm_runtime_enable(&card->dev);
>>>>> +
>>>>>           return 0;
>>>>>        out:
>>>>> @@ -2344,9 +2363,12 @@ static void mmc_blk_remove(struct mmc_card *card)
>>>>>           struct mmc_blk_data *md = mmc_get_drvdata(card);
>>>>>           mmc_blk_remove_parts(card, md);
>>>>> +       pm_runtime_get_sync(&card->dev);
>>>>>           mmc_claim_host(card->host);
>>>>>           mmc_blk_part_switch(card, md);
>>>>>           mmc_release_host(card->host);
>>>>> +       pm_runtime_disable(&card->dev);
>>>>> +       pm_runtime_put_noidle(&card->dev);
>>>>>           mmc_blk_remove_req(md);
>>>>>           mmc_set_drvdata(card, NULL);
>>>>>     }
>>>>> @@ -2358,6 +2380,7 @@ static int mmc_blk_suspend(struct mmc_card *card)
>>>>>           struct mmc_blk_data *md = mmc_get_drvdata(card);
>>>>>           if (md) {
>>>>> +               pm_runtime_get_sync(&card->dev);
>>>>>                   mmc_queue_suspend(&md->queue);
>>>>>                   list_for_each_entry(part_md, &md->part, part) {
>>>>>                           mmc_queue_suspend(&part_md->queue);
>>>>> @@ -2381,6 +2404,7 @@ static int mmc_blk_resume(struct mmc_card *card)
>>>>>                   list_for_each_entry(part_md, &md->part, part) {
>>>>>                           mmc_queue_resume(&part_md->queue);
>>>>>                   }
>>>>> +               pm_runtime_put(&card->dev);
>>>>>           }
>>>>>           return 0;
>>>>>     }
>>> Hi Asutosh,
>>>
>>>
>>>> Hi Ulf
>>>> Currently, I am implementing a patch that facilitates each device to
>>>> manage
>>>> is runtime pm on its own.
>>>> I am using the parent-child relationship that is already established in
>>>> the
>>>> mmc stack for this implementation. In this case,
>>>> mmc_card is a child of mmc_host which is in turn is the child of
>>>> platform-device.
>>>> The following contexts exist which would have to invoke get_sync and
>>>> put_sync on the mmc_card device:
>>>> 1. mmcqd
>>>> 2. bkops
>>>> 3. mmc_rescan
>>>>
>>>> The get_sync on card device would resume all the 3 devices starting from
>>>> the
>>>> platform-device and the put-sync would suspend all the 3 devices starting
>>>> from the card-device.
>>>> pm_auto_suspend/pm_schedule_suspend may be used to trigger the suspend
>>>> from
>>>> the above contexts.
>>>> I believe this would simplify the runtime pm functionality.
>>>>
>>>> I can put up the patch for review in a couple of days.
>>>>
>>>> Please let me know your opinion about this approach.
>>> No, I don't think this is way of doing it. I will try to elaborate a
>>> bit with the approach I took in my patchset and why.
>>>
>>> First of all, the host platform device must be kept separate (no
>>> parent/child and not the same bus) from the card device. There is many
>>> reason to why, but within this context (runtime pm point of view), the
>>> host must be able to handle it's runtime pm resources completely
>>> separate from the blk device (card device) runtime resources. More
>>> precisely and from a BKOPS point of view; while doing BKOPS the host
>>> platform device must still be able to enter runtime power save states.
>>>
>>> I realize that in your case, you are doing mmc_suspend|resume_host in
>>> your host drivers runtime callbacks, which is kind of a very special
>>> case, though worth to consider of course. There are two solutions to
>>> enable the option for this functionality. In both cases a host caps
>>> flag will be needed to enable this.
>>>
>>> 1.
>>> In mmc bus_ops runtime callback, do a pm_runtime_get_sync("host plf
>>> device"), and vice verse in the runtime resume callback. This will
>>> prevent the host driver from entering runtime power save sate while
>>> for example doing BKOPS, thus preventing your host driver from doing
>>> mmc_suspend_host while BKOPS is running.
>>>
>>> 2.
>>> Move mmc_suspend|resume_host from your host runtime callbacks, into
>>> the bus_ops runtime callbacks. Typically, when no BKOPS is needed
>>> mmc_suspend_host can be done.
>>>
>>> What are you thoughts around this?
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>
>>>> --
>>>> Thanks
>>>> Asutosh
>>>>
>>>> --
>>>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>>>> Forum.
>>>>
>> Hi Ulf,
>> Typically, when the pltfm device enters power-save during bkops, it can only
>> shut-off the clocks to the card (?), the power would still be on.
>> With clock-gating in place, this would be done anyhow.
> Clock gating is only one of the things you might want to do.
>
> For example;
>
> Your host plf device can reside in a power domain.
> You might want to save power by doing pinctrl.
> Disable/enable irqs.
> Etc.
>
> So, to conclude it's is realy important runtime pm for the block
> device (card device) is kept separate from the host plf device.
> They do handle completly different stuff.
>
>> I wanted to separate the functionality as detailed below:
>>
>> Say we do aggressive power management: (invoke mmc_[suspend/resume]_host in
>> runtime pm as well), idle-timeout of 10 s (configurable though)
>>
>> during suspend of mmc_card device:
>> - do all card related power management, like power-off notifications etc.
>>
>> during suspend of mmc_host device:
>> - do all the host related power management, like power-off host, shut-off
>> clocks etc.
>>
>> during suspend of pltfm device:
>> - do all the pltfm specific power management, like disable irqs, configure
>> wake-ups etc.
>>
>> During system-suspend, it can be checked if the device is runtime-suspended,
>> if yes, return.
>>
>> On resume, the above path would be retraced in the reverse order.
>>
>> I think each bus can be responsible for suspending its devices during system
>> suspend.
> According to my comment above, I don't think this sequence will be possible.
>
>>
>>>> First of all, the host platform device must be kept separate (no
>>>> parent/child and not the same bus) from the card device.
>> Can you please elaborate on this point a bit.
> See above comment for what actions a host plf device can do at runtime
> power management.
>
>> I guess you would be joining the IRC chat tomorrow, if yes, we can discuss
>> there itself.
> It wont be possible for me to joing IRC today, I am at Hongkong with
> Linaro Connect this week. Although it seems like a good discussion on
> IRC, I suppose it would help to clarify on this topic.
>
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>>
> Kind regards
> Ulf Hansson
Hi Ulf
Sorry for the delayed response.

The card and host are anyhow coupled except in the idle-time bkops case, 
which is kind of a special case. I think this can be handled in the 
approach I am suggesting by not invoking mmc_suspend_host if bkops is 
running. In this way, the pltfm device can still be put in low-power 
mode (like you suggested), when card is doing bkops.
Moreover, the parent-child relationship is already established (in 
mmc_alloc_host and mmc_alloc_card) and runtime-pm framework only uses it 
if we enable runtime-pm of the particular device.
Even now, we first put the card to sleep and then the host.

What are your thoughts on this ?

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

