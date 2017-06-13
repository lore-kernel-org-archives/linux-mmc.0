From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: queue: Drop call to blk_cleanup_queue()
Date: Tue, 13 Jun 2017 11:27:11 +0200
Message-ID: <CAPDyKFoiS2ar8Ew9uHMekHMQt04BpK8+z4RojrWXsauX2b354A@mail.gmail.com>
References: <20170613085906.5726-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35702 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdFMJ1R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2017 05:27:17 -0400
Received: by mail-qt0-f173.google.com with SMTP id w1so162289835qtg.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2017 02:27:17 -0700 (PDT)
In-Reply-To: <20170613085906.5726-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>

On 13 June 2017 at 10:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit 0d8587376878c8da5a4953025e621c5dceb8b76a
> "mmc: core: Allocate per-request data using the block layer core"
> added a call to blk_cleanup_queue() into the mmc_cleanup_queue()
> call.
>
> This might look intutitive (and that is why I made the mistake),
> since the cleanup is called if we fail in mmc_init_queue(), but due
> to the nature of the MMC stack we are cleaning up the queue
> inside the stack once the queue has been started.
>
> The actual call to blk_cleanup_queue() is in mmc_blk_put() in
> block.c, calling it twice wreaks havoc.
>
> Fixes: 0d8587376878 ("mmc: core: Allocate per-request data using the block layer core")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for next! I may consider to squash this change into
the fixed commit, as to avoid bisect problems. In such case I will add
Heiner's tested by tag to that commit.

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 4bf9978b707a..ba689a2ffc51 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -312,7 +312,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>         q->queuedata = NULL;
>         blk_start_queue(q);
>         spin_unlock_irqrestore(q->queue_lock, flags);
> -       blk_cleanup_queue(mq->queue);
>
>         mq->card = NULL;
>  }
> --
> 2.9.4
>
