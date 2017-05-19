From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Delete an error message for a failed memory
 allocation in three functions
Date: Fri, 19 May 2017 09:49:59 +0200
Message-ID: <CAPDyKFqhNQdfr19195YfL7f4Jh0u6pGZ9QtSff0C6fe6R9wdjw@mail.gmail.com>
References: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35211 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdESHuA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 03:50:00 -0400
Received: by mail-qk0-f180.google.com with SMTP id a72so54813747qkj.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 00:50:00 -0700 (PDT)
In-Reply-To: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Shawn Lin <shawn.lin@rock-chips.com>, Uri Yanai <uri.yanai@sandisk.com>, Tomas Winkler <tomas.winkler@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 13 May 2017 at 14:54, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 May 2017 14:40:08 +0200
>
> Omit an extra message for a memory allocation failure in these functions.
>
> This issue was detected by using the Coccinelle software.
>
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

It's a nice cleanup. However I found one more occasion in mmc_test.c,
please fix that and re-spin.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d109634fbfce..1d7542daecbe 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -294,12 +294,8 @@ static int mmc_read_switch(struct mmc_card *card)
>         err = -EIO;
>
>         status = kmalloc(64, GFP_KERNEL);
> -       if (!status) {
> -               pr_err("%s: could not allocate a buffer for "
> -                       "switch capabilities.\n",
> -                       mmc_hostname(card->host));
> +       if (!status)
>                 return -ENOMEM;
> -       }
>
>         /*
>          * Find out the card's support bits with a mode 0 operation.
> @@ -359,11 +355,8 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>                 return 0;
>
>         status = kmalloc(64, GFP_KERNEL);
> -       if (!status) {
> -               pr_err("%s: could not allocate a buffer for "
> -                       "switch capabilities.\n", mmc_hostname(card->host));
> +       if (!status)
>                 return -ENOMEM;
> -       }
>
>         err = mmc_sd_switch(card, 1, 0, 1, status);
>         if (err)
> @@ -596,11 +589,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>                 return 0;
>
>         status = kmalloc(64, GFP_KERNEL);
> -       if (!status) {
> -               pr_err("%s: could not allocate a buffer for "
> -                       "switch capabilities.\n", mmc_hostname(card->host));
> +       if (!status)
>                 return -ENOMEM;
> -       }
>
>         /* Set 4-bit bus width */
>         if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> --
> 2.12.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
