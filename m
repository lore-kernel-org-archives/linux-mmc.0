From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 3/4] mmc: block: Enable runtime pm for mmc blkdevice
Date: Thu, 02 May 2013 15:22:35 +0300
Message-ID: <51825A8B.4010804@intel.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com> <1366106437-18004-4-git-send-email-ulf.hansson@stericsson.com> <51822AB2.40603@intel.com> <CAPDyKFpU06ys-7y3mZvrjSawd2+fdXJwmCEQwV11q7ihz1HKAg@mail.gmail.com> <5182387B.2030309@codeaurora.org> <CAPDyKFrTop6H08rvTAVZJPDhS6g=Mq6gBohNy0Mx7iwmcF5baA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5490 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077Ab3EBMRb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 May 2013 08:17:31 -0400
In-Reply-To: <CAPDyKFrTop6H08rvTAVZJPDhS6g=Mq6gBohNy0Mx7iwmcF5baA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 02/05/13 14:09, Ulf Hansson wrote:
> On 2 May 2013 11:57, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> On 5/2/2013 3:22 PM, Ulf Hansson wrote:
>>>
>>> On 2 May 2013 10:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 16/04/13 13:00, Ulf Hansson wrote:
>>>>>
>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>
>>>>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>>>>> By using runtime autosuspend, the power save operations can be done
>>>>> when request inactivity occurs for a certain time. Right now the
>>>>> selected timeout value is set to 3 s. Obviously this value will likely
>>>>> need to be configurable somehow since it needs to be trimmed depending
>>>>> on the power save algorithm.
>>>>
>>>> Already is configurable in sysfs "power/autosuspend_delay_ms"
>>>
>>> Yes you are right - it is already configurable from sysfs point of view.
>>>
>>> What I had in mind was the default values, it could very well be
>>> depending on what power save operation that is to be scheduled. For
>>> example the aggressive power gating could likely use a longer timeout
>>> than when about to schedule idle BKOPS. Anyway, I think it is fair to
>>> leave this to a future patch to handle.
>>>
>>>> Another issue is that re-initialization consumes power - possibly more
>>>> than
>>>> is being saved by powering off.  I wonder if the default value of 3
>>>> seconds
>>>> is realistic.  Do you have any numbers to compare idle power consumption
>>>> with the power consumed by re-initialization?
>>>
>>> This is very card specific data.
>>>
>>> - I have not done a measurement for the power consumed during a
>>> re-init, but only the time it takes to do the re-init. Typically we
>>> are talking about hundreds of ms.
>>>
>>> - I have done measurements for a handful of pretty new SD-cards and
>>> for some eMMCs (preventing them from putting them to "sleep"). uSD:
>>> ~100-400 uA, eMMC: ~10-150 uA - in both cases I expect the card to not
>>> do any internal house keeping operations, since then we would likely
>>> be talking about tens of mA instead.
>>>
>>> The above numbers should also be possible to be fetched from vendors
>>> data sheets.
>>>
>>> Maybe some in the mmc code aurora team can elaborate more, since they
>>> have been using this feature for a while now in end user products I
>>> believe. Would be interesting to know what timeout they have chosen
>>> here.
>>
>> Currently, we have a default idle-timeout of 10 seconds. However, we haven't
>> pulled in and tested Ulf's patch series yet.
> 
> That sounds reasonable!
> 
> Although, I suggest we stick with the 3 s timeout in this patchset,
> since it's to be considered as the generic default timeout. Then we
> can send a new patch which possibly consider what power save
> operations that are to be scheduled before changing timeout. Is that a
> way forward for you?

OK

