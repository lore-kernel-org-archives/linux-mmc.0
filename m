From: Tomas Winkler <tomasw@gmail.com>
Subject: Re: [PATCH 8/8 v5] mmc: block: Delete mmc_access_rpmb()
Date: Tue, 22 Aug 2017 11:58:43 +0300
Message-ID: <CA+i0qc46iEV1g_FVX7oDh6cpk_9zR1-YwR9uUvgNpBQ4XtH5OA@mail.gmail.com>
References: <20170820213913.9737-1-linus.walleij@linaro.org>
 <20170820213913.9737-9-linus.walleij@linaro.org> <55bd0aec-d9a5-6162-1aed-40950497d96c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38405 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVI6p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 04:58:45 -0400
Received: by mail-it0-f66.google.com with SMTP id w204so3410427ita.5
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 01:58:45 -0700 (PDT)
In-Reply-To: <55bd0aec-d9a5-6162-1aed-40950497d96c@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>

This was done to prevent boot time scanning of the block device.
Thanks
Tomas

On Mon, Aug 21, 2017 at 3:51 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/08/17 00:39, Linus Walleij wrote:
>> This function is used by the block layer queue to bail out of
>> requests if the current request is an RPMB request.
>>
>> However this makes no sense: RPMB is only used from ioctl():s,
>> there are no RPMB accesses coming from the block layer.
>> An RPMB ioctl() always switches to the RPMB partition and
>> then back to the main partition before completing.
>>
>> The only (possible) use of this check must have been to
>> duct-tape over a race between RPMB ioctl()s colliding with
>> concurrent non-RPMB accesses to the same device.
>
> It was always possible to read / write (unsuccessfully) the rpmb block
> device. i.e. dd of=/dev/mmcblk0rpmb
>
> Actually one thing to look at is that it looks like it was blocking your
> IOCTL requests.  i.e. wouldn't the IOCTL request also get killed.
>
>>
>> This could happen in the past because the RPMB device was
>> created as a separate block device/disk with its own submit
>> queue competing with the main partition, and submitting
>> requests in parallel. This is now gone as we removed the
>> offending RPMB block device in another patch.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v5:
>> - Renumber to keep together with the rest of the series.
>> ---
>>  drivers/mmc/core/block.c | 12 ------------
>>  drivers/mmc/core/queue.c |  2 +-
>>  drivers/mmc/core/queue.h |  2 --
>>  3 files changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 27e1cf07a7a2..61ea402f2569 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1207,18 +1207,6 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>>       md->reset_done &= ~type;
>>  }
>>
>> -int mmc_access_rpmb(struct mmc_queue *mq)
>> -{
>> -     struct mmc_blk_data *md = mq->blkdata;
>> -     /*
>> -      * If this is a RPMB partition access, return ture
>> -      */
>> -     if (md && md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
>> -             return true;
>> -
>> -     return false;
>> -}
>> -
>>  /*
>>   * The non-block commands come back from the block layer after it queued it and
>>   * processed it with all other requests and then they get issued in this
>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>> index affa7370ba82..3baccbf16f3d 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -32,7 +32,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>>  {
>>       struct mmc_queue *mq = q->queuedata;
>>
>> -     if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
>> +     if (mq && mmc_card_removed(mq->card))
>>               return BLKPREP_KILL;
>>
>>       req->rq_flags |= RQF_DONTPREP;
>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
>> index a2b6a9fcab01..7649ed6cbef7 100644
>> --- a/drivers/mmc/core/queue.h
>> +++ b/drivers/mmc/core/queue.h
>> @@ -89,6 +89,4 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
>>  extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
>>  extern void mmc_queue_bounce_post(struct mmc_queue_req *);
>>
>> -extern int mmc_access_rpmb(struct mmc_queue *);
>> -
>>  #endif
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
