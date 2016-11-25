From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 20/25] mmc: queue: Share mmc request array between partitions
Date: Fri, 25 Nov 2016 16:01:46 +0100
Message-ID: <CACRpkdYfVUgh2kx97HKTcG9zcGX=3b9MQsUi-0MNj6KTkfmCCw@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-21-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35189 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754355AbcKYPKc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 10:10:32 -0500
Received: by mail-qk0-f178.google.com with SMTP id n204so80747986qke.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 07:10:04 -0800 (PST)
In-Reply-To: <1480068442-5169-21-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> eMMC can have multiple internal partitions that are represented as separate
> disks / queues. However the card has only 1 command queue which must be
> empty when switching partitions. Consequently the array of mmc requests
> that are queued can be shared between partitions saving memory.
>
> Keep a pointer to the mmc request queue on the card, and use that instead
> of allocating a new one for each partition. Use a reference count to keep
> track of when to free it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This is a good refactoring no matter how we proceed with command
queueuing. Some comments.

> @@ -1480,6 +1480,9 @@ static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
>         if (mq->qdepth != 2)
>                 return -EINVAL;
>
> +       if (mqrq_cur->packed)
> +               goto out;

Well packed command is gone so this goes away.

> +++ b/drivers/mmc/card/queue.c
> @@ -200,10 +200,17 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(struct mmc_queue *mq,
>         struct mmc_queue_req *mqrq;
>         int i;
>
> +       if (mq->card->mqrq) {
> +               mq->card->mqrq_ref_cnt += 1;
> +               return mq->card->mqrq;
> +       }
> +
>         mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
>         if (mqrq) {
>                 for (i = 0; i < mq->qdepth; i++)
>                         mqrq[i].task_id = i;
> +               mq->card->mqrq = mqrq;
> +               mq->card->mqrq_ref_cnt = 1;
>         }

OK

> +       if (mq->card->mqrq_ref_cnt > 1)
> +               return !!mq->mqrq[0].bounce_buf;

Hm that seems inseparable from the other changes.

Decrease of refcount seems correct.

> +       struct mmc_queue_req    *mqrq;          /* Shared queue structure */
> +       int                     mqrq_ref_cnt;   /* Shared queue ref. count */

I'm not smart enough to see if we're always increasing/decreasing
this under a lock or otherwise exclusive context, or if it would be
better to use an atomic type for counting, like kref does?

Well maybe the whole thing could use kref I dunno.

I guess it should be an unsigned int atleast.

Yours,
Linus Walleij
