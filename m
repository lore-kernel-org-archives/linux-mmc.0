From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: return errorcode and not 0
Date: Tue, 14 Feb 2017 09:16:04 +0100
Message-ID: <CAPDyKFqiNWyYdpCgU3TpRo-CFALjc97XFDC4yR+RyqPZDWeF+g@mail.gmail.com>
References: <20170213144038.975-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34840 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdBNIQF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 03:16:05 -0500
Received: by mail-ua0-f174.google.com with SMTP id y9so81701010uae.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 00:16:05 -0800 (PST)
In-Reply-To: <20170213144038.975-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On 13 February 2017 at 15:40, Linus Walleij <linus.walleij@linaro.org> wrote:
> The function mmc_sd_num_wr_blocks() was changed in
> 9a5e7ddc7954: "mmc: block: return errorcode from mmc_sd_num_wr_blocks()"
> to return err; but this was fixed in
> 65f2da1ecb36: "mmc: block: return 0 where evident"
> as clearly err was anyways zero.
>
> Well the first commit was wrong, we should have returned an
> errorcode all the time.

As both of the fixed commits is still only in my tree, I decided to
fold this change into the first one ("mmc: block: return errorcode
from mmc_sd_num_wr_blocks()" and the drop the second ("mmc: block:
return 0 where evident"). In this way we get clean git history and
avoid bisect issues.

I also added a little information in the change-log of the amended
commit about the update.

>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 65f2da1ecb36: ("mmc: block: return 0 where evident")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next!

Kind regards
Uffe

> ---
> Ulf please apply this for fixes.
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 985477cdcb3e..cd909aecfded 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -783,7 +783,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         if (err)
>                 return err;
>         if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
> -               return 0;
> +               return -EIO;
>
>         memset(&cmd, 0, sizeof(struct mmc_command));
>
> --
> 2.9.3
>
