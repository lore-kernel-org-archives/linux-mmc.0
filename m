From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v11] mmc: support BKOPS feature for eMMC
Date: Fri, 03 Aug 2012 11:26:33 +0900
Message-ID: <501B36D9.3070409@samsung.com>
References: <500E00E8.7040504@samsung.com>
 <CAEwNFnA0CKaORGJ1TVnjYgLgi6dtgebVZ1xUVeY6MU92LWb9RA@mail.gmail.com>
 <50164D28.4030907@samsung.com>
 <5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12295 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab2HCC0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Aug 2012 22:26:44 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M8500FJNQSD05I0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Aug 2012 11:26:42 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M8500G0CQSHQ530@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Aug 2012 11:26:42 +0900 (KST)
In-reply-to: <5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Minchan Kim <minchan@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Hi,

Any other comment for this patch?

Best Regards,
Jaehoon Chung

On 07/31/2012 11:01 PM, merez@codeaurora.org wrote:
> 
> On Mon, July 30, 2012 2:00 am, Jaehoon Chung wrote:
>> On 07/29/2012 11:33 AM, Minchan Kim wrote:
>>> On Tue, Jul 24, 2012 at 10:56 AM, Jaehoon Chung <jh80.chung@samsung.com>
>>> wrote:
>>>> Enable eMMC background operations (BKOPS) feature.
>>>>
>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>> are required. Immediately run BKOPS if required.
>>>> read/write operations should be requested during BKOPS(LEVEL-1),
>>>> then issue HPI to interrupt the ongoing BKOPS
>>>> and service the foreground operation.
>>>> (This patch is only control the LEVEL2/3.)
>>>>
>>>> When repeating the writing 1GB data, at a certain time, performance is
>>>> decreased.
>>>> At that time, card is also triggered the Level-3 or Level-2.
>>>> After running bkops, performance is recovered.
>>>>
>>>> Future considerations
>>>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>>>  * Interrupt ongoing BKOPS before powering off the card.
>>>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>>>>  * If use periodic bkops, also consider runtime_pm control.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>>>> Signed-off-by: Maya Erez <merez@codeaurora.org>
>>>> ---
>>>> Changelog v11:
>>>>         - removed the MMC_CAP2_BKOPS.
>>>>                 : if card support and enable bkops, then use it.
>>>> Changelog v10:
>>>>         - Based on latest mmc-next
>>>>         - Only control the level-2/3.
>>>>                 : If triggered upper than level2, immediately start
>>>> bkops.
>>>>         - Remove the BKOPS_CAP2_INIT_BKOPS (move into mmc-util)
>>>>         - change use_busy_signal instead of waiting_for_prog_done for
>>>> __mmc_switch
>>>>         - Remove the useless code.
>>>>         - Add the from_exception to prepare the periodic bkops.
>>>> Changelog V9:
>>>>         - Rebased on patch-v7.
>>>>         - Added Konstantin and Maya's patch
>>>>                 : mmc:core: Define synchronous BKOPS timeout
>>>>                 : mmc:core: eMMC4.5 BKOPS fixes
>>>>         - Removed periodic bkops
>>>>                 : This feature will do in future work
>>>>         - Add __mmc_switch() for waiting_for_prod_done.
>>>>
>>>> Changelog V8:
>>>>         - Remove host->lock spin lock reviewed by Adrian
>>>>         - Support periodic start bkops
>>>>         - when bkops_status is level-3, if timeout is set to 0, send
>>>> hpi.
>>>>         - Move the start-bkops point
>>>> Changelog V7:
>>>>         - Use HPI command when issued URGENT_BKOPS
>>>>         - Recheck until clearing the bkops-status bit.
>>>> Changelog V6:
>>>>         - Add the flag of check-bkops-status.
>>>>           (For fixing async_req problem)
>>>>         - Add the capability for MMC_CAP2_INIT_BKOPS.
>>>>           (When unset the bkops_en bit in ext_csd register)
>>>>         - modify the wrong condition.
>>>> Changelog V5:
>>>>         - Rebase based on the latest mmc-next.
>>>>         - modify codes based-on Chris's comment
>>>> Changelog V4:
>>>>         - Add mmc_read_bkops_status
>>>>         - When URGENT_BKOPS(level2-3), didn't use HPI command.
>>>>         - In mmc_switch(), use R1B/R1 according to level.
>>>> Changelog V3:
>>>>         - move the bkops setting's location in mmc_blk_issue_rw_rq
>>>>         - modify condition checking
>>>>         - bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
>>>>         - remove the unused code
>>>>         - change pr_debug instead of pr_warn in mmc_send_hpi_cmd
>>>>         - Add the Future consideration suggested by Per
>>>> Changelog V2:
>>>>         - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>>>         - Add function to check Exception_status(for eMMC4.5)
>>>> ---
>>>>  drivers/mmc/core/core.c    |  145
>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>  drivers/mmc/core/mmc.c     |   11 +++
>>>>  drivers/mmc/core/mmc_ops.c |   26 +++++++-
>>>>  include/linux/mmc/card.h   |    8 +++
>>>>  include/linux/mmc/core.h   |    4 +
>>>>  include/linux/mmc/mmc.h    |   19 ++++++
>>>>  6 files changed, 207 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 8ac5246..ed2cc93 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -41,6 +41,12 @@
>>>>  #include "sd_ops.h"
>>>>  #include "sdio_ops.h"
>>>>
>>>> +/*
>>>> + * The Background operation can take a long time, depends on the house
>>>> keeping
>>>> + * operations the card has to peform
>>>> + */
>>>> +#define MMC_BKOPS_MAX_TIMEOUT  (4 * 60 * 1000) /* max time to wait in
>>>> ms */
>>>> +
>>>>  static struct workqueue_struct *workqueue;
>>>>  static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>>>>
>>>> @@ -245,6 +251,70 @@ mmc_start_request(struct mmc_host *host, struct
>>>> mmc_request *mrq)
>>>>         host->ops->request(host, mrq);
>>>>  }
>>>>
>>>> +/**
>>>> + *     mmc_start_bkops - start BKOPS for supported cards
>>>> + *     @card: MMC card to start BKOPS
>>>> + *     @form_exception: A flags to indicate if this function was
>>>> + *                     called due to an exception raised by the card
>>>> + *
>>>> + *     Start background operations whenever requested.
>>>> + *     when the urgent BKOPS bit is set in a R1 command response
>>>> + *     then background operations should be started immediately.
>>>> +*/
>>>> +void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>>>> +{
>>>> +       int err;
>>>> +       int timeout;
>>>> +       bool use_busy_signal;
>>>> +
>>>> +       BUG_ON(!card);
>>>> +
>>>> +       if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card))
>>>> +               return;
>>>> +
>>>> +       err = mmc_read_bkops_status(card);
>>>> +       if (err) {
>>>> +               pr_err("%s: Didn't read bkops status : %d\n",
>>>> +                      mmc_hostname(card->host), err);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       if (!card->ext_csd.raw_bkops_status)
>>>> +               return;
>>>> +
>>>> +       if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2
>>>> +           && (from_exception))
>>>> +               return;
>>>> +
>>>> +       mmc_claim_host(card->host);
>>>> +       if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
>>>> +               timeout = MMC_BKOPS_MAX_TIMEOUT;
>>>> +               use_busy_signal = true;
>>>> +       } else {
>>>> +               timeout = 0;
>>>> +               use_busy_signal = false;
>>>> +       }
>>>> +
>>>> +       err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> +                       EXT_CSD_BKOPS_START, 1, timeout,
>>>> use_busy_signal);
>>>> +       if (err) {
>>>> +               pr_warn("%s: error %d starting bkops\n",
>>>> +                          mmc_hostname(card->host), err);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * For urgent bkops status (LEVEL_2 and more)
>>>> +        * bkops executed synchronously, otherwise
>>>> +        * the operation is in progress
>>>> +        */
>>>> +       if (!use_busy_signal)
>>>> +               mmc_card_set_doing_bkops(card);
>>>> +out:
>>>> +       mmc_release_host(card->host);
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_start_bkops);
>>>> +
>>>>  static void mmc_wait_done(struct mmc_request *mrq)
>>>>  {
>>>>         complete(&mrq->completion);
>>>> @@ -354,6 +424,14 @@ struct mmc_async_req *mmc_start_req(struct
>>>> mmc_host *host,
>>>>         if (host->areq) {
>>>>                 mmc_wait_for_req_done(host, host->areq->mrq);
>>>>                 err = host->areq->err_check(host->card, host->areq);
>>>> +               /*
>>>> +                * Check BKOPS urgency for each R1 response
>>>> +                */
>>>> +               if (host->card && mmc_card_mmc(host->card) &&
>>>> +               ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
>>>> +                (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B))
>>>> &&
>>>> +               (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
>>>> +                       mmc_start_bkops(host->card, true);
>>>>         }
>>>>
>>>>         if (!err && areq)
>>>> @@ -489,6 +567,53 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct
>>>> mmc_command *cmd, int retries
>>>>  EXPORT_SYMBOL(mmc_wait_for_cmd);
>>>>
>>>>  /**
>>>> + *     mmc_stop_bkops - stop ongoing BKOPS
>>>> + *     @card: MMC card to check BKOPS
>>>> + *
>>>> + *     Send HPI command to stop ongoing background operations,
>>>> + *     to allow rapid servicing of foreground operations,e.g. read/
>>>> + *     writes. Wait until the card comes out of the programming state
>>>> + *     to avoid errors in servicing read/write requests.
>>>> + */
>>>> +int mmc_stop_bkops(struct mmc_card *card)
>>>> +{
>>>> +       int err = 0;
>>>> +
>>>> +       BUG_ON(!card);
>>>> +       err = mmc_interrupt_hpi(card);
>>>> +
>>>> +       /*
>>>> +        * if err is EINVAL, it's status that can't issue HPI.
>>>> +        * it should complete the BKOPS.
>>>> +        */
>>>> +       if (!err || (err == -EINVAL)) {
>>>> +               mmc_card_clr_doing_bkops(card);
>>>> +               err = 0;
>>>> +       }
>>>> +
>>>> +       return err;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_stop_bkops);
>>>> +
>>>> +int mmc_read_bkops_status(struct mmc_card *card)
>>>> +{
>>>> +       int err;
>>>> +       u8 ext_csd[512];
>>>
>>> 512 byte stack? Isn't it really a problem?
>> How about this?
>>
>> +int mmc_read_bkops_status(struct mmc_card *card)
>> +{
>> +	int err;
>> +	u8 *ext_csd;
>> +
>> +	ext_csd = kmalloc(512, GFP_KERNEL);
>> +	if (!ext_csd) {
>> +		pr_err("%s: could not allocate a buffer to "
>> +			"receive the ext_csd.\n", mmc_hostname(card->host));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	mmc_claim_host(card->host);
>> +	err = mmc_send_ext_csd(card, ext_csd);
>> +	mmc_release_host(card->host);
>> +	if (err)
>> +		goto out;
>> +
>> +	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
>> +	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
>> +out:
>> +	kfree(ext_csd);
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(mmc_read_bkops_status);
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>
>>
>>
> 
> I'm not sure it would be a good idea to allocate the buffer every time the
> ext_csd is read since with the periodic BKOPs we might do it more often to
> see if there is a need for BKOPs.
> How about keeping the buffer in the card structure?
> 
> Thanks,
> Maya
> 