> 
>>>
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>>> For SD-combo cards, we are still leaving the enablement of runtime PM
>>>>> to the SDIO init sequence since it depends on the capabilities of the
>>>>> SDIO func driver.
>>>>>
>>>>> Moreover, when the blk device is being suspended, we make sure the
>>>>> device
>>>>> will be runtime resumed. The reason for doing this is that we want the
>>>>> host suspend sequence to be unaware of any runtime power save operations
>>>>> done for the card in this phase. Thus it can just handle the suspend as
>>>>> the card is fully powered from a runtime perspective.
>>>>>
>>>>> Finally, this patch prepares to make it possible to move BKOPS handling
>>>>> into the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>>>>> accomplished.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Cc: Maya Erez <merez@codeaurora.org>
>>>>> Cc: Subhash Jadavani <subhashj@codeaurora.org>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>> Cc: Kevin Liu <kliu5@marvell.com>
>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>> Cc: Daniel Drake <dsd@laptop.org>
>>>>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>>>>> ---
>>>>>   drivers/mmc/card/block.c   |   32 ++++++++++++++++++++++++++------
>>>>>   drivers/mmc/core/core.c    |   23 +++++++++++++++++++++++
>>>>>   drivers/mmc/core/debugfs.c |    8 ++++----
>>>>>   drivers/mmc/core/mmc.c     |    4 ++--
>>>>>   drivers/mmc/core/sd.c      |    4 ++--
>>>>>   include/linux/mmc/core.h   |    3 +++
>>>>>   6 files changed, 60 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index e12a03c..360a41a 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -34,6 +34,7 @@
>>>>>   #include <linux/delay.h>
>>>>>   #include <linux/capability.h>
>>>>>   #include <linux/compat.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>>
>>>>>   #include <linux/mmc/ioctl.h>
>>>>>   #include <linux/mmc/card.h>
>>>>> @@ -222,7 +223,7 @@ static ssize_t power_ro_lock_store(struct device
>>>>> *dev,
>>>>>        md = mmc_blk_get(dev_to_disk(dev));
>>>>>        card = md->queue.card;
>>>>>
>>>>> -     mmc_claim_host(card->host);
>>>>> +     mmc_get_card(card);
>>>>>
>>>>>        ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
>>>>>                                card->ext_csd.boot_ro_lock |
>>>>> @@ -233,7 +234,7 @@ static ssize_t power_ro_lock_store(struct device
>>>>> *dev,
>>>>>        else
>>>>>                card->ext_csd.boot_ro_lock |=
>>>>> EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>>>>>
>>>>> -     mmc_release_host(card->host);
>>>>> +     mmc_put_card(card);
>>>>>
>>>>>        if (!ret) {
>>>>>                pr_info("%s: Locking boot partition ro until next power
>>>>> on\n",
>>>>> @@ -492,7 +493,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
>>>>> *bdev,
>>>>>
>>>>>        mrq.cmd = &cmd;
>>>>>
>>>>> -     mmc_claim_host(card->host);
>>>>> +     mmc_get_card(card);
>>>>>
>>>>>        err = mmc_blk_part_switch(card, md);
>>>>>        if (err)
>>>>> @@ -559,7 +560,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
>>>>> *bdev,
>>>>>        }
>>>>>
>>>>>   cmd_rel_host:
>>>>> -     mmc_release_host(card->host);
>>>>> +     mmc_put_card(card);
>>>>>
>>>>>   cmd_done:
>>>>>        mmc_blk_put(md);
>>>>> @@ -1896,7 +1897,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>>>>> struct request *req)
>>>>>
>>>>>        if (req && !mq->mqrq_prev->req)
>>>>>                /* claim host only for the first request */
>>>>> -             mmc_claim_host(card->host);
>>>>> +             mmc_get_card(card);
>>>>>
>>>>>        ret = mmc_blk_part_switch(card, md);
>>>>>        if (ret) {
>>>>> @@ -1940,7 +1941,7 @@ out:
>>>>>                 * In case sepecial request, there is no reentry to
>>>>>                 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>>>>>                 */
>>>>> -             mmc_release_host(card->host);
>>>>> +             mmc_put_card(card);
>>>>>        return ret;
>>>>>   }
>>>>>
>>>>> @@ -2337,6 +2338,19 @@ static int mmc_blk_probe(struct mmc_card *card)
>>>>>                if (mmc_add_disk(part_md))
>>>>>                        goto out;
>>>>>        }
>>>>> +
>>>>> +     pm_runtime_set_autosuspend_delay(&card->dev, 3000);
>>>>> +     pm_runtime_use_autosuspend(&card->dev);
>>>>> +
>>>>> +     /*
>>>>> +      * Don't enable runtime PM for SD-combo cards here. Leave that
>>>>> +      * decision to be taken during the SDIO init sequence instead.
>>>>> +      */
>>>>> +     if (card->type != MMC_TYPE_SD_COMBO) {
>>>>> +             pm_runtime_set_active(&card->dev);
>>>>> +             pm_runtime_enable(&card->dev);
>>>>> +     }
>>>>> +
>>>>>        return 0;
>>>>>
>>>>>    out:
>>>>> @@ -2350,9 +2364,13 @@ static void mmc_blk_remove(struct mmc_card *card)
>>>>>        struct mmc_blk_data *md = mmc_get_drvdata(card);
>>>>>
>>>>>        mmc_blk_remove_parts(card, md);
>>>>> +     pm_runtime_get_sync(&card->dev);
>>>>>        mmc_claim_host(card->host);
>>>>>        mmc_blk_part_switch(card, md);
>>>>>        mmc_release_host(card->host);
>>>>> +     if (card->type != MMC_TYPE_SD_COMBO)
>>>>> +             pm_runtime_disable(&card->dev);
>>>>> +     pm_runtime_put_noidle(&card->dev);
>>>>>        mmc_blk_remove_req(md);
>>>>>        mmc_set_drvdata(card, NULL);
>>>>>   }
>>>>> @@ -2364,6 +2382,7 @@ static int mmc_blk_suspend(struct mmc_card *card)
>>>>>        struct mmc_blk_data *md = mmc_get_drvdata(card);
>>>>>
>>>>>        if (md) {
>>>>> +             pm_runtime_get_sync(&card->dev);
>>>>>                mmc_queue_suspend(&md->queue);
>>>>>                list_for_each_entry(part_md, &md->part, part) {
>>>>>                        mmc_queue_suspend(&part_md->queue);
>>>>> @@ -2387,6 +2406,7 @@ static int mmc_blk_resume(struct mmc_card *card)
>>>>>                list_for_each_entry(part_md, &md->part, part) {
>>>>>                        mmc_queue_resume(&part_md->queue);
>>>>>                }
>>>>> +             pm_runtime_put(&card->dev);
>>>>>        }
>>>>>        return 0;
>>>>>   }
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index b16b64a..602db00 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -952,6 +952,29 @@ void mmc_release_host(struct mmc_host *host)
>>>>>   EXPORT_SYMBOL(mmc_release_host);
>>>>>
>>>>>   /*
>>>>> + * This is a helper function, which fetches a runtime pm reference for
>>>>> the
>>>>> + * card device and also claims the host.
>>>>> + */
>>>>> +void mmc_get_card(struct mmc_card *card)
>>>>> +{
>>>>> +     pm_runtime_get_sync(&card->dev);
>>>>> +     mmc_claim_host(card->host);
>>>>> +}
>>>>> +EXPORT_SYMBOL(mmc_get_card);
>>>>> +
>>>>> +/*
>>>>> + * This is a helper function, which releases the host and drops the
>>>>> runtime
>>>>> + * pm reference for the card device.
>>>>> + */
>>>>> +void mmc_put_card(struct mmc_card *card)
>>>>> +{
>>>>> +     mmc_release_host(card->host);
>>>>> +     pm_runtime_mark_last_busy(&card->dev);
>>>>> +     pm_runtime_put_autosuspend(&card->dev);
>>>>> +}
>>>>> +EXPORT_SYMBOL(mmc_put_card);
>>>>> +
>>>>> +/*
>>>>>    * Internal function that does the actual ios call to the host driver,
>>>>>    * optionally printing some debug output.
>>>>>    */
>>>>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>>>>> index 35c2f85..54829c0 100644
>>>>> --- a/drivers/mmc/core/debugfs.c
>>>>> +++ b/drivers/mmc/core/debugfs.c
>>>>> @@ -258,13 +258,13 @@ static int mmc_dbg_card_status_get(void *data, u64
>>>>> *val)
>>>>>        u32             status;
>>>>>        int             ret;
>>>>>
>>>>> -     mmc_claim_host(card->host);
>>>>> +     mmc_get_card(card);
>>>>>
>>>>>        ret = mmc_send_status(data, &status);
>>>>>        if (!ret)
>>>>>                *val = status;
>>>>>
>>>>> -     mmc_release_host(card->host);
>>>>> +     mmc_put_card(card);
>>>>>
>>>>>        return ret;
>>>>>   }
>>>>> @@ -291,9 +291,9 @@ static int mmc_ext_csd_open(struct inode *inode,
>>>>> struct file *filp)
>>>>>                goto out_free;
>>>>>        }
>>>>>
>>>>> -     mmc_claim_host(card->host);
>>>>> +     mmc_get_card(card);
>>>>>        err = mmc_send_ext_csd(card, ext_csd);
>>>>> -     mmc_release_host(card->host);
>>>>> +     mmc_put_card(card);
>>>>>        if (err)
>>>>>                goto out_free;
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 66a530e..bf19058 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -1380,14 +1380,14 @@ static void mmc_detect(struct mmc_host *host)
>>>>>        BUG_ON(!host);
>>>>>        BUG_ON(!host->card);
>>>>>
>>>>> -     mmc_claim_host(host);
>>>>> +     mmc_get_card(host->card);
>>>>>
>>>>>        /*
>>>>>         * Just check if our card has been removed.
>>>>>         */
>>>>>        err = _mmc_detect_card_removed(host);
>>>>>
>>>>> -     mmc_release_host(host);
>>>>> +     mmc_put_card(host->card);
>>>>>
>>>>>        if (err) {
>>>>>                mmc_remove(host);
>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>> index 9e645e1..30387d6 100644
>>>>> --- a/drivers/mmc/core/sd.c
>>>>> +++ b/drivers/mmc/core/sd.c
>>>>> @@ -1037,14 +1037,14 @@ static void mmc_sd_detect(struct mmc_host *host)
>>>>>        BUG_ON(!host);
>>>>>        BUG_ON(!host->card);
>>>>>
>>>>> -     mmc_claim_host(host);
>>>>> +     mmc_get_card(host->card);
>>>>>
>>>>>        /*
>>>>>         * Just check if our card has been removed.
>>>>>         */
>>>>>        err = _mmc_detect_card_removed(host);
>>>>>
>>>>> -     mmc_release_host(host);
>>>>> +     mmc_put_card(host->card);
>>>>>
>>>>>        if (err) {
>>>>>                mmc_sd_remove(host);
>>>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>>>> index 39613b9..49fb132 100644
>>>>> --- a/include/linux/mmc/core.h
>>>>> +++ b/include/linux/mmc/core.h
>>>>> @@ -188,6 +188,9 @@ extern int __mmc_claim_host(struct mmc_host *host,
>>>>> atomic_t *abort);
>>>>>   extern void mmc_release_host(struct mmc_host *host);
>>>>>   extern int mmc_try_claim_host(struct mmc_host *host);
>>>>>
>>>>> +extern void mmc_get_card(struct mmc_card *card);
>>>>> +extern void mmc_put_card(struct mmc_card *card);
>>>>> +
>>>>>   extern int mmc_flush_cache(struct mmc_card *);
>>>>>
>>>>>   extern int mmc_detect_card_removed(struct mmc_host *host);
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>>
> 
> 

