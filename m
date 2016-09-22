From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: card: do away with indirection pointer
Date: Thu, 22 Sep 2016 11:40:04 +0200
Message-ID: <CAPDyKFquLbNSDHabWD=ZxusXc4UnBgCVTRrb+c2JZHARKc524A@mail.gmail.com>
References: <1474364078-15769-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36956 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbcIVJkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 05:40:08 -0400
Received: by mail-wm0-f48.google.com with SMTP id b130so137927736wmc.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2016 02:40:07 -0700 (PDT)
In-Reply-To: <1474364078-15769-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20 September 2016 at 11:34, Linus Walleij <linus.walleij@linaro.org> wrote:
> We have enough vtables in the kernel as it is, we don't need
> this one to create even more artificial separation of concerns.
>
> As is proved by the Makefile:
>
> obj-$(CONFIG_MMC_BLOCK)         += mmc_block.o
> mmc_block-objs                  := block.o queue.o
>
> block.c and queue.c are baked into the same mmc_block.o object.
> So why would one of these objects access a function in the
> other object by dereferencing a pointer?
>
> Create a new block.h header file for the single shared function
> from block to queue and remove the function pointer and just
> call the queue request function.
>
> Apart from making the code more readable, this also makes link
> optimizations possible and probably speeds up the call as well.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Actually commit the new block.h file too, mea culpa.
> ---
>  drivers/mmc/card/block.c | 3 +--
>  drivers/mmc/card/block.h | 1 +
>  drivers/mmc/card/queue.c | 4 +++-
>  drivers/mmc/card/queue.h | 2 --
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mmc/card/block.h

Thanks, applied for next!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2206d4477dbb..15acf96147f3 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2144,7 +2144,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>         return 0;
>  }
>
> -static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> +int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  {
>         int ret;
>         struct mmc_blk_data *md = mq->data;
> @@ -2265,7 +2265,6 @@ again:
>         if (ret)
>                 goto err_putdisk;
>
> -       md->queue.issue_fn = mmc_blk_issue_rq;
>         md->queue.data = md;
>
>         md->disk->major = MMC_BLOCK_MAJOR;
> diff --git a/drivers/mmc/card/block.h b/drivers/mmc/card/block.h
> new file mode 100644
> index 000000000000..cdabb2ee74be
> --- /dev/null
> +++ b/drivers/mmc/card/block.h
> @@ -0,0 +1 @@
> +int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 708057261b38..8037f73a109a 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -19,7 +19,9 @@
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +
>  #include "queue.h"
> +#include "block.h"
>
>  #define MMC_QUEUE_BOUNCESZ     65536
>
> @@ -68,7 +70,7 @@ static int mmc_queue_thread(void *d)
>                         bool req_is_special = mmc_req_is_special(req);
>
>                         set_current_state(TASK_RUNNING);
> -                       mq->issue_fn(mq, req);
> +                       mmc_blk_issue_rq(mq, req);
>                         cond_resched();
>                         if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
>                                 mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index fee5e1271465..3c15a75bae86 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -57,8 +57,6 @@ struct mmc_queue {
>         unsigned int            flags;
>  #define MMC_QUEUE_SUSPENDED    (1 << 0)
>  #define MMC_QUEUE_NEW_REQUEST  (1 << 1)
> -
> -       int                     (*issue_fn)(struct mmc_queue *, struct request *);
>         void                    *data;
>         struct request_queue    *queue;
>         struct mmc_queue_req    mqrq[2];
> --
> 2.7.4
>
