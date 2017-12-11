From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: blk-mq: Potential NULL deref on
 mmc_blk_alloc_req() failure
Date: Mon, 11 Dec 2017 13:29:28 +0100
Message-ID: <CAPDyKFpWVPfj6MNadAQa26Tcv3_ARV4sYYH=_VtCHxmXU-6YvQ@mail.gmail.com>
References: <20171208115516.3h55rvjq54hyfecq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:40794 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdLKM33 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 07:29:29 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so15308271ita.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 04:29:29 -0800 (PST)
In-Reply-To: <20171208115516.3h55rvjq54hyfecq@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 8 December 2017 at 12:55, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> mmc_blk_alloc_req() is supposed to return error pointers but there is
> one path where we forget to set the error code and accidentally return
> NULL.  The callers are not expecting that and will have a NULL pointer
> dereference.
>
> Fixes: 23da8bed11f2 ("mmc: block: Simplify cleaning up the queue")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied for next!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ab384ba6cb37..6af2b660b1f7 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3037,6 +3037,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>          */
>         if (!blk_get_queue(md->queue.queue)) {
>                 mmc_cleanup_queue(&md->queue);
> +               ret = -ENODEV;
>                 goto err_putdisk;
>         }
>
