From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: get idx after the check of packed
Date: Tue, 23 Aug 2016 12:28:38 +0200
Message-ID: <CAPDyKFqr+NX2sGGUHJ_bq113oTq8KVvwpYKBGsdVDN_vk_77CA@mail.gmail.com>
References: <1471753379-814-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36549 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbcHWKel (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2016 06:34:41 -0400
Received: by mail-wm0-f53.google.com with SMTP id q128so157231051wma.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2016 03:34:41 -0700 (PDT)
In-Reply-To: <1471753379-814-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 21 August 2016 at 06:22, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We should not use packed command before we verify
> it's valid. So let's move the assignment of idx
> after the check.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/card/block.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 48a5dd7..11d3046 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1883,11 +1883,13 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
>  {
>         struct request *prq;
>         struct mmc_packed *packed = mq_rq->packed;
> -       int idx = packed->idx_failure, i = 0;
> +       int idx, i = 0;
>         int ret = 0;
>
>         BUG_ON(!packed);
>
> +       idx = packed->idx_failure;
> +

Instead of changing this, may I suggest we try to implement better
error handling - if needed.

I don't think a BUG_ON() is actually what should be used here.

>         while (!list_empty(&packed->list)) {
>                 prq = list_entry_rq(packed->list.next);
>                 if (idx == i) {
> --
> 2.3.7
>
>

Kind regards
Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
