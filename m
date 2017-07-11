From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: remove unused struct mmc_card *card
Date: Tue, 11 Jul 2017 16:44:29 +0200
Message-ID: <CAPDyKFqWZgm=DAO22FeYaKGQLV9frJGn28na1mmiQKV9zLf8hg@mail.gmail.com>
References: <1499329615-104052-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34154 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933234AbdGKOob (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:31 -0400
Received: by mail-qk0-f175.google.com with SMTP id d78so2752708qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:30 -0700 (PDT)
In-Reply-To: <1499329615-104052-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 6 July 2017 at 10:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It was never used and introduced a long standing compile
> warning:
>
> drivers/mmc/core/block.c: In function 'power_ro_lock_store':
> drivers/mmc/core/block.c:191:19: warning: variable 'card' set but not
> used [-Wunused-but-set-variable]
>
> Remove it to fix the warning.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/block.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0cfac2d..4adde50 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -188,7 +188,6 @@ static ssize_t power_ro_lock_store(struct device *dev,
>  {
>         int ret;
>         struct mmc_blk_data *md, *part_md;
> -       struct mmc_card *card;
>         struct mmc_queue *mq;
>         struct request *req;
>         unsigned long set;
> @@ -201,7 +200,6 @@ static ssize_t power_ro_lock_store(struct device *dev,
>
>         md = mmc_blk_get(dev_to_disk(dev));
>         mq = &md->queue;
> -       card = md->queue.card;
>
>         /* Dispatch locking to the block layer */
>         req = blk_get_request(mq->queue, REQ_OP_DRV_OUT, __GFP_RECLAIM);
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
