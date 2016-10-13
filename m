From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Thu, 13 Oct 2016 09:36:05 +0200
Message-ID: <CAPDyKFoAxiYWYOYZeYByXOwbK_k0Mgq_LCCqp3t2NJJmV4p1kQ@mail.gmail.com>
References: <1472706726-893-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34296 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbcJMIGP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 04:06:15 -0400
Received: by mail-qk0-f170.google.com with SMTP id f128so70440119qkb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 01:05:21 -0700 (PDT)
In-Reply-To: <1472706726-893-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "alex.lemberg" <alex.lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Avi Shchislowski <avi.shchislowski@sandisk.com>

On 1 September 2016 at 07:12, alex.lemberg <alex.lemberg@sandisk.com> wrote:
> Add MMC_AUTOSUSPEND_DELAY_MS define
>
> Signed-off-by: alex.lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/card/block.c | 3 ++-
>  include/linux/mmc/host.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 48a5dd7..f4386ed 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2610,7 +2610,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>                         goto out;
>         }
>
> -       pm_runtime_set_autosuspend_delay(&card->dev, 3000);
> +       pm_runtime_set_autosuspend_delay(&card->dev,
> +               MMC_RUNTIME_SUSPEND_DELAY_MS);
>         pm_runtime_use_autosuspend(&card->dev);
>
>         /*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index aa4bfbf..8cb8218 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -22,6 +22,8 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>
> +#define MMC_RUNTIME_SUSPEND_DELAY_MS   3000
> +
>  struct mmc_ios {
>         unsigned int    clock;                  /* clock rate */
>         unsigned short  vdd;
> --
> 1.9.1
>

Actually, I don't mind having hardcoded values like this one directly
in the code. Especially since it's used only at one single place and
because it's not a magic number.

Although, if really feel strong about this, I can apply it.

Kind regards
Uffe
