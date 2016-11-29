From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 20/25] mmc: queue: Share mmc request array between
 partitions
Date: Tue, 29 Nov 2016 12:14:09 +0200
Message-ID: <f8b342c5-f30e-0167-8dd3-93161406b51c@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-21-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYfVUgh2kx97HKTcG9zcGX=3b9MQsUi-0MNj6KTkfmCCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbcK2KTO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:19:14 -0500
In-Reply-To: <CACRpkdYfVUgh2kx97HKTcG9zcGX=3b9MQsUi-0MNj6KTkfmCCw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 25/11/16 17:01, Linus Walleij wrote:
> On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> eMMC can have multiple internal partitions that are represented as separate
>> disks / queues. However the card has only 1 command queue which must be
>> empty when switching partitions. Consequently the array of mmc requests
>> that are queued can be shared between partitions saving memory.
>>
>> Keep a pointer to the mmc request queue on the card, and use that instead
>> of allocating a new one for each partition. Use a reference count to keep
>> track of when to free it.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> This is a good refactoring no matter how we proceed with command
> queueuing. Some comments.
> 
>> @@ -1480,6 +1480,9 @@ static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
>>         if (mq->qdepth != 2)
>>                 return -EINVAL;
>>
>> +       if (mqrq_cur->packed)
>> +               goto out;
> 
> Well packed command is gone so this goes away.
> 
>> +++ b/drivers/mmc/card/queue.c
>> @@ -200,10 +200,17 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(struct mmc_queue *mq,
>>         struct mmc_queue_req *mqrq;
>>         int i;
>>
>> +       if (mq->card->mqrq) {
>> +               mq->card->mqrq_ref_cnt += 1;
>> +               return mq->card->mqrq;
>> +       }
>> +
>>         mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
>>         if (mqrq) {
>>                 for (i = 0; i < mq->qdepth; i++)
>>                         mqrq[i].task_id = i;
>> +               mq->card->mqrq = mqrq;
>> +               mq->card->mqrq_ref_cnt = 1;
>>         }
> 
> OK
> 
>> +       if (mq->card->mqrq_ref_cnt > 1)
>> +               return !!mq->mqrq[0].bounce_buf;
> 
> Hm that seems inseparable from the other changes.
> 
> Decrease of refcount seems correct.
> 
>> +       struct mmc_queue_req    *mqrq;          /* Shared queue structure */
>> +       int                     mqrq_ref_cnt;   /* Shared queue ref. count */
> 
> I'm not smart enough to see if we're always increasing/decreasing
> this under a lock or otherwise exclusive context, or if it would be
> better to use an atomic type for counting, like kref does?

Queues are allocated and deallocated via mmc_blk_probe() and mmc_blk_probe()
so no other synchronization is needed for the reference count.  I have
updated the commit message anf put a comment in the code to reflect that.

> 
> Well maybe the whole thing could use kref I dunno.
> 
> I guess it should be an unsigned int atleast.

Ok

