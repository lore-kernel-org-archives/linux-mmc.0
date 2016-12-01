From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: queue: add #ifdef around bounce buffer code
Date: Thu, 1 Dec 2016 09:00:01 +0100
Message-ID: <CAPDyKFpS3EyQx5UzXe9BjzjjtY2AEcmix01=oY3MARpyZ4bstw@mail.gmail.com>
References: <20161130210427.1721327-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35274 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756051AbcLAIAD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 03:00:03 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so196878455wjy.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 00:00:03 -0800 (PST)
In-Reply-To: <20161130210427.1721327-1-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@fb.com>, Harjani Ritesh <riteshh@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30 November 2016 at 22:03, Arnd Bergmann <arnd@arndb.de> wrote:
> The two functions that got split out from the bounce
> buffer handling are now unused when CONFIG_MMC_BLOCK_BOUNCE
> is disabled:
>
> mmc/card/queue.c:212:12: error: 'mmc_queue_alloc_bounce_sgs' defined but not used [-Werror=unused-function]
> mmc/card/queue.c:189:13: error: 'mmc_queue_alloc_bounce_bufs' defined but not used [-Werror=unused-function]
>
> This adds a new #ifdef around them.
>
> Fixes: 0a6321310492 ("mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix. This time I have already amended the changes that
causes the problem and pushed them for next by yesterday.

Kind regards
Uffe

> ---
>  drivers/mmc/card/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 8d10fab701b6..6ae6bfb8b221 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -186,6 +186,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>                 queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
>  }
>
> +#ifdef CONFIG_MMC_BLOCK_BOUNCE
>  static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
>                                         unsigned int bouncesz)
>  {
> @@ -226,6 +227,7 @@ static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
>
>         return 0;
>  }
> +#endif
>
>  static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
>  {
> --
> 2.9.0
>
