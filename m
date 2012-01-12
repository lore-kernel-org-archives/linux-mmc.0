From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5] mmc: support BKOPS feature for eMMC
Date: Thu, 12 Jan 2012 11:10:07 +0900
Message-ID: <4F0E40FF.2040305@samsung.com>
References: <4F04F512.1020909@samsung.com>
 <CANfBPZ_b0ypRUrhJH4izFUOJmxg4fh5u1NM5ED6eSiKeVibyAg@mail.gmail.com>
 <m2r4z6dogm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21212 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2ALCKO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 21:10:14 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXN0087OY0ZDF70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 Jan 2012 11:10:12 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXN00B4LY10YG90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 Jan 2012 11:10:12 +0900 (KST)
In-reply-to: <m2r4z6dogm.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, per.forlin@stericsson.com, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi Chris & Venkat,

Thanks for testing...i will modify insufficiency part about venkat's testing results.
I will resend the patch-v6 at next week.

Best Regards,
Jaehoon Chung


On 01/12/2012 04:32 AM, Chris Ball wrote:

> Hi,
> 
> On Wed, Jan 11 2012, S, Venkatraman wrote:
>> On Thu, Jan 5, 2012 at 6:25 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>
>>> Enable eMMC background operations (BKOPS) feature.
>>>
>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>> are required. After all I/O requests are finished, run
>>> BKOPS if required. Should read/write operations be requested
>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>> and then service the request.
>>>
>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>
>>> Future considerations
>>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>>  * Interrupt ongoing BKOPS before powering off the card.
>>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>> Changelog V5:
>>>        - Rebase based on the latest mmc-next.
>>>        - modify codes based-on Chris's comment
>>> Changelog V4:
>>>        - Add mmc_read_bkops_status
>>>        - When URGENT_BKOPS(level2-3), didn't use HPI command.
>>>        - In mmc_switch(), use R1B/R1 according to level.
>>> Changelog V3:
>>>        - move the bkops setting's location in mmc_blk_issue_rw_rq
>>>        - modify condition checking
>>>        - bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
>>>        - remove the unused code
>>>        - change pr_debug instead of pr_warn in mmc_send_hpi_cmd
>>>        - Add the Future consideration suggested by Per
>>> Changelog V2:
>>>        - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>>        - Add function to check Exception_status(for eMMC4.5)
>>>
>>>  drivers/mmc/card/block.c   |   11 +++++
>>>  drivers/mmc/card/queue.c   |    3 +
>>>  drivers/mmc/core/core.c    |  105
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/core/mmc.c     |    8 +++
>>>  drivers/mmc/core/mmc_ops.c |   12 +++++-
>>>  include/linux/mmc/card.h   |   13 +++++
>>>  include/linux/mmc/core.h   |    4 ++
>>>  include/linux/mmc/host.h   |    1 +
>>>  include/linux/mmc/mmc.h    |   19 ++++++++
>>>  9 files changed, 175 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 0cad48a..5e3c580 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1273,6 +1273,17 @@ static int mmc_blk_issue_rw_rq(struct
>>> mmc_queue *mq, struct request *rqc)
>>>                type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>>>                mmc_queue_bounce_post(mq_rq);
>>>
>>> +               /*
>>> +                * Check BKOPS urgency from each R1 response
>>> +                */
>>> +               if (mmc_card_mmc(card) &&
>>> +                       (brq->cmd.flags == MMC_RSP_R1B ||
>>> +                        brq->cmd.flags == MMC_RSP_R1) &&
>>
>> I tested this patch on my setup and this condition never hit, as other
>> flags are also set in cmd.flags
>> It should have been
>> (brq->cmd.flags & MMC_RSP_R1B ||
>>  brq->cmd.flags & MMC_RSP_R1)
>>
>>
>>> +                       (brq->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
>>> +                       if (mmc_is_exception_event(card,
>>> EXT_CSD_URGENT_BKOPS))
>>
>> This causes a crash on my test setup. The next req is already given to
>> the controller (see the mmc_start_req call a few lines above) and a
>> parallel request to read BKOPS_STATUS is interfering with it. This
>> won't work with any host controller driver which implements async_req
>> functions.
>>
>> But there is no need to read BKOPS_STATUS at this stage anyway. By
>> checking R1_EXCEPTION_EVENT and the BKOPS bit inside the response, the
>> need to do BKOPS can be determined (as only a urgen_bkops state would
>> trigger a R1_EXCEPTION_EVENT in the first place)
> 
> Thanks very much for testing!  I'll drop this from my 3.3 queue --
> we can try it again for 3.4.
> 
> - Chris.


