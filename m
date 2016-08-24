From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/2] mmc: block: remove the check of packed for
 end_packed_req and hdr_wrq_prep
Date: Wed, 24 Aug 2016 18:01:04 +0800
Message-ID: <c4bfcc3b-d0ab-01f5-6116-39c092e01ae3@rock-chips.com>
References: <1472025499-6758-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFozVGtqbLciGQJbf9PTNZuJWmPjTcqq2AUekeoME8eHaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:39541 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbcHXKBW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 06:01:22 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.161])
        by lucky1.263xmail.com (Postfix) with ESMTP id B6EEC1EE7D8
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2016 18:01:07 +0800 (CST)
In-Reply-To: <CAPDyKFozVGtqbLciGQJbf9PTNZuJWmPjTcqq2AUekeoME8eHaA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>

在 2016/8/24 17:30, Ulf Hansson 写道:
> On 24 August 2016 at 09:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> packed should always exist without calling its cleanup function
>> explicitly. Moreover, we have use it when preparing packed list.
>> So I don't believe we should ever fall into this check again when
>> doing mmc_blk_packed_hdr_wrq_prep or mmc_blk_end_packed_req. And
>> the code of mmc_blk_end_packed_req is trying to use packed before
>> checking it which makes it quite weird. This patch is trying to
>> remove these two checks and move it to the mmc_blk_prep_packed_list.
>> If we find packed is null, then we should never use MMC_PACKED_NONE
>> and MMC_BLK_PACKED_CMD. By doing this, we could fall back to
>> non-packed request if finding null packed, though it's impossible
>> theoretically.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - remove BUG_ON and add fallback for packed instead of
>>   panic it.
>>
>>  drivers/mmc/card/block.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 48a5dd7..c7a9b28 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1673,6 +1673,18 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
>>         u8 max_packed_rw = 0;
>>         u8 reqs = 0;
>>
>> +       /*
>> +        * We don't need to check packed for any further
>> +        * operation of packed stuff as we set MMC_PACKED_NONE
>> +        * and return zero for reqs if geting null packed. Also
>> +        * we clean the flag of MMC_BLK_PACKED_CMD to avoid doing
>> +        * it again when removing blk req.
>> +        */
>> +       if (!mqrq->packed) {
>> +               md->flags &= (~MMC_BLK_PACKED_CMD);
>> +               goto no_packed;
>> +       }
>> +
>>         if (!(md->flags & MMC_BLK_PACKED_CMD))
>>                 goto no_packed;
>>
>> @@ -1781,8 +1793,6 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>>         u8 hdr_blocks;
>>         u8 i = 1;
>>
>> -       BUG_ON(!packed);
>> -
>>         mqrq->cmd_type = MMC_PACKED_WRITE;
>>         packed->blocks = 0;
>>         packed->idx_failure = MMC_PACKED_NR_IDX;
>> @@ -1886,8 +1896,6 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
>>         int idx = packed->idx_failure, i = 0;
>>         int ret = 0;
>>
>> -       BUG_ON(!packed);
>> -
>>         while (!list_empty(&packed->list)) {
>>                 prq = list_entry_rq(packed->list.next);
>>                 if (idx == i) {
>> --
>> 2.3.7
>>
>>
>
> This is step in the right direction, although there are still some
> BUG_ONs() for the packed command path. Could you please have look and
> remove all of them?

yup, I will try to remove all of them when I respin v3.

Thansk.

>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

