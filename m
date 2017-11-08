From: Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH 2/2] mmc : implement REQ_OP_WRITE_ZEROES
Date: Wed, 8 Nov 2017 23:25:26 +0900
Message-ID: <CAPP0e=O2p68jewHDpG0nJtFitrVmpWHO1DU0f32LxF22Hsbapw@mail.gmail.com>
References: <CGME20171107070328eucas1p12d563f31022e62a4ac6daac26fb0b81d@eucas1p1.samsung.com>
 <20171107070259.11664-1-js07.lee@samsung.com> <20171107070259.11664-2-js07.lee@samsung.com>
 <CAPDyKFpj+rfuhXAd5sB9nxfyRU4i6eUF=V3d1bm9RKqi1ZwXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:55331 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdKHOZ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2017 09:25:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id 15so1958145pgc.12
        for <linux-mmc@vger.kernel.org>; Wed, 08 Nov 2017 06:25:28 -0800 (PST)
In-Reply-To: <CAPDyKFpj+rfuhXAd5sB9nxfyRU4i6eUF=V3d1bm9RKqi1ZwXVw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jungseung Lee <js07.lee@samsung.com>, Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Nov 7, 2017 at 9:54 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 7 November 2017 at 08:02, Jungseung Lee <js07.lee@samsung.com> wrote:
>> Some devices return zeroes on read to unmmaped logical blocks.
>> Use this behavior to implement REQ_OP_WRITES_ZEROES.
>>
>> Send TRIM operation for the non-partial erase at a convenient time.
>
> This doesn't explain the problem enough.
>
> What does unmapped logical blocks means for an eMMC device? Isn't all
> logical blocks that is accessible being mapped?
>
Right. There is no unmapped logical block.
Only unmapped host address space on eMMC device exist in the spec.

"The contents of a write block where the trim function has been applied
shall be '0' or '1' depending on different memory technology"

I'd like to fix the name as trimmed block. Is it more clear and reasonable?

> Please elaborate for my understanding.
>
> Also, there is no need to split patch1 and patch2, those can go together.
>
> And finally, please follow Christoph's suggestion, so we can see when
> this new quirk is going to be used.
>
OK, I'll send new patch. thanks for the review.

> Kind regards
> Uffe
>
>>
>> Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
>> ---
>>  drivers/mmc/core/block.c | 8 ++++++--
>>  drivers/mmc/core/queue.c | 4 ++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index ea80ff4..41c4ec1 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1273,9 +1273,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>>         struct mmc_card *card = md->queue.card;
>>         unsigned int from, nr, arg;
>>         int err = 0, type = MMC_BLK_DISCARD;
>> +       int force_trim = (req_op(req) == REQ_OP_WRITE_ZEROES);
>>         blk_status_t status = BLK_STS_OK;
>>
>> -       if (!mmc_can_erase(card)) {
>> +       if (!mmc_can_erase(card) || (!mmc_can_trim(card) && force_trim)) {
>>                 status = BLK_STS_NOTSUPP;
>>                 goto fail;
>>         }
>> @@ -1283,7 +1284,9 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>>         from = blk_rq_pos(req);
>>         nr = blk_rq_sectors(req);
>>
>> -       if (mmc_can_discard(card))
>> +       if (force_trim)
>> +               arg = MMC_TRIM_ARG;
>> +       else if (mmc_can_discard(card))
>>                 arg = MMC_DISCARD_ARG;
>>         else if (mmc_can_trim(card))
>>                 arg = MMC_TRIM_ARG;
>> @@ -2032,6 +2035,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>>                                 mmc_blk_issue_rw_rq(mq, NULL);
>>                         mmc_blk_issue_drv_op(mq, req);
>>                         break;
>> +               case REQ_OP_WRITE_ZEROES:
>>                 case REQ_OP_DISCARD:
>>                         /*
>>                          * Complete ongoing async transfer before issuing
>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>> index 4f33d27..dc95b3a 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -144,6 +144,10 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>>         /* granularity must not be greater than max. discard */
>>         if (card->pref_erase > max_discard)
>>                 q->limits.discard_granularity = 0;
>> +
>> +       if (card->quirks & MMC_QUIRK_UNMAPPED_ZEROES)
>> +               blk_queue_max_write_zeroes_sectors(q, UINT_MAX);
>> +
>>         if (mmc_can_secure_erase_trim(card))
>>                 queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
>>  }
>> --
>> 2.10.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
