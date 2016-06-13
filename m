From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: Fix tag condition with packed writes
Date: Mon, 13 Jun 2016 15:32:46 +0800
Message-ID: <2908e07a-a404-0d05-6adc-a1918fe71372@rock-chips.com>
References: <575ABF08.4010102@intel.com>
 <7b6b85e2-4439-f091-3319-9f5ceeb72e82@rock-chips.com>
 <575E5228.3030802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:39660 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161172AbcFMHdB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 03:33:01 -0400
In-Reply-To: <575E5228.3030802@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 2016/6/13 14:26, Adrian Hunter wrote:
> On 13/06/16 05:42, Shawn Lin wrote:
>> Hi Adrian,
>>
>> On 2016/6/10 21:22, Adrian Hunter wrote:
>>> Apparently a cut-and-paste error, 'do_data_tag' is using 'brq' for data
>>> size even though 'brq' has not been set up. Instead use blk_rq_sectors().
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>
>>>
>>> Hi
>>>
>>> I don't know if anyone is actually using packed writes, but this is
>>> something I noticed.
>>
>>
>> I think if brq has not been set up, the we could meet another problem
>> of checking the case of whether 4KB native sector is enabled.
>> When fetching blk req from the queue, mmc_blk_issue_rw_rq already
>> use brq there which is the same from your case, namely
>> mq->mqrq_cur->brq, right?
>
> Looks like that was that fixed by:
>
> commit 3a6db10d86902491b759103ee97b2539175dd1dd
> Author: Yuan, Juntao <juntao.yuan@intel.com>
> Date:   Fri May 13 07:59:24 2016 +0000
>

Ahh.. yes, I see it now from Ulf's next.

But I'm wondering about why not cast the mqrq_cur->brq to NULL or memset 
it to be zero if it's expired after the completion. And a
WARN_ON will prevent the brq from being used by mistake any more.

Anyway, you patch of course fix the problem. :)

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>     mmc: block: correct 4KB alignment check
>
>     In sectors alignment check, brq->data.blocks means sectors of the
>     previous mqrq since data.blocks for mqrq_cur hasn't been updated yet.
>     data.blocks will be updated later in mmc_blk_packed_hdr_wrq_prep or
>     mmc_blk_rw_rq_prep.
>
>     static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, ......
>             ......
>         struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
>
>     Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> There is also another fix in the SWCMDQ changes:
>
> 	http://marc.info/?l=linux-mmc&m=146547356109940
>
>>
>>
>>
>>>
>>> Regards
>>> Adrian
>>>
>>>
>>>  drivers/mmc/card/block.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index b954516739be..aa5cfaf1fdf0 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1834,8 +1834,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct
>>> mmc_queue_req *mqrq,
>>>          do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>>>              (prq->cmd_flags & REQ_META) &&
>>>              (rq_data_dir(prq) == WRITE) &&
>>> -            ((brq->data.blocks * brq->data.blksz) >=
>>> -             card->ext_csd.data_tag_unit_size);
>>> +            blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
>>>          /* Argument of CMD23 */
>>>          packed_cmd_hdr[(i * 2)] =
>>>              (do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
>>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

