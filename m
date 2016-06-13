From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Fix tag condition with packed writes
Date: Mon, 13 Jun 2016 09:26:48 +0300
Message-ID: <575E5228.3030802@intel.com>
References: <575ABF08.4010102@intel.com>
 <7b6b85e2-4439-f091-3319-9f5ceeb72e82@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64123 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933353AbcFMGaw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jun 2016 02:30:52 -0400
In-Reply-To: <7b6b85e2-4439-f091-3319-9f5ceeb72e82@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 13/06/16 05:42, Shawn Lin wrote:
> Hi Adrian,
> 
> On 2016/6/10 21:22, Adrian Hunter wrote:
>> Apparently a cut-and-paste error, 'do_data_tag' is using 'brq' for data
>> size even though 'brq' has not been set up. Instead use blk_rq_sectors().
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Hi
>>
>> I don't know if anyone is actually using packed writes, but this is
>> something I noticed.
> 
> 
> I think if brq has not been set up, the we could meet another problem
> of checking the case of whether 4KB native sector is enabled.
> When fetching blk req from the queue, mmc_blk_issue_rw_rq already
> use brq there which is the same from your case, namely
> mq->mqrq_cur->brq, right?

Looks like that was that fixed by:

commit 3a6db10d86902491b759103ee97b2539175dd1dd
Author: Yuan, Juntao <juntao.yuan@intel.com>
Date:   Fri May 13 07:59:24 2016 +0000

    mmc: block: correct 4KB alignment check

    In sectors alignment check, brq->data.blocks means sectors of the
    previous mqrq since data.blocks for mqrq_cur hasn't been updated yet.
    data.blocks will be updated later in mmc_blk_packed_hdr_wrq_prep or
    mmc_blk_rw_rq_prep.

    static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, ......
            ......
        struct mmc_blk_request *brq = &mq->mqrq_cur->brq;

    Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

There is also another fix in the SWCMDQ changes:

	http://marc.info/?l=linux-mmc&m=146547356109940

> 
> 
> 
>>
>> Regards
>> Adrian
>>
>>
>>  drivers/mmc/card/block.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index b954516739be..aa5cfaf1fdf0 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1834,8 +1834,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct
>> mmc_queue_req *mqrq,
>>          do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>>              (prq->cmd_flags & REQ_META) &&
>>              (rq_data_dir(prq) == WRITE) &&
>> -            ((brq->data.blocks * brq->data.blksz) >=
>> -             card->ext_csd.data_tag_unit_size);
>> +            blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
>>          /* Argument of CMD23 */
>>          packed_cmd_hdr[(i * 2)] =
>>              (do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
>>
> 
> 

